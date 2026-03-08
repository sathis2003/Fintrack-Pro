// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_profile_dao.dart';

// ignore_for_file: type=lint
mixin _$FinancialProfileDaoMixin on DatabaseAccessor<AppDatabase> {
  $FinancialProfilesTable get financialProfiles =>
      attachedDatabase.financialProfiles;
  FinancialProfileDaoManager get managers => FinancialProfileDaoManager(this);
}

class FinancialProfileDaoManager {
  final _$FinancialProfileDaoMixin _db;
  FinancialProfileDaoManager(this._db);
  $$FinancialProfilesTableTableManager get financialProfiles =>
      $$FinancialProfilesTableTableManager(
          _db.attachedDatabase, _db.financialProfiles);
}
