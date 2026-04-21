import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

@singleton
class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // TEMPORARILY DISABLED: App crashing on startup due to invalid_icon on Android.
    // const android = AndroidInitializationSettings('app_icon');
    // const ios = DarwinInitializationSettings(
    //   requestAlertPermission: true,
    //   requestBadgePermission: true,
    //   requestSoundPermission: true,
    // );
    //
    // await _plugin.initialize(
    //   const InitializationSettings(android: android, iOS: ios),
    // );
  }

  Future<void> showBudgetWarning({
    required String category,
    required double spent,
    required double limit,
    required bool isExceeded,
  }) async {
    final percent = ((spent / limit) * 100).toStringAsFixed(0);
    final title = isExceeded
        ? '⚠️ $category budget exceeded!'
        : '🔔 $category at $percent% of budget';

    final body = isExceeded
        ? 'You spent ₹${spent.toStringAsFixed(0)} of ₹${limit.toStringAsFixed(0)}'
        : '₹${(limit - spent).toStringAsFixed(0)} remaining this month';

    await _plugin.show(
      category.hashCode,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'budget_alerts',
          'Budget Alerts',
          importance: Importance.high,
          priority: Priority.high,
          showWhen: true,
        ),
      ),
    );
  }

  static Future<void> showWeeklyDigest({
    required double total,
    required String topCategory,
    required int count,
    String? customBody,
  }) async {
    final plugin = FlutterLocalNotificationsPlugin();
    await plugin.show(
      9999, // fixed id for weekly digest
      '📊 Your Week in Review',
      customBody ??
          'Spent ₹${total.toStringAsFixed(0)} across $count expenses. Top category: $topCategory',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'weekly_digest',
          'Weekly Digest',
          importance: Importance.defaultImportance,
        ),
      ),
    );
  }
}
