import 'package:drift/drift.dart';

class FinancialProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  RealColumn get monthlyIncome => real().withDefault(const Constant(0))();
  IntColumn get incomeDay => integer().withDefault(const Constant(1))();
  TextColumn get currency => text().withDefault(const Constant('INR'))();
  BoolColumn get budgetAlertsEnabled =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get offlineModeOnly =>
      boolean().withDefault(const Constant(false))();
  IntColumn get updatedAt => integer()();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  TextColumn get lastTrackedDate =>
      text().nullable()(); // ISO date "YYYY-MM-DD"
}
