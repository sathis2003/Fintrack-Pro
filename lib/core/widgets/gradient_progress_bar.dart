import 'package:flutter/material.dart';
import '../constants/app_gradients.dart';

class GradientProgressBar extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final double height;

  const GradientProgressBar({
    super.key,
    required this.value,
    this.height = 6,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final fillWidth = constraints.maxWidth * value.clamp(0.0, 1.0);
      final isDark = Theme.of(context).brightness == Brightness.dark;
      return Container(
        height: height,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E2E) : const Color(0xFFEDE9FE),
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            width: fillWidth,
            height: height,
            decoration: BoxDecoration(
              gradient: AppGradients.budgetFill,
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
        ),
      );
    });
  }
}
