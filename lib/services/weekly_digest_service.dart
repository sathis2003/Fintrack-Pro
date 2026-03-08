import 'package:workmanager/workmanager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../core/di/injection.dart';
import '../data/local/database/app_database.dart';
import 'notification_service.dart';
import 'gemma_model_service.dart';
import 'gemma_analysis_service.dart';

class WeeklyDigestService {
  static Future<void> init() async {
    await Workmanager().initialize(callbackDispatcher);
    await Workmanager().registerPeriodicTask(
      'weekly_digest',
      'sendWeeklyDigest',
      frequency: const Duration(days: 7),
      initialDelay: _nextSunday(),
      constraints: Constraints(networkType: NetworkType.notRequired),
    );
  }

  static Duration _nextSunday() {
    final now = DateTime.now();
    final daysUntilSunday = (7 - now.weekday) % 7;
    final nextSunday = now
        .add(Duration(days: daysUntilSunday == 0 ? 7 : daysUntilSunday))
        .copyWith(hour: 10, minute: 0, second: 0);
    return nextSunday.difference(now);
  }
}

// Top-level function (required by WorkManager — must be outside any class)
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'sendWeeklyDigest') {
      // Re-init dependencies (new isolate)
      // Note: In a real app, these should be handled via environment variables carefully
      try {
        await Supabase.initialize(
          url: const String.fromEnvironment('SUPABASE_URL'),
          anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
        );
        await configureDependencies();

        final userId = Supabase.instance.client.auth.currentUser?.id;
        if (userId == null) return true;

        // Query Drift for last 7 days
        final db = getIt<AppDatabase>();
        final weekStart = DateTime.now().subtract(const Duration(days: 7));
        final expenses = await db.expensesDao
            .getByDateRange(userId, weekStart, DateTime.now());

        if (expenses.isEmpty) return true;

        final total = expenses.fold(0.0, (s, e) => s + e.amount);
        final topCategory = _topCategory(expenses);

        // Try getting an AI summary from Gemma
        String body = '₹${total.toInt()} spent in ${expenses.length} expenses.';
        if (GemmaModelService.isReady.value) {
          final prompt = GemmaAnalysisService.weeklyDigestPrompt(
            totalSpend: total,
            topCategory: topCategory,
            expenseCount: expenses.length,
          );
          final summary = await GemmaModelService.generateSync(prompt);
          if (summary.isNotEmpty) body = summary;
        }

        await NotificationService.showWeeklyDigest(
          total: total,
          topCategory: topCategory,
          count: expenses.length,
          customBody: body,
        );
      } catch (e, stackTrace) {
        await Sentry.captureException(
          e,
          stackTrace: stackTrace,
          hint: Hint.withMap({'context': 'weekly_digest_bg_fail'}),
        );
        return false;
      }
    }
    return true;
  });
}

String _topCategory(List<dynamic> expenses) {
  final counts = <String, double>{};
  for (final e in expenses) {
    counts[e.category] = (counts[e.category] ?? 0.0) + e.amount;
  }
  var top = 'Other';
  var maxAmount = -1.0;
  counts.forEach((cat, amount) {
    if (amount > maxAmount) {
      maxAmount = amount;
      top = cat;
    }
  });
  return top;
}
