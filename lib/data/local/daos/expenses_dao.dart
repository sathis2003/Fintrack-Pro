import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../tables/expenses_table.dart';

part 'expenses_dao.g.dart';

@DriftAccessor(tables: [Expenses])
class ExpensesDao extends DatabaseAccessor<AppDatabase>
    with _$ExpensesDaoMixin {
  ExpensesDao(super.db);

  // Watch all non-deleted expenses for a user, ordered by date
  Stream<List<ExpenseData>> watchByUser(String userId) => (select(expenses)
        ..where((e) => e.userId.equals(userId) & e.isDeleted.equals(false))
        ..orderBy([(e) => OrderingTerm.desc(e.date)]))
      .watch();

  // Watch expenses for a specific month (Unix ms range)
  Stream<List<ExpenseData>> watchByMonth(
          String userId, int monthStart, int monthEnd) =>
      (select(expenses)
            ..where((e) =>
                e.userId.equals(userId) &
                e.isDeleted.equals(false) &
                e.date.isBiggerOrEqualValue(monthStart) &
                e.date.isSmallerOrEqualValue(monthEnd))
            ..orderBy([(e) => OrderingTerm.desc(e.date)]))
          .watch();

  Future<int> insertExpense(ExpensesCompanion expense) =>
      into(expenses).insert(expense);

  Future<bool> updateExpense(ExpensesCompanion expense) =>
      update(expenses).replace(expense);

  // Soft delete only — never hard delete
  Future softDelete(String uuid) =>
      (update(expenses)..where((e) => e.uuid.equals(uuid)))
          .write(ExpensesCompanion(
        isDeleted: const Value(true),
        syncStatus: const Value('pending'),
        updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));

  Future<List<ExpenseData>> getPendingSync() =>
      (select(expenses)..where((e) => e.syncStatus.equals('pending'))).get();

  Future<List<ExpenseData>> getByDateRange(
          String userId, DateTime start, DateTime end) =>
      (select(expenses)
            ..where((e) =>
                e.userId.equals(userId) &
                e.isDeleted.equals(false) &
                e.date.isBiggerOrEqualValue(start.millisecondsSinceEpoch) &
                e.date.isSmallerOrEqualValue(end.millisecondsSinceEpoch)))
          .get();

  Future<int> getTotalCount(String userId) async {
    final countExp = expenses.id.count();
    final query = selectOnly(expenses)..addColumns([countExp]);
    query.where(
        expenses.userId.equals(userId) & expenses.isDeleted.equals(false));
    final result = await query.getSingle();
    return result.read(countExp) ?? 0;
  }
}
