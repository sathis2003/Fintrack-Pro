import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  final int? id;
  final String uuid;
  final String userId;
  final double amount;
  final String category;
  final String description;
  final DateTime date;
  final bool isRecurring;
  final String source;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  const Expense({
    this.id,
    required this.uuid,
    required this.userId,
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
    this.isRecurring = false,
    this.source = 'chat',
    this.syncStatus = 'pending',
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
  });

  Expense copyWith({
    int? id,
    String? uuid,
    String? userId,
    double? amount,
    String? category,
    String? description,
    DateTime? date,
    bool? isRecurring,
    String? source,
    String? syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
  }) {
    return Expense(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
      isRecurring: isRecurring ?? this.isRecurring,
      source: source ?? this.source,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        uuid,
        userId,
        amount,
        category,
        description,
        date,
        isRecurring,
        source,
        syncStatus,
        createdAt,
        updatedAt,
        isDeleted,
      ];
}
