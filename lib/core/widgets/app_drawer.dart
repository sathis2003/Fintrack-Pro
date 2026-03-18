import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class AppDrawer extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onClose;
  const AppDrawer(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      required this.onClose});

  @override
  Widget build(BuildContext context) {
    // Inject your DashboardBloc or FinancialProfileBloc here
    // to get real salary + spent values
    const salary = 15000.0; // replace with bloc state
    const spent = 1300.0; // replace with bloc state
    final balance = salary - spent;
    final pct = spent / salary;

    return SizedBox(
      width: 280,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.drawerBg,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(32), bottomRight: Radius.circular(32)),
        ),
        child: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // ── Top gradient section ──
            _DrawerTop(),
            const SizedBox(height: 12),
            // ── Balance card ──
            _BalanceCard(balance: balance, salary: salary, pct: pct),
            const SizedBox(height: 8),
            // ── Nav items ──
            Expanded(
                child: _NavList(
                    currentIndex: currentIndex,
                    onTap: (i) {
                      HapticFeedback.selectionClick();
                      onTap(i);
                    })),
            // ── Sign out ──
            _DrawerBottom(),
          ]),
        ),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────
class _DrawerTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A0A3E), Color(0xFF0C0C14)]),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Avatar
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFF5B2EFF), Color(0xFFFF3B5C)]),
              borderRadius: BorderRadius.circular(16)),
          child: Center(
              child: Text('T',
                  style: GoogleFonts.sora(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white))),
        ),
        const SizedBox(height: 12),
        Text('testing12',
            style: GoogleFonts.sora(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        const SizedBox(height: 3),
        Text('testing12@gmail.com',
            style: GoogleFonts.inter(
                fontSize: 12, color: Colors.white.withValues(alpha: 0.4))),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: const Color(0xFFFFB800).withValues(alpha: 0.12),
              border: Border.all(
                  color: const Color(0xFFFFB800).withValues(alpha: 0.25)),
              borderRadius: BorderRadius.circular(8)),
          child: Text('⭐  FREE — Upgrade to Pro',
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFFB800))),
        ),
      ]),
    );
  }
}

// ── Balance card ──────────────────────────────────────
class _BalanceCard extends StatelessWidget {
  final double balance, salary, pct;
  const _BalanceCard(
      {required this.balance, required this.salary, required this.pct});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('BALANCE THIS MONTH',
                style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                    color: Colors.white.withValues(alpha: 0.35))),
            const SizedBox(height: 4),
            Text('₹${balance.toInt()}',
                style: GoogleFonts.sora(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5)),
            const SizedBox(height: 2),
            Text(
                'from ₹${salary.toInt()} salary · ${(pct * 100).toStringAsFixed(1)}% used',
                style: GoogleFonts.inter(
                    fontSize: 11, color: Colors.white.withValues(alpha: 0.35))),
            const SizedBox(height: 12),
            // Progress bar
            ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                    value: pct.clamp(0.0, 1.0),
                    minHeight: 4,
                    backgroundColor: Colors.white.withValues(alpha: 0.08),
                    valueColor:
                        const AlwaysStoppedAnimation(Color(0xFF5B2EFF)))),
          ],
        ),
      ),
    );
  }
}

// ── Nav items ─────────────────────────────────────────
class _NavList extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _NavList({required this.currentIndex, required this.onTap});

  static const _items = [
    _DrawerItem(
        emoji: '💬',
        label: 'AI Chat',
        sub: 'Log expenses, ask anything',
        badge: ''),
    _DrawerItem(
        emoji: '📊', label: 'Dashboard', sub: 'Your money overview', badge: ''),
    _DrawerItem(
        emoji: '🕐', label: 'History', sub: 'All transactions', badge: ''),
    _DrawerItem(
        emoji: '🏆',
        label: 'Achievements',
        sub: '7 day streak 🔥',
        badge: 'New'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      children: [
        _sectionLabel('MENU'),
        ...List.generate(
            _items.length,
            (i) => _DrawerTile(
                  item: _items[i],
                  isActive: i == currentIndex,
                  onTap: () => onTap(i),
                )),
      ],
    );
  }

  Widget _sectionLabel(String t) => Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      child: Text(t,
          style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: Colors.white.withValues(alpha: 0.25))));
}

class _DrawerItem {
  final String emoji, label, sub, badge;
  const _DrawerItem(
      {required this.emoji,
      required this.label,
      required this.sub,
      required this.badge});
}

class _DrawerTile extends StatelessWidget {
  final _DrawerItem item;
  final bool isActive;
  final VoidCallback onTap;
  const _DrawerTile(
      {required this.item, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
            color: isActive
                ? Colors.white.withValues(alpha: 0.07)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          // Icon box
          AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                  gradient: isActive
                      ? const LinearGradient(
                          colors: [Color(0xFF5B2EFF), Color(0xFFFF3B5C)])
                      : null,
                  color: isActive ? null : Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                  child:
                      Text(item.emoji, style: const TextStyle(fontSize: 18)))),
          const SizedBox(width: 12),
          // Text
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.label,
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isActive
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.75))),
              const SizedBox(height: 1),
              Text(item.sub,
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.3))),
            ],
          )),
          // Badge
          if (item.badge.isNotEmpty)
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                    color: const Color(0xFFFF3B5C),
                    borderRadius: BorderRadius.circular(6)),
                child: Text(item.badge,
                    style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white))),
          // Active dot
          if (item.badge.isEmpty && isActive)
            Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                    color: Color(0xFF00C896), shape: BoxShape.circle)),
        ]),
      ),
    );
  }
}

// ── Bottom sign out ───────────────────────────────────
class _DrawerBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.06)))),
      child: GestureDetector(
        onTap: () {/* sign out */},
        child: Row(children: [
          Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.logout_rounded,
                  size: 16, color: Colors.white54)),
          const SizedBox(width: 10),
          Text('Sign out',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white38)),
        ]),
      ),
    );
  }
}
