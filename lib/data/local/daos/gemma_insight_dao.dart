import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import '../database/app_database.dart';
import '../tables/gemma_insights_table.dart';

part 'gemma_insight_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [GemmaInsightsTable])
class GemmaInsightDao extends DatabaseAccessor<AppDatabase>
    with _$GemmaInsightDaoMixin {
  GemmaInsightDao(AppDatabase db) : super(db);

  Future<String?> getCached({
    required String userId,
    required String taskType,
    required String contextHash,
  }) async {
    final result = await (select(gemmaInsightsTable)
          ..where((g) =>
              g.userId.equals(userId) &
              g.taskType.equals(taskType) &
              g.contextHash.equals(contextHash)))
        .getSingleOrNull();
    return result?.insightText;
  }

  Future<void> cacheInsight({
    required String userId,
    required String taskType,
    required String contextHash,
    required String insightText,
    required String month,
  }) =>
      into(gemmaInsightsTable).insertOnConflictUpdate(
        GemmaInsightsTableCompanion(
          userId: Value(userId),
          taskType: Value(taskType),
          contextHash: Value(contextHash),
          insightText: Value(insightText),
          month: Value(month),
          generatedAt: Value(DateTime.now()),
        ),
      );
}
