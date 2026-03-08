import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injectable/injectable.dart';
import '../data/local/daos/achievements_dao.dart';

@injectable
class AchievementService {
  final AchievementsDao _dao;
  final SupabaseClient _supabase;

  AchievementService(this._dao, this._supabase);

  String get _userId => _supabase.auth.currentUser?.id ?? '';

  // Call after every expense save
  Future<List<String>> checkAfterExpenseSave({
    required int totalExpenseCount,
    required int currentStreakDays,
  }) async {
    if (_userId.isEmpty) return [];

    final unlocked = <String>[];

    if (totalExpenseCount == 1) {
      final id = await _tryUnlock('first_expense');
      if (id.isNotEmpty) unlocked.add(id);
    }
    if (totalExpenseCount >= 100) {
      final id = await _tryUnlock('hundred_expenses');
      if (id.isNotEmpty) unlocked.add(id);
    }
    if (currentStreakDays >= 3) {
      final id = await _tryUnlock('three_day_streak');
      if (id.isNotEmpty) unlocked.add(id);
    }
    if (currentStreakDays >= 7) {
      final id = await _tryUnlock('seven_day_streak');
      if (id.isNotEmpty) unlocked.add(id);
    }
    if (currentStreakDays >= 30) {
      final id = await _tryUnlock('thirty_day_streak');
      if (id.isNotEmpty) unlocked.add(id);
    }

    return unlocked;
  }

  // Call at end of month (or on Dashboard load for previous month)
  Future<List<String>> checkMonthEnd({
    required bool allBudgetsMet,
    required double savingsRate,
    required int recurringDetectedCount,
  }) async {
    if (_userId.isEmpty) return [];

    final unlocked = <String>[];
    if (allBudgetsMet) {
      final id1 = await _tryUnlock('budget_master');
      if (id1.isNotEmpty) unlocked.add(id1);
      final id2 = await _tryUnlock('zero_overspend');
      if (id2.isNotEmpty) unlocked.add(id2);
    }
    if (savingsRate >= 0.30) {
      final id = await _tryUnlock('saver');
      if (id.isNotEmpty) unlocked.add(id);
    }
    if (recurringDetectedCount >= 3) {
      final id = await _tryUnlock('recurring_detective');
      if (id.isNotEmpty) unlocked.add(id);
    }
    return unlocked;
  }

  // Call after first AI insights report generated
  Future<void> checkAiExplorer() => _tryUnlock('ai_explorer');

  // Returns badgeId if newly unlocked, '' if already unlocked
  Future<String> _tryUnlock(String badgeId) async {
    final all = await _dao.getAll(_userId);
    try {
      final badge = all.firstWhere((b) => b.badgeId == badgeId);
      if (badge.isUnlocked) return '';
      await _dao.unlock(_userId, badgeId);
      return badgeId;
    } catch (e) {
      // Badge not seeded or found
      return '';
    }
  }
}
