import 'dart:io';
import 'package:equatable/equatable.dart';

enum ExportFormat { pdf, csv }

abstract class ExportState extends Equatable {
  const ExportState();

  @override
  List<Object?> get props => [];
}

class ExportInitial extends ExportState {}

class ExportGenerating extends ExportState {}

class ExportReady extends ExportState {
  final File file;
  final ExportFormat format;

  const ExportReady({required this.file, required this.format});

  @override
  List<Object?> get props => [file, format];
}

class ExportError extends ExportState {
  final String message;

  const ExportError(this.message);

  @override
  List<Object?> get props => [message];
}
