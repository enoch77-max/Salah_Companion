# Project Context: Salah Companion

## Stack & Versions
- **Platform**: Flutter (Dart 3.x), Android Native (Kotlin), iOS
- **Target Platform**: Android (minSdk 21+, targetSdk 34/35)
- **Database / Persistence**: Drift (SQLite), SharedPreferences
- **Architecture**: Feature-first Clean Architecture (`lib/features/`, `lib/core/`, `lib/app/`)
- **Theme**: Material 3 with Custom AppTheme tokens and Google Fonts
- **Notifications & Alarms**: Flutter Local Notifications, Android Exact Alarms, WorkManager

## Key Architecture & Battery Protection
- **Battery Service**: `lib/core/services/battery_service.dart` via MethodChannel `com.salahcompanion/battery`
- **Native Implementation**: `android/app/src/main/kotlin/com/rymthos/salahcompanion/MainActivity.kt`
- **Battery Optimization UI**: `lib/features/battery_protection/presentation/sheets/battery_optimization_sheet.dart`
- **Lifecycle Listener**: `lib/features/battery_protection/presentation/widgets/battery_protection_listener.dart`

## Verification Commands
- `flutter test`
- `flutter analyze`
