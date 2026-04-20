import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/di/injection.dart';
import 'core/constants/app_constants.dart';
import 'services/sync_service.dart';
import 'services/notification_service.dart';
import 'features/app.dart';

import 'services/crash_reporting_service.dart';
import 'package:flutter_gemma/flutter_gemma.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env file before anything else
  await dotenv.load(fileName: '.env');

  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.env['SENTRY_DSN'] ?? '';
      options.tracesSampleRate = kDebugMode ? 0.0 : 0.2; // 20% in prod
      options.environment = kDebugMode ? 'debug' : 'production';
      options.attachScreenshot = true; // capture UI on error
      options.attachViewHierarchy = true; // widget tree snapshot
      options.enableAutoSessionTracking = true;
    },
    appRunner: () async {
      try {
        // 1. Initialize Crashlytics/Sentry
        await CrashReportingService.init();

        // Initialize Gemma (non-blocking — isolated so failures don't kill the app)
        try {
          FlutterGemma.initialize(
            maxDownloadRetries: 3,
          );
        } catch (gemmaError) {
          // Gemma is optional — app continues without on-device AI
        }

        // 2. Initialize Supabase
        await Supabase.initialize(
          url: AppConstants.supabaseUrl,
          anonKey: AppConstants.supabaseAnonKey,
        );

        // 3. Setup Dependency Injection
        await configureDependencies();

        // 4. Start Background Services
        await getIt<NotificationService>().init();
        getIt<SyncService>().start();

        // 5. Run App
        runApp(const FinTrackApp());
      } catch (e) {
        // Show an error UI instead of a white screen
        runApp(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: const Color(0xFF0F3460),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 80, color: Colors.white),
                      const SizedBox(height: 24),
                      const Text(
                        'FinTrack Pro failed to start',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error: $e',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Please restart the app or contact support.',
                        style: TextStyle(color: Colors.white54, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    },
  );
}
