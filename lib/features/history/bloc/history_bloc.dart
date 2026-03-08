import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'history_event.dart';
import 'history_state.dart';
import '../../../domain/repositories/i_expense_repository.dart';
import '../../../domain/entities/expense.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final IExpenseRepository _expenseRepo;
  final SupabaseClient _supabase;

  HistoryFilter _currentFilter = HistoryFilter(month: DateTime.now());

  HistoryBloc(this._expenseRepo, this._supabase) : super(HistoryInitial()) {
    on<HistoryLoaded>(_onLoaded);
    on<HistoryFilterChanged>(_onFilterChanged);
    on<HistoryExpenseDeleted>(_onDeleted);
  }

  Future<void> _onLoaded(
      HistoryLoaded event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    final userId = _supabase.auth.currentUser?.id ?? 'temp-user';
    await emit.forEach<List<Expense>>(
      _expenseRepo.watchByMonth(userId, _currentFilter.month),
      onData: (expenses) {
        final filtered = _applyFilters(expenses);
        return HistoryData(expenses: filtered, filter: _currentFilter);
      },
      onError: (e, s) => HistoryError(e.toString()),
    );
  }

  Future<void> _onFilterChanged(
      HistoryFilterChanged event, Emitter<HistoryState> emit) async {
    _currentFilter = event.filter;
    add(HistoryLoaded());
  }

  Future<void> _onDeleted(
      HistoryExpenseDeleted event, Emitter<HistoryState> emit) async {
    await _expenseRepo.softDelete(event.uuid);
  }

  List<Expense> _applyFilters(List<Expense> expenses) {
    var filtered = expenses.where((e) => !e.isDeleted).toList();

    if (_currentFilter.category != null) {
      filtered =
          filtered.where((e) => e.category == _currentFilter.category).toList();
    }

    if (_currentFilter.searchQuery.isNotEmpty) {
      final query = _currentFilter.searchQuery.toLowerCase();
      filtered = filtered
          .where((e) =>
              e.description.toLowerCase().contains(query) ||
              e.category.toLowerCase().contains(query))
          .toList();
    }

    // Sort by date descending
    filtered.sort((a, b) => b.date.compareTo(a.date));

    return filtered;
  }
}
