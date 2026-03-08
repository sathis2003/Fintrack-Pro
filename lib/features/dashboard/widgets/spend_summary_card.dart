import 'package:flutter/material.dart';
import '../../../../domain/value_objects/monthly_summary.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/animated_amount.dart';
import '../../../../core/constants/app_gradients.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/gradient_progress_bar.dart';

class SpendSummaryCard extends StatelessWidget {
  final MonthlySummary summary;
  final double? monthlyIncome;

  const SpendSummaryCard(
      {super.key, required this.summary, this.monthlyIncome});

  @override
  Widget build(BuildContext context) {
    final isIncrease = summary.changePercent > 0;

    return GradientCard(
      gradient: AppGradients.heroCard,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'TOTAL SPENT THIS MONTH',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.7),
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      isIncrease ? Icons.trending_up : Icons.trending_down,
                      size: 14,
                      color: isIncrease
                          ? const Color(0xFFFF8B8B)
                          : const Color(0xFF6EE7B7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${summary.changePercent.abs().toStringAsFixed(1)}%',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isIncrease
                            ? const Color(0xFFFF8B8B)
                            : const Color(0xFF6EE7B7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedAmount(
            amount: summary.totalSpend,
            style: GoogleFonts.sora(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Keep it up! You are within limits.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.65),
            ),
          ),
          if (monthlyIncome != null && monthlyIncome! > 0) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Balance Remaining',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '₹${(monthlyIncome! - summary.totalSpend).toInt()}',
                  style: GoogleFonts.sora(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GradientProgressBar(
              value: (summary.totalSpend / monthlyIncome!).clamp(0.0, 1.0),
              height: 5,
            ),
          ],
        ],
      ),
    );
  }
}
