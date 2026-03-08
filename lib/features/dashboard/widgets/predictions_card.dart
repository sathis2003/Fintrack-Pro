import 'package:flutter/material.dart';
import '../../../services/gemma_model_service.dart';
import '../../../services/gemma_analysis_service.dart';
import '../../../services/prediction_engine.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/animated_amount.dart';

class PredictionData {
  final double predictedTotal;
  final double budgetLimit;
  final bool isOverBudget;
  final String insightMessage;
  final List<CategoryAnomaly> anomalies;

  PredictionData({
    required this.predictedTotal,
    required this.budgetLimit,
    required this.isOverBudget,
    required this.insightMessage,
    required this.anomalies,
  });
}

class PredictionsCard extends StatefulWidget {
  final PredictionData prediction;

  const PredictionsCard({super.key, required this.prediction});

  @override
  State<PredictionsCard> createState() => _PredictionsCardState();
}

class _PredictionsCardState extends State<PredictionsCard> {
  String? _gemmaNarration;

  @override
  void initState() {
    super.initState();
    _loadGemmaNarration();
  }

  Future<void> _loadGemmaNarration() async {
    if (!GemmaModelService.isReady.value) return;
    if (widget.prediction.anomalies.isEmpty) return;

    final anomaly = widget.prediction.anomalies.first;
    final prompt = GemmaAnalysisService.anomalyPrompt(
      anomaly.category,
      anomaly.currentSpend,
      anomaly.lastMonthSpend,
      anomaly.ratio,
    );
    final narration = await GemmaModelService.generateSync(prompt);
    if (mounted && narration.isNotEmpty) {
      setState(() {
        _gemmaNarration = narration;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final prediction = widget.prediction;
    final isOverBudget = prediction.budgetLimit > 0 &&
        prediction.predictedTotal > prediction.budgetLimit;
    final color = isOverBudget ? Colors.redAccent : Colors.greenAccent;
    final insight = _gemmaNarration ??
        (isOverBudget
            ? '⚠️ Over budget by \u20B9${(prediction.predictedTotal - prediction.budgetLimit).toInt()}'
            : '✅ On track: \u20B9${(prediction.budgetLimit - prediction.predictedTotal).toInt()} remaining');

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C2BD9).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome_rounded,
                  color: Color(0xFF00C2CB), size: 18),
              const SizedBox(width: 8),
              Text(
                'AI Prediction',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Estimated Month-End Spend',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedAmount(
                amount: prediction.predictedTotal,
                style: GoogleFonts.sora(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '/ ₹${prediction.budgetLimit.toInt()}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (prediction.predictedTotal / prediction.budgetLimit)
                  .clamp(0.0, 1.0),
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            height: 100,
            width: double.infinity,
            child: _TrajectoryChart(),
          ),
          const SizedBox(height: 12),
          Text(
            insight,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isOverBudget
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF10B981),
                  fontStyle: FontStyle.italic,
                ),
          ),
        ],
      ),
    );
  }
}

class _TrajectoryChart extends StatelessWidget {
  const _TrajectoryChart();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ChartPainter(),
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.7,
      size.width * 0.7,
      size.height * 0.4,
    );
    path.lineTo(size.width, size.height * 0.2);

    canvas.drawPath(path, paint);

    // Dotted prediction line
    final dashPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.5)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(0, size.height * 0.5),
      Offset(size.width, size.height * 0.5),
      dashPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
