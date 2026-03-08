import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../tables/budgets_table.dart';
import '../../../domain/entities/budget.dart';
import '../../mappers/budget_mapper.dart';

import 'package:injectable/injectable.dart';

part 'budgets_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [Budgets])
class BudgetsDao extends DatabaseAccessor<AppDatabase> with _$BudgetsDaoMixin {
  BudgetsDao(super.db);

  // Watch all budgets for current month
  Stream<List<Budget>> watchByMonth(String userId, String month) {
    final monthInt = int.parse(month.replaceAll('-', ''));
    return (select(budgets)
          ..where((b) => b.userId.equals(userId) & b.month.equals(monthInt)))
        .watch()
        .map((rows) => rows.map((row) => BudgetMapper.fromRow(row)).toList());
  }

  // Upsert by category+month
  Future<void> upsertBudget(BudgetsCompanion entry) =>
      into(budgets).insertOnConflictUpdate(entry);

  Future<Budget?> getMonthlyBudget(String userId, int month, int year) async {
    final monthStr = '${year.toString()}${month.toString().padLeft(2, '0')}';
    final monthInt = int.parse(monthStr);
    final row = await (select(budgets)
          ..where((b) => b.userId.equals(userId) & b.month.equals(monthInt)))
        .getSingleOrNull();
    return row != null ? BudgetMapper.fromRow(row) : null;
  }

  Future<void> deleteBudgetByUuid(String uuid) =>
      (delete(budgets)..where((b) => b.uuid.equals(uuid))).go();
}
