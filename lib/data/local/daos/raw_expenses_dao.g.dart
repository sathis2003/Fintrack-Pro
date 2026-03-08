// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_expenses_dao.dart';

// ignore_for_file: type=lint
mixin _$RawExpensesDaoMixin on DatabaseAccessor<AppDatabase> {
  $RawExpensesTable get rawExpenses => attachedDatabase.rawExpenses;
  RawExpensesDaoManager get managers => RawExpensesDaoManager(this);
}

class RawExpensesDaoManager {
  final _$RawExpensesDaoMixin _db;
  RawExpensesDaoManager(this._db);
  $$RawExpensesTableTableManager get rawExpenses =>
      $$RawExpensesTableTableManager(_db.attachedDatabase, _db.rawExpenses);
}
