import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';

class HeroSpendCard extends StatelessWidget {
  final double totalSpent, salary, budget;
  const HeroSpendCard(
      {super.key,
      required this.totalSpent,
      required this.salary,
      required this.budget});

  @override
  Widget build(BuildContext context) {
    final balance = salary - totalSpent;
    final pct = salary > 0 ? totalSpent / salary : 0.0;

    return Container(
      decoration: BoxDecoration(
          gradient: AppGradients.heroGrad,
          borderRadius: BorderRadius.circular(28)),
      padding: const EdgeInsets.all(24),
      child: Column(children: [
        // Top row
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('TOTAL SPENT',
                    style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                        color: Colors.white.withValues(alpha: 0.35))),
                const SizedBox(height: 6),
                Text('₹${totalSpent.toInt()}',
                    style: GoogleFonts.sora(
                        fontSize: 46,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -2.0)),
              ]),
              // % badge
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                    Text('${(pct * 100).toStringAsFixed(1)}%',
                        style: GoogleFonts.sora(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accent)),
                    Text('of income',
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            color: Colors.white.withValues(alpha: 0.35))),
                  ])),
            ]),
        const SizedBox(height: 16),
        // Balance strip
        Container(
            decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
                borderRadius: BorderRadius.circular(16)),
            child: IntrinsicHeight(
                child: Row(children: [
              Expanded(
                  child: _StripCol(
                      label: 'Balance left',
                      value: '₹${balance.toInt()}',
                      valueColor: AppColors.green)),
              VerticalDivider(
                  width: 1, color: Colors.white.withValues(alpha: 0.07)),
              Expanded(
                  child: _StripCol(
                      label: 'Monthly salary', value: '₹${salary.toInt()}')),
            ]))),
        const SizedBox(height: 14),
        // Progress
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Salary used',
              style: GoogleFonts.inter(
                  fontSize: 11, color: Colors.white.withValues(alpha: 0.3))),
          Text('${(pct * 100).toStringAsFixed(1)}%',
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent)),
        ]),
        const SizedBox(height: 6),
        ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
                value: pct.clamp(0.0, 1.0),
                minHeight: 5,
                backgroundColor: Colors.white.withValues(alpha: 0.08),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.violet))),
      ]),
    );
  }
}

class _StripCol extends StatelessWidget {
  final String label, value;
  final Color? valueColor;
  const _StripCol({required this.label, required this.value, this.valueColor});
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 10, color: Colors.white.withValues(alpha: 0.35))),
        const SizedBox(height: 4),
        Text(value,
            style: GoogleFonts.sora(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: valueColor ?? Colors.white)),
      ]));
}
