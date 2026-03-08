import 'package:sentry_flutter/sentry_flutter.dart';

/// Lightweight analytics service backed by Sentry breadcrumbs.
///
/// All events are recorded as Sentry breadcrumbs so they appear in
/// crash/error reports, giving full context without needing Firebase.
class AnalyticsService {
  static void _log(String name, [Map<String, dynamic>? params]) {
    Sentry.addBreadcrumb(Breadcrumb(
      message: name,
      category: 'analytics',
      data: params,
    ));
  }

  static Future<void> logSignup({required String method}) async {
    _log('sign_up', {'method': method});
  }

  static Future<void> logLogin({required String method}) async {
    _log('login', {'method': method});
  }

  static Future<void> logExpenseSaved({
    required String category,
    required double amount,
    required String source, // 'chat' | 'manual'
  }) async {
    _log('expense_saved', {
      'category': category,
      'amount': amount.round(),
      'source': source,
    });
  }

  static Future<void> logReportGenerated({required String month}) async {
    _log('ai_report_generated', {'month': month});
  }

  static Future<void> logExport({
    required String format,
    required String month,
  }) async {
    _log('export_triggered', {'format': format, 'month': month});
  }

  static Future<void> logPurchase(String productId) async {
    _log('purchase', {
      'product_id': productId,
      'currency': 'INR',
      'value': productId.contains('yearly') ? 1499.0 : 199.0,
    });
  }

  static Future<void> logBadgeUnlocked(String badgeId) async {
    _log('badge_unlocked', {'badge_id': badgeId});
  }

  static Future<void> setUserProperties({required bool isPro}) async {
    Sentry.configureScope((scope) => scope.setTag('is_pro', isPro.toString()));
  }
}
