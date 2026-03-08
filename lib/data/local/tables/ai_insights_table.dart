import 'package:drift/drift.dart';

@DataClassName('AiInsightData')
class AiInsights extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  IntColumn get month => integer()();
  TextColumn get riskLevel => text()();
  IntColumn get riskScore => integer()();
  TextColumn get summary => text()();
  TextColumn get suggestions => text()();
  TextColumn get positiveNote => text().nullable()();
  IntColumn get exhaustionDate => integer().nullable()();
  IntColumn get generatedAt => integer()();
}
