// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_dao.dart';

// ignore_for_file: type=lint
mixin _$RecurringDaoMixin on DatabaseAccessor<AppDatabase> {
  $RecurringExpensesTableTable get recurringExpensesTable =>
      attachedDatabase.recurringExpensesTable;
  RecurringDaoManager get managers => RecurringDaoManager(this);
}

class RecurringDaoManager {
  final _$RecurringDaoMixin _db;
  RecurringDaoManager(this._db);
  $$RecurringExpensesTableTableTableManager get recurringExpensesTable =>
      $$RecurringExpensesTableTableTableManager(
          _db.attachedDatabase, _db.recurringExpensesTable);
}
