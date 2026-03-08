import 'package:equatable/equatable.dart';

abstract class BudgetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BudgetLoaded extends BudgetEvent {}

class BudgetMonthChanged extends BudgetEvent {
  final DateTime month;
  BudgetMonthChanged(this.month);

  @override
  List<Object?> get props => [month];
}

class BudgetSetRequested extends BudgetEvent {
  final String category;
  final double amount;
  BudgetSetRequested(this.category, this.amount);

  @override
  List<Object?> get props => [category, amount];
}

class BudgetDeleted extends BudgetEvent {
  final String uuid;
  BudgetDeleted(this.uuid);

  @override
  List<Object?> get props => [uuid];
}
