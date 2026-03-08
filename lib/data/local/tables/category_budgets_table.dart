import 'package:drift/drift.dart';

@DataClassName('CategoryBudgetData')
class CategoryBudgets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get category => text()();
  RealColumn get limitAmount => real()();
}
