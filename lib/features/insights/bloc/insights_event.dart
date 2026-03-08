import 'package:equatable/equatable.dart';

abstract class InsightsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InsightsLoaded extends InsightsEvent {
  final String month;
  InsightsLoaded(this.month);

  @override
  List<Object?> get props => [month];
}

class InsightsGenerateRequested extends InsightsEvent {
  final String month;
  final double monthlyIncome;
  InsightsGenerateRequested(this.month, this.monthlyIncome);

  @override
  List<Object?> get props => [month, monthlyIncome];
}
