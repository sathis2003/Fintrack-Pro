import 'package:equatable/equatable.dart';
import 'history_state.dart';

abstract class HistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoryLoaded extends HistoryEvent {}

class HistoryFilterChanged extends HistoryEvent {
  final HistoryFilter filter;
  HistoryFilterChanged(this.filter);

  @override
  List<Object?> get props => [filter];
}

class HistoryExpenseDeleted extends HistoryEvent {
  final String uuid;
  HistoryExpenseDeleted(this.uuid);

  @override
  List<Object?> get props => [uuid];
}

class HistoryExpenseRefreshed extends HistoryEvent {}
