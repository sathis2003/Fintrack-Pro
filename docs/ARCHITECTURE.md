# Architecture

## Overview
FinTrack Pro employs a Clean Architecture structure coupled with standard feature-first layouts. Data flows unidirectionally, driven by BLoC state management. Offline-first semantics are preserved by prioritizing Drift local writes and syncing retroactively to Supabase.

## Layer Breakdown
- **Presentation Layer** — GradientCards, AnimatedAmounts, Lottie empty states, BLoC builders
- **Domain Layer** — Entities (Expense, Profile), repository interfaces
- **Data Layer** — Drift DAOs, Supabase database bindings

## BLoC Structure
- `AuthBloc`: Manages user sessions.
- `DashboardBloc`: Orchestrates stats fetching and layout generation.
- `ChatBloc`: Handles AI ingestion of expenses and validation loops.
- `HistoryBloc`: Paginates and filters past expense records.
- `ProfileBloc`: Manages theme handling, bio-metrics, and premium checks.

## Navigation
Driven by `go_router` located in `app_router.dart`. Includes a `MainShell` stack acting as the core app layout. No BottomNavigationBar is used; instead a gesture-invoked `AppDrawer` manages index state between `ChatPage`, `DashboardPage`, `HistoryPage`, and `AchievementsPage`.

## Data Flow
User Input (Chat) -> NLP Parser (Local Gemma/Groq) -> ChatBloc -> AppDatabase (Drift) -> Emit to DashboardBloc -> UI Update (AnimatedAmount) -> Background Sync via Workmanager to Supabase.
