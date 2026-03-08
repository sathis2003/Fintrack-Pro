import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../tables/recurring_expenses_table.dart';

import 'package:injectable/injectable.dart';

part 'recurring_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [RecurringExpensesTable])
class RecurringDao extends DatabaseAccessor<AppDatabase>
    with _$RecurringDaoMixin {
  RecurringDao(super.db);

  Stream<List<RecurringExpensesTableData>> watchAll(String userId) =>
      (select(recurringExpensesTable)
            ..where((r) => r.userId.equals(userId) & r.isActive.isValue(true))
            ..orderBy([(r) => OrderingTerm(expression: r.dayOfMonth)]))
          .watch();

  Future<void> upsertRecurring(RecurringExpensesTableCompanion entry) =>
      into(recurringExpensesTable).insertOnConflictUpdate(entry);

  Future<void> deactivate(String uuid) =>
      (update(recurringExpensesTable)..where((r) => r.uuid.equals(uuid)))
          .write(const RecurringExpensesTableCompanion(
        isActive: Value(false),
      ));

  // Get all upcoming in next N days
  Future<List<RecurringExpensesTableData>> getUpcoming(
      String userId, int daysAhead) async {
    final all = await (select(recurringExpensesTable)
          ..where((r) => r.userId.equals(userId) & r.isActive.isValue(true)))
        .get();
    final now = DateTime.now();
    final cutoff = now.add(Duration(days: daysAhead));

    return all.where((r) {
      final next = DateTime.parse(r.nextExpectedDate);
      return next.isBefore(cutoff) && next.isAfter(now);
    }).toList();
  }
}
