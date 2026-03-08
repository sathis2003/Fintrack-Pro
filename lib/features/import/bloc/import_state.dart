import 'package:equatable/equatable.dart';
import '../../../services/sms_parser_service.dart';
import '../../../data/local/database/app_database.dart';

class SelectableSmsTransaction {
  final ParsedSmsTransaction transaction;
  bool isSelected;
  SelectableSmsTransaction({required this.transaction, this.isSelected = true});
}

sealed class ImportState extends Equatable {
  const ImportState();
  @override
  List<Object?> get props => [];
}

class ImportInitial extends ImportState {}

class ImportLoading extends ImportState {}

class SmsScanSuccess extends ImportState {
  final List<SelectableSmsTransaction> pending;
  const SmsScanSuccess(this.pending);
  @override
  List<Object?> get props => [pending];
}

class ImportCompleted extends ImportState {
  final int count;
  const ImportCompleted(this.count);
  @override
  List<Object?> get props => [count];
}

class ImportHistoryLoaded extends ImportState {
  final List<SmsImportLogTableData> logs;
  const ImportHistoryLoaded(this.logs);
  @override
  List<Object?> get props => [logs];
}

class ImportFailure extends ImportState {
  final String error;
  const ImportFailure(this.error);
  @override
  List<Object?> get props => [error];
}
