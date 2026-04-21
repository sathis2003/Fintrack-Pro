import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../features/onboarding/pages/onboarding_page.dart';
import '../../features/auth/pages/login_page.dart';
import '../../features/auth/pages/signup_page.dart';
import '../../features/auth/pages/forgot_password_page.dart';
import '../../features/profile_setup/pages/profile_setup_page.dart';

import '../../features/shell/main_shell.dart';
import '../../services/onboarding_service.dart';
import '../../features/import/pages/sms_import_page.dart';
import '../../features/import/pages/import_history_page.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/main',
    observers: [SentryNavigatorObserver()],
    redirect: (context, state) async {
      final onboardingDone = await OnboardingService.isComplete();
      if (!onboardingDone && state.matchedLocation != '/onboarding') {
        return '/onboarding';
      }

      final session = Supabase.instance.client.auth.currentSession;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup' ||
          state.matchedLocation == '/forgot-password';

      if (session == null && !isAuthRoute && onboardingDone) {
        return '/login';
      }

      if (session != null && isAuthRoute) {
        return '/main';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/main',
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/profile-setup',
        builder: (context, state) => const ProfileSetupPage(),
      ),
      GoRoute(
        path: '/sms-import',
        builder: (context, state) => const SmsImportPage(),
      ),
      GoRoute(
        path: '/import-history',
        builder: (context, state) => const ImportHistoryPage(),
      ),
      GoRoute(
        path: '/main',
        builder: (context, state) => const MainShell(),
      ),
    ],
  );
}
