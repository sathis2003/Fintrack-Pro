import 'package:injectable/injectable.dart';
import 'notification_service.dart';
import '../domain/repositories/i_budget_repository.dart';
import '../domain/repositories/i_expense_repository.dart';
import 'package:intl/intl.dart';

@singleton
class BudgetAlertService {
  final IBudgetRepository _budgetRepo;
  final IExpenseRepository _expenseRepo;
  final NotificationService _notifications;

  BudgetAlertService(this._budgetRepo, this._expenseRepo, this._notifications);

  Future<void> checkAlerts(String userId, String category) async {
    final month = DateFormat('yyyy-MM').format(DateTime.now());

    // 1. Get budget for this category
    final budgets = await _budgetRepo.watchByMonth(userId, month).first;
    final budget = budgets.where((b) => b.category == category).firstOrNull;

    if (budget == null) return;

    // 2. Calculate spent
    final expenses =
        await _expenseRepo.watchByMonth(userId, DateTime.now()).first;
    final spent = expenses
        .where((e) => e.category == category && !e.isDeleted)
        .fold(0.0, (prev, e) => prev + e.amount);

    // 3. Trigger notification if thresholds reached
    if (spent >= budget.amount) {
      await _notifications.showBudgetWarning(
        category: category,
        spent: spent,
        limit: budget.amount,
        isExceeded: true,
      );
    } else if (spent >= budget.amount * 0.8) {
      await _notifications.showBudgetWarning(
        category: category,
        spent: spent,
        limit: budget.amount,
        isExceeded: false,
      );
    }
  }
}
