import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/navigation/app_router.dart';
import '../core/di/injection.dart';
import '../services/biometric_service.dart';
import 'chat/bloc/chat_bloc.dart';
import 'dashboard/bloc/dashboard_bloc.dart';
import 'dashboard/bloc/dashboard_event.dart';
import 'history/bloc/history_bloc.dart';
import 'history/bloc/history_event.dart';
import 'budget/bloc/budget_bloc.dart';
import 'budget/bloc/budget_event.dart';
import 'insights/bloc/insights_bloc.dart';
import 'onboarding/bloc/onboarding_bloc.dart';
import 'auth/bloc/auth_bloc.dart';
import 'auth/bloc/auth_event.dart';
import 'profile_setup/bloc/profile_setup_bloc.dart';
import 'profile/bloc/profile_bloc.dart';
import 'profile/bloc/profile_event.dart';
import 'recurring/bloc/recurring_bloc.dart';
import 'premium/bloc/premium_bloc.dart';
import 'premium/bloc/premium_event.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/theme_notifier.dart';

class FinTrackApp extends StatefulWidget {
  const FinTrackApp({super.key});

  @override
  State<FinTrackApp> createState() => _FinTrackAppState();
}

class _FinTrackAppState extends State<FinTrackApp> with WidgetsBindingObserver {
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkBiometricLock();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _lockApp();
    } else if (state == AppLifecycleState.resumed) {
      _checkBiometricLock();
    }
  }

  Future<void> _lockApp() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('biometric_enabled') ?? false) {
      setState(() => _isLocked = true);
    }
  }

  Future<void> _checkBiometricLock() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('biometric_enabled') ?? false) {
      setState(() => _isLocked = true);
      final authenticated = await BiometricService.authenticate();
      if (authenticated) {
        setState(() => _isLocked = false);
      }
    } else {
      setState(() => _isLocked = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<OnboardingBloc>()),
        BlocProvider(
            create: (context) => getIt<AuthBloc>()..add(AuthCheckRequested())),
        BlocProvider(create: (context) => getIt<ProfileSetupBloc>()),
        BlocProvider(
            create: (context) => getIt<ProfileBloc>()..add(ProfileLoaded())),
        BlocProvider(create: (context) => getIt<ChatBloc>()),
        BlocProvider(
            create: (context) =>
                getIt<DashboardBloc>()..add(DashboardLoaded())),
        BlocProvider(
            create: (context) => getIt<HistoryBloc>()..add(HistoryLoaded())),
        BlocProvider(
            create: (context) => getIt<BudgetBloc>()..add(BudgetLoaded())),
        BlocProvider(create: (context) => getIt<InsightsBloc>()),
        BlocProvider(create: (context) => getIt<RecurringBloc>()),
        BlocProvider(
            create: (context) =>
                getIt<PremiumBloc>()..add(PremiumCheckStatus())),
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            ListenableBuilder(
              listenable: getIt<ThemeNotifier>(),
              builder: (context, _) => MaterialApp.router(
                title: 'FinTrack Pro',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: getIt<ThemeNotifier>().mode,
                routerConfig: AppRouter.router,
              ),
            ),
            if (_isLocked)
              Container(
                color: const Color(0xFF0F3460),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock_outline,
                          size: 80, color: Colors.white),
                      const SizedBox(height: 24),
                      const Text(
                        "FinTrack Pro is Locked",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: _checkBiometricLock,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF0F3460),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                        ),
                        child: const Text("Unlock with Biometrics"),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
