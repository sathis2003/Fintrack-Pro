// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievements_dao.dart';

// ignore_for_file: type=lint
mixin _$AchievementsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AchievementsTableTable get achievementsTable =>
      attachedDatabase.achievementsTable;
  AchievementsDaoManager get managers => AchievementsDaoManager(this);
}

class AchievementsDaoManager {
  final _$AchievementsDaoMixin _db;
  AchievementsDaoManager(this._db);
  $$AchievementsTableTableTableManager get achievementsTable =>
      $$AchievementsTableTableTableManager(
          _db.attachedDatabase, _db.achievementsTable);
}
