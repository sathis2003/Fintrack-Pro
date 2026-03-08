import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../entities/ai_insight.dart';

abstract class IInsightsRepository {
  Future<Either<Failure, AiInsight?>> getByMonth(String userId, String month);
  Future<Either<Failure, AiInsight>> generateInsight({
    required String userId,
    required String month,
    required double monthlyIncome,
    required double totalSpend,
    required Map<String, double> categoryBreakdown,
    required List<Map<String, dynamic>> topExpenses,
  });
  Future<int> getMonthlyInsightCount(String userId, String month);
}
