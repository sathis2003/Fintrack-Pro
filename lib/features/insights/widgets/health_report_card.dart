import 'package:flutter/material.dart';
import '../../../domain/entities/ai_insight.dart';

class HealthReportCard extends StatelessWidget {
  final AiInsight insight;

  const HealthReportCard({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _getGradient(),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.analytics, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Financial Health: ${insight.riskLevel.toUpperCase()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              insight.summary,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Key Suggestions:',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...insight.suggestions.map((s) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text(
                          s,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                )),
            if (insight.positiveNote != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFBBC05), size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        insight.positiveNote!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Color> _getGradient() {
    switch (insight.riskLevel.toLowerCase()) {
      case 'low':
        return [const Color(0xFF0CAF60), const Color(0xFF0F3460)];
      case 'medium':
        return [Colors.orange, const Color(0xFF0F3460)];
      case 'high':
        return [const Color(0xFFE94560), const Color(0xFF0F3460)];
      default:
        return [const Color(0xFF0F3460), Colors.black87];
    }
  }
}

