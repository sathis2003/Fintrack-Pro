import 'package:flutter/material.dart';

abstract class AppGradients {
  static const heroGrad = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF0C0C14), Color(0xFF1A0A3E), Color(0xFF2E0A1A)],
      stops: [0.0, 0.5, 1.0]);

  static const accentGrad =
      LinearGradient(colors: [Color(0xFFFF3B5C), Color(0xFFFF6B35)]);

  static const violetGrad =
      LinearGradient(colors: [Color(0xFF5B2EFF), Color(0xFF9B59FF)]);

  static const drawerTopGrad = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF1A0A3E), Color(0xFF0C0C14)]);
}
