import 'package:equatable/equatable.dart';
import '../../../data/local/database/app_database.dart' as db;

abstract class RecurringEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecurringLoaded extends RecurringEvent {}

class RecurringDetectorStarted extends RecurringEvent {}

class RecurringToggled extends RecurringEvent {
  final String uuid;
  final bool isEnable;
  RecurringToggled(this.uuid, this.isEnable);
  @override
  List<Object?> get props => [uuid, isEnable];
}

class RecurringState extends Equatable {
  final List<db.RecurringExpensesTableData> recurrings;
  final bool isDetecting;
  final String? error;

  const RecurringState({
    this.recurrings = const [],
    this.isDetecting = false,
    this.error,
  });

  @override
  List<Object?> get props => [recurrings, isDetecting, error];
}
