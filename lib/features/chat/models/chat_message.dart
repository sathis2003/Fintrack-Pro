import 'package:equatable/equatable.dart';

enum MessageType { user, bot, confirmation, error }

class ChatMessage extends Equatable {
  final String id;
  final String text;
  final MessageType type;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.type,
    required this.timestamp,
  });

  factory ChatMessage.user(String text) => ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text,
        type: MessageType.user,
        timestamp: DateTime.now(),
      );

  factory ChatMessage.bot(String text) => ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text,
        type: MessageType.bot,
        timestamp: DateTime.now(),
      );

  factory ChatMessage.error(String text) => ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text,
        type: MessageType.error,
        timestamp: DateTime.now(),
      );

  @override
  List<Object?> get props => [id, text, type, timestamp];
}
