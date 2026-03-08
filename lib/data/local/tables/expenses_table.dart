import 'package:drift/drift.dart';

@DataClassName('ExpenseData')
class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().withLength(min: 36, max: 36)();
  TextColumn get userId => text()();
  RealColumn get amount => real()();
  TextColumn get category => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get date => integer()();
  BoolColumn get isRecurring => boolean().withDefault(const Constant(false))();
  TextColumn get source => text().withDefault(const Constant('chat'))();
  // syncStatus: 'synced' | 'pending' | 'conflict'
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  // Soft delete — never hard delete
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get currency => text().withDefault(const Constant('INR'))();
  RealColumn get exchangeRate => real().withDefault(const Constant(1.0))();
}
