import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PageChanged extends OnboardingEvent {
  final int index;
  PageChanged(this.index);

  @override
  List<Object?> get props => [index];
}

class FinishOnboarding extends OnboardingEvent {}
