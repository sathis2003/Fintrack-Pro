import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'import_event.dart';
import 'import_state.dart';
import '../../../services/sms_reader_service.dart';
import '../../../services/sms_parser_service.dart';
import '../../../data/local/daos/sms_import_dao.dart';
import '../../../data/local/daos/expenses_dao.dart';
import '../../../data/local/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

@injectable
class ImportBloc extends Bloc<ImportEvent, ImportState> {
  final SmsImportDao _importDao;
  final ExpensesDao _expensesDao;
  final SupabaseClient _supabase;
  List<SelectableSmsTransaction> _pending = [];

  ImportBloc(this._importDao, this._expensesDao, this._supabase)
      : super(ImportInitial()) {
    on<ScanSmsRequested>(_onScanSms);
    on<ToggleSmsSelection>(_onToggleSelection);
    on<ImportSelectedSms>(_onImportSelected);
    on<LoadImportHistory>(_onLoadHistory);
  }

  Future<void> _onScanSms(
      ScanSmsRequested event, Emitter<ImportState> emit) async {
    emit(ImportLoading());
    try {
      final messages = await SmsReaderService.readBankSms();
      final List<SelectableSmsTransaction> parsed = [];
      for (final sms in messages) {
        final already = await _importDao.isAlreadyImported(sms.id.toString());
        if (already) continue;
        final tx = SmsParserService.parse(sms);
        if (tx != null) {
          parsed.add(SelectableSmsTransaction(transaction: tx));
        }
      }
      _pending = parsed;
      emit(SmsScanSuccess(List.from(_pending)));
    } catch (e) {
      emit(ImportFailure(e.toString()));
    }
  }

  void _onToggleSelection(ToggleSmsSelection event, Emitter<ImportState> emit) {
    if (state is SmsScanSuccess) {
      final index =
          _pending.indexWhere((t) => t.transaction.smsId == event.smsId);
      if (index != -1) {
        _pending[index].isSelected = !_pending[index].isSelected;
        emit(SmsScanSuccess(List.from(_pending)));
      }
    }
  }

  Future<void> _onImportSelected(
      ImportSelectedSms event, Emitter<ImportState> emit) async {
    final toImport = _pending.where((t) => t.isSelected).toList();
    if (toImport.isEmpty) return;
    emit(ImportLoading());
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    int count = 0;
    for (final item in toImport) {
      final tx = item.transaction;
      final expenseUuid = const Uuid().v4();

      // 1. Save to Expenses
      await _expensesDao.insertExpense(ExpensesCompanion.insert(
        uuid: expenseUuid,
        userId: userId,
        amount: tx.amount,
        category: tx.category,
        description: Value(tx.description),
        date: tx.date.millisecondsSinceEpoch,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      ));

      // 2. Log Import
      await _importDao.logImport(SmsImportLogTableCompanion.insert(
        smsId: tx.smsId,
        userId: userId,
        sender: tx.sender,
        rawBody: tx.rawBody,
        amount: tx.amount,
        merchant: tx.merchant,
        category: tx.category,
        smsDate: tx.date,
        expenseUuid: Value(expenseUuid),
      ));
      count++;
    }
    _pending.clear();
    emit(ImportCompleted(count));
  }

  Future<void> _onLoadHistory(
      LoadImportHistory event, Emitter<ImportState> emit) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;
    await emit.forEach(
      _importDao.watchHistory(userId),
      onData: (data) => ImportHistoryLoaded(data),
      onError: (e, st) => ImportFailure(e.toString()),
    );
  }
}
