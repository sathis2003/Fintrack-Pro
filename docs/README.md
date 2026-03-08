# FinTrack Pro

## What is this app?
FinTrack Pro is a privacy-first, offline-capable, AI-powered personal finance management application with a premium Indian Fintech design aesthetic. It uses a local SLM (Gemma) to analyze and parse natural language expenses, completely locally.

## Tech Stack
- Flutter version: 3.29.x
- State Management: BLoC (flutter_bloc)
- Backend/API: Supabase (Auth & Cloud Database sync)
- Database: Drift (SQLite offline-first persistence)
- AI Engine: Local Gemma using `google_smart_replies` or ONNX
- Key packages: `flutter_animate`, `lottie`, `google_fonts`, `workmanager`, `go_router`

## How to Run
1. Ensure Flutter is installed.
2. Provide a `.env` configuration file with `SUPABASE_URL` and `SUPABASE_ANON_KEY`.
3. Build the app using `flutter run --dart-define-from-file=.env`.

## Folder Structure
```text
lib/
├── core/            # Themes, Constants, DI setup, base Widgets
├── data/            # Drift DB definitions, Repository implementations
├── domain/          # Entities and logic interfaces
├── features/        # Feature blocks (auth, chat, dashboard, history)
├── services/        # Third-party utilities & Gemma API 
└── main.dart        # Entrypoint & routes
```

## Environment Setup
The project relies on a Supabase backend. Place your `.env` in the root:
```
SUPABASE_URL=YOUR_URL
SUPABASE_ANON_KEY=YOUR_KEY
```
