import 'package:drift/drift.dart';

@DataClassName('GemmaInsightData')
class GemmaInsightsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get taskType => text()(); // 'pattern' | 'anomaly' | 'weekly'
  TextColumn get contextHash => text()(); // SHA256 substring — cache key
  TextColumn get insightText => text()();
  TextColumn get month => text()(); // 'YYYY-MM'
  DateTimeColumn get generatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
