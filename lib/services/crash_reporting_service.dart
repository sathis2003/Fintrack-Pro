import 'package:sentry_flutter/sentry_flutter.dart';

class CrashReportingService {
  static Future<void> init() async {
    // Sentry is already initialized in main.dart
  }

  // Call after user logs in — links crashes to user
  static Future<void> setUser(String userId) async {
    Sentry.configureScope((scope) => scope.setUser(SentryUser(id: userId)));
  }

  // Log non-fatal errors
  static Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) async {
    await Sentry.captureException(
      exception,
      stackTrace: stack,
      hint: reason != null ? Hint.withMap({'reason': reason}) : null,
    );
  }

  // Add custom key-value context to crash reports
  static Future<void> addContext(String key, String value) async {
    Sentry.configureScope((scope) => scope.setTag(key, value));
  }
}
