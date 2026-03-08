import 'package:drift/drift.dart';

class RecurringExpensesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().withLength(min: 36, max: 36)();
  TextColumn get userId => text()();
  TextColumn get category => text()();
  TextColumn get description => text()();
  RealColumn get averageAmount => real()(); // average of last 3 occurrences
  IntColumn get dayOfMonth => integer()(); // 1–31, when it typically hits
  TextColumn get frequency => text()(); // "monthly" | "weekly" | "yearly"
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get reminderEnabled =>
      boolean().withDefault(const Constant(true))();
  IntColumn get reminderDaysBefore =>
      integer().withDefault(const Constant(3))();
  TextColumn get lastOccurrence => text()(); // ISO date string
  TextColumn get nextExpectedDate => text()(); // ISO date string (computed)
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
