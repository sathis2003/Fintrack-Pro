// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_queue_dao.dart';

// ignore_for_file: type=lint
mixin _$SyncQueueDaoMixin on DatabaseAccessor<AppDatabase> {
  $PendingSyncsTable get pendingSyncs => attachedDatabase.pendingSyncs;
  SyncQueueDaoManager get managers => SyncQueueDaoManager(this);
}

class SyncQueueDaoManager {
  final _$SyncQueueDaoMixin _db;
  SyncQueueDaoManager(this._db);
  $$PendingSyncsTableTableManager get pendingSyncs =>
      $$PendingSyncsTableTableManager(_db.attachedDatabase, _db.pendingSyncs);
}
