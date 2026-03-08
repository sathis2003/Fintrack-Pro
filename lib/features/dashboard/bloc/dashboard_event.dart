import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardLoaded extends DashboardEvent {}

class DashboardMonthChanged extends DashboardEvent {
  final DateTime month;
  DashboardMonthChanged(this.month);

  @override
  List<Object?> get props => [month];
}

class DashboardRefreshed extends DashboardEvent {}
