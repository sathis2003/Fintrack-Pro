import 'package:equatable/equatable.dart';

// Result from Groq AI extraction
class ExtractedExpense extends Equatable {
  final bool hasExpense;
  final double amount;
  final String category;
  final String description;
  final String date; // 'today' | 'yesterday' | 'DD-MM-YYYY'
  final double confidence; // 0.0 – 1.0
  final bool isRecurring;
  final String? errorCode; // 'rate_limited' | 'parse_failed' | 'network' | null
  final String intent; // 'expense' | 'question' | 'greeting' | 'other'

  const ExtractedExpense({
    required this.hasExpense,
    this.amount = 0,
    this.category = 'Other',
    this.description = '',
    this.date = 'today',
    this.confidence = 0,
    this.isRecurring = false,
    this.errorCode,
    this.intent = 'expense',
  });

  factory ExtractedExpense.noExpense({String intent = 'other'}) =>
      ExtractedExpense(hasExpense: false, intent: intent);

  factory ExtractedExpense.fromJson(Map<String, dynamic> json) =>
      ExtractedExpense(
        hasExpense: json['has_expense'] as bool? ?? false,
        amount: (json['amount'] as num?)?.toDouble() ?? 0,
        category: json['category'] as String? ?? 'Other',
        description: json['description'] as String? ?? '',
        date: json['date'] as String? ?? 'today',
        confidence: (json['confidence'] as num?)?.toDouble() ?? 0,
        isRecurring: json['is_recurring'] as bool? ?? false,
        errorCode: json['error'] as String?,
        intent: json['intent'] as String? ?? 'expense',
      );

  @override
  List<Object?> get props => [
        hasExpense,
        amount,
        category,
        description,
        date,
        confidence,
        isRecurring,
        errorCode,
        intent,
      ];
}
