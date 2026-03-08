import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const SkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? const Color(0xFF1E1E2E) : const Color(0xFFEDE9FE),
      highlightColor:
          isDark ? const Color(0xFF2D1B69) : const Color(0xFFF4F0FF),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E2E) : const Color(0xFFEDE9FE),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
