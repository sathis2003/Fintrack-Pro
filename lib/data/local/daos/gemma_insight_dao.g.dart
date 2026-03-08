// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemma_insight_dao.dart';

// ignore_for_file: type=lint
mixin _$GemmaInsightDaoMixin on DatabaseAccessor<AppDatabase> {
  $GemmaInsightsTableTable get gemmaInsightsTable =>
      attachedDatabase.gemmaInsightsTable;
  GemmaInsightDaoManager get managers => GemmaInsightDaoManager(this);
}

class GemmaInsightDaoManager {
  final _$GemmaInsightDaoMixin _db;
  GemmaInsightDaoManager(this._db);
  $$GemmaInsightsTableTableTableManager get gemmaInsightsTable =>
      $$GemmaInsightsTableTableTableManager(
          _db.attachedDatabase, _db.gemmaInsightsTable);
}
