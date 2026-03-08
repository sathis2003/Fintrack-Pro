# Archive Note: `chat_intent_classifier.dart`

**Date Archived:** 2026-03-08
**Reason:** The app was originally using this file to locally match words like "spent" or "balance" to figure out the user's intent to avoid an extra AI call. However, this pattern matching was too rigid (e.g. failing on "i spent 10k for emi").
We removed this and updated the core `_extractUseCase` / Groq AI extraction prompt to handle both the intent classification and expense extraction in a single, more reliable pass.
**Was used in:** `ChatBloc`
