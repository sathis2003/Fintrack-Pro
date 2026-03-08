import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger();

  static void i(String tag, String message) => _logger.i('[$tag] $message');
  static void e(String tag, String message, [dynamic error]) =>
      _logger.e('[$tag] $message', error: error);
  static void w(String tag, String message) => _logger.w('[$tag] $message');
  static void d(String tag, String message) => _logger.d('[$tag] $message');
}
