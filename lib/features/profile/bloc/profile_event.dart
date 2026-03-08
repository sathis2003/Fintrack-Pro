import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileEvent {}

class BiometricToggled extends ProfileEvent {
  final bool enabled;
  BiometricToggled(this.enabled);
  @override
  List<Object?> get props => [enabled];
}

class SignOutRequested extends ProfileEvent {}

class DeleteAccountRequested extends ProfileEvent {}
