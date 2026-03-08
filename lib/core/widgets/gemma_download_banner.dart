import 'package:flutter/material.dart';
import '../../services/gemma_model_service.dart';

class GemmaDownloadBanner extends StatelessWidget {
  const GemmaDownloadBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double?>(
      valueListenable: GemmaModelService.downloadProgress,
      builder: (context, progress, _) {
        if (progress == null || progress >= 1.0) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: const Color(0xFF7C3AED).withValues(alpha: 0.1),
          child: Row(
            children: [
              const Icon(Icons.auto_awesome,
                  color: Color(0xFF7C3AED), size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Downloading on-device AI (${(progress * 100).toInt()}%)',
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF7C3AED)),
                    ),
                    const SizedBox(height: 2),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF7C3AED)),
                      minHeight: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

