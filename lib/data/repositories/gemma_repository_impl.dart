import 'package:injectable/injectable.dart';
import '../../domain/repositories/i_gemma_repository.dart';
import '../../domain/value_objects/monthly_summary.dart';
import '../../domain/entities/recurring_expense.dart';
import '../../services/prediction_engine.dart';
import '../../services/gemma_model_service.dart';
import '../../services/gemma_analysis_service.dart';
import '../local/daos/gemma_insight_dao.dart';

@Injectable(as: IGemmaRepository)
class GemmaRepositoryImpl implements IGemmaRepository {
  final GemmaInsightDao _dao;
  GemmaRepositoryImpl(this._dao);

  @override
  Future<String?> analyzeSpendingPattern({
    required MonthlySummary current,
    required MonthlySummary previous,
    required List<RecurringExpense> recurring,
    required double monthlyIncome,
    required String userId,
    required String month,
  }) async {
    if (!GemmaModelService.isReady.value) return null;

    final context = GemmaAnalysisService.buildContext(
      current: current,
      previous: previous,
      recurring: recurring,
      monthlyIncome: monthlyIncome,
    );
    final hash = GemmaAnalysisService.hashContext(context);

    // Cache hit
    final cached = await _dao.getCached(
        userId: userId, taskType: 'pattern', contextHash: hash);
    if (cached != null) return cached;

    // Cache miss — run inference
    final result = await GemmaModelService.generateSync(
        GemmaAnalysisService.patternPrompt(context));
    if (result.isEmpty) return null;

    await _dao.cacheInsight(
      userId: userId,
      taskType: 'pattern',
      contextHash: hash,
      insightText: result,
      month: month,
    );
    return result;
  }

  @override
  Stream<String>? suggestCategoryStream(String partialText) {
    if (!GemmaModelService.isReady.value) return null;
    return GemmaModelService.generate(
        GemmaAnalysisService.categoryPrompt(partialText));
  }

  @override
  Future<String?> narrateAnomaly(CategoryAnomaly anomaly) async {
    if (!GemmaModelService.isReady.value) return null;
    return GemmaModelService.generateSync(GemmaAnalysisService.anomalyPrompt(
      anomaly.category,
      anomaly.currentSpend,
      anomaly.lastMonthSpend,
      anomaly.ratio,
    ));
  }

  @override
  Future<String?> generateWeeklyDigest({
    required double totalSpend,
    required String topCategory,
    required int expenseCount,
  }) async {
    if (!GemmaModelService.isReady.value) return null;
    return GemmaModelService.generateSync(
      GemmaAnalysisService.weeklyDigestPrompt(
        totalSpend: totalSpend,
        topCategory: topCategory,
        expenseCount: expenseCount,
      ),
    );
  }
}
