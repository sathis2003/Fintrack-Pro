import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'insights_event.dart';
import 'insights_state.dart';
import '../../../domain/use_cases/generate_ai_insight.dart';
import '../../../domain/repositories/i_insights_repository.dart';

import '../../../services/revenue_cat_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@injectable
class InsightsBloc extends Bloc<InsightsEvent, InsightsState> {
  final GenerateAiInsight _generateAiInsight;
  final IInsightsRepository _insightsRepo;
  final RevenueCatService _revenueCat;
  final SupabaseClient _supabase;

  InsightsBloc(
    this._generateAiInsight,
    this._insightsRepo,
    this._revenueCat,
    this._supabase,
  ) : super(InsightsInitial()) {
    on<InsightsLoaded>(_onLoaded);
    on<InsightsGenerateRequested>(_onGenerateRequested);
  }

  Future<void> _onLoaded(
      InsightsLoaded event, Emitter<InsightsState> emit) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    emit(InsightsLoading());
    final result = await _insightsRepo.getByMonth(userId, event.month);

    result.fold(
      (failure) => emit(InsightsError(failure.toString())),
      (insight) {
        if (insight == null) {
          emit(InsightsEmpty(event.month));
        } else {
          emit(InsightsData(insight));
        }
      },
    );
  }

  Future<void> _onGenerateRequested(
      InsightsGenerateRequested event, Emitter<InsightsState> emit) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    emit(InsightsLoading());

    // Paywall Gate
    final isPro = await _revenueCat.isPro();
    if (!isPro) {
      final count =
          await _insightsRepo.getMonthlyInsightCount(userId, event.month);
      if (count >= 3) {
        emit(InsightsError(
            'Monthly limit reached. Go Pro to unlock unlimited reports!'));
        return;
      }
    }

    final result = await _generateAiInsight(
      userId: userId,
      month: event.month,
      monthlyIncome: event.monthlyIncome,
    );

    result.fold(
      (failure) => emit(InsightsError(failure.toString())),
      (insight) => emit(InsightsData(insight)),
    );
  }
}
