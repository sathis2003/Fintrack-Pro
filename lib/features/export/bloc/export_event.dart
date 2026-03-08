import 'package:equatable/equatable.dart';
import 'export_state.dart';

abstract class ExportEvent extends Equatable {
  const ExportEvent();

  @override
  List<Object?> get props => [];
}

class ExportRequested extends ExportEvent {
  final String month; // "YYYY-MM"
  final ExportFormat format;

  const ExportRequested({required this.month, required this.format});

  @override
  List<Object?> get props => [month, format];
}
