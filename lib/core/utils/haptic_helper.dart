import 'package:flutter/services.dart';

class HapticHelper {
  static void light() => HapticFeedback.lightImpact();
  static void medium() => HapticFeedback.mediumImpact();
  static void success() => HapticFeedback.vibrate(); // Fallback for success
  static void error() => HapticFeedback.vibrate(); // Fallback for error

  // Use specialized notifications if available (requires manual call or wrapper)
}
