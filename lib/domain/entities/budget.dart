import 'package:equatable/equatable.dart';

class Budget extends Equatable {
  final int? id;
  final String uuid;
  final String userId;
  final String category; // matches ExpenseCategory enum string
  final double amount; // monthly limit in INR
  final String month; // format: "YYYY-MM"
  final String syncStatus;
  final DateTime updatedAt;

  const Budget({
    this.id,
    required this.uuid,
    required this.userId,
    required this.category,
    required this.amount,
    required this.month,
    this.syncStatus = 'pending',
    required this.updatedAt,
  });

  Budget copyWith({
    int? id,
    String? uuid,
    String? userId,
    String? category,
    double? amount,
    String? month,
    String? syncStatus,
    DateTime? updatedAt,
  }) {
    return Budget(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      month: month ?? this.month,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        uuid,
        userId,
        category,
        amount,
        month,
        syncStatus,
        updatedAt,
      ];
}
