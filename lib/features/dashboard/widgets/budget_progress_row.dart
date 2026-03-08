import 'package:flutter/material.dart';
import '../../../../domain/entities/budget.dart';
import '../../../../core/widgets/gradient_progress_bar.dart';

class BudgetProgressRow extends StatelessWidget {
  final Budget budget;
  final double spent;

  const BudgetProgressRow({
    super.key,
    required this.budget,
    required this.spent,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (spent / budget.amount).clamp(0.0, 1.0);
    final isExceeded = spent > budget.amount;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                budget.category,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const Spacer(),
              Text(
                '₹${spent.toStringAsFixed(0)} / ₹${budget.amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 13,
                  color: isExceeded
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                  fontWeight: isExceeded ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GradientProgressBar(
            value: percent,
            height: 8,
          ),
        ],
      ),
    );
  }
}
