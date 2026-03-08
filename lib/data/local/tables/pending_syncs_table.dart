import 'package:drift/drift.dart';

// This is the backbone of offline-first.
// Every write to the local DB adds a row here.
// SyncService drains these when internet returns.
class PendingSyncs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tableIdentifier => text()();
  // 'expenses' | 'budgets'
  TextColumn get recordUuid => text()();
  TextColumn get operation => text()();
  // 'insert' | 'update' | 'delete'
  TextColumn get payload => text()();
  // Full record as JSON string
  IntColumn get createdAt => integer()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
}
