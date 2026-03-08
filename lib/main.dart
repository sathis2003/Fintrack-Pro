import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'core/di/injection.dart';
import 'core/constants/app_constants.dart';
import 'services/sync_service.dart';
import 'services/notification_service.dart';
import 'features/app.dart';

import 'services/crash_reporting_service.dart';
import 'package:flutter_gemma/flutter_gemma.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SentryFlutter.init(
    (options) {
      options.dsn = const String.fromEnvironment('SENTRY_DSN');
      options.tracesSampleRate = kDebugMode ? 0.0 : 0.2; // 20% in prod
      options.environment = kDebugMode ? 'debug' : 'production';
      options.attachScreenshot = true; // capture UI on error
      options.attachViewHierarchy = true; // widget tree snapshot
      options.enableAutoSessionTracking = true;
    },
    appRunner: () async {
      try {
        print('--- APP INIT: Start ---');
        // 1. Initialize Crashlytics/Sentry (Firebase removed)
        print('--- APP INIT: CrashReportingService ---');
        await CrashReportingService.init();

        // Initialize Gemma
        print('--- APP INIT: FlutterGemma ---');
        FlutterGemma.initialize(
          maxDownloadRetries: 10,
        );

        // 2. Initialize Supabase
        print('--- APP INIT: Supabase ---');
        await Supabase.initialize(
          url: AppConstants.supabaseUrl,
          anonKey: AppConstants.supabaseAnonKey,
        );

        // 3. Setup Dependency Injection
        print('--- APP INIT: configureDependencies ---');
        await configureDependencies();

        // 4. Start Background Services
        print('--- APP INIT: NotificationService ---');
        await getIt<NotificationService>().init();
        print('--- APP INIT: SyncService ---');
        getIt<SyncService>().start();

        // 5. Run App
        print('--- APP INIT: runApp ---');
        runApp(const FinTrackApp());
      } catch (e, stackTrace) {
        print('--- APP INIT ERROR ---');
        print('Error during app initialization: $e');
        print('StackTrace: $stackTrace');
      }
    },
  );
}
