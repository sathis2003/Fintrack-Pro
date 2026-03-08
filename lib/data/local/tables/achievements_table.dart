import 'package:drift/drift.dart';

class AchievementsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get badgeId => text()(); // e.g. "first_expense", "week_streak"
  TextColumn get badgeName => text()();
  TextColumn get badgeDescription => text()();
  TextColumn get badgeIcon => text()(); // emoji or asset path
  BoolColumn get isUnlocked => boolean().withDefault(const Constant(false))();
  DateTimeColumn get unlockedAt => dateTime().nullable()();
}
