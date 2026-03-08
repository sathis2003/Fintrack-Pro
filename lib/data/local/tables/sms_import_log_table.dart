import 'package:drift/drift.dart';

class SmsImportLogTable extends Table {
  @override
  String get tableName => 'sms_import_log';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get smsId => text()();
  TextColumn get userId => text()();
  TextColumn get sender => text()();
  TextColumn get rawBody => text()();
  RealColumn get amount => real()();
  TextColumn get merchant => text()();
  TextColumn get category => text()();
  TextColumn get status => text().withDefault(const Constant('imported'))();
  TextColumn get expenseUuid => text().nullable()();
  DateTimeColumn get smsDate => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
