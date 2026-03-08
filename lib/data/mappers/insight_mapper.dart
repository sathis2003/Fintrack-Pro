import 'dart:convert';
import 'package:drift/drift.dart';
import '../../domain/entities/ai_insight.dart';
import '../local/database/app_database.dart';

class InsightMapper {
  static AiInsight fromRow(AiInsightData row) {
    return AiInsight(
      id: row.id,
      userId: row.userId,
      month: row.month.toString(),
      riskLevel: row.riskLevel,
      riskScore: row.riskScore.toDouble(),
      summary: row.summary,
      suggestions: List<String>.from(jsonDecode(row.suggestions)),
      positiveNote: row.positiveNote,
      exhaustionDate: row.exhaustionDate != null
          ? DateTime.fromMillisecondsSinceEpoch(row.exhaustionDate!)
          : null,
      generatedAt: DateTime.fromMillisecondsSinceEpoch(row.generatedAt),
    );
  }

  static AiInsightsCompanion toCompanion(AiInsight entity) {
    return AiInsightsCompanion(
      userId: Value(entity.userId),
      month: Value(int.parse(entity.month.replaceAll('-', ''))),
      riskLevel: Value(entity.riskLevel),
      riskScore: Value(entity.riskScore.toInt()),
      summary: Value(entity.summary),
      suggestions: Value(jsonEncode(entity.suggestions)),
      positiveNote: Value(entity.positiveNote),
      exhaustionDate: Value(entity.exhaustionDate?.millisecondsSinceEpoch),
      generatedAt: Value(entity.generatedAt.millisecondsSinceEpoch),
    );
  }
}
