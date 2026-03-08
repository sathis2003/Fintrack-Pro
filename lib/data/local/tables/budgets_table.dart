import 'package:drift/drift.dart';

@DataClassName('BudgetData')
class Budgets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text()();
  TextColumn get userId => text()();
  TextColumn get category => text()();
  RealColumn get amount => real()();
  IntColumn get month => integer()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  IntColumn get updatedAt => integer()();
}
