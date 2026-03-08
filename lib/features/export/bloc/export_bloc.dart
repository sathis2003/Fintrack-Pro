import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'export_event.dart';
import 'export_state.dart';
import '../../../data/local/daos/expenses_dao.dart';
import '../../../data/local/daos/financial_profile_dao.dart';
import '../../../services/pdf_export_service.dart';
import '../../../services/csv_export_service.dart';
import '../../../services/analytics_service.dart';
import '../../../data/mappers/expense_mapper.dart';

@injectable
class ExportBloc extends Bloc<ExportEvent, ExportState> {
  final ExpensesDao _expensesDao;
  final FinancialProfileDao _profileDao;
  final SupabaseClient _supabase;

  ExportBloc(
    this._expensesDao,
    this._profileDao,
    this._supabase,
  ) : super(ExportInitial()) {
    on<ExportRequested>(_onExportRequested);
  }

  Future<void> _onExportRequested(
    ExportRequested event,
    Emitter<ExportState> emit,
  ) async {
    emit(ExportGenerating());

    final user = _supabase.auth.currentUser;
    if (user == null) {
      emit(const ExportError('User not logged in'));
      return;
    }

    try {
      // Parse YYYY-MM
      final parts = event.month.split('-');
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);

      final start = DateTime(year, month, 1);
      final end = DateTime(year, month + 1, 1)
          .subtract(const Duration(milliseconds: 1));

      final rows = await _expensesDao.getByDateRange(user.id, start, end);
      final expenses = rows.map((r) => r.toDomain()).toList();
      final profile = await _profileDao.getByUser(user.id);

      File file;
      if (event.format == ExportFormat.pdf) {
        file = await PdfExportService.generateMonthlyStatement(
          expenses: expenses,
          month: DateFormat('MMMM yyyy').format(start),
          userName: user.email ?? 'User', // Fallback to email
          monthlyIncome: profile?.monthlyIncome ?? 0,
        );
      } else {
        file = await CsvExportService.generateCsv(
          expenses: expenses,
          month: event.month,
        );
      }

      AnalyticsService.logExport(format: event.format.name, month: event.month);
      emit(ExportReady(file: file, format: event.format));
    } catch (e) {
      emit(ExportError(e.toString()));
    }
  }
}
