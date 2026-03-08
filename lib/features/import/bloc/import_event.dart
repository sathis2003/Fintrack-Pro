import 'package:equatable/equatable.dart';

sealed class ImportEvent extends Equatable {
  const ImportEvent();
  @override
  List<Object?> get props => [];
}

class ScanSmsRequested extends ImportEvent {}

class ToggleSmsSelection extends ImportEvent {
  final String smsId;
  const ToggleSmsSelection(this.smsId);
  @override
  List<Object?> get props => [smsId];
}

class ImportSelectedSms extends ImportEvent {}

class LoadImportHistory extends ImportEvent {}

class ClearImportLogs extends ImportEvent {}
