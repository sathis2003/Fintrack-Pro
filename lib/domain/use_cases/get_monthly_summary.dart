import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../core/errors/failures.dart';
import '../repositories/i_expense_repository.dart';
import '../value_objects/monthly_summary.dart';

@injectable
class GetMonthlySummary {
  final IExpenseRepository _expenseRepo;

  GetMonthlySummary(this._expenseRepo);

  Future<Either<Failure, MonthlySummary>> call({
    required String userId,
    required DateTime month,
  }) async {
    try {
      // 1. Get current month expenses
      final currentExpenses =
          await _expenseRepo.watchByMonth(userId, month).first;

      // 2. Get previous month expenses
      final prevMonth = DateTime(month.year, month.month - 1);
      final prevExpenses =
          await _expenseRepo.watchByMonth(userId, prevMonth).first;

      // 3. Aggregate data
      double totalSpend = 0;
      final Map<String, double> categoryBreakdown = {};
      final Map<String, double> dailySpend = {};

      for (final e in currentExpenses) {
        if (e.isDeleted) continue;

        totalSpend += e.amount;

        // Category
        categoryBreakdown[e.category] =
            (categoryBreakdown[e.category] ?? 0) + e.amount;

        // Daily
        final day = e.date.day.toString().padLeft(2, '0');
        dailySpend[day] = (dailySpend[day] ?? 0) + e.amount;
      }

      double prevTotal = prevExpenses
          .where((e) => !e.isDeleted)
          .fold(0.0, (sum, e) => sum + e.amount);

      double changePercent =
          prevTotal == 0 ? 0 : ((totalSpend - prevTotal) / prevTotal) * 100;

      return Right(MonthlySummary(
        totalSpend: totalSpend,
        spendByCategory: categoryBreakdown,
        dailySpend: dailySpend,
        previousMonthTotal: prevTotal,
        changePercent: changePercent,
        expenses: currentExpenses.where((e) => !e.isDeleted).toList(),
        previousMonthExpenses: prevExpenses.where((e) => !e.isDeleted).toList(),
      ));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
