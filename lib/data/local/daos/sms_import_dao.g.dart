// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_import_dao.dart';

// ignore_for_file: type=lint
mixin _$SmsImportDaoMixin on DatabaseAccessor<AppDatabase> {
  $SmsImportLogTableTable get smsImportLogTable =>
      attachedDatabase.smsImportLogTable;
  SmsImportDaoManager get managers => SmsImportDaoManager(this);
}

class SmsImportDaoManager {
  final _$SmsImportDaoMixin _db;
  SmsImportDaoManager(this._db);
  $$SmsImportLogTableTableTableManager get smsImportLogTable =>
      $$SmsImportLogTableTableTableManager(
          _db.attachedDatabase, _db.smsImportLogTable);
}
