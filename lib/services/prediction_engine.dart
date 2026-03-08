import '../domain/entities/expense.dart';
import '../domain/entities/recurring_expense.dart';
import '../core/constants/categories.dart';

class CategoryAnomaly {
  final String category;
  final double currentSpend;
  final double lastMonthSpend;
  final double ratio;
  final String message;

  const CategoryAnomaly({
    required this.category,
    required this.currentSpend,
    required this.lastMonthSpend,
    required this.ratio,
    required this.message,
  });
}

class MonthPrediction {
  final double projectedTotal;
  final double currentTotal;
  final double avgDailySpend;
  final int daysRemaining;
  final double upcomingFixed;
  final double lastMonthTotal;
  final double projectedSavings;
  final List<CategoryAnomaly> anomalies;
  final double confidence; // 0.0–1.0

  const MonthPrediction({
    required this.projectedTotal,
    required this.currentTotal,
    required this.avgDailySpend,
    required this.daysRemaining,
    required this.upcomingFixed,
    required this.lastMonthTotal,
    required this.projectedSavings,
    required this.anomalies,
    required this.confidence,
  });
}

class PredictionEngine {
  static MonthPrediction predict({
    required List<Expense> currentMonthExpenses,
    required List<Expense> lastMonthExpenses,
    required List<RecurringExpense> upcomingRecurring,
    required double monthlyIncome,
    required DateTime now,
  }) {
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final daysPassed = now.day;
    final daysRemaining = daysInMonth - daysPassed;

    // Current pace: average daily spend × days remaining
    final currentTotal =
        currentMonthExpenses.fold(0.0, (sum, e) => sum + e.amount);
    final avgDailySpend = daysPassed > 0 ? currentTotal / daysPassed : 0.0;
    final projectedVariableSpend = avgDailySpend * daysRemaining;

    // Known upcoming recurring expenses
    final upcomingFixed = upcomingRecurring
        .where((r) => r.nextExpectedDate.month == now.month)
        .fold(0.0, (sum, r) => sum + r.averageAmount);

    final projectedTotal =
        currentTotal + projectedVariableSpend + upcomingFixed;

    // Compare to last month
    final lastMonthTotal =
        lastMonthExpenses.fold(0.0, (sum, e) => sum + e.amount);

    // Anomaly detection per category
    final anomalies = _detectAnomalies(
      currentExpenses: currentMonthExpenses,
      lastExpenses: lastMonthExpenses,
      daysPassed: daysPassed,
    );

    return MonthPrediction(
      projectedTotal: projectedTotal,
      currentTotal: currentTotal,
      avgDailySpend: avgDailySpend,
      daysRemaining: daysRemaining,
      upcomingFixed: upcomingFixed,
      lastMonthTotal: lastMonthTotal,
      projectedSavings: monthlyIncome - projectedTotal,
      anomalies: anomalies,
      confidence: _predictionConfidence(daysPassed, daysInMonth),
    );
  }

  static List<CategoryAnomaly> _detectAnomalies({
    required List<Expense> currentExpenses,
    required List<Expense> lastExpenses,
    required int daysPassed,
  }) {
    final anomalies = <CategoryAnomaly>[];
    // Use ExpenseCategory enum values for categories
    final categories = ExpenseCategory.values.map((c) => c.label).toList();

    for (final cat in categories) {
      final currentSpend = currentExpenses
          .where((e) => e.category == cat)
          .fold(0.0, (s, e) => s + e.amount);

      final lastSpend = lastExpenses
          .where((e) => e.category == cat)
          .fold(0.0, (s, e) => s + e.amount);

      if (lastSpend < 100) continue; // not enough baseline

      // Annualize current spend to full month for fair comparison
      final projectedCurrent =
          daysPassed > 0 ? (currentSpend / daysPassed) * 30 : 0.0;

      final ratio = projectedCurrent / lastSpend;

      if (ratio >= 2.5) {
        anomalies.add(CategoryAnomaly(
          category: cat,
          currentSpend: currentSpend,
          lastMonthSpend: lastSpend,
          ratio: ratio,
          message:
              'Your $cat spending is ${ratio.toStringAsFixed(1)}× higher than last month',
        ));
      }
    }

    return anomalies;
  }

  // Confidence increases as the month progresses
  static double _predictionConfidence(int daysPassed, int daysInMonth) {
    return (daysPassed / daysInMonth).clamp(0.1, 0.95);
  }
}
