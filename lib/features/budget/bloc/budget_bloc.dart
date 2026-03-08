import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'budget_event.dart';
import 'budget_state.dart';
import '../../../domain/repositories/i_budget_repository.dart';
import '../../../domain/use_cases/set_budget.dart';
import '../../../domain/entities/budget.dart';
import 'package:intl/intl.dart';

@injectable
class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final IBudgetRepository _repository;
  final SetBudget _setBudget;
  final SupabaseClient _supabase;

  DateTime _currentMonth = DateTime.now();

  BudgetBloc(this._repository, this._setBudget, this._supabase)
      : super(BudgetInitial()) {
    on<BudgetLoaded>(_onLoaded);
    on<BudgetMonthChanged>(_onMonthChanged);
    on<BudgetSetRequested>(_onSetRequested);
    on<BudgetDeleted>(_onDeleted);
  }

  Future<void> _onLoaded(BudgetLoaded event, Emitter<BudgetState> emit) async {
    final monthStr = DateFormat('yyyy-MM').format(_currentMonth);
    final userId = _supabase.auth.currentUser?.id ?? 'temp-user';

    await emit.forEach<List<Budget>>(
      _repository.watchByMonth(userId, monthStr),
      onData: (budgets) =>
          BudgetData(budgets: budgets, currentMonth: _currentMonth),
      onError: (e, s) => BudgetError(e.toString()),
    );
  }

  Future<void> _onMonthChanged(
      BudgetMonthChanged event, Emitter<BudgetState> emit) async {
    _currentMonth = event.month;
    add(BudgetLoaded());
  }

  Future<void> _onSetRequested(
      BudgetSetRequested event, Emitter<BudgetState> emit) async {
    final monthStr = DateFormat('yyyy-MM').format(_currentMonth);
    final userId = _supabase.auth.currentUser?.id ?? 'temp-user';
    await _setBudget(
      userId: userId,
      category: event.category,
      amount: event.amount,
      month: monthStr,
    );
  }

  Future<void> _onDeleted(
      BudgetDeleted event, Emitter<BudgetState> emit) async {
    await _repository.deleteBudget(event.uuid);
  }
}
