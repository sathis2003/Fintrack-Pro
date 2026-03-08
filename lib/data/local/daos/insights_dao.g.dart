// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insights_dao.dart';

// ignore_for_file: type=lint
mixin _$InsightsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AiInsightsTable get aiInsights => attachedDatabase.aiInsights;
  InsightsDaoManager get managers => InsightsDaoManager(this);
}

class InsightsDaoManager {
  final _$InsightsDaoMixin _db;
  InsightsDaoManager(this._db);
  $$AiInsightsTableTableManager get aiInsights =>
      $$AiInsightsTableTableManager(_db.attachedDatabase, _db.aiInsights);
}
