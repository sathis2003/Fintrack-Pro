import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../core/errors/failures.dart';
import '../entities/ai_insight.dart';
import '../repositories/i_insights_repository.dart';
import '../use_cases/get_monthly_summary.dart';
import '../repositories/i_expense_repository.dart';

@injectable
class GenerateAiInsight {
  final IInsightsRepository _insightsRepo;
  final GetMonthlySummary _getSummary;
  final IExpenseRepository _expenseRepo;

  GenerateAiInsight(this._insightsRepo, this._getSummary, this._expenseRepo);

  Future<Either<Failure, AiInsight>> call({
    required String userId,
    required String month,
    required double monthlyIncome,
  }) async {
    // 1. Check cache first
    final cachedResult = await _insightsRepo.getByMonth(userId, month);
    final cached = cachedResult.getOrElse((_) => null);

    if (cached != null) {
      // If generated within last 24h, return cached
      final age = DateTime.now().difference(cached.generatedAt);
      if (age.inHours < 24) {
        return Right(cached);
      }
    }

    // 2. Not cached or stale — generate new
    final summaryResult =
        await _getSummary(userId: userId, month: DateTime.parse('$month-01'));

    return summaryResult.fold(
      (failure) => Left(failure),
      (summary) async {
        // Get top 3 expenses
        final expenses = await _expenseRepo
            .watchByMonth(userId, DateTime.parse('$month-01'))
            .first;
        final sorted = expenses.where((e) => !e.isDeleted).toList()
          ..sort((a, b) => b.amount.compareTo(a.amount));

        final top3 = sorted
            .take(3)
            .map((e) => {
                  'description': e.description,
                  'amount': e.amount,
                })
            .toList();

        return _insightsRepo.generateInsight(
          userId: userId,
          month: month,
          monthlyIncome: monthlyIncome,
          totalSpend: summary.totalSpend,
          categoryBreakdown: summary.spendByCategory,
          topExpenses: top3,
        );
      },
    );
  }
}
