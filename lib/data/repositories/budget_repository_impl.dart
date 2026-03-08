import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';
import 'dart:convert';
import '../local/database/app_database.dart' as db;
import '../local/daos/budgets_dao.dart';
import '../local/daos/sync_queue_dao.dart';
import '../mappers/budget_mapper.dart';
import '../../domain/entities/budget.dart';
import '../../domain/repositories/i_budget_repository.dart';
import '../../core/errors/failures.dart';

@Injectable(as: IBudgetRepository)
class BudgetRepositoryImpl implements IBudgetRepository {
  final BudgetsDao _budgetsDao;
  final SyncQueueDao _syncDao;

  BudgetRepositoryImpl(this._budgetsDao, this._syncDao);

  @override
  Stream<List<Budget>> watchByMonth(String userId, String month) {
    return _budgetsDao.watchByMonth(userId, month);
  }

  @override
  Future<Either<Failure, Unit>> setBudget(Budget budget) async {
    try {
      final companion = BudgetMapper.toCompanion(budget);
      await _budgetsDao.upsertBudget(companion);

      // Queue sync
      await _syncDao.enqueue(db.PendingSyncsCompanion(
        tableIdentifier: const Value('budgets'),
        recordUuid: Value(budget.uuid),
        operation: const Value('upsert'),
        payload: Value(jsonEncode(BudgetMapper.toSupabaseMap(budget))),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));

      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBudget(String uuid) async {
    try {
      await _budgetsDao.deleteBudgetByUuid(uuid);

      // Queue sync
      await _syncDao.enqueue(db.PendingSyncsCompanion(
        tableIdentifier: const Value('budgets'),
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
