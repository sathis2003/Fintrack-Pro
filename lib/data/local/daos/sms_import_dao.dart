import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../tables/sms_import_log_table.dart';

part 'sms_import_dao.g.dart';

@injectable
@DriftAccessor(tables: [SmsImportLogTable])
class SmsImportDao extends DatabaseAccessor<AppDatabase>
    with _$SmsImportDaoMixin {
  SmsImportDao(super.db);

  Future<bool> isAlreadyImported(String smsId) async {
    final result = await (select(smsImportLogTable)
          ..where((s) => s.smsId.equals(smsId)))
        .getSingleOrNull();
    return result != null;
  }

  Future<void> logImport(SmsImportLogTableCompanion entry) =>
      into(smsImportLogTable).insert(entry);

  Stream<List<SmsImportLogTableData>> watchHistory(String userId) =>
      (select(smsImportLogTable)
            ..where((s) => s.userId.equals(userId))
            ..orderBy([(s) => OrderingTerm.desc(s.smsDate)])
            ..limit(100))
          .watch();
}
