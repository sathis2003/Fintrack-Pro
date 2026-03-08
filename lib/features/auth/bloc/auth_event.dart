import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;

  SignUpRequested(
      {required this.email, required this.password, required this.name});

  @override
  List<Object?> get props => [email, password, name];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignOutRequested extends AuthEvent {}

class ForgotPasswordRequested extends AuthEvent {
  final String email;
  ForgotPasswordRequested(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthCheckRequested extends AuthEvent {}

class ProfileSetupCompleted extends AuthEvent {}

class GoogleSignInRequested extends AuthEvent {}

class AppleSignInRequested extends AuthEvent {}
