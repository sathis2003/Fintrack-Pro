# Features

## Implemented Features
| Feature | Status | BLoC | Screens | Notes |
|---------|--------|------|---------|-------|
| Gen V2 Auth | ✅ Done | AuthBloc | LoginScreen, SignupScreen | Email OTP + OAuth |
| Offline First DB | ✅ Done | N/A | Global | Drift SQLite with reactive streams |
| Natural Language Expenses | ✅ Done | ChatBloc | ChatPage | Local Gemma or Groq fallback |
| Design System v2 | ✅ Done | ThemeNotifier | All | CRED/Groww inspired gradients, Lottie states |
| Categorized Dashboard | ✅ Done | DashboardBloc | DashboardPage | FlChart integration, Animated Counters |

## Planned Features
| Feature | Priority | Notes |
|---------|----------|-------|
| Family Sharing | Low | Co-op vaults |
| Automated Receipt Scanning | High | Local OCR fallback |

## Known Issues / Tech Debt
| Issue | File | Priority |
|-------|------|----------|
| Background Sync Edge Cases | `workmanager` | Med |
