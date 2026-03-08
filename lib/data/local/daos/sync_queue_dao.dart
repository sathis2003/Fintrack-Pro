import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../tables/pending_syncs_table.dart';

part 'sync_queue_dao.g.dart';

@DriftAccessor(tables: [PendingSyncs])
class SyncQueueDao extends DatabaseAccessor<AppDatabase>
    with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);

  Future<List<PendingSync>> getAllPending() =>
      (select(pendingSyncs)..orderBy([(s) => OrderingTerm.asc(s.createdAt)]))
          .get();

  Future<int> enqueue(PendingSyncsCompanion entry) =>
      into(pendingSyncs).insert(entry);

  Future<int> deleteById(int id) =>
      (delete(pendingSyncs)..where((s) => s.id.equals(id))).go();

  Future incrementRetry(int id) => customUpdate(
        'UPDATE pending_syncs SET retry_count = retry_count + 1 WHERE id = ?',
        variables: [Variable(id)],
      );
}
