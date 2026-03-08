import '../data/local/daos/expenses_dao.dart';
import '../data/local/daos/budgets_dao.dart';
import '../data/local/daos/financial_profile_dao.dart';
import 'package:intl/intl.dart';

class ChatContextBuilder {
  final ExpensesDao _expensesDao;
  final BudgetsDao _budgetsDao;
  final FinancialProfileDao _profileDao;

  ChatContextBuilder(
    this._expensesDao,
    this._budgetsDao,
    this._profileDao,
  );

  Future<String> build(String userId) async {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final monthLabel = DateFormat('MMMM yyyy').format(now);

    // ── 1. This month's expenses ──────────────────────────
    final allExpenses =
        await _expensesDao.getByDateRange(userId, monthStart, now);

    final totalSpent = allExpenses.fold(0.0, (s, e) => s + e.amount);

    // Category breakdown
    final Map<String, double> byCategory = {};
    for (final e in allExpenses) {
      byCategory[e.category] = (byCategory[e.category] ?? 0) + e.amount;
    }
    final sortedCats = byCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // ── 2. Budget ──────────────────────────────────────────
    final budget =
        await _budgetsDao.getMonthlyBudget(userId, now.month, now.year);
    final budgetAmount = budget?.amount ?? 0.0;

    // ── 3. Last 5 expenses (recent activity) ─────────────
    final recent = allExpenses.take(5).toList();
    final recentStr = recent
        .map((e) =>
            '${e.category} ₹${e.amount.toInt()} on ${DateFormat('d MMM').format(DateTime.fromMillisecondsSinceEpoch(e.date))}')
        .join('; ');

    // ── 4. Profile (salary if set) ────────────────────────
    final profile = await _profileDao.getByUser(userId);
    final monthlyIncome = profile?.monthlyIncome ?? 0.0;

    // ── 5. Calculations ───────────────────────────────────
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final daysElapsed = now.difference(monthStart).inDays + 1;
    final balance = monthlyIncome - totalSpent;
    final pace = daysElapsed > 0 ? totalSpent / daysElapsed : 0.0;
    final projected = pace * daysInMonth;
    final willOverspend = projected > monthlyIncome;

    // ── Build context string ──────────────────────────────
    final buffer = StringBuffer();
    buffer.writeln('=== USER FINANCIAL DATA ($monthLabel) ===');
    buffer.writeln('monthlyIncome: ₹${monthlyIncome.toInt()}');
    buffer.writeln('totalSpentThisMonth: ₹${totalSpent.toInt()}');
    buffer.writeln('balance_remaining: ₹${balance.toInt()}');
    buffer.writeln('daysElapsed: $daysElapsed of $daysInMonth');
    buffer.writeln('spending_pace: ₹${pace.toStringAsFixed(0)}/day');
    buffer.writeln('will_overspend_this_month: $willOverspend');

    if (willOverspend && monthlyIncome > 0) {
      buffer
          .writeln('WARNING: at this pace, projected = ₹${projected.toInt()}');
      buffer
          .writeln('which exceeds monthlyIncome of ₹${monthlyIncome.toInt()}');
    }

    if (budgetAmount > 0) {
      buffer.writeln('budget_set: ₹${budgetAmount.toInt()}');
      buffer
          .writeln('budget_remaining: ₹${(budgetAmount - totalSpent).toInt()}');
      buffer.writeln('is_over_budget: ${totalSpent > budgetAmount}');
    }

    buffer.writeln('');
    buffer.writeln('category_breakdown:');
    for (final e in sortedCats.take(5)) {
      final amt = e.value;
      final pct = monthlyIncome > 0
          ? (amt / monthlyIncome * 100).toStringAsFixed(1)
          : '0';
      buffer.writeln('  ${e.key}: ₹${amt.toInt()} ($pct% of income)');
    }

    if (recentStr.isNotEmpty) {
      buffer.writeln('');
      buffer.writeln('recent_expenses: $recentStr');
    }
    buffer.writeln('=== END OF DATA ===');

    return buffer.toString();
  }
}
