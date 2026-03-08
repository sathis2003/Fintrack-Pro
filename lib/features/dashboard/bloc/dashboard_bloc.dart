import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import '../../../domain/use_cases/get_monthly_summary.dart';
import '../../../domain/repositories/i_budget_repository.dart';
import 'package:intl/intl.dart';
import '../../../services/prediction_engine.dart';
import '../widgets/predictions_card.dart';
import '../../../data/local/daos/financial_profile_dao.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetMonthlySummary _getSummary;
  final IBudgetRepository _budgetRepo;
  final SupabaseClient _supabase;
  final FinancialProfileDao _profileDao;

  DateTime _currentMonth = DateTime.now();

  DashboardBloc(
    this._getSummary,
    this._budgetRepo,
    this._supabase,
    this._profileDao,
  ) : super(DashboardInitial()) {
    on<DashboardLoaded>(_onLoaded);
    on<DashboardMonthChanged>(_onMonthChanged);
    on<DashboardRefreshed>(_onLoaded);
  }

  Future<void> _onLoaded(
      DashboardEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    await _fetchData(emit);
  }

  Future<void> _onMonthChanged(
      DashboardMonthChanged event, Emitter<DashboardState> emit) async {
    _currentMonth = event.month;
    emit(DashboardLoading());
    await _fetchData(emit);
  }

  Future<void> _fetchData(Emitter<DashboardState> emit) async {
    final userId = _supabase.auth.currentUser?.id ?? 'temp-user';

    final profile = await _profileDao.getByUser(userId);
    final monthlyIncome = profile?.monthlyIncome;

    // 1. Get Summary
    final summaryResult = await _getSummary(
      userId: userId,
      month: _currentMonth,
    );

    // 2. Get Budgets
    final monthStr = DateFormat('yyyy-MM').format(_currentMonth);
    final budgets = await _budgetRepo.watchByMonth(userId, monthStr).first;

    // 3. Get Prediction (only for current month)
    PredictionData? prediction;
    final isCurrentMonth = _currentMonth.year == DateTime.now().year &&
        _currentMonth.month == DateTime.now().month;

    if (isCurrentMonth) {
      summaryResult.fold((_) => null, (summary) {
        final predictionResult = PredictionEngine.predict(
          currentMonthExpenses: [], // TODO: If needed, fetch raw list
          lastMonthExpenses: [],
          upcomingRecurring: [],
          monthlyIncome: 0,
          now: DateTime.now(),
        );
        final forecast = predictionResult.projectedTotal;

        final totalBudget = budgets.fold(0.0, (sum, b) => sum + b.amount);

        prediction = PredictionData(
          predictedTotal: forecast > 0 ? forecast : summary.totalSpend,
          budgetLimit: totalBudget > 0 ? totalBudget : 1000,
          isOverBudget: forecast > totalBudget && totalBudget > 0,
          insightMessage: forecast > totalBudget && totalBudget > 0
              ? 'Warning: You might exceed your total budget.'
              : 'On track: You are staying within budget limits.',
          anomalies: predictionResult.anomalies,
        );
      });
    }

    summaryResult.fold(
      (failure) => emit(DashboardError(failure.toString())),
      (summary) => emit(DashboardData(
        summary: summary,
        budgets: budgets,
        currentMonth: _currentMonth,
        prediction: prediction,
        monthlyIncome: monthlyIncome,
      )),
    );
  }
}
