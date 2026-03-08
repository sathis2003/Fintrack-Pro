import 'package:equatable/equatable.dart';
import '../models/chat_message.dart';
import '../../../domain/entities/extracted_expense.dart';

sealed class ChatState extends Equatable {
  final List<ChatMessage> messages;
  const ChatState({this.messages = const []});
  @override
  List<Object?> get props => [messages];
}

// Waiting for user input
class ChatIdle extends ChatState {
  const ChatIdle({super.messages});
}

// AI is processing the message
class ChatProcessing extends ChatState {
  const ChatProcessing({required super.messages});
}

// AI returned an expense — waiting for user to confirm
class ChatAwaitingConfirmation extends ChatState {
  final ExtractedExpense extracted;
  const ChatAwaitingConfirmation({
    required super.messages,
    required this.extracted,
  });
  @override
  List<Object?> get props => [...super.props, extracted];
}

// Expense saved successfully
class ChatExpenseSaved extends ChatState {
  const ChatExpenseSaved({required super.messages});
}

// AI found no expense in message
class ChatNoExpenseFound extends ChatState {
  const ChatNoExpenseFound({required super.messages});
}

// Error occurred
class ChatError extends ChatState {
  final String errorMessage;
  const ChatError({required super.messages, required this.errorMessage});
  @override
  List<Object?> get props => [...super.props, errorMessage];
}

// New badge unlocked
class ChatBadgeUnlocked extends ChatState {
  final String badgeId;
  const ChatBadgeUnlocked({required this.badgeId, required super.messages});
  @override
  List<Object?> get props => [...super.props, badgeId];
}

// Gemma suggested a category while typing
class ChatCategorySuggested extends ChatState {
  final String suggestedCategory;
  const ChatCategorySuggested({
    required super.messages,
    required this.suggestedCategory,
  });
  @override
  List<Object?> get props => [...super.props, suggestedCategory];
}
