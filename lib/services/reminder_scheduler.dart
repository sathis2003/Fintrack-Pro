import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../domain/entities/recurring_expense.dart';

class ReminderScheduler {
  static final _plugin = FlutterLocalNotificationsPlugin();

  // Must call once in NotificationService.init()
  static Future<void> initTimezone() async {
    tz.initializeTimeZones();
    // Defaulting to India for now as per guide, but ideally should be dynamic
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
  }

  static Future<void> scheduleRecurringReminder({
    required RecurringExpense recurring,
  }) async {
    final nextExpected = recurring.nextExpectedDate;
    final reminderDate =
        nextExpected.subtract(Duration(days: recurring.reminderDaysBefore));

    if (reminderDate.isBefore(DateTime.now())) return; // already past

    final scheduledDate = tz.TZDateTime.from(reminderDate, tz.local);
    final finalDate = tz.TZDateTime(
      tz.local,
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      9,
    ); // 9 AM notification

    await _plugin.zonedSchedule(
      recurring.uuid.hashCode,
      '📅 Upcoming: ${recurring.description}',
      '₹${recurring.averageAmount.toStringAsFixed(0)} expected in ${recurring.reminderDaysBefore} days',
      finalDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'recurring_reminders',
          'Recurring Reminders',
          channelDescription: 'Reminders for upcoming recurring expenses',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancelRecurringReminder(String uuid) =>
      _plugin.cancel(uuid.hashCode);

  static Future<void> rescheduleAll(List<RecurringExpense> recurrings) async {
    // Cancel all in channel then re-schedule
    for (final r in recurrings) {
      await cancelRecurringReminder(r.uuid);
      if (r.reminderEnabled && r.isActive) {
        await scheduleRecurringReminder(recurring: r);
      }
    }
  }
}
