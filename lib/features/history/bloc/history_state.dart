import 'package:equatable/equatable.dart';
import '../../../domain/entities/expense.dart';

class HistoryFilter extends Equatable {
  final DateTime month;
  final String? category;
  final String searchQuery;

  const HistoryFilter({
    required this.month,
    this.category,
    this.searchQuery = '',
  });

  HistoryFilter copyWith({
    DateTime? month,
    String? category,
    String? searchQuery,
  }) {
    return HistoryFilter(
      month: month ?? this.month,
      category: category ?? this.category,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [month, category, searchQuery];
}

abstract class HistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryData extends HistoryState {
  final List<Expense> expenses;
  final HistoryFilter filter;

  HistoryData({required this.expenses, required this.filter});

  @override
  List<Object?> get props => [expenses, filter];
}

class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
