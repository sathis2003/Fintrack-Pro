import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget {
  final String? lottiePath;
  final String? imagePath;
  final String title;
  final String subtitle;
  final Widget? action;

  const EmptyState({
    super.key,
    this.lottiePath,
    this.imagePath,
    required this.title,
    required this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (lottiePath != null)
            LottieBuilder.asset(
              lottiePath!,
              width: 200,
              height: 200,
              repeat: true,
              animate: true,
              errorBuilder: (context, error, stackTrace) => _buildFallback(),
            )
          else if (imagePath != null)
            Image.asset(
              imagePath!,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => _buildFallback(),
            )
          else
            _buildFallback(),
          const SizedBox(height: 24),
          Text(title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
          if (action != null) ...[const SizedBox(height: 24), action!],
        ]),
      ),
    );
  }
  Widget _buildFallback() {
    return Container(
      width: 110,
      height: 110,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2D1B69), Color(0xFF6C2BD9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 44),
    );
  }
}
