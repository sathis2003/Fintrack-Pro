import 'package:flutter/material.dart';

class GradientCard extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final EdgeInsets? padding;
  final double radius;
  final Color? borderColor;

  const GradientCard({
    super.key,
    required this.child,
    required this.gradient,
    this.padding,
    this.radius = 20,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: borderColor ??
              (isDark ? const Color(0xFF2D1B69) : const Color(0xFFE5E7EB)),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color:
                const Color(0xFF6C2BD9).withValues(alpha: isDark ? 0.25 : 0.10),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}
