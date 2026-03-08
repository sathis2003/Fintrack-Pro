import 'dart:math';
import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import '../database/app_database.dart';
import '../tables/financial_profile_table.dart';
import 'package:injectable/injectable.dart';

part 'financial_profile_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [FinancialProfiles])
class FinancialProfileDao extends DatabaseAccessor<AppDatabase>
    with _$FinancialProfileDaoMixin {
  FinancialProfileDao(super.db);

  Future<FinancialProfile?> getByUser(String userId) =>
      (select(financialProfiles)..where((p) => p.userId.equals(userId)))
          .getSingleOrNull();

  Future<void> updateStreak(String userId) async {
    final profile = await getByUser(userId);
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final yesterday = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(const Duration(days: 1)));

    if (profile?.lastTrackedDate == today) return; // already tracked today

    int newStreak;
    if (profile?.lastTrackedDate == yesterday) {
      newStreak = (profile?.currentStreak ?? 0) + 1;
    } else {
      newStreak = 1; // streak broken, restart
    }

    final longest = max(newStreak, profile?.longestStreak ?? 0);

    await (update(financialProfiles)..where((p) => p.userId.equals(userId)))
        .write(FinancialProfilesCompanion(
      currentStreak: Value(newStreak),
      longestStreak: Value(longest),
      lastTrackedDate: Value(today),
    ));
  }

  Future<void> upsertProfile(FinancialProfilesCompanion entry) =>
      into(financialProfiles).insertOnConflictUpdate(entry);

  Future<void> updateIncome(String userId, double amount) =>
      (update(financialProfiles)..where((p) => p.userId.equals(userId)))
          .write(FinancialProfilesCompanion(
        monthlyIncome: Value(amount),
      ));
}
