import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';
import '../../domain/entities/expense.dart';
import '../../domain/repositories/i_expense_repository.dart';
import '../../core/errors/failures.dart';
import '../local/database/app_database.dart' as db;
import '../local/daos/expenses_dao.dart';
import '../local/daos/sync_queue_dao.dart';
import '../mappers/expense_mapper.dart';

@Injectable(as: IExpenseRepository)
class ExpenseRepositoryImpl implements IExpenseRepository {
  final ExpensesDao _expensesDao;
  final SyncQueueDao _syncDao;
  ExpenseRepositoryImpl(this._expensesDao, this._syncDao);

  @override
  Stream<List<Expense>> watchByMonth(String userId, DateTime month) {
    final start = DateTime(month.year, month.month, 1).millisecondsSinceEpoch;
    final end = DateTime(month.year, month.month + 1, 0, 23, 59, 59)
        .millisecondsSinceEpoch;
    return _expensesDao
        .watchByMonth(userId, start, end)
        .map((rows) => rows.map((row) => ExpenseMapper.fromRow(row)).toList());
  }

  @override
  Future<Either<Failure, Expense>> add(Expense expense) async {
    try {
      // 1. Write to Drift (offline-first — no network needed)
      final companion = ExpenseMapper.toCompanion(expense);
      final id = await _expensesDao.insertExpense(companion);
      final saved = expense.copyWith(id: id, syncStatus: 'pending');

      // 2. Queue sync to Supabase
      await _syncDao.enqueue(db.PendingSyncsCompanion(
        tableIdentifier: const Value('expenses'),
        recordUuid: Value(expense.uuid),
        operation: const Value('insert'),
        payload: Value(jsonEncode(ExpenseMapper.toSupabaseMap(saved))),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));

      return Right(saved);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> update(Expense expense) async {
    try {
      final updated = expense.copyWith(
        updatedAt: DateTime.now(),
        syncStatus: 'pending',
      );
      await _expensesDao.updateExpense(ExpenseMapper.toCompanion(updated));
      await _syncDao.enqueue(db.PendingSyncsCompanion(
        tableIdentifier: const Value('expenses'),
        recordUuid: Value(expense.uuid),
        operation: const Value('update'),
        payload: Value(jsonEncode(ExpenseMapper.toSupabaseMap(updated))),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> softDelete(String uuid) async {
    try {
      await _expensesDao.softDelete(uuid);
      await _syncDao.enqueue(db.PendingSyncsCompanion(
        tableIdentifier: const Value('expenses'),
        recordUuid: Value(uuid),
        operation: const Value('delete'),
        payload: const Value('{}'),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
