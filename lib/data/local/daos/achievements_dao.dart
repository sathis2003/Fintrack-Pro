import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../tables/achievements_table.dart';
import '../../../core/constants/achievement_definitions.dart';

import 'package:injectable/injectable.dart';

part 'achievements_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [AchievementsTable])
class AchievementsDao extends DatabaseAccessor<AppDatabase>
    with _$AchievementsDaoMixin {
  AchievementsDao(super.db);

  Future<List<AchievementsTableData>> getAll(String userId) =>
      (select(achievementsTable)..where((a) => a.userId.equals(userId))).get();

  Future<void> unlock(String userId, String badgeId) async {
    await (update(achievementsTable)
          ..where((a) => a.userId.equals(userId) & a.badgeId.equals(badgeId)))
        .write(AchievementsTableCompanion(
      isUnlocked: const Value(true),
      unlockedAt: Value(DateTime.now()),
    ));
  }

  // Seed all badges for new user (call once after signup)
  Future<void> seedBadges(String userId) async {
    for (final badge in AchievementDefinitions.all) {
      await into(achievementsTable).insertOnConflictUpdate(
        AchievementsTableCompanion(
          userId: Value(userId),
          badgeId: Value(badge.id),
          badgeName: Value(badge.name),
          badgeDescription: Value(badge.description),
          badgeIcon: Value(badge.icon),
          isUnlocked: const Value(false),
        ),
      );
    }
  }
}
