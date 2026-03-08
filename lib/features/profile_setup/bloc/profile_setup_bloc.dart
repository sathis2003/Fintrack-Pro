import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';
import 'profile_setup_event.dart';
import 'profile_setup_state.dart';
import '../../../data/local/database/app_database.dart';
import '../../../domain/repositories/i_auth_repository.dart';

@injectable
class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  final AppDatabase _db;
  final IAuthRepository _authRepository;

  ProfileSetupBloc(this._db, this._authRepository)
      : super(const ProfileSetupState()) {
    on<StepAdvanced>((event, emit) {
      if (state.step == ProfileSetupStep.income) {
        emit(state.copyWith(step: ProfileSetupStep.date));
      } else if (state.step == ProfileSetupStep.date) {
        emit(state.copyWith(step: ProfileSetupStep.currency));
      }
    });

    on<StepRetracted>((event, emit) {
      if (state.step == ProfileSetupStep.date) {
        emit(state.copyWith(step: ProfileSetupStep.income));
      } else if (state.step == ProfileSetupStep.currency) {
        emit(state.copyWith(step: ProfileSetupStep.date));
      }
    });

    on<IncomeSet>((event, emit) => emit(state.copyWith(income: event.income)));
    on<IncomeDateSet>(
        (event, emit) => emit(state.copyWith(incomeDay: event.day)));
    on<CurrencySet>(
        (event, emit) => emit(state.copyWith(currency: event.currency)));

    on<SetupCompleted>((event, emit) async {
      emit(state.copyWith(isSaving: true));
      final userId = _authRepository.currentUserId;
      if (userId != null) {
        await _db.into(_db.financialProfiles).insertOnConflictUpdate(
              FinancialProfilesCompanion.insert(
                userId: userId,
                updatedAt: DateTime.now().millisecondsSinceEpoch,
                monthlyIncome: Value(state.income),
                incomeDay: Value(state.incomeDay),
                currency: Value(state.currency),
              ),
            );
        emit(state.copyWith(isSaving: false, isDone: true));
      }
    });

    on<SetupSkipped>((event, emit) async {
      emit(state.copyWith(isSaving: true));
      final userId = _authRepository.currentUserId;
      if (userId != null) {
        await _db.into(_db.financialProfiles).insertOnConflictUpdate(
              FinancialProfilesCompanion.insert(
                userId: userId,
                updatedAt: DateTime.now().millisecondsSinceEpoch,
                monthlyIncome: const Value(0),
                incomeDay: const Value(1),
                currency: const Value('INR'),
              ),
            );
        emit(state.copyWith(isSaving: false, isDone: true));
      }
    });
  }
}
