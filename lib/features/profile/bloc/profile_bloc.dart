import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../../../data/local/database/app_database.dart';
import '../../../services/biometric_service.dart';
import '../../../domain/repositories/i_auth_repository.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AppDatabase _db;
  final IAuthRepository _authRepository;
  final SupabaseClient _supabase;

  ProfileBloc(this._db, this._authRepository, this._supabase)
      : super(ProfileInitial()) {
    on<ProfileLoaded>((event, emit) async {
      emit(ProfileLoading());
      final userId = _authRepository.currentUserId;
      if (userId == null) {
        emit(ProfileError("Not authenticated"));
        return;
      }

      final profile = await (_db.select(_db.financialProfiles)
            ..where((t) => t.userId.equals(userId)))
          .getSingleOrNull();

      if (profile == null) {
        emit(ProfileError("Profile not found"));
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      final isBiometricEnabled = prefs.getBool('biometric_enabled') ?? false;
      final isBiometricAvailable = await BiometricService.isAvailable();
      final email = _supabase.auth.currentUser?.email ?? "";

      emit(ProfileData(
        profile: profile,
        isBiometricAvailable: isBiometricAvailable,
        isBiometricEnabled: isBiometricEnabled,
        email: email,
      ));
    });

    on<BiometricToggled>((event, emit) async {
      if (state is ProfileData) {
        final currentState = state as ProfileData;
        final prefs = await SharedPreferences.getInstance();

        if (event.enabled) {
          final authenticated = await BiometricService.authenticate();
          if (authenticated) {
            await prefs.setBool('biometric_enabled', true);
            emit(ProfileData(
              profile: currentState.profile,
              isBiometricAvailable: currentState.isBiometricAvailable,
              isBiometricEnabled: true,
              email: currentState.email,
            ));
          }
        } else {
          await prefs.setBool('biometric_enabled', false);
          emit(ProfileData(
            profile: currentState.profile,
            isBiometricAvailable: currentState.isBiometricAvailable,
            isBiometricEnabled: false,
            email: currentState.email,
          ));
        }
      }
    });

    on<SignOutRequested>((event, emit) async {
      await _authRepository.signOut();
    });

    on<DeleteAccountRequested>((event, emit) async {
      // In a real app, you'd call a Supabase Edge Function to delete the user
      // For now, we'll just sign out and clear local data
      final userId = _authRepository.currentUserId;
      if (userId != null) {
        await (_db.delete(_db.financialProfiles)
              ..where((t) => t.userId.equals(userId)))
            .go();
        await (_db.delete(_db.expenses)..where((t) => t.userId.equals(userId)))
            .go();
      }
      await _authRepository.signOut();
    });
  }
}
