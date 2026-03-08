import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextTheme get textTheme => TextTheme(
        displayLarge: GoogleFonts.sora(
            fontSize: 48, fontWeight: FontWeight.w700, letterSpacing: -1.5),
        displayMedium: GoogleFonts.sora(
            fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -1.0),
        displaySmall: GoogleFonts.sora(
            fontSize: 28, fontWeight: FontWeight.w600, letterSpacing: -0.5),
        headlineLarge:
            GoogleFonts.sora(fontSize: 24, fontWeight: FontWeight.w600),
        headlineMedium: GoogleFonts.plusJakartaSans(
            fontSize: 20, fontWeight: FontWeight.w600),
        titleLarge: GoogleFonts.plusJakartaSans(
            fontSize: 18, fontWeight: FontWeight.w600),
        titleMedium: GoogleFonts.plusJakartaSans(
            fontSize: 16, fontWeight: FontWeight.w500),
        bodyLarge: GoogleFonts.plusJakartaSans(
            fontSize: 15, fontWeight: FontWeight.w400),
        bodyMedium: GoogleFonts.plusJakartaSans(
            fontSize: 13, fontWeight: FontWeight.w400),
        labelLarge: GoogleFonts.plusJakartaSans(
            fontSize: 12, fontWeight: FontWeight.w500),
        labelSmall: GoogleFonts.plusJakartaSans(
            fontSize: 10, fontWeight: FontWeight.w500),
      );
}
