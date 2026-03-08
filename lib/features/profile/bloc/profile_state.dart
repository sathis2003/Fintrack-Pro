import '../../../data/local/database/app_database.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileData extends ProfileState {
  final FinancialProfile profile;
  final bool isBiometricAvailable;
  final bool isBiometricEnabled;
  final String email;

  ProfileData({
    required this.profile,
    required this.isBiometricAvailable,
    required this.isBiometricEnabled,
    required this.email,
  });

  @override
  List<Object?> get props =>
      [profile, isBiometricAvailable, isBiometricEnabled, email];
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
  @override
  List<Object?> get props => [message];
}
