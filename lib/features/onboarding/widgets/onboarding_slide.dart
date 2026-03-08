import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:lottie/lottie.dart';

class OnboardingSlide extends StatelessWidget {
  final String headline;
  final String subtitle;
  final String lottieAsset;
  final List<Color> gradientColors;

  const OnboardingSlide({
    super.key,
    required this.headline,
    required this.subtitle,
    required this.lottieAsset,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    Widget illustrationWidget = Lottie.asset(
      lottieAsset,
      width: 280,
      height: 280,
      repeat: true,
      errorBuilder: (context, error, stackTrace) => const Icon(
        Icons.insights,
        size: 200,
        color: Colors.white,
      ),
    );

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const Spacer(flex: 4),
            illustrationWidget
                .animate()
                .fade(duration: 600.ms)
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
            const SizedBox(height: 60),
            Text(
              headline,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
            ).animate().fade(delay: 300.ms).slideY(begin: 0.1, end: 0),
            const SizedBox(height: 20),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.75),
                height: 1.5,
              ),
            ).animate().fade(delay: 500.ms).slideY(begin: 0.1, end: 0),
            const Spacer(flex: 6),
          ],
        ),
      ),
    );
  }
}
