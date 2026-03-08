import 'package:equatable/equatable.dart';
import '../../../domain/entities/extracted_expense.dart';

sealed class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// User typed and sent a message
class MessageSent extends ChatEvent {
  final String text;
  MessageSent(this.text);
  @override
  List<Object?> get props => [text];
}

// User tapped Confirm on the confirmation card
class ExpenseConfirmed extends ChatEvent {
  final ExtractedExpense expense;
  ExpenseConfirmed(this.expense);
  @override
  List<Object?> get props => [expense];
}

// User tapped Cancel/Edit on confirmation card
class ExpenseRejected extends ChatEvent {}

// Clear all messages
class ChatCleared extends ChatEvent {}

// User's text changed — trigger category suggestion
class TextChanged extends ChatEvent {
  final String text;
  TextChanged(this.text);
  @override
  List<Object?> get props => [text];
}

// User accepted the suggested category
class CategorySuggestionAccepted extends ChatEvent {
  final String category;
  CategorySuggestionAccepted(this.category);
  @override
  List<Object?> get props => [category];
}

class ReceiptScanRequested extends ChatEvent {
  ReceiptScanRequested();
  @override
  List<Object?> get props => [];
}

class ReceiptScanCompleted extends ChatEvent {
  final String base64Image;
  ReceiptScanCompleted(this.base64Image);
  @override
  List<Object?> get props => [base64Image];
}
