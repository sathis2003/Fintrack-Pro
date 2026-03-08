import 'package:equatable/equatable.dart';

class AiInsight extends Equatable {
  final int? id;
  final String userId;
  final String month; // "YYYY-MM"
  final String riskLevel; // "low" | "medium" | "high"
  final double riskScore; // 0.0–100.0
  final String summary; // 2-3 sentence paragraph
  final List<String> suggestions; // 3–5 action items
  final String? positiveNote; // 1 encouraging sentence
  final DateTime? exhaustionDate; // projected date savings run out (nullable)
  final DateTime generatedAt;

  const AiInsight({
    this.id,
    required this.userId,
    required this.month,
    required this.riskLevel,
    required this.riskScore,
    required this.summary,
    required this.suggestions,
    this.positiveNote,
    this.exhaustionDate,
    required this.generatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        month,
        riskLevel,
        riskScore,
        summary,
        suggestions,
        positiveNote,
        exhaustionDate,
        generatedAt,
      ];
}
