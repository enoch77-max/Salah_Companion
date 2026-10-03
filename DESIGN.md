# Design System & UI Specification: Salah Companion

## 1. Overview & Architectural Philosophy
Salah Companion is an authentic, offline-first Islamic prayer companion and spiritual guide built with Flutter. Its user experience is characterized by tactile physical feedback, iOS-inspired squircle geometry, zero continuous-polling efficiency, and high spiritual dignity.

---

## 2. Color Distribution & Design Tokens (OKLCH Calibrated)
The visual hierarchy implements a calibrated 60-30-10 distribution:
- **60% Dominant (Surface / Canvas)**:
  - Light Canvas: Soft warm bone / parchment (`#F8F9FA` / `#FFFFFF`)
  - Dark Canvas: Deep slate void (`#0D1117` / `#161B22`)
- **30% Structural (Borders, Dividers, Neutral Secondary)**:
  - Subtle Dividers: `#21262D` / `colors.dividerStrong`
  - Secondary typography: `colors.textSecondary` / `colors.textTertiary`
- **10% Accent Tokens**:
  - **Islamic Emerald Primary**: `#10B981` (Dhikr, Success, Done states)
  - **Marigold Amber / Warning**: `#F59E0B` (Upcoming prayer warnings, upcoming forbidden time alerts)
  - **Crimson Red / Missed**: `#EF4444` (Forbidden Nafl prayer prohibitions, missed prayers)
  - **Cerulean Azure**: `#0284C7` (Audio & Adhan acoustics)
  - **Amethyst Purple**: `#9333EA` (Spiritual daily reflection)

---

## 3. Shape Geometry & Typography
- **Continuous Squircle**: `ContinuousRectangleBorder` with `BorderRadius.circular(16)` to `24` across cards, sheet containers, and active pills.
- **Elevation**: 2-step lightness elevation with dual-light soft shadows; no harsh black drop-shadows.
- **Tactile Depress**: Scaled micro-interactions on pointer/tap events (`scale(0.97)` depress feel).

---

## 4. Dynamic Forbidden Nafl Note (`_ForbiddenNaflNote`)
Located dynamically at the bottom of the "Today's Prayers" card (`lib/features/home/presentation/widgets/prayer_list_card.dart`).

### A. Lifecycle & Visibility
- **Appears**: Exactly **10 minutes before** a forbidden window starts.
- **Active Window**: Full prohibition period with live pulsing red warning badge.
- **Concluded Window**: Brief permissible notice indicating the prohibition has ended.
- **Disappears**: Exactly **1 minute after** the forbidden window concludes.
- **Outside Windows**: Renders `SizedBox.shrink()` (0 pixels, zero visual footprint or extra padding).

### B. The Three Prohibited Windows
1. **Sunrise (Shuruq)**:
   - Prohibited window: `sunrise` to `sunrise + 20 minutes`
   - Visible: `sunrise - 10 minutes` until `sunrise + 21 minutes`
2. **Solar Zenith (Zawal / Midday)**:
   - Prohibited window: `dhuhr - 10 minutes` to `dhuhr`
   - Visible: `dhuhr - 20 minutes` until `dhuhr + 1 minute`
3. **Sunset (Ghurub / Pre-Maghrib)**:
   - Prohibited window: `maghrib - 20 minutes` to `maghrib`
   - Visible: `maghrib - 30 minutes` until `maghrib + 1 minute`

### C. Visual States
| State | Accent Color | Icon | Animation | Border / Background |
| :--- | :--- | :--- | :--- | :--- |
| **Upcoming (10m before)** | `#F59E0B` (Amber) | `Icons.hourglass_top_rounded` | Static | `alpha: 0.12` fill, `alpha: 0.4` border |
| **Active (Prohibited)** | `#EF4444` (Crimson) | `Icons.do_not_disturb_on_rounded` | Repeating fade pulse (`800ms`) | `alpha: 0.12` fill, `alpha: 0.4` border |
| **Concluded (1m after)** | `#10B981` (Emerald) | `Icons.check_circle_outline_rounded` | Static | `alpha: 0.12` fill, `alpha: 0.4` border |
| **Outside** | N/A | None | None | `SizedBox.shrink()` |

### D. Zero-Polling Event-Driven Architecture & Real-Time Notification Trigger
- Calculates the earliest future transition (`appear`, `start`, `end`, `disappear`).
- Sets a **single one-shot alarm/timer** (`_eventTimer`) sleeping until that transition. Consumes **0 CPU cycles and 0 battery** outside transitions.
- Re-syncs on app resume via `WidgetsBindingObserver.didChangeAppLifecycleState(AppLifecycleState.resumed)`.
- **Real-Time In-App Notification Trigger**: When `_ForbiddenNaflNote` enters or initializes in an active prohibited window (via timer transition, app launch/mount, app resume, or widget update), if forbidden notifications are enabled in SharedPreferences (`notif_enabled_forbidden_times`), it automatically invokes `NotificationService.scheduleForbiddenTimesNotifications` to immediately display the active heads-up notification with remaining duration `timeoutAfter`.

---

## 5. Settings Screen (`SettingsScreen`) & Instant Reaction Wiring
Located under **NOTIFICATIONS** group card (`lib/features/settings/presentation/screens/settings_screen.dart`):
- **Tile**: `forbidden_times_notification_tile`
- **Icon**: `Icons.do_not_disturb_on_rounded` in Crimson Red (`#EF4444`)
- **Title**: Localized `forbiddenTimesNotificationTitle` ("Forbidden Time Notifications")
- **Subtitle**: Localized `forbiddenTimesNotificationSubtitle` ("Alerts for Sunrise, Zenith & Sunset prohibited windows")
- **Control**: Adaptive iOS-styled switch tied to SharedPreferences key `'notif_enabled_forbidden_times'`.
- **Immediate Reaction Wiring**: Wired via `onForbiddenTimesNotificationsToggled` callback in `HomeScreen`. Toggling the switch inside `SettingsScreen` immediately recalculates and posts (if in active window or future windows) or cancels all scheduled/active notifications via `NotificationService` in real time, without waiting for the user to pop or close the Settings screen.

---

## 6. Auto-Expiring Notification Attributes
- **Channel**: `forbidden_times_channel` (`Forbidden Nafl Times`, High importance)
- **LED & Badge**: `#EF4444` Crimson
- **Auto-Dismissal**: Android `timeoutAfter` configured to the exact remaining duration of the prohibited window, guaranteeing clean system notification trays.
- **Active Window Heads-Up**: Immediate notification alert using `notificationsPlugin.show(...)` with auto-expiration when entering or enabling notifications during a prohibited window.

---

## 7. Android System Navigation Bar & Edge-to-Edge Protection
### A. Dynamic Bottom Inset Architecture
- **Problem**: Fixed bottom paddings cause scrollable content and floating navigation pills to collide with Android 3-button navigation bars (Square, Circle, Triangle) and gesture handles.
- **Dynamic Formula**: `58.0 + (bottomPadding > 0 ? 8.0 + bottomPadding : 12.0) + buffer`
  - Floating pill height: `58.0`
  - Pill-to-system-bar spacing: `8.0` (or `12.0` when system insets are 0)
  - System navigation insets: `MediaQuery.paddingOf(context).bottom`
  - Content buffer: `16.0` to `20.0`
- **Application**: Applied across Home Dashboard, Duas list, Tasbih workspace card, Qibla compass scroll, and Hijri Calendar occasions.

### B. Solid Themed System Navigation Dock Protection
- In `FrostedGlassBottomNavBar`, the bottom dock features:
  1. A solid themed container (`Container(height: bottomPadding, color: colors.background)`) directly behind the system navigation bar, ensuring zero prayer cards, text, or elements bleed under physical or software system buttons.
  2. A subtle gradient backdrop (`[colors.background.withValues(alpha: 0.0), colors.background.withValues(alpha: 0.72), colors.background]`) spanning from the top of the pill down to the system bar, eliminating awkward sharp see-through gaps while preserving frosted-glass blur aesthetics.

---

## 8. Dynamic SystemUiOverlayStyle Contrast Engine
- Automatically adapts status bar and system navigation bar icon brightness and colors upon theme switching:
  - **Dark Mode**:
    - `systemNavigationBarColor`: `colors.background` (`#0A0E0D`)
    - `systemNavigationBarIconBrightness`: `Brightness.light` (white icons)
    - `statusBarIconBrightness`: `Brightness.light` (white status icons)
  - **Light Mode**:
    - `systemNavigationBarColor`: `colors.background` (`#FAFAF7`)
    - `systemNavigationBarIconBrightness`: `Brightness.dark` (dark icons)
    - `statusBarIconBrightness`: `Brightness.dark` (dark status icons)
- **Implementation**: Generated centrally via `AppTheme.systemOverlayStyle(brightness: brightness, colors: colors)`, applied globally via `AppBarTheme` and mounted to root view hierarchies using `AnnotatedRegion<SystemUiOverlayStyle>`.

---

## 9. Hierarchical Device Back Navigation (`PopScope`)
- Replaces deprecated `WillPopScope` with Flutter's modern `PopScope` architecture to support Android 14+ Predictive Back gestures.
- **Condition**: `canPop: _selectedNavIndex == 0 && !_isDrawerOpen`
- **Hierarchical Interception Logic**:
  1. **Drawer Open**: Back closes the drawer first via `ScaffoldState.closeDrawer()` (`canPop: false`).
  2. **Secondary Tab Active (Duas, Tasbih, Qibla, Calendar)**: Back navigates the active index back to the Home Dashboard (`_selectedNavIndex = 0`) (`canPop: false`).
  3. **Root Home Tab & Drawer Closed**: Allows native system pop (`canPop: true`), enabling smooth predictive back wallpaper scaling on Android 14+.
