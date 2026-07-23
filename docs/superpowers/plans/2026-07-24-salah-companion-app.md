# Salah Companion Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build "Salah Companion" — an offline-first, highly reliable, iOS/Apple-inspired Flutter prayer time and spiritual reflection app for Android with native battery optimization recovery, GPS-derived location calculation, daily Sahih hadith/ayah reflection cards, fluid spring animations, and home/lock screen widgets.

**Architecture:** Clean architecture using `flutter_riverpod` for state management, `drift` (SQLite) + `shared_preferences` for data persistence, native Android platform channels (`com.salahcompanion/battery`) for battery optimization state, `adhan_dart` for prayer/qibla calculation, and `workmanager` + `flutter_local_notifications` for exact alarms and background refresh.

**Tech Stack:** Flutter 3.x, Dart 3.x, Riverpod 2.x, Drift, adhan_dart, hijri_calendar, flutter_compass, geolocator, geocoding, flutter_local_notifications, workmanager, google_fonts (Inter, Lora, Amiri, Noto Sans Arabic), lucide_icons, flutter_animate, mocktail, golden_toolkit.

**Design & Motion Principles (`/apple-design`, `/pick-ui-library`, `/animation`):**
- **Apple Design Language:** Translucent materials (`BackdropFilter` frosted glass), 1:1 direct manipulation, instant pointer-down feedback (`scale(0.97)` on press), squircle continuous curvature (`ContinuousRectangleBorder` 18-20pt), optical typography hierarchy with size-specific tracking/leading, and spatial consistency.
- **Fluid Spring Animations:** Critically damped springs (`damping: 1.0`, `response: 0.3-0.4s`) for UI transitions; interruptible motion that animates from live presentation values; tabular figures (`FontFeature.tabularFigures()`) for countdown timers to prevent jank/layout shifts.
- **Ecosystem Library Selection:** Reskinned Material 3 substrate, `lucide_icons` for stroke-consistent iconography, `google_fonts` for legal open typography (Inter, Lora, Amiri), `flutter_animate` for spring micro-interactions.

---

## User Review Required

> [!IMPORTANT]
> **Open Decisions from PRD Section 11 Needing User Confirmation:**
> 1. **Color Tokens vs "No Gold" Rule:** PRD v2 specifies an amber primary color (`#D4A574` dark / `#A67C52` light) from tested design CSVs, superseding the v1 "no gold" constraint and "night blue + teal" palette. This plan proceeds with the warm charcoal/parchment base + amber primary tokens from PRD Section 5.3.
> 2. **Daily Reflection Notification Time:** Suggested default is 30 minutes after Fajr.
> 3. **Quran & Hadith Translations:** Saheeh International is selected as the default Quran translation; English translations for hadith collections will use standard verified translations (e.g. Nasir Khattab for Musnad Ahmad, Darussalam for Bukhari/Muslim).
> 4. **Featured Content Override:** Firebase Remote Config is used for pushing featured content overrides without requiring custom backend servers.
> 5. **Share-as-Image Action:** Card image generation using `RepaintBoundary` will be included as an optional widget utility.

---

## Proposed File Structure

```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_typography.dart
│   │   └── app_theme.dart
│   └── constants/
│       └── app_constants.dart
├── core/
│   ├── database/
│   │   ├── app_database.dart
│   │   ├── tables/
│   │   └── daos/
│   ├── services/
│   │   ├── battery_service.dart
│   │   ├── location_service.dart
│   │   ├── timezone_service.dart
│   │   ├── notification_service.dart
│   │   └── background_service.dart
│   └── utils/
│       ├── calculation_method_mapper.dart
│       └── weighted_random_picker.dart
├── features/
│   ├── onboarding/
│   │   ├── presentation/
│   │   └── data/
│   ├── home/
│   │   ├── presentation/
│   │   │   ├── screens/home_screen.dart
│   │   │   └── widgets/
│   │   │       ├── prayer_countdown_hero.dart
│   │   │       ├── prayer_list_card.dart
│   │   │       └── daily_reflection_card.dart
│   │   └── providers/
│   ├── reflection/
│   │   ├── domain/
│   │   │   └── models/daily_content.dart
│   │   ├── data/
│   │   │   └── repositories/daily_content_repository.dart
│   │   └── presentation/
│   │       └── screens/favorites_screen.dart
│   ├── battery_protection/
│   │   └── presentation/
│   │       └── sheets/battery_optimization_sheet.dart
│   ├── qibla/
│   │   └── presentation/
│   │       └── screens/qibla_screen.dart
│   ├── tracker/
│   │   └── presentation/
│   │       └── screens/tracker_screen.dart
│   ├── tasbih/
│   │   └── presentation/
│   │       └── screens/tasbih_screen.dart
│   ├── calendar/
│   │   └── presentation/
│   │       └── screens/hijri_calendar_screen.dart
│   ├── duas/
│   │   └── presentation/
│   │       └── screens/duas_screen.dart
│   └── settings/
│       └── presentation/
│           └── screens/settings_screen.dart
assets/
├── data/
│   └── daily_content.json
└── fonts/
```

---

## Phase 0: Documentation & Package API Discovery & Project Setup

### Task 0.1: Initialize Flutter Project & Package Discovery
**Files:**
- Create: `pubspec.yaml`
- Create: `analysis_options.yaml`
- Create: `lib/main.dart`

- [ ] **Step 1: Scaffolding Flutter project structure**
Initialize the project using `flutter create --org com.salahcompanion --platforms android,ios ./` in `d:\App Build\Salah Companion`.

- [ ] **Step 2: Update `pubspec.yaml` with exact dependencies**
Add core dependencies: `flutter_riverpod`, `drift`, `sqlite3_flutter_libs`, `shared_preferences`, `adhan_dart`, `hijri_calendar`, `flutter_compass`, `geolocator`, `geocoding`, `flutter_local_notifications`, `timezone`, `just_audio`, `permission_handler`, `flutter_animate`, `workmanager`, `google_fonts`, `lucide_icons`.
Add dev dependencies: `drift_dev`, `build_runner`, `flutter_test`, `mocktail`, `golden_toolkit`.

- [ ] **Step 3: Run `flutter pub get` and verify build**
Run: `flutter pub get`
Expected: `Exit code 0`.

- [ ] **Step 4: Verify package APIs**
Verify class and method signatures for `adhan_dart`, `hijri_calendar`, `geolocator`, `drift` by compiling simple smoke test code.

---

## Phase 1: Apple-Inspired Design System & Core Database Schema

### Task 1.1: Color Tokens, Typography & Apple Design Theme System (PRD Section 5 & `/apple-design`)
**Files:**
- Create: `lib/app/theme/app_colors.dart`
- Create: `lib/app/theme/app_typography.dart`
- Create: `lib/app/theme/app_theme.dart`
- Test: `test/theme/app_theme_test.dart`

- [ ] **Step 1: Create `app_colors.dart` with dark & light tokens**
Define dark palette (`#0D0F14` background, `#181B22` surface, `#D4A574` primary amber, `#7DB89A` success, `#C97B6B` missed) and light palette (`#F5F2EE` warm parchment, `#FFFFFF` surface, `#A67C52` primary amber, `#4A8F6E` success, `#A85E4F` missed).

- [ ] **Step 2: Create `app_typography.dart` with optical sizing & tabular figures**
Configure Google Fonts for Inter (UI Chrome with `FontFeature.tabularFigures()`), Amiri (Arabic script), Lora (Quotes/Translations), and Noto Sans Arabic. Implement size-specific tracking (letter spacing) and leading (line height).

- [ ] **Step 3: Create `app_theme.dart` with ContinuousRectangleBorder squircles & frosted glass**
Configure `ThemeData` for dark and light modes with 18–20pt squircle radii cards, `BackdropFilter` blur properties (sigma 20), soft diffuse shadows (`BoxShadow(color: shadowColor, blurRadius: 24, offset: Offset(0, 8))`), and instant press feedback wrappers.

- [ ] **Step 4: Write unit test for Theme Data**
Verify colors match PRD Section 5.3 specifications and squircle/typography constraints.
Run: `flutter test test/theme/app_theme_test.dart`
Expected: PASS.

### Task 1.2: Database Schema (Drift) (PRD Section 8)
**Files:**
- Create: `lib/core/database/tables/prayer_logs_table.dart`
- Create: `lib/core/database/tables/battery_opt_state_table.dart`
- Create: `lib/core/database/tables/daily_content_cache_table.dart`
- Create: `lib/core/database/tables/daily_content_shown_log_table.dart`
- Create: `lib/core/database/tables/favorite_daily_content_table.dart`
- Create: `lib/core/database/tables/app_metadata_table.dart`
- Create: `lib/core/database/app_database.dart`
- Test: `test/database/app_database_test.dart`

- [ ] **Step 1: Write Drift table definitions**
Define tables: `PrayerLogs`, `BatteryOptState`, `DailyContentCache`, `DailyContentShownLog`, `FavoriteDailyContent`, `AppMetadata`.

- [ ] **Step 2: Run `build_runner` to generate drift code**
Run: `flutter pub run build_runner build --delete-conflicting-outputs`
Expected: Generation of `app_database.g.dart` with 0 errors.

- [ ] **Step 3: Write in-memory database test**
Test CRUD operations on `favorite_daily_content` and `daily_content_cache`.
Run: `flutter test test/database/app_database_test.dart`
Expected: PASS.

---

## Phase 2: Location, Timezone & Prayer Time Engine

### Task 2.1: Prayer Calculation & Country Auto-Detection Engine
**Files:**
- Create: `lib/core/utils/calculation_method_mapper.dart`
- Create: `lib/core/services/location_service.dart`
- Create: `lib/core/services/timezone_service.dart`
- Create: `lib/features/home/domain/prayer_times_calculator.dart`
- Test: `test/services/prayer_times_calculator_test.dart`

- [ ] **Step 1: Implement `calculation_method_mapper.dart`**
Map country codes (e.g. `EG` -> Makkah/Egyptian, `SA` -> Umm Al-Qura, `US` -> ISNA, `PK` -> Karachi, `AE` -> UAE) to `adhan_dart` calculation parameters.

- [ ] **Step 2: Implement GPS Location & Timezone Mismatch Detection**
Use `geolocator` to fetch high-accuracy coordinates. Compare device timezone against coordinates to produce a non-blocking mismatch warning if `deviceTimezone != locationTimezone`.

- [ ] **Step 3: Implement `prayer_times_calculator.dart`**
Compute Fajr, Sunrise, Dhuhr, Asr, Maghrib, Isha using `adhan_dart` for given coordinates, date, and calculation method.

- [ ] **Step 4: Unit test prayer time calculation**
Test calculation accuracy against known reference benchmarks for key cities (Makkah, London, New York).
Run: `flutter test test/services/prayer_times_calculator_test.dart`
Expected: PASS.

---

## Phase 3: Daily Reflection Engine & Vintage Paper UI

### Task 3.1: Bundled Sahih Hadith & Quran Asset Setup (PRD Section 6.3 - 6.4)
**Files:**
- Create: `assets/data/daily_content.json`
- Create: `lib/features/reflection/domain/models/daily_content.dart`
- Create: `lib/features/reflection/data/repositories/daily_content_repository.dart`
- Test: `test/reflection/daily_content_repository_test.dart`

- [ ] **Step 1: Create `daily_content.json` dataset**
Populate `assets/data/daily_content.json` with 180+ valid entries. Every Hadith entry MUST have `grade: "Sahih"`, a non-empty `graded_by` field, `source_weight` (1.5 for Musnad Ahmad/Bukhari, 1.0 for others), and valid `occasion_tags`.

- [ ] **Step 2: Implement `daily_content.dart` model**
Parse JSON into typed objects with `HadithContent` and `AyahContent` sealed/freezed classes or Dart 3 records.

- [ ] **Step 3: Implement `WeightedRandomPicker` & Selection Pipeline (PRD 6.5)**
Filter entries against 45-day `ShownLog`, apply occasion tags based on `hijri_calendar`, apply `source_weight` modifiers, and pick using daily ISO date + `installation_seed` random generator. Cache daily selection in SQLite `DailyContentCache`.

- [ ] **Step 4: Unit test selection algorithm**
Verify per-install randomness, 45-day no-repeat constraint, and 100% Sahih validation guard.
Run: `flutter test test/reflection/daily_content_repository_test.dart`
Expected: PASS.

### Task 3.2: Vintage Paper Reflection Card & Favorites Screen
**Files:**
- Create: `lib/features/home/presentation/widgets/daily_reflection_card.dart`
- Create: `lib/features/reflection/presentation/screens/favorites_screen.dart`
- Test: `test/widgets/daily_reflection_card_test.dart`

- [ ] **Step 1: Implement `daily_reflection_card.dart`**
Render card with `Elevated BG` (`#12151C`/`#EDE9E4`), hairline border (`Divider Strong`), decorative quote glyph (`Primary Soft`), Amiri Arabic script, Lora italic translation, and star icon toggle.

- [ ] **Step 2: Implement star icon toggle & optimistic DB write**
Tapping star updates `FavoriteDailyContent` table in SQLite immediately with press feedback scale animation.

- [ ] **Step 3: Implement `favorites_screen.dart`**
Render list of favorited cards in reverse-chronological order with vintage paper styling.

- [ ] **Step 4: Widget test for Daily Reflection Card**
Verify card rendering, star toggle state, and favoriting flow.
Run: `flutter test test/widgets/daily_reflection_card_test.dart`
Expected: PASS.

---

## Phase 4: Native Android Battery Optimization & Recovery Flow

### Task 4.1: Native Android Platform Channel (PRD Section 4.2)
**Files:**
- Modify: `android/app/src/main/kotlin/com/salahcompanion/MainActivity.kt`
- Create: `lib/core/services/battery_service.dart`
- Test: `test/services/battery_service_test.dart`

- [ ] **Step 1: Implement native method channel in Kotlin `MainActivity.kt`**
Register channel `com.salahcompanion/battery` with method `isIgnoringBatteryOptimizations` calling `PowerManager.isIgnoringBatteryOptimizations(packageName)`.

- [ ] **Step 2: Implement Dart `battery_service.dart`**
Call platform channel on Android. Read `battery_opt_state` from SQLite database. Implement 24-hour cooldown logic, `nagDisabled` check, and manual "Check now" triggers.

- [ ] **Step 3: Implement OEM guidance helper**
Add OEM manufacturer detection (`Build.MANUFACTURER`) to show tailored autostart/battery settings guidance for Samsung, Xiaomi, Huawei, Oppo, Vivo.

- [ ] **Step 4: Unit test `battery_service.dart`**
Mock method channel calls and test 24-hour cooldown and prompt state triggers.
Run: `flutter test test/services/battery_service_test.dart`
Expected: PASS.

### Task 4.2: Battery Optimization Dismissible Bottom Sheet UI
**Files:**
- Create: `lib/features/battery_protection/presentation/sheets/battery_optimization_sheet.dart`

- [ ] **Step 1: Implement bottom sheet UI**
Build frosted-glass modal sheet with title "Prayer alerts may be delayed", explanation body, "Fix it" primary button (launching `ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS`), "Remind me later" (setting 24h cooldown), and "Don't ask again" (`nagDisabled = true`).

- [ ] **Step 2: Wire lifecycle listener in `app.dart`**
Listen to `WidgetsBindingObserver.didChangeAppLifecycleState == resumed` to trigger check automatically.

---

## Phase 5: Home Dashboard & Full Feature Screens

### Task 5.1: Home Dashboard Screen (PRD Section 7 & `/apple-design` & `/animation`)
**Files:**
- Create: `lib/features/home/presentation/screens/home_screen.dart`
- Create: `lib/features/home/presentation/widgets/prayer_countdown_hero.dart`
- Create: `lib/features/home/presentation/widgets/prayer_list_card.dart`
- Create: `lib/features/home/presentation/widgets/hijri_strip.dart`

- [ ] **Step 1: Implement `prayer_countdown_hero.dart` with tabular numbers**
Build dynamic circular countdown ring with animated LED dot (`flutter_animate`), next prayer name, tabular figures remaining time (`FontFeature.tabularFigures()`), and subtle background gradient based on time-of-day.

- [ ] **Step 2: Implement `prayer_list_card.dart` with press feedback**
Display 5 daily prayers + Sunrise with one-tap status toggle (Prayed / Missed / Pending) using status colors (`Success` `#7DB89A` / `Missed` `#C97B6B`), squircle continuous borders, and instant press-down scaling.

- [ ] **Step 3: Implement `hijri_strip.dart`**
Show current Hijri date using `hijri_calendar` with moon-sighting offset adjustment support.

- [ ] **Step 4: Assemble `home_screen.dart`**
Combine hero section, Hijri strip, prayer list cards, and daily reflection card in a single smooth scrolling viewport with frosted-glass bottom navigation bar.

### Task 5.2: Qibla Compass Screen (PRD Section 7 & `/animation`)
**Files:**
- Create: `lib/features/qibla/presentation/screens/qibla_screen.dart`

- [ ] **Step 1: Implement `qibla_screen.dart` with smooth spring rotation**
Compute exact Qibla bearing using `adhan_dart` from GPS coordinates. Read raw device compass heading from `flutter_compass`. Render smooth rotating compass dial using `AnimatedBuilder` with spring dynamics (`damping 1.0`, `response 0.4s`).

### Task 5.3: Remaining Feature Screens (Tracker, Tasbih, Calendar, Duas, Settings)
**Files:**
- Create: `lib/features/tracker/presentation/screens/tracker_screen.dart`
- Create: `lib/features/tasbih/presentation/screens/tasbih_screen.dart`
- Create: `lib/features/calendar/presentation/screens/hijri_calendar_screen.dart`
- Create: `lib/features/duas/presentation/screens/duas_screen.dart`
- Create: `lib/features/settings/presentation/screens/settings_screen.dart`

- [ ] **Step 1: Implement Prayer Tracker / Statistics**
Render weekly/monthly prayer completion charts using styled progress bars.

- [ ] **Step 2: Implement Tasbih Counter**
Build interactive counter widget with haptic feedback, custom targets (33, 100, custom), and reset.

- [ ] **Step 3: Implement Hijri Calendar & Event list**
Show monthly calendar view with key Islamic events (Ramadan, Eid, Ashura).

- [ ] **Step 4: Implement Settings Screen**
Add controls for calculation methods, battery optimization check button, daily reflection notification time, and sound options.

---

## Phase 6: Notifications, Background Refresh & Override

### Task 6.1: Prayer & Daily Reflection Notification Engine
**Files:**
- Create: `lib/core/services/notification_service.dart`
- Create: `lib/core/services/background_service.dart`

- [ ] **Step 1: Implement `notification_service.dart`**
Initialize `flutter_local_notifications` with custom adhan audio channel. Schedule exact alarms for 5 daily prayers and independent Daily Reflection notification (default 30 min post-Fajr).

- [ ] **Step 2: Implement Midnight Background Task with `workmanager`**
Schedule daily midnight `workmanager` task to recalculate prayer times for the new date, resolve daily reflection content, update local cache, and reschedule notifications.

- [ ] **Step 3: Implement Featured Content Remote Override**
In the midnight job, check optional Firebase Remote Config / static URL for `featured_content_id` override. Fallback silently to normal weighted random algorithm if offline or unavailable.

---

## Phase 7: Home & Lock Screen Widgets

### Task 7.1: Android Home Screen Widget Implementation
**Files:**
- Create: `android/app/src/main/kotlin/com/salahcompanion/PrayerWidgetProvider.kt`
- Create: `android/app/src/main/res/layout/prayer_widget.xml`

- [ ] **Step 1: Implement native Android AppWidgetProvider**
Create lightweight native Android widget rendering next prayer name, time, and countdown.

- [ ] **Step 2: Update widget data from Dart background job**
Pass updated prayer time calculation payload from `background_service.dart` to home screen widget via Android `SharedPreferences` / `WidgetManager`.

---

## Phase 8: Comprehensive Verification & Quality Assurance

### Task 8.1: Full Dataset Sanity Verification Script
**Files:**
- Create: `test/verification/dataset_verification_test.dart`

- [ ] **Step 1: Write automated dataset validator**
Verify that 100% of Hadiths in `daily_content.json` have `grade == "Sahih"`, non-empty `graded_by`, valid `source_weight`, and valid references.

- [ ] **Step 2: Run verification script**
Run: `flutter test test/verification/dataset_verification_test.dart`
Expected: 0 errors, 100% Sahih compliance.

### Task 8.2: Automated & Manual Verification Suite
- [ ] **Step 1: Run full test suite**
Run: `flutter test`
Expected: ALL TESTS PASS.

- [ ] **Step 2: Build release APK**
Run: `flutter build apk --release`
Expected: Successful build with zero compilation errors.

---

## Verification Plan

### Automated Tests
- `flutter test`: Executes all unit, widget, and database tests.
- `flutter test test/verification/dataset_verification_test.dart`: Validates Sahih hadith constraints.

### Manual Verification
1. **Battery Optimization Check**: Verify on real Android device (Samsung/Xiaomi) that revoking battery exemption triggers the bottom sheet within 1 app resume cycle.
2. **Offline Daily Content**: Disable device network, launch app, verify Daily Reflection card displays properly from offline JSON/cache.
3. **Qibla Compass**: Verify compass needle alignment against physical location bearing.
