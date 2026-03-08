import 'package:equatable/equatable.dart';
import '../../../domain/entities/ai_insight.dart';

abstract class InsightsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InsightsInitial extends InsightsState {}

class InsightsLoading extends InsightsState {}

class InsightsData extends InsightsState {
  final AiInsight insight;
  InsightsData(this.insight);

  @override
  List<Object?> get props => [insight];
}

class InsightsEmpty extends InsightsState {
  final String month;
  InsightsEmpty(this.month);

  @override
  List<Object?> get props => [month];
}

class InsightsError extends InsightsState {
  final String message;
  InsightsError(this.message);

  @override
  List<Object?> get props => [message];
}
