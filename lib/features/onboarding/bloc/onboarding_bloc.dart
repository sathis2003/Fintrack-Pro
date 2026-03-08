import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';
import '../../../services/onboarding_service.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingInitial()) {
    on<PageChanged>((event, emit) {
      emit(OnboardingChanged(event.index));
    });

    on<FinishOnboarding>((event, emit) async {
      await OnboardingService.markComplete();
      emit(const OnboardingComplete());
    });
  }
}
