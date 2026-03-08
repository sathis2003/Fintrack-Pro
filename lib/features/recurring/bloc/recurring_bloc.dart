import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/local/database/app_database.dart' as db;
import '../../../data/local/daos/recurring_dao.dart';
import '../../../data/local/daos/expenses_dao.dart';
import '../../../services/recurrence_detector.dart';
import '../../../data/mappers/recurring_mapper.dart';
import '../../../data/mappers/expense_mapper.dart';
import 'recurring_bloc_parts.dart';

@injectable
class RecurringBloc extends Bloc<RecurringEvent, RecurringState> {
  final RecurringDao _recurringDao;
  final ExpensesDao _expensesDao;
  final SupabaseClient _supabase;

  RecurringBloc(
    this._recurringDao,
    this._expensesDao,
    this._supabase,
  ) : super(const RecurringState()) {
    on<RecurringLoaded>(_onLoaded);
    on<RecurringDetectorStarted>(_onDetect);
  }

  Future<void> _onLoaded(
      RecurringLoaded event, Emitter<RecurringState> emit) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    await emit.forEach(
      _recurringDao.watchAll(userId),
      onData: (data) => state.copyWith(recurrings: data),
    );
  }

  Future<void> _onDetect(
      RecurringDetectorStarted event, Emitter<RecurringState> emit) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    emit(state.copyWith(isDetecting: true));

    final expensesRows = await _expensesDao.getByDateRange(
      userId,
      DateTime.now().subtract(const Duration(days: 90)),
      DateTime.now(),
    );

    final expenses = expensesRows.map((e) => e.toDomain()).toList();
    final detected = RecurrenceDetector.detect(expenses);

    for (final d in detected) {
      await _recurringDao
          .upsertRecurring(d.toDomain(userId).toCompanion(userId));
    }

    emit(state.copyWith(isDetecting: false));
  }
}

extension on RecurringState {
  RecurringState copyWith({
    List<db.RecurringExpensesTableData>? recurrings,
    bool? isDetecting,
    String? error,
  }) {
    return RecurringState(
      recurrings: recurrings ?? this.recurrings,
      isDetecting: isDetecting ?? this.isDetecting,
      error: error ?? this.error,
    );
  }
}
