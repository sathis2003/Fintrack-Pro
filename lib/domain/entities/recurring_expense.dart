import 'package:equatable/equatable.dart';

class RecurringExpense extends Equatable {
  final String uuid;
  final String userId;
  final String category;
  final String description;
  final double averageAmount;
  final int dayOfMonth;
  final String frequency; // monthly, weekly, yearly
  final bool isActive;
  final bool reminderEnabled;
  final int reminderDaysBefore;
  final DateTime lastOccurrence;
  final DateTime nextExpectedDate;

  const RecurringExpense({
    required this.uuid,
    required this.userId,
    required this.category,
    required this.description,
    required this.averageAmount,
    required this.dayOfMonth,
    required this.frequency,
    this.isActive = true,
    this.reminderEnabled = true,
    this.reminderDaysBefore = 3,
    required this.lastOccurrence,
    required this.nextExpectedDate,
  });

  @override
  List<Object?> get props => [
        uuid,
        userId,
        category,
        description,
        averageAmount,
        dayOfMonth,
        frequency,
        isActive,
        reminderEnabled,
        reminderDaysBefore,
        lastOccurrence,
        nextExpectedDate,
      ];
}
