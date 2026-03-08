import 'package:drift/drift.dart';

@DataClassName('RawExpenseData')
class RawExpenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get rawText => text()();
  IntColumn get createdAt => integer()();
}
