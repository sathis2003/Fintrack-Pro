import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import '../local/daos/insights_dao.dart';
import '../mappers/insight_mapper.dart';
import '../../domain/entities/ai_insight.dart';
import '../../domain/repositories/i_insights_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/logger.dart';

@Injectable(as: IInsightsRepository)
class InsightsRepositoryImpl implements IInsightsRepository {
  final InsightsDao _insightsDao;
  final Dio _dio;

  InsightsRepositoryImpl(this._insightsDao, this._dio);

  @override
  Future<Either<Failure, AiInsight?>> getByMonth(
      String userId, String month) async {
    try {
      final cached = await _insightsDao.getByMonth(userId, month);
      return Right(cached);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AiInsight>> generateInsight({
    required String userId,
    required String month,
    required double monthlyIncome,
    required double totalSpend,
    required Map<String, double> categoryBreakdown,
    required List<Map<String, dynamic>> topExpenses,
  }) async {
    try {
      // 1. Prepare request for Groq Proxy Edge Function
      final url = '${AppConstants.supabaseUrl}/functions/v1/groq-proxy';

      final response = await _dio.post(
        url,
        data: {
          'task': 'insights',
          'model': AppConstants.groqFastModel,
          'monthlyIncome': monthlyIncome,
          'month': month,
          'totalSpend': totalSpend,
          'categoryBreakdown': categoryBreakdown,
          'topExpenses': topExpenses,
        },
        options: Options(headers: {
          'Authorization': 'Bearer ${AppConstants.supabaseAnonKey}',
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data['choices'][0]['message']['content'];
        // The data is a JSON string because we used response_format: { type: "json_object" }
        // in our Edge Function implementation plan.

        final insightData = AiInsight(
          userId: userId,
          month: month,
          riskLevel: data['risk_level'],
          riskScore: (data['risk_score'] as num).toDouble(),
          summary: data['summary'],
          suggestions: List<String>.from(data['suggestions']),
          positiveNote: data['positive_note'],
          exhaustionDate: data['exhaustion_date'] != null
              ? DateTime.parse(data['exhaustion_date'])
              : null,
          generatedAt: DateTime.now(),
        );

        // 2. Cache in local DB
        await _insightsDao
            .upsertInsight(InsightMapper.toCompanion(insightData));

        return Right(insightData);
      } else {
        return Left(
            ServerFailure('AI Generation failed: ${response.statusMessage}'));
      }
    } catch (e) {
      AppLogger.e('InsightsRepo', 'Generation error', e);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<int> getMonthlyInsightCount(String userId, String month) {
    return _insightsDao.countByMonth(userId, month);
  }
}
