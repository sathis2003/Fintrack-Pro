import 'package:uuid/uuid.dart';
import '../domain/entities/recurring_expense.dart';
import '../../../domain/entities/expense.dart';

class DetectedRecurrence {
  final String description;
  final String category;
  final double averageAmount;
  final String frequency;
  final int dayOfMonth;
  final DateTime lastOccurrence;
  final DateTime nextExpectedDate;
  final double confidence; // 0.0–1.0

  const DetectedRecurrence({
    required this.description,
    required this.category,
    required this.averageAmount,
    required this.frequency,
    required this.dayOfMonth,
    required this.lastOccurrence,
    required this.nextExpectedDate,
    required this.confidence,
  });

  RecurringExpense toDomain(String userId) {
    return RecurringExpense(
      uuid: const Uuid().v4(),
      userId: userId,
      category: category,
      description: description,
      averageAmount: averageAmount,
      dayOfMonth: dayOfMonth,
      frequency: frequency,
      isActive: true,
      reminderEnabled: true,
      reminderDaysBefore: 3,
      lastOccurrence: lastOccurrence,
      nextExpectedDate: nextExpectedDate,
    );
  }
}

class RecurrenceDetector {
  // Algorithm: looks at last 90 days of expenses
  // Groups by (description_similarity + category)
  // If same description appears 2+ times with ~30-day gap → mark as monthly recurring
  // If appears 4+ times with ~7-day gap → mark as weekly recurring

  static List<DetectedRecurrence> detect(List<Expense> last90DaysExpenses) {
    final grouped = <String, List<Expense>>{};

    // Group by normalized description key
    for (final e in last90DaysExpenses) {
      final key = _normalizeDescription(e.description);
      grouped.putIfAbsent(key, () => []).add(e);
    }

    final results = <DetectedRecurrence>[];

    grouped.forEach((key, expenses) {
      if (expenses.length < 2) return;

      // Sort by date
      expenses.sort((a, b) => a.date.compareTo(b.date));

      // Calculate gaps between consecutive occurrences
      final gaps = <int>[];
      for (int i = 1; i < expenses.length; i++) {
        gaps.add(expenses[i].date.difference(expenses[i - 1].date).inDays);
      }

      final avgGap = gaps.reduce((a, b) => a + b) / gaps.length;
      final variance = _variance(gaps, avgGap);

      // Low variance = consistent pattern
      if (variance > 8) return; // too irregular

      String frequency;
      if (avgGap >= 25 && avgGap <= 35) {
        frequency = 'monthly';
      } else if (avgGap >= 6 && avgGap <= 8) {
        frequency = 'weekly';
      } else if (avgGap >= 350 && avgGap <= 380) {
        frequency = 'yearly';
      } else {
        return; // not a recognized pattern
      }

      final avgAmount = expenses.map((e) => e.amount).reduce((a, b) => a + b) /
          expenses.length;
      final lastDate = expenses.last.date;
      final nextDate = _computeNextDate(lastDate, frequency, avgGap.round());

      results.add(DetectedRecurrence(
        description: expenses.first.description,
        category: expenses.first.category,
        averageAmount: avgAmount,
        frequency: frequency,
        dayOfMonth: lastDate.day,
        lastOccurrence: lastDate,
        nextExpectedDate: nextDate,
        confidence: _confidence(variance, expenses.length),
      ));
    });

    return results;
  }

  // Normalize: lowercase, remove amounts, trim
  static String _normalizeDescription(String desc) => desc
      .toLowerCase()
      .replaceAll(RegExp(r'\d+'), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  static double _variance(List<int> values, double mean) {
    if (values.isEmpty) return 0.0;
    final sumSq =
        values.map((v) => (v - mean) * (v - mean)).reduce((a, b) => a + b);
    return sumSq / values.length;
  }

  static DateTime _computeNextDate(DateTime last, String freq, int avgGap) {
    switch (freq) {
      case 'monthly':
        return DateTime(last.year, last.month + 1, last.day);
      case 'weekly':
        return last.add(const Duration(days: 7));
      case 'yearly':
        return DateTime(last.year + 1, last.month, last.day);
      default:
        return last.add(Duration(days: avgGap));
    }
  }

  static double _confidence(double variance, int occurrenceCount) {
    // Lower variance + more occurrences = higher confidence
    final varianceScore = (1 - (variance / 10)).clamp(0.0, 1.0);
    final countScore = (occurrenceCount / 5).clamp(0.0, 1.0);
    return (varianceScore * 0.6 + countScore * 0.4);
  }
}
