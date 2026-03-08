import 'package:flutter/material.dart';

class AppGradients {
  // ── Hero spend card (Dashboard) ────────────────────────
  // Light: soft violet to white  |  Dark: deep violet to near-black
  static const heroCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4C1D95), // deep violet
      Color(0xFF1E1B4B), // indigo-dark
      Color(0xFF0C0C14), // near black
    ],
    stops: [0.0, 0.5, 1.0],
  );

  // ── Primary action button (Coral → Violet) ─────────────
  static const primaryButton = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF6C2BD9), Color(0xFFFF6B6B)],
  );

  // ── Pro / upgrade card ──────────────────────────────────
  static const proCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A0533), Color(0xFF6C2BD9)],
  );

  // ── Category cards (one per category) ───────────────────
  static LinearGradient category(String cat, bool isDark) {
    final Map<String, List<Color>> light = {
      'Food': [const Color(0xFFFFF3E0), const Color(0xFFFFFAF0)],
      'Transport': [const Color(0xFFE3F2FD), const Color(0xFFF0F8FF)],
      'Shopping': [const Color(0xFFF3E5F5), const Color(0xFFFAF0FF)],
      'Bills': [const Color(0xFFFFF8E1), const Color(0xFFFFFDF0)],
      'Health': [const Color(0xFFE8F5E9), const Color(0xFFF0FFF0)],
      'Entertainment': [const Color(0xFFFCE4EC), const Color(0xFFFFF0F5)],
      'Education': [const Color(0xFFE1F5FE), const Color(0xFFF0FAFF)],
      'Investment': [const Color(0xFFE8EAF6), const Color(0xFFF5F5FF)],
      'Other': [const Color(0xFFF5F5F5), const Color(0xFFFAFAFA)],
    };
    final Map<String, List<Color>> dark = {
      'Food': [const Color(0xFF2A1A00), const Color(0xFF14141F)],
      'Transport': [const Color(0xFF001529), const Color(0xFF14141F)],
      'Shopping': [const Color(0xFF1A0033), const Color(0xFF14141F)],
      'Bills': [const Color(0xFF2A1F00), const Color(0xFF14141F)],
      'Health': [const Color(0xFF002A0F), const Color(0xFF14141F)],
      'Entertainment': [const Color(0xFF2A0015), const Color(0xFF14141F)],
      'Education': [const Color(0xFF00152A), const Color(0xFF14141F)],
      'Investment': [const Color(0xFF0A0A2A), const Color(0xFF14141F)],
      'Other': [const Color(0xFF1A1A1A), const Color(0xFF14141F)],
    };
    final colors = isDark ? dark[cat] : light[cat];
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors ?? [Colors.grey.shade100, Colors.white],
    );
  }

  // ── Budget progress bar fill ─────────────────────────────
  static const budgetFill = LinearGradient(
    colors: [Color(0xFF6C2BD9), Color(0xFF00C2CB)],
  );

  // ── Stat card (small metric cards on Dashboard) ──────────
  static LinearGradient statCard(bool isDark) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [const Color(0xFF1E1E2E), const Color(0xFF14141F)]
            : [const Color(0xFFFFFFFF), const Color(0xFFF4F0FF)],
      );
}
