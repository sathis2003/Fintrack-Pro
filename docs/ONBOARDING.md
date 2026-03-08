# Onboarding Guide

## Prerequisites
- Flutter SDK 3.29.0+
- Android Studio / Xcode
- A Supabase Project configured with Email Auth and valid Postgres endpoint

## First Time Setup
1. Clone the repository.
2. Run `flutter pub get`.
3. Create a `.env` root file containing your Supabase bindings:
   `SUPABASE_URL=foo` and `SUPABASE_ANON_KEY=bar`
4. Run `flutter run --dart-define-from-file=.env`.

## Project Conventions
- **Feature-first organization**: Each isolated logic block (like chat, dashboard, history) has a folder with sub-directories `bloc`, `pages`, and `widgets`.
- **BLoC Strict**: State Management relies 100% on `flutter_bloc`. No `setState` used for logic beyond transient UI interactions.
- **Null Safety strict**: Forced null-safety across all entities using domain data encapsulation.
- **Design DNA**: Uses FinTrack Pro "Design System v2" containing vivid gradient aesthetics, CRED/Groww styling cues, Lottie illustrations, and standard fallback patterns. Do not stray from typography in `app_typography.dart`.

## Key Contacts / Ownership
- Lead Dev (AI Agent): Handled rewriting of BLoCs, Chat ingestion, Dashboard redesigns and Theme routing. 

## Common Tasks
- **How to add a new feature**: 
  1. Add a new folder inside `lib/features`.
  2. Implement `bloc/`, `pages/`, `widgets/`.
  3. Wire the route in `app.dart`.
- **How to add a new BLoC**: 
  Inject using `getIt.registerFactory()` inside `core/di/injection.dart`.
- **How to run tests**:
  `flutter test`  (Requires `.env` mocks if depending on network calls).
