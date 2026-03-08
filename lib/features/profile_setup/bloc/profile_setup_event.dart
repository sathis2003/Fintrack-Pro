import 'package:equatable/equatable.dart';

abstract class ProfileSetupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StepAdvanced extends ProfileSetupEvent {}

class StepRetracted extends ProfileSetupEvent {}

class IncomeSet extends ProfileSetupEvent {
  final double income;
  IncomeSet(this.income);
  @override
  List<Object?> get props => [income];
}

class IncomeDateSet extends ProfileSetupEvent {
  final int day;
  IncomeDateSet(this.day);
  @override
  List<Object?> get props => [day];
}

class CurrencySet extends ProfileSetupEvent {
  final String currency;
  CurrencySet(this.currency);
  @override
  List<Object?> get props => [currency];
}

class SetupCompleted extends ProfileSetupEvent {}

class SetupSkipped extends ProfileSetupEvent {}
