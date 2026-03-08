import 'package:equatable/equatable.dart';
import '../../../domain/value_objects/monthly_summary.dart';
import '../../../domain/entities/budget.dart';

import '../widgets/predictions_card.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardData extends DashboardState {
  final MonthlySummary summary;
  final List<Budget> budgets;
  final DateTime currentMonth;
  final PredictionData? prediction;
  final double? monthlyIncome;

  DashboardData({
    required this.summary,
    required this.budgets,
    required this.currentMonth,
    this.prediction,
    this.monthlyIncome,
  });

  @override
  List<Object?> get props =>
      [summary, budgets, currentMonth, prediction, monthlyIncome];
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
