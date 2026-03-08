import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  // ── Brand colours (static, theme-independent) ───────────
  static const Color violet = Color(0xFF6C2BD9);
  static const Color violetLight = Color(0xFF8B5CF6);
  static const Color violetTint = Color(0xFFEDE9FE);
  static const Color violetDeep = Color(0xFF2D1B69);
  static const Color coral = Color(0xFFFF6B6B);
  static const Color teal = Color(0xFF00C2CB);
  static const Color gold = Color(0xFFF59E0B);
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);

  // ── Light Theme ──────────────────────────────────────────
  static ThemeData get light => _build(
        brightness: Brightness.light,
        scheme: const ColorScheme.light(
          primary: violet,
          onPrimary: Colors.white,
          secondary: coral,
          onSecondary: Colors.white,
          tertiary: teal,
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF111827),
          surfaceContainerHighest: Color(0xFFF4F0FF),
          outline: Color(0xFFE5E7EB),
          error: error,
          shadow: Color(0x146C2BD9),
        ),
        scaffoldBg: const Color(0xFFFAFAFA),
        cardBg: const Color(0xFFFFFFFF),
        subtleText: const Color(0xFF6B7280),
        overlayStyle: SystemUiOverlayStyle.dark,
      );

  // ── Dark Theme ───────────────────────────────────────────
  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        scheme: const ColorScheme.dark(
          primary: violet,
          onPrimary: Colors.white,
          secondary: coral,
          onSecondary: Colors.white,
          tertiary: teal,
          surface: Color(0xFF14141F),
          onSurface: Color(0xFFF9FAFB),
          surfaceContainerHighest: Color(0xFF1E1E2E),
          outline: Color(0xFF2D1B69),
          error: error,
          shadow: Color(0x1A6C2BD9),
        ),
        scaffoldBg: const Color(0xFF0C0C14),
        cardBg: const Color(0xFF14141F),
        subtleText: const Color(0xFF9CA3AF),
        overlayStyle: SystemUiOverlayStyle.light,
      );

  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme scheme,
    required Color scaffoldBg,
    required Color cardBg,
    required Color subtleText,
    required SystemUiOverlayStyle overlayStyle,
  }) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: AppTypography.textTheme.apply(
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBg,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle:
            overlayStyle.copyWith(statusBarColor: Colors.transparent),
        titleTextStyle: GoogleFonts.sora(
            fontSize: 20, fontWeight: FontWeight.w600, color: scheme.onSurface),
      ),
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: scheme.outline, width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: violet,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.plusJakartaSans(
              fontSize: 16, fontWeight: FontWeight.w600),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: violet,
          minimumSize: const Size.fromHeight(52),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          side: const BorderSide(color: Color(0xFF6C2BD9), width: 1.5),
          textStyle: GoogleFonts.plusJakartaSans(
              fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF6C2BD9), width: 2),
        ),
        hintStyle: GoogleFonts.plusJakartaSans(color: subtleText, fontSize: 15),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerHighest,
        selectedColor: isDark ? violetDeep : violetTint,
        labelStyle: GoogleFonts.plusJakartaSans(fontSize: 12),
        side: BorderSide(color: scheme.outline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      dividerTheme:
          DividerThemeData(color: scheme.outline, thickness: 1, space: 1),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: violet,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        elevation: 6,
      ),
    );
  }
}
