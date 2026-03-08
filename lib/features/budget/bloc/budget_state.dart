import 'package:equatable/equatable.dart';
import '../../../domain/entities/budget.dart';

abstract class BudgetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetData extends BudgetState {
  final List<Budget> budgets;
  final DateTime currentMonth;

  BudgetData({required this.budgets, required this.currentMonth});

  @override
  List<Object?> get props => [budgets, currentMonth];
}

class BudgetError extends BudgetState {
  final String message;
  BudgetError(this.message);

  @override
  List<Object?> get props => [message];
}
