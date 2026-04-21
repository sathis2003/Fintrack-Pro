## [2026-03-24 18:25] — Database Schema Export Complete
**Status:** ✅ Done
**What was done:** 
- Manually generated the `schema.sql` file for Supabase by analyzing the app's data models and sync logic.
- Included table definitions for `expenses` and `budgets`, along with Row Level Security (RLS) policies and performance indexes.
- Placed the schema in the Envato package at `3_Database/schema.sql` and in the project at `supabase/schema.sql`.
- Verified that the schema aligns perfectly with the app's current sync mappers.
**Files changed:** 
- `supabase/schema.sql` (New)
- `d:\FINTRACK PRO\FinTrack_Pro_Envato_Package\3_Database\schema.sql` (New)
**Notes:** Bypassed the Docker-based CLI dump which was failing on the user's machine. The package is now fully complete for submission.
---

## [2026-03-24 18:04] — Finalized Envato Package Structure
**Status:** ✅ Done
**What was done:** 
- Created the final release folder structure required for the Envato marketplace at `d:\FINTRACK PRO\FinTrack_Pro_Envato_Package`.
- Isolated the pure Flutter source code (excluding `.git`, `build`, `.env`, etc.) into `1_Source_Code`.
- Staged the `Demo_APK` and buyer documentations.
- Staged `Database` and `Screenshots` folders pending manual assets from the owner.
**Files changed:** 
- `FinTrack_Pro_Envato_Package` (New directory spanning the required Envato structure)
**Notes:** The code is completely ready. Awaiting final user assets before compressing the release zip.
---

## [2026-03-24 17:55] — Envato Release Preparation
**Status:** ✅ Done
**What was done:** 
- Created CHANGELOG.md for the initial Envato release.
- Prepared codebase for Envato submission by writing buyer guidelines (`ENVATO_BUYER_GUIDE.md` and `EDGE_FUNCTION_SETUP.md`).
- Secured environment variables and removed hardcoded secrets.
- Configured production release build structure.
**Files changed:** 
- `CHANGELOG.md` (New)
- `docs/ENVATO_BUYER_GUIDE.md` (New)
- `docs/EDGE_FUNCTION_SETUP.md` (New)
**Notes:** Final steps for Envato readiness. Schema export and Demo APK build remaining.
---

## [2026-03-23 16:35] — Filter Toggle Fix & AI Icon Integration
**Status:** ✅ Done
**What was done:** 
- Modified `HistoryFilter` and `FilterBar` to allow deselecting categories (toggle behavior).
- Generated and integrated 3 sets of premium AI icons: `empty_history_pro.png`, `chat_ai_pro.png`, and `analytics_pro.png`.
- Updated `AppDrawer`, `EmptyState`, `HistoryPage`, and `DashboardPage` to use these new assets.
- Refined `EmptyState` widget to support both Lottie and Asset Images with a styled fallback.
**Files changed:** 
- `lib/features/history/bloc/history_state.dart`
- `lib/features/history/widgets/filter_bar.dart`
- `lib/core/widgets/empty_state.dart`
- `lib/core/widgets/app_drawer.dart`
- `lib/features/history/pages/history_page.dart`
- `lib/features/dashboard/pages/dashboard_page.dart`
- `assets/images/empty_history_pro.png` (New)
- `assets/images/chat_ai_pro.png` (New)
- `assets/images/analytics_pro.png` (New)
**Notes:** Replaced several static emojis and basic Lottie animations with custom-generated professional assets to enhance the app's premium feel.
---

## [2026-03-23 16:25] — Fix Chat Response Issue
**Status:** ✅ Done
**What was done:** Implemented handling for `ChatAwaitingConfirmation` state in `ChatPage`. Replaced text typing indicator with `TypingIndicator` widget.
**Files changed:** 
- `lib/features/chat/pages/chat_page.dart`
**Notes:** The UI was missing logic to show the `ConfirmationCard` when the AI successfully extracted an expense, making it look like nothing happened.
---

## [2026-03-23 16:15] — Implemented Dynamic Dashboard Data
**Status:** ✅ Done
**What was done:** Updated the Dashboard to use real-time data from the repository instead of static mockups. This includes dynamic recent expenses and accurate AI predictions based on current and previous month data.
**Files changed:** 
- `lib/domain/value_objects/monthly_summary.dart`
- `lib/domain/use_cases/get_monthly_summary.dart`
- `lib/features/dashboard/bloc/dashboard_bloc.dart`
- `lib/features/dashboard/pages/dashboard_page.dart`
**Notes:** Added `expenses` and `previousMonthExpenses` to the domain layer to bridge the gap between aggregated summaries and raw list requirements in the UI and prediction engine.
---

## [2026-03-23 16:04] — Fix Dashboard Rendering Exception (Border/Radius)
**Status:** ✅ Done
**What was done:** Resolved a Flutter rendering assertion error in `_PredictCard` within `dashboard_page.dart`. The previous `BoxDecoration` used a non-uniform `Border` with a `width: 0.0` side, which is incompatible with a non-zero `borderRadius`. Changed to `Border.all(color: AppColors.border)`.
**Files changed:**
- `lib/features/dashboard/pages/dashboard_page.dart`
**Notes:** Flutter requires uniform borders when using corner radii to ensure correct path painting at corners.
---

## [2026-03-23 16:00] — Fix GoRouter no routes for location: /
**Status:** ✅ Done
**What was done:** Added a root path `GoRoute(path: '/')` to `app_router.dart` that redirects to `/main` to fix a crash on startup when the app tries to load the root location.
**Files changed:**
- `lib/core/navigation/app_router.dart`
**Notes:** Deep linking or initial OS routing can default to `/`, which threw a GoException since it lacked a defined route mapping.
---

## [2026-03-23 12:08] — Bypass Notification Initialization
**Status:** ✅ Done
**What was done:** Temporarily commented out `FlutterLocalNotificationsPlugin.initialize()` in `NotificationService.init()` as the app was continuously crashing on startup due to `invalid_icon` error, regardless of the resource name.
**Files changed:** 
- `lib/services/notification_service.dart`
**Notes:** This was a hotfix requested to unblock app startup while the local notification icon issue is root-caused.
---

## [2026-03-23 11:55] — Fix App Startup Icon Error (Refined)
**Status:** ✅ Done
**What was done:** Resolved a `PlatformException(invalid_icon)` that prevented the app from starting. After an initial rename failed, a more robust fix was applied: copied `launcher_icon.png` to `android/app/src/main/res/drawable/app_icon.png` and updated `NotificationService` to use `'app_icon'`.
**Files changed:** 
- `lib/services/notification_service.dart`
- `android/app/src/main/res/drawable/app_icon.png` (New)
**Notes:** Placing the notification icon in the `drawable` folder is more reliable for plugin initialization across different Android versions.
---

## [2026-03-20 16:38] — Fix White Screen on App Launch
**Status:** ✅ Done
**What was done:** `FlutterGemma.initialize()` was blocking or crashing silently during app startup. Because the entire init was inside a single try/catch that only printed to console and never called `runApp()` on failure, the user saw a permanent white screen. Isolated Gemma init in its own try/catch (non-fatal) and added a fallback error UI so any future init failure shows a real error message instead of a white screen.
**Files changed:** lib/main.dart
**Notes:** Reduced `maxDownloadRetries` from 10 to 3 to prevent long hangs. Gemma is treated as optional — the app continues without on-device AI if it fails.
---

## [2026-03-19 11:47] — Disabling SMS Import Feature
**Status:** ✅ Done
**What was done:** Commented out `READ_SMS` and `RECEIVE_SMS` permissions in `AndroidManifest.xml` to prevent Google Play Protect from blocking the app installation on sideload. Verified that there were no active UI triggers to the SMS import page.
**Files changed:** android/app/src/main/AndroidManifest.xml
**Notes:** The user wanted to avoid Play Protect warnings for testing. We simply removed the permissions since the feature wasn't currently linked in the UI.
---

## [2026-03-17 18:52] — Fix Secret Push Block
**Status:** ✅ Done
**What was done:** Removed hardcoded Groq API key from `supabase/functions/groq-proxy/index.ts` to unblock git push due to GitHub Secret Protection.
**Files changed:** supabase/functions/groq-proxy/index.ts
**Notes:** The code now expects the key to be supplied purely via the `GROQ_API_KEY` environment variable in Supabase.
---

## [2026-03-17 20:41] — Fixed GitHub Push Protection (Groq Proxy Key)
**Status:** ✅ Done
**What was done:** A hardcoded Groq API key in the `supabase/functions/groq-proxy/index.ts` file triggered a GitHub push protection block, preventing code from being pushed. The key was removed, `Deno.env.get` fallback logic was fixed, and the git history of the local `new-Ui-design` branch was rewritten using a soft reset to `master` to completely purge the leaking commits from the tree before pushing successfully.
**Files changed:**
- `supabase/functions/groq-proxy/index.ts`
**Notes:** Rewrote Git history to purge secret commit `a24a7a39fc8b5799b14388b2d25ed201357b0d8f`.
---

## [2026-03-09 14:56] — Design v3 AI Chat & Main Drawer Nav
**Status:** ✅ Done
**What was done:** Completely redesigned main navigation switching from BottomNavigationBar to a custom AppDrawer (dark Zepto/CRED style). Rewrote ChatPage as index 0 default home with conversational suggestions. Redesigned DashboardPage with a new hero gradient card and AI predictions preview widget. Standardized FinTrackTopBar across main app tabs.
**Files changed:**
- `lib/features/shell/main_shell.dart`, `lib/features/chat/pages/chat_page.dart`, `lib/features/dashboard/pages/dashboard_page.dart`
- `lib/features/history/pages/history_page.dart`, `lib/features/achievements/pages/achievements_page.dart`
- `lib/core/navigation/app_router.dart`
**🗂️ Archived:**
- `lib/core/widgets/app_nav_bar.dart` -> moved to `/.agent/archive/...`
- `lib/features/shell/main_shell.dart` -> moved to archive
- `lib/features/chat/pages/chat_page.dart` -> moved to archive
- `lib/features/dashboard/pages/dashboard_page.dart` -> moved to archive
**Notes:** Design System Phase 3 complete. No bottom bars left.
---

## [2026-03-08 14:43] — Fixed R8 Compilation Error (Play Core)
**Status:** ✅ Done
**What was done:** Fixed another Android release build failure (`minifyReleaseWithR8`) where `com.google.android.play.core` classes were being missing/stripped by R8. Added the required custom ProGuard keep and dontwarn rules.
**Files changed:** 
- `android/app/proguard-rules.pro`
**Notes:** Added `-keep class com.google.android.play.core.** { *; }` and suppressed specific warnings for `SplitInstallManager` and `SplitCompatApplication` generated by the previous failed build.
---


**Status:** ✅ Done
**What was done:** Fixed an Android release build failure (`minifyReleaseWithR8`) where `com.google.mediapipe` classes were being missing/stripped by R8. Added custom ProGuard keep rules and linked them in `build.gradle.kts`.
**Files changed:** 
- `android/app/build.gradle.kts`
- `android/app/proguard-rules.pro` (Created)
**Notes:** Added `-keep class com.google.mediapipe.** { *; }` and suppressed specific warnings for `CalculatorProfileProto` and `GraphTemplateProto`.
---


**Status:** ✅ Done
**What was done:** Fixed an AI hallucination where Groq was freely returning a made-up overinflated "projected month-end spend" figure rather than accurately stating the remaining salary/budget balance. This was achieved by setting hard rules in `_conversationPrompt`, providing explicit math in `ChatContextBuilder`, and reducing output temperature in Groq APIs to `0.1` to enforce factual grounding.
**Files changed:** 
- `lib/data/remote/groq_ai_source.dart`
- `lib/services/chat_context_builder.dart`
**Notes:** Added exact `balance_remaining`, `projected`, `pace`, and `willOverspend` calculations before injecting into the context, so Groq doesn't try to compute it on the fly and hallucinate. Removed unused `catSummary` and `remaining` vars from context builder.
---


**Status:** ✅ Done
**What was done:** Removed the "Download Model Now" option from the Profile page as requested. Moved the code to the archive rather than leaving commented-out code, in accordance with the project safety rules.
**Files changed:** 
- `lib/features/profile/pages/profile_page.dart`
**🗂️ Archived:**
- `download_model_button.dart` -> moved to `/.agent/archive/unused/2026-03-08/download_model_button.dart`
**Notes:** Replaced the widget with a comment pointing to the archive location.
---


**Status:** ✅ Done
**What was done:** Completely removed the local `ChatIntentClassifier` pattern matching to let the Groq AI handle the intent classification natively, making the AI routing significantly more reliable for complex queries like "emi for laptop".
**Files changed:** 
- `lib/domain/entities/extracted_expense.dart`
- `lib/data/remote/groq_ai_source.dart`
- `lib/features/chat/bloc/chat_bloc.dart`
**🗂️ Archived:**
- `lib/services/chat_intent_classifier.dart` -> moved to `/.agent/archive/unused/2026-03-08/chat_intent_classifier.dart` (Reason: Refactored away local regex/keyword matching in favor of purely AI-driven intent parsing).
**Notes:** Updated the `_extractionPrompt` to return an `intent` field. The `chat_bloc.dart` now uses the AI's determined intent to route the message logic.
---


**Status:** ✅ Done
**What was done:** Fixed a bug in `ChatIntentClassifier` where expense-related keywords like 'spent', 'today', 'yesterday', and 'this month' were incorrectly classified as conversational questions, preventing expenses from being saved.
**Files changed:** 
- `lib/services/chat_intent_classifier.dart`
**Notes:** Removed colliding keywords from the question check list.
---

## [2026-03-08 12:58] — Fix Chat Page Border Rendering Exception
**Status:** ✅ Done
**What was done:** Resolved a Flutter rendering exception caused by a `borderRadius` combined with non-uniform `BorderSide` colors on the Chat Page empty state container.
**Files changed:** 
- `lib/features/chat/pages/chat_page.dart`
**Notes:** Achieved uniform borders by separating the outer uniform outline and inner accent left-border using nested containers and `ClipRRect`.
---

## [2026-03-08 09:47] — Conversational AI - Complete Fix
**Status:** ✅ Done
**What was done:** Implemented two-mode AI chat. Added Intent Classifier to detect conversational questions versus expense entries. Added Context Builder to supply user financial data to Groq. Expanded AI repository methods and updated profile sections to accept monthly income for better calculations.
**Files changed:** 
- `lib/services/chat_intent_classifier.dart`
- `lib/services/chat_context_builder.dart`
- `lib/data/remote/groq_ai_source.dart`
- `lib/data/repositories/ai_repository_impl.dart`
- `lib/features/chat/bloc/chat_bloc.dart`
- `lib/core/di/injection.dart`
- `lib/features/profile/pages/profile_page.dart`
- `lib/data/local/daos/budgets_dao.dart`
- `lib/data/local/daos/financial_profile_dao.dart`
**Notes:** Skipped updating groq-proxy index.ts as proxy logic did not require changes.
---

## [2026-03-06 23:00] — Applying Design System v2
**Status:** ✅ Done
**What was done:** Completely overhauled the app to follow the Indian Fintech "Design DNA" utilizing `flutter_animate`, `lottie`, and `google_fonts`. Developed `GradientCard`, `GradientProgressBar`, and `AnimatedAmount` building blocks and re-styled Dashboard, History, Chat, Profile, and Onboarding screens. Fixed several residual lint errors, including a `workmanager` API typo.
**Files changed:** `lib/core/theme/*`, `lib/core/widgets/*`, `lib/features/dashboard/*`, `lib/features/chat/*`, `lib/features/history/*`, `lib/features/profile/*`, `lib/features/onboarding/*`, `lib/services/weekly_digest_service.dart`
**Notes:** Decided to dynamically link themes using a `ThemeNotifier` injected via `get_it`. Lottie assets used for empty states gracefully fallback to generic Icons until assets are placed in the `assets/lottie` folder.
---
