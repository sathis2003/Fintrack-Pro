import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();

  // Supabase — loaded from .env file at runtime
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  // Edge Function URL
  static String get groqProxyUrl => '$supabaseUrl/functions/v1/groq-proxy';

  // Groq models
  static const groqFastModel = 'llama-3.1-8b-instant';
  static const groqQualityModel = 'llama-3.1-70b-versatile';

  // Thresholds
  static const minConfidence = 0.70;
  static const maxSyncRetries = 5;
  static const budgetAlertThreshold = 0.80;
}
