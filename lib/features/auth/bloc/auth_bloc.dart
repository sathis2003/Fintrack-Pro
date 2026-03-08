import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../../domain/repositories/i_auth_repository.dart';
import '../../../data/local/database/app_database.dart';
import '../../../services/revenue_cat_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;
  final AppDatabase _db;
  final RevenueCatService _revenueCatService;
  StreamSubscription<String?>? _authStateSubscription;

  AuthBloc(this._authRepository, this._db, this._revenueCatService)
      : super(AuthInitial()) {
    _authStateSubscription = _authRepository.authStateChanges.listen((userId) {
      add(AuthCheckRequested());
    });

    on<AuthCheckRequested>((event, emit) async {
      final userId = _authRepository.currentUserId;
      if (userId == null) {
        emit(AuthUnauthenticated());
        Sentry.configureScope((scope) => scope.setUser(null));
      } else {
        final email = _authRepository.currentUserEmail;

        // RevenueCat may not be configured yet — default to free
        bool isPro = false;
        try {
          isPro = await _revenueCatService.isPro();
        } catch (_) {
          // RevenueCat SDK not initialized — treat as free user
          isPro = false;
        }

        Sentry.configureScope((scope) {
          scope.setUser(SentryUser(
            id: userId,
            email: email,
            data: {'is_pro': isPro},
          ));
        });

        final hasProfile = await _checkHasProfile(userId);
        if (hasProfile) {
          emit(AuthAuthenticated(userId));
        } else {
          emit(AuthNeedsProfileSetup(userId));
        }
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await _authRepository.signUp(
        email: event.email,
        password: event.password,
        name: event.name,
      );

      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (_) => add(AuthCheckRequested()),
      );
    });

    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );

      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (_) => add(AuthCheckRequested()),
      );
    });

    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      await _authRepository.signOut();
      Sentry.configureScope((scope) => scope.setUser(null));
      emit(AuthUnauthenticated());
    });

    on<ForgotPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await _authRepository.resetPassword(event.email);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (_) => emit(AuthPasswordResetSent()),
      );
    });

    on<ProfileSetupCompleted>((event, emit) async {
      final userId = _authRepository.currentUserId;
      if (userId != null) {
        emit(AuthAuthenticated(userId));
      }
    });

    on<GoogleSignInRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await _authRepository.signInWithGoogle();
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (_) => add(AuthCheckRequested()),
      );
    });

    on<AppleSignInRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await _authRepository.signInWithApple();
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (_) => add(AuthCheckRequested()),
      );
    });
  }

  Future<bool> _checkHasProfile(String userId) async {
    // Basic check: see if a profile exists for this user in Drift
    final profile = await (_db.select(_db.financialProfiles)
          ..where((t) => t.userId.equals(userId)))
        .getSingleOrNull();
    return profile != null;
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
