import 'package:flutter/material.dart';
import '../../../services/gemma_model_service.dart';

class GemmaInsightChip extends StatefulWidget {
  final String? insight;
  const GemmaInsightChip({super.key, this.insight});

  @override
  State<GemmaInsightChip> createState() => _GemmaInsightChipState();
}

class _GemmaInsightChipState extends State<GemmaInsightChip> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GemmaModelService.isReady,
      builder: (context, ready, _) {
        final text = widget.insight;
        if (!ready || text == null || text.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F0FF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF7C3AED).withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              const Icon(Icons.auto_awesome,
                  color: Color(0xFF7C3AED), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF1F2937)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

