import '../value_objects/monthly_summary.dart';
import '../entities/recurring_expense.dart';
import '../../services/prediction_engine.dart';

abstract class IGemmaRepository {
  /// Returns null if model not ready.
  Future<String?> analyzeSpendingPattern({
    required MonthlySummary current,
    required MonthlySummary previous,
    required List<RecurringExpense> recurring,
    required double monthlyIncome,
    required String userId,
    required String month,
  });

  /// Returns null if model not ready.
  Stream<String>? suggestCategoryStream(String partialText);

  Future<String?> narrateAnomaly(CategoryAnomaly anomaly);

  Future<String?> generateWeeklyDigest({
    required double totalSpend,
    required String topCategory,
    required int expenseCount,
  });
}
