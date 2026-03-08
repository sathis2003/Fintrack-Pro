import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../tables/ai_insights_table.dart';
import '../../../domain/entities/ai_insight.dart';
import '../../mappers/insight_mapper.dart';
import 'package:injectable/injectable.dart';

part 'insights_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [AiInsights])
class InsightsDao extends DatabaseAccessor<AppDatabase>
    with _$InsightsDaoMixin {
  InsightsDao(super.db);

  Future<AiInsight?> getByMonth(String userId, String month) async {
    final monthInt = int.parse(month.replaceAll('-', ''));
    final row = await (select(aiInsights)
          ..where((i) => i.userId.equals(userId) & i.month.equals(monthInt)))
        .getSingleOrNull();
    return row != null ? InsightMapper.fromRow(row) : null;
  }

  Future<void> upsertInsight(AiInsightsCompanion entry) =>
      into(aiInsights).insertOnConflictUpdate(entry);

  Future<int> countByMonth(String userId, String month) async {
    final monthInt = int.parse(month.replaceAll('-', ''));
    final query = select(aiInsights)
      ..where((i) => i.userId.equals(userId) & i.month.equals(monthInt));
    final result = await query.get();
    return result.length;
  }
}
