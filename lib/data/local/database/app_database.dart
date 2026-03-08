import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import '../tables/expenses_table.dart';
import '../tables/pending_syncs_table.dart';
import '../tables/financial_profile_table.dart';
import '../tables/budgets_table.dart';
import '../tables/ai_insights_table.dart';
import '../tables/recurring_expenses_table.dart';
import '../tables/achievements_table.dart';
import '../tables/category_budgets_table.dart';
import '../tables/raw_expenses_table.dart';
import '../tables/gemma_insights_table.dart';
import '../tables/sms_import_log_table.dart';
import '../daos/expenses_dao.dart';
import '../daos/sync_queue_dao.dart';
import '../daos/budgets_dao.dart';
import '../daos/insights_dao.dart';
import '../daos/recurring_dao.dart';
import '../daos/achievements_dao.dart';
import '../daos/financial_profile_dao.dart';
import '../daos/raw_expenses_dao.dart';
import '../daos/gemma_insight_dao.dart';
import '../daos/sms_import_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Expenses,
  PendingSyncs,
  FinancialProfiles,
  Budgets,
  AiInsights,
  RecurringExpensesTable,
  AchievementsTable,
  CategoryBudgets,
  RawExpenses,
  GemmaInsightsTable,
  SmsImportLogTable,
], daos: [
  ExpensesDao,
  SyncQueueDao,
  BudgetsDao,
  InsightsDao,
  RecurringDao,
  AchievementsDao,
  FinancialProfileDao,
  RawExpensesDao,
  GemmaInsightDao,
  SmsImportDao,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(categoryBudgets);
            await m.createTable(rawExpenses);
          }
          if (from < 3) {
            await m.addColumn(
                financialProfiles, financialProfiles.currentStreak);
            await m.addColumn(
                financialProfiles, financialProfiles.longestStreak);
            await m.addColumn(
                financialProfiles, financialProfiles.lastTrackedDate);
          }
          if (from < 4) {
            await m.createTable(recurringExpensesTable);
            await m.createTable(achievementsTable);
          }
          if (from < 5) {
            await m.createTable(gemmaInsightsTable);
          }
          if (from < 6) {
            await m.createTable(smsImportLogTable);
          }
          if (from < 7) {
            await m.addColumn(expenses, expenses.currency);
            await m.addColumn(expenses, expenses.exchangeRate);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          await customStatement('PRAGMA journal_mode = WAL');
        },
      );
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'fintrack_db');
}
