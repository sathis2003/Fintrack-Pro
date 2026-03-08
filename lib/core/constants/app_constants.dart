class AppConstants {
  AppConstants._();

  // Supabase
  static const supabaseUrl = 'https://zbeeapuorkwkefypremw.supabase.co';
  static const supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpiZWVhcHVvcmt3a2VmeXByZW13Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI0NjYzODQsImV4cCI6MjA4ODA0MjM4NH0.-j_2a3yylei3O2W9dYfItsLdJAOqV8iyezYSSu4QY4w';

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
