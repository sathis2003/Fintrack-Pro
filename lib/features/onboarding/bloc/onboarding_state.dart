import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  final int currentIndex;
  const OnboardingState(this.currentIndex);

  @override
  List<Object?> get props => [currentIndex];
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial() : super(0);
}

class OnboardingChanged extends OnboardingState {
  const OnboardingChanged(int index) : super(index);
}

class OnboardingComplete extends OnboardingState {
  const OnboardingComplete() : super(2);
}
