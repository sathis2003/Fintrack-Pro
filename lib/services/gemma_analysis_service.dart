import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../domain/value_objects/monthly_summary.dart';
import '../domain/entities/recurring_expense.dart';

class GemmaAnalysisService {
  // ── Context builder (keeps tokens under 2000) ──
  static String buildContext({
    required MonthlySummary current,
    required MonthlySummary previous,
    required List<RecurringExpense> recurring,
    required double monthlyIncome,
  }) {
    final buf = StringBuffer();
    buf.writeln('Monthly income: Rs${monthlyIncome.toInt()}');
    buf.writeln('This month spent: Rs${current.totalSpend.toInt()}');
    buf.writeln('Last month spent: Rs${previous.totalSpend.toInt()}');
    buf.writeln('Category breakdown this month:');
    current.spendByCategory.forEach((cat, amt) {
      if (amt > 0) buf.writeln('  $cat: Rs${amt.toInt()}');
    });
    if (recurring.isNotEmpty) {
      buf.writeln('Upcoming recurring:');
      for (final r in recurring.take(5)) {
        buf.writeln(
            '  ${r.description}: Rs${r.averageAmount.toInt()} on ${r.nextExpectedDate.day}th');
      }
    }
    return buf.toString();
  }

  // ── Hash for cache key ──
  static String hashContext(String context) {
    final bytes = utf8.encode(context);
    return sha256.convert(bytes).toString().substring(0, 16);
  }

  // ── Prompt templates ──

  static String patternPrompt(String context) => '''
You are a personal finance assistant for an Indian user.
Analyse this spending data and give ONE key insight in 2 sentences max.
Be specific with rupee amounts. Be encouraging but honest.
Do NOT use markdown. Plain text only.

$context

Key insight:''';

  static String categoryPrompt(String partialText) => '''
Indian expense tracker. User is typing an expense.
Respond with ONLY ONE category word from this list:
Food | Transport | Shopping | Bills | Health | Entertainment | Education | Investment | Other

User typed: "$partialText"

Category:''';

  static String anomalyPrompt(String category, double currentSpend,
          double lastMonthSpend, double ratio) =>
      '''
Write ONE friendly sentence warning an Indian user about unusual spending.
Be specific with amounts. Maximum 20 words. No markdown. No emojis.

Category: $category
This month so far: Rs${currentSpend.toInt()}
Last month full: Rs${lastMonthSpend.toInt()}
Ratio: ${ratio.toStringAsFixed(1)}x higher

Warning:''';

  static String weeklyDigestPrompt({
    required double totalSpend,
    required String topCategory,
    required int expenseCount,
  }) =>
      '''
Write a 2-sentence weekly spending summary for an Indian user.
Be encouraging and specific. No markdown.

This week: Rs${totalSpend.toInt()} spent across $expenseCount expenses.
Top category: $topCategory

Summary:''';
}
