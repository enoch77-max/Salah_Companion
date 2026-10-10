# Design System & UI Specification: Salah Companion

## 1. Overview & Architectural Philosophy
Salah Companion is an authentic, offline-first Islamic prayer companion and spiritual guide built with Flutter. Its user experience is characterized by tactile physical feedback, iOS-inspired squircle geometry, zero continuous-polling efficiency, and high spiritual dignity.

---

## 2. Color Distribution & Design Tokens (OKLCH Calibrated)
The visual hierarchy implements a calibrated 60-30-10 distribution across Light and Dark themes:

### A. Light Theme (Stitch Serene Sanctuary Palette)
- **60% Dominant (Surface / Canvas)**:
  - Canvas Background: Stitch serene warm parchment (`#FFF8F5`)
  - Elevated Container Low: Cream parchment (`#FCF2EB`)
  - Paper Reflection Card: Warm natural paper parchment (`#EFE4D6`)
  - Surface Lowest: Clean white surface (`#FFFFFF`)
  - Surface Hover: Soft sand (`#F6ECE6`)
- **30% Structural (Borders, Dividers, Neutral Secondary)**:
  - Hairline Dividers: Warm stone (`#EAE1DA`)
  - Strong Dividers: Softened warm stone contour (`#E4DAD2`, `colors.dividerStrong`)
  - Dedicated Card Border: Delicate 6% warm neutral contour `Color(0x0F1F1B17)` (`colors.cardBorder`) that naturally blends into warm cream/linen surfaces without muddy tan outlines
  - Typography: On-surface primary (`#1F1B17`), variant secondary (`#53433A`), subtle tertiary (`#85736B`)
- **10% Accent Tokens**:
  - **Signature App Icon Emerald**: `#0F766E` (Active floating prayer card border & glow, primary controls, switches, chips)
  - **Success Container**: `#007952` (Prayed state, completion badges)
  - **Restricted / Error**: `#BA1A1A` (Forbidden Nafl prohibitions, missed prayers)
  - **Amber Caution**: `#B45309` / `#FEF3C7` (Upcoming prayer pills, early forbidden warnings)

### B. Dark Theme (Authentic Obsidian & Warm Gold Palette)
- **60% Dominant (Surface / Canvas)**:
  - Canvas Background: Pure obsidian void (`#0D0F14`)
  - Elevated Background: Deep obsidian (`#12151C`)
  - Surface Card: Slate obsidian (`#181B22`)
  - Surface Hover: Elevated dark slate (`#1E222C`)
- **30% Structural (Borders, Dividers, Neutral Secondary)**:
  - Subtle Dividers: `0x0DFFFFFF` / `colors.divider`
  - Strong Dividers: `0x17FFFFFF` / `colors.dividerStrong`
  - Dedicated Card Border: Subtle 7% white glass-edge rim `Color(0x12FFFFFF)` (`colors.cardBorder`) providing delicate edge definition on deep obsidian containers
  - Typography: Primary bone (`#F0EDE8`), Secondary mist (`#8B9099`), Tertiary slate (`#5A5F68`)
- **10% Accent Tokens**:
  - **Signature Warm Gold Primary**: `#D4A574` (Active floating prayer card border & glow, primary controls, active text `#E8C9A0`)
  - **Success Emerald**: `#10B981` (Prayed state, streak indicators)
  - **Missed Terracotta**: `#C97B6B` (Missed prayers)
  - **Amber Alert**: `#F59E0B` (Upcoming prayer warnings, upcoming forbidden time alerts)

---

## 3. Shape Geometry & Anti-Distortion Card Architecture
- **Anti-Distortion Card Borders**: All container cards, dashboard surfaces, sheets, dialogs, navigation drawers, and grouped cards employ `RoundedRectangleBorder` with smooth, anti-aliased hairline strokes (`side: BorderSide(color: colors.cardBorder, width: 0.8)` or `border: Border.all(color: colors.cardBorder, width: 0.8)`).
  - *Flutter Bézier Blooming Remediation*: Flutter's `ContinuousRectangleBorder` with stroking suffers from an un-inset path blooming defect where outer strokes bulge at the corners, creating muddy and distorted border visuals. Replacing stroked continuous rectangles with `RoundedRectangleBorder` at 0.8dp width guarantees razor-sharp, uniform, distortion-free contours across all high-DPI displays.
  - *Universal Screen & Modal Coverage*: Modernized consistently across Home (`prayer_list_card.dart`, `daily_reflection_card.dart`, `hijri_strip.dart`), Duas (`duas_screen.dart`), Qibla (`qibla_screen.dart`), Hijri Calendar (`hijri_calendar_screen.dart`), Learn Salah (`learn_salah_hub_screen.dart`, `salah_step_by_step_screen.dart`, `salah_category_detail_screen.dart`, `posture_avatars.dart`), Navigation Drawer (`app_navigation_drawer.dart`), Bottom Sheets & Modals (`widget_preview_sheet.dart`, `battery_optimization_sheet.dart`, `prayer_streak_sheet.dart`, `daily_reflection_popup.dart`, `open_source_sheet.dart`), Legal Documentation (`terms_screen.dart`, `privacy_policy_screen.dart`, `calculation_docs_screen.dart`), Settings (`settings_screen.dart`), Tasbih (`tasbih_screen.dart`), Favorites (`favorites_screen.dart`), and Onboarding (`onboarding_screen.dart`, `language_selection_step.dart`, `visual_feature_showcase_step.dart`, `trust_manifesto_step.dart`, `permission_priming_step.dart`, `spiritual_dedication_step.dart`, `interactive_feature_demo_step.dart`).
- **Continuous Squircle Usage**: Preserved exclusively for borderless filled chips, unbordered pill backgrounds, and inner icon badge fills where no stroked borders are drawn.
- **Elevation**: 2-step lightness elevation with dual-light soft shadows; no harsh black drop-shadows.
- **Tactile Depress**: Scaled micro-interactions on pointer/tap events (`scale(0.97)` depress feel).
- **Animation Key Scoping Invariant (List Items & Dynamic Mode Toggles)**: Widget keys and animation keys (e.g. Flutter Animate `.animate(key: ...)`) on recurring list items (such as `_PrayerRowItem`) must strictly scope to item-specific identity and state (`'icon_${item.name}_${item.status.name}'` and `'anim_icon_${item.name}_${item.status.name}'`), strictly excluding global or sibling view mode toggles (such as `widget.isFridayMosqueMode`). Including container-level mode flags in row item keys invalidates widget keys across all list rows during mode toggles, causing Flutter Animate to unmount/remount and replay scale/fade entrance animations on all unchanged items simultaneously (producing visual flicker).

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
- **Subtitle**: Localized `forbiddenTimesNotificationSubtitle` ("Alert for prohibited nafl time")
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

### B. Frosted Glass Floating Navigation Capsule & System Dock Protection
- In `FrostedGlassBottomNavBar`, the navigation bar features:
  1. An authentic frosted-glass capsule using a high-precision `BackdropFilter` (`sigma: 18`) and calibrated translucent surface (`colors.surface` with `alpha: 0.72` in Dark, `0.80` in Light) bounded inside a 28px squircle `ClipRRect`.
  2. A dual-light elevation shadow (ambient `blur: 6, offset: (0, 2)` + key shadow `blur: 18, offset: (0, 6)`) providing genuine physical depth that casts soft shadows over scrolling content beneath.
  3. Clean, 100% transparent margins around and under the floating capsule (zero gradient backdrop fog), ensuring the capsule genuinely floats in clear space.
  4. A solid themed container (`Container(height: bottomPadding, color: colors.background)`) directly behind the Android system navigation bar, ensuring zero prayer cards, text, or elements bleed under physical or software system buttons.

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

---

## 10. Synchronized Hero Time-Shift Animation Engine (`PrayerCountdownHero`)
Located inside the home dashboard hero card (`lib/features/home/presentation/widgets/prayer_countdown_hero.dart`).

### A. Architectural Optimization (60/120 FPS Motion)
- **Elimination of Relayout Loops**: Replaced 6 concurrent uncoordinated `AnimatedDefaultTextStyle` tickers and 2 `AnimatedContainer` width animators with a single synchronized `TweenAnimationBuilder<double>`.
- **Target Value**: `end: isCurrentSalah ? 1.0 : 0.0`.
- **Physics Calibration**: `260ms` duration with `Curves.easeOutCubic` for snappy, immediate initial response that glides smoothly to rest, staying strictly under the 300ms interaction budget.
- **Accessibility & Reduced Motion**: Queries `MediaQuery.disableAnimationsOf(context)` to instantly snap duration to `Duration.zero` for users with motion sensitivity.

### B. Geometry & Invariant Locks
- **Zero Screen Shake Constraint**: Outer container strictly locked to `SizedBox(height: 52.0)`. Elements and cards below remain 100% stationary throughout state transitions.
- **Dual-Row Fixed Semantic Roles**:
  - **Top Row**: Always Start Time (`Starts` / `Started`).
  - **Bottom Row**: Always End Time (`Ends`).
- **Synchronized Hierarchy Shift**:
  - Upcoming Prayer (`t = 0.0`): Top row prominently active (28px digits), bottom row secondary (13.5px digits).
  - Current Salah (`t = 1.0`): Top row secondary (13.5px digits), bottom row prominently active (28px digits).
- **Zero Layout Overflow**: Typography sizing interpolates along mathematical bounds such that the combined height of both rows consistently equals ~46px, fitting cleanly within the 52.0px container across all animation frames.

---

## 11. Modern Popped-Up Floating Prayer Cards (`_PrayerRowItem` & `PrayerListCard`)
Located inside the home dashboard Today's Prayers list (`lib/features/home/presentation/widgets/prayer_list_card.dart`).

### A. Compact Physical Elevation & Rail Hierarchy
- **Active / Target Salah Card**:
  - Height: Compact ~64px height (`padding: 10px 14px`).
  - Width: Full container width (`margin: EdgeInsets.zero`), expanding 8px past unselected cards on both sides.
  - Border: 1.0px hairline border matching the active theme accent (`#D4A574` Warm Gold in Dark Mode, `#0F766E` Emerald in Light Mode) with clean, uninterrupted surface geometry.
  - Sits at 100% full visual opacity (`1.0`).
- **Recessed Unselected Cards**:
  - Height: Compact ~48px height (`padding: 7px 11px`).
  - Width: Inset by 8px on left and right (`margin: EdgeInsets.symmetric(horizontal: 8.0)`).
  - Depth Opacities: Prayed cards recede to `0.45` opacity, upcoming cards to `0.85` opacity, and future cards to `0.70` opacity.

### B. Progressive 360° Omnidirectional Ambient Shadow Engine
- Zero-offset (`Offset.zero`) multi-tiered Gaussian shadows calibrated for 360° physical depth:
  - **Dark Mode**: 6px core (black 40%), 16px (+2px spread, black 32%), 32px (+4px spread, black 22%), 54px (+6px spread, black 12%), and 14px warm gold aura (`#D4A574` at 18%).
  - **Light Mode**: 6px core (`#78716C` at 16%), 16px (+2px spread, `#78716C` at 14%), 32px (+4px spread, `#78716C` at 9%), 54px (+6px spread, `#78716C` at 5%), and 14px emerald aura (`#0F766E` at 10%).
- **Snug Symmetrical Distance**: List separator is strictly 6px (`SizedBox(height: 6)`). With positive shadow spread (up to +6px with 54px blur) and `clipBehavior: Clip.none`, the ambient glow spills onto the neighbor cards above and below, establishing equal optical distance on both sides.

### C. Prayer Name Typography & Proportions
- **Prayer Title Typography**:
  - Selected / Active Prayer: `fontSize: 17.5`, `FontWeight.w800`, `letterSpacing: -0.2` for enhanced prominence and optical balance against the sleeker capsule pills.
  - Unselected Prayers: `fontSize: 15.0`, `FontWeight.w700` (or `FontWeight.w500` when marked prayed), `letterSpacing: -0.2`.

### D. Time Capsule Pill (`_TimeCapsulePill`)
- **Responsive Geometry & Anti-Clipping**: Wrapped in `FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft)` to prevent parent column width constraints (~170–190px on compact mobile devices) from clamping padding and clipping text against capsule borders.
- **Background & Border**:
  - **Light Mode**: Warm cream parchment background (`#FCF2EB`) and subtle warm stone border (`#EAE1DA`, 1.0px width). Never uses conditional emerald/green tint.
  - **Dark Mode**: Elevated dark slate background (`colors.surfaceHover`) and subtle divider border (`colors.divider`, 1.0px width).
- **Padding & Breathing Room**: Calibrated `EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5)` guaranteeing ample spacing between text and capsule borders while maintaining sleek proportions.
- **Typography & Partition**:
  - Labels ('Start', 'End'): `fontSize: 9.5`, `FontWeight.w500`, colored `#53433A` (Light) / `colors.textTertiary` (Dark).
  - Time Values: `fontSize: 10.0`, `FontWeight.w700`, colored `#1F1B17` (Light) / `colors.textPrimary` (Dark).
  - Divider: Clean 1px width, 8.0px height vertical divider (`#D6CBC3` in Light, `colors.dividerStrong.withValues(alpha: 0.45)` in Dark) with `4.5px` horizontal padding on both sides.

### E. Full-Width Card Sub-Row Sunnah Strip & Compact Typography
- **Architectural Placement**: Positioned as a dedicated horizontal sub-row inside the selected card (`Column` under the main icon/name/status `Row` with `7.0px` vertical spacing), spanning the entire internal card width (~300px on mobile).
- **Zero Shrinking & High Contrast**: Relieves the narrow middle column from vertical/horizontal overcrowding. Text renders at full, unconstrained `fontSize: 11.5` with `FontWeight.w600` and letter spacing `0.1`, guaranteeing zero micro-font scaling by `FittedBox` on Bengali or English text.
- **Visual Styling**: Continuous squircle container (`BorderRadius.circular(8)`) with `Icons.menu_book_rounded` (13px), 6px icon spacing, and calibrated padding (`EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.5)`).
  - Light Mode: `Color(0xFF0F766E).withValues(alpha: 0.08)` surface with `0.25` border.
  - Dark Mode: `Color(0xFFD4A574).withValues(alpha: 0.14)` surface with `0.35` border and `#E8C9A0` text.
- **Compacted Typography Contract**:
  - Eliminates verbose prefixes (e.g. removes "ফরজের" and heavy Arabic grammatical titles from Bengali badges) to ensure quick, at-a-glance spiritual guidance:
    - Fajr: "পূর্বে ২ রাকাত সুন্নত"
    - Dhuhr: "পূর্বে ৪ রাকাত ও পরে ২ রাকাত সুন্নত"
    - Asr: "পূর্বে ৪ রাকাত সুন্নত"
    - Maghrib: "পরে ২ রাকাত সুন্নত"
    - Isha: "পরে ২ রাকাত সুন্নত + ৩ রাকাত বিতর"

### F. Hard Calculation & Target Invariant Locks
- **Zero Calculation Drift**: Absolute zero touch on `PrayerTimesCalculator`, astronomical math, notification schedulers, or background alarms.
- **Target Prayer Selection Invariant**:
  ```dart
  final isSelected = item.isCurrent
      ? !isPrayed
      : (item.isNext && !widget.hasCurrentUnprayed && !isPrayed);
  ```
  Elevates the current unprayed prayer first; once marked prayed, seamlessly transfers elevation to the next upcoming prayer.

---

## 12. Compact & Short Screen Ergonomic Hardening (Qibla & Tasbih)

### A. Qibla Screen Responsive Scaling
- **Dynamic Dial Sizing (`LayoutBuilder`)**:
  - `dialSize`: `math.min(constraints.maxWidth - 24, 300.0).clamp(220.0, 320.0)`.
  - `painterSize`: `(dialSize - 10.0).clamp(210.0, 310.0)`.
  - Replaces hardcoded 300px dial and 290px painter sizes. On a 320px screen width (288px padded space), `dialSize` scales proportionally to 264px without distortion or overflow, maintaining full needle and compass dial clarity.
- **Header & Metric Row Flex Adaptation**:
  - Screen title: Wrapped in `Expanded` with single-line ellipsis to prevent collision with calibration button on narrow viewports.
  - Numeric metrics tile: `_MetricDisplayTile` elements wrapped in `Expanded` with `FittedBox(fit: BoxFit.scaleDown)` typography, preventing horizontal RenderFlex overflows on screens <= 320px width.

### B. Digital Tasbih Screen Height-Adaptive Ergonomics
- **Height-Adaptive State Engine (`LayoutBuilder`)**:
  - Screen height threshold: `constraints.maxHeight < 680`.
- **Short Screens & Landscape Mode (`< 680px`)**:
  - Body wrapped in `SingleChildScrollView` with `BouncingScrollPhysics()`.
  - Workspace card unbounds from `Expanded` to `Container` with `MainAxisSize.min`, keeping the full 162px illustrated bead conveyor belt, target chips, and Apple reset button comfortably accessible with zero `RenderFlex` overflow.
- **Standard & Large Viewports (`>= 680px`)**:
  - Preserves the clean `Expanded` workspace layout with `MainAxisAlignment.spaceEvenly` distribution and zero unnecessary scroll bounce.


---

## 13. Friday Jumu'ah & Companion Suite Localization & Token Contract
- **Contract Coverage**: Full 19-language parity (`en`, `ar`, `az`, `bn`, `bs`, `de`, `fa`, `fr`, `hi`, `id`, `kk`, `ky`, `ms`, `ru`, `sq`, `sw`, `tr`, `ur`, `uz`).
- **Core Key Registry**:
  - **Jumu'ah Mode & Location**: `fridayJumuahTitle`, `fridayLocationLabel`, `fridayAtMosque`, `fridayAtHome`.
  - **Sunnah Rulings & Sub-strip**: `fridaySunnahRulingsTitle`, `fridayBeforeLabel`, `fridayAfterLabel`, `fridayMosqueBeforeDesc`, `fridayMosqueAfterDesc`, `fridayHomeBeforeDesc`, `fridayHomeAfterDesc`, `fridayClickToReadFull`.
  - **Special Deeds Suite**: `fridaySuiteHeader`, `fridayTodayOnly`.
  - **Surah Al-Kahf Action**: `surahKahfTitle`, `surahKahfBadge`, `surahKahfHadith`, `markAsRead`, `readCompleted`.
  - **Salawat Action & Tasbih**: `salawatTitle`, `salawatBadge`, `salawatHadith`, `doSalawat`, `dhikrSalawat`, `dhikrSalawatTranslation`.
  - **Friday Etiquettes (Sunan)**: `fridayEtiquettesTitle`, `fridayEtiquettesRef`, `fridayGhusl`, `fridaySiwak`, `fridayCleanClothes`, `fridayEarlyMosque`.
  - **Hour of Response (Sa'at al-Istijabah)**: `istijabahTitle`, `istijabahBadge`, `istijabahHadith`.
  - **Hadith Evidence Modal Guide**: `fridayHadithGuideSheetTitle`, `fridayHadithBeforeCardTitle`, `fridayHadithBeforeCardDesc`, `fridayHadithAfterMosqueTitle`, `fridayHadithAfterMosqueDesc`, `fridayHadithAfterHomeTitle`, `fridayHadithAfterHomeDesc`, `closeGuideBtn`.
- **Zero Drift Invariant**: Core calculation algorithms, Saturday–Thursday rendering pipelines, and astronomical calculation matrices are strictly isolated and untouched.

---

## 14. In-Card Friday Jumu'ah & Sunnah Rulings Implementation

### A. Architectural Overview & Context Detection
- **Target File**: `lib/features/home/presentation/widgets/prayer_list_card.dart`
- **Friday Detection Engine (`_effectiveIsFriday`)**:
  - Direct explicit property `widget.isFriday` when supplied.
  - Multi-tier fallback examining `.weekday == DateTime.friday` on `nowOverride`, `dhuhrDateTime`, `sunriseDateTime`, and `maghribDateTime`.
- **Zero-Touch Core Invariant**:
  - Zero modifications to `PrayerTimesCalculator`, prayer timing windows, or Saturday–Thursday rendering logic.
  - Uncompromised prayer selection state logic: `isSelected`, `isCurrent`, `isNext`, elevation transfer logic, and toggle callbacks operate identically.

### B. Dynamic Friday Mode & Location Persistence
- **State Key**: `'friday_prayer_location'` in `SharedPreferences`.
- **Modes**:
  - `mosque` (Default): Friday Jumu'ah congregation at the mosque. Dhuhr slot renders `l10n.fridayJumuahTitle`.
  - `home`: Individual Dhuhr prayer at home. Dhuhr slot renders `l10n.prayerDhuhr`.
- **Haptic Feedback**: Fires `AppHaptics.selection()` on mode toggle with immediate UI re-rendering and async disk persistence.

### C. Visual Ergonomics & In-Card Components
- **Location Selector (`_buildFridayLocationSelector`)**:
  - Mounted directly above the Sunnah card when Friday Dhuhr is the selected prayer.
  - **Unboxed Floating Architecture**: Redundant outer tile container, background fill, and enclosing border completely eliminated (`Padding(padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0))`), creating an airy unboxed hierarchy that eliminates nested capsule-in-capsule visual clutter.
  - **Clean Flat Track**: Low-profile recessed slider track (196px width, 28px height, 14dp pill radius, 2.0dp internal padding) with subtle background tint (`isDark ? colors.surface.withValues(alpha: 0.45) : colors.surfaceHover.withValues(alpha: 0.55)`) and zero harsh outer border.
  - **Sliding Pill Indicator**: Smooth `AnimatedAlign` (`Alignment.centerLeft` vs `Alignment.centerRight`, `220ms` duration, `Curves.easeOutCubic`) with `FractionallySizedBox(widthFactor: 0.5, heightFactor: 1.0)`, 12dp concentric inner radius, ultra-thin crisp hairline border (`0.5dp` width; `Color(0xFF0F766E).withValues(alpha: 0.28)` in Light mode / `Color(0xFFD4A574).withValues(alpha: 0.45)` in Dark mode), vibrant luminous active capsule tint (`Color(0xFFCCFBF1)` in Light mode / `Color(0xFFD4A574).withValues(alpha: 0.22)` in Dark mode), high-contrast active typography (`#0F766E` in Light mode / `#E8C9A0` in Dark mode), and subtle elevation shadow.
  - **Tactile Segmented Options**: Equal-width flex tiles with responsive text scale-down (`FittedBox(fit: BoxFit.scaleDown)`), cross-fading typography (`AnimatedDefaultTextStyle`, 220ms), and domain micro-icons (`Icons.mosque_rounded` and `Icons.home_rounded` at 12px) with zero tap highlight clutter.
- **Compact Friday Sunnah Card (`_buildCompactFridaySunnahCard`)**:
  - Replaces single-line generic strip on Friday with a dedicated 2-tier structured card:
    - **Header**: Book icon (`Icons.menu_book_rounded`) + `fridaySunnahRulingsTitle` with full horizontal span.
    - **Row 1 (`BEFORE`)**: Badged micro-tag with voluntary / Tahiyyat al-Masjid guidance.
    - **Row 2 (`AFTER`)**: Badged micro-tag with 4 Rak'ahs (mosque) or 2 Rak'ahs (home) guidance.
    - **Footer Prompt**: Centered `fridayClickToReadFull` text with forward arrow, inviting user to explore authentic references.
  - Strict zero-emoji policy across all badges, labels, and text.

### D. Authentic Hadith Guide Modal Sheet (`_FridayHadithGuideSheet`)
- **Presentation**: `showModalBottomSheet` with `ImageFilter.blur(sigmaX: 16, sigmaY: 16)` and 32pt continuous squircle top radius.
- **Tonal Contrast Standards**:
  - **Dark Mode**: Sheet background `#0D0F14`, recessed cards `#06080C`, accent gold `#D4A574` / `#E8C9A0`.
  - **Light Mode**: Sheet background `#F5EBE4`, warmer lighter cards `#FFF7F2`, accent emerald `#0F766E`.
- **Dismiss Control**: Centered "Close Guide" button without checkmark icons, adhering strictly to design system purity.

---

## 15. Friday Companion Suite Specification & Invariants

### A. Architectural Placement & Conditional Lifecycle
- **Target File**: `lib/features/home/presentation/widgets/friday_companion_suite.dart`
- **Dashboard Insertion**: Mounted inside `HomeScreen` (Tab 0) directly beneath `PrayerListCard` and above `DailyReflectionCard`.
- **Conditional Visibility**:
  ```dart
  if ((widget.overrideIsFriday ?? ((widget.nowOverride ?? DateTime.now()).weekday == DateTime.friday))) ...
  ```
  Outside of Fridays, the widget tree completely skips mounting or returns `SizedBox.shrink()` (0 pixels footprint).

### B. The Four Sacred Friday Practice Cards
1. **Surah Al-Kahf (`_buildKahfCard` & `SurahKahfReaderPopup`)**:
   - **Card Surface & Metrics**: Features `110 Ayat` chapter badge, localized `surahKahfBadge` ("Light Between Two Fridays"), authentic Al-Bayhaqi citation, and dynamic theme color branding (`colors.primary`: Warm Gold `#D4A574` dark / Deep Teal `#0F766E` light).
   - **Expanding Card Animation (`CardExpandRoute`)**: Tapping the action button captures the physical screen coordinates of the card (`originRect`) and initiates an origin-aware container transform. The card expands and pops up out via a 320ms container transform with dynamic z-axis pop scaling (`popScale = 1.0 + 0.015 * sin(t * pi)`) and elevation lift (`2.0 -> 24.0`). The card preview is anchored at `originRect` and smoothly dissolves over t: 0.0 -> 0.22, while reader content emerges fast and reaches full opacity over t: 0.08 -> 0.28 (~80ms). On closing, it rapidly and smoothly shrinks back over 250ms into the screen and the exact card size (`originRect`), landing seamlessly on the home screen card.
   - **Full Surah Al-Kahf Reader Pop-Up (`SurahKahfReaderPopup`)**:
     - Integrates complete 110 verses in authentic Uthmani Arabic script and English translation (`SurahKahfData`).
     - Dual-view toggle: Continuous **Mushaf View** with ornamental ayah symbols (`۝`) for traditional Friday recitation, and **Verse-by-Verse View** with translation cards.
     - Toolbar: Segmented mode selector, tactile font size stepper (two elevated physical squircle buttons flanking a recessed luminous teal point-size badge 24 pt, with 18pt–36pt bounds and haptic feedback), scroll-linked reading progress indicator, and sacred Bismillah calligraphy header.
     - Bottom sticky action bar with two dedicated controls:
       - **"Close"**: Shrinks back to the screen; leaves the item unread if not marked.
       - **"Mark as Read"**: Elevated theme-colored pill button with checkmark icon (`colors.primary`); records completion state to `SharedPreferences` (`'friday_kahf_completed'`) with haptic feedback and smoothly closes the reader.
   - **Post-Read Home Screen Feedback**:
     - When marked as read, the card renders a refined **success-green done tick badge** (Done with Icons.check_circle_rounded in colors.successText, bordered in colors.success.withValues(alpha: isDark ? 0.40 : 0.28) with colors.successSoft background, interactive for direct toggle).
     - The action button transforms into **"Read Again"** in luminous teal styling, preserving full re-entry capability to recite anytime.
     - When uncompleted or dismissed without marking, the button displays **"Read"** with no done badge.
2. **Abundant Salawat Action Card (`_buildSalawatCard`)**:
   - Badged with `salawatBadge` ("Presented Directly") and Abu Dawud Hadith citation.
   - High-contrast action button labeled "Do Salawat" (`l10n.doSalawat`) with custom vector `TasbihIcon`, tactile haptic feedback (`AppHaptics.light()`), and forward navigation chevron.
   - Direct tab transition: Invokes `onOpenSalawatTasbih` callback, seamlessly switching to the Digital Tasbih tab (`_selectedNavIndex = 2`) and auto-selecting the Friday-exclusive Salawat item.
3. **Friday Purification & Etiquettes Checklist (`_buildEtiquettesCard`)**:
   - 4 Sunnah practices from authentic traditions:
     - **Ghusl**: `Icons.water_drop_rounded`, key `'friday_etiquette_ghusl'`.
     - **Siwak & Perfume**: `Icons.brush_rounded`, key `'friday_etiquette_siwak'`.
     - **Clean Clothes**: Bespoke `TailoredGarmentIcon` vector painter (authentic mandarin collar, sleeves, chest placket, and hem silhouette; strictly bans generic 4-pointed stars), key `'friday_etiquette_clothes'`.
     - **Early Mosque Arrival**: `Icons.mosque_rounded`, key `'friday_etiquette_early_mosque'`.
   - Each item features animated circular completion checkboxes and tactile haptic selection.
4. **Sa'at al-Istijabah (`_buildIstijabahCard`)**:
   - Badged with `istijabahBadge` ("Supplication Accepted") and authentic Abu Dawud / An-Nasa'i Hadith citation.
   - Dynamic time evaluation between `asrDateTime` and `maghribDateTime`:
     - Outside window: pristine subtle card styling.
     - Within window (between Asr and Maghrib): elevates card with primary glowing border and pulsating `ACTIVE` indicator.

### C. Design Invariants & Ergonomic Hardening
- **Clean Suite Section Header**: Rendered as a clean, single-row typographic header matching standard app category headers (`Icons.mosque_rounded` + `labelSmall` with `1.2` letterSpacing), completely omitting redundant pill badges to provide full horizontal span and eliminate awkward multi-line word breaks.
- **Strict Ban on AI Sparkles & Generative Icons (`Icons.auto_awesome*`)**: Generative AI sparkles, magic wands, and 4-pointed sparkle stars are strictly prohibited anywhere in the application. All icons must be authentic, purposeful Islamic or system domain icons (`Icons.mosque_rounded`, `Icons.menu_book_rounded`, `Icons.verified_rounded`, etc.).
- **Zero Hardcoded Strings**: 100% of titles, badges, hadith citations, and button labels consume `AppLocalizations.of(context)` across all 19 supported locales.
- **Zero Emojis**: Pure typographic and vector icon styling across all cards.
- **Zero-Truncation Invariant (`softWrap: true` & Zero Ellipsis Dots)**:
  - Strict eradication of text truncation (`TextOverflow.ellipsis` and hard `maxLines` clamps) across all Friday section headers, titles, location toggles, checklists, and Sunnah cards.
  - All textual elements utilize `softWrap: true` to wrap naturally across lines, ensuring full, complete unclipped readability in every language without any `...` dots.
- **Narrow Viewport Resilience & Fluid Layouts (<= 320px - 360px)**:
  - Location selectors utilize responsive `Wrap` (`WrapAlignment.spaceBetween`, `runSpacing: 4-5`) to guarantee 0px RenderFlex overflow across narrow viewports and expansive locales (e.g. German, Russian, French).
  - All card badges utilize `Wrap` with `runSpacing: 4`, and action controls employ `Flexible` with `FittedBox(fit: BoxFit.scaleDown)` to guarantee pristine layout integrity across all form factors.
- **Zero Core Drift**: Core astronomical calculation algorithms, timing windows, and Saturday–Thursday execution pathways remain strictly untouched.

---

## 16. Friday-Exclusive Salawat & Durood Ibrahim Tasbih Integration

### A. Architectural Overview & Conditional Dynamic Rotation
- **Target File**: `lib/features/tasbih/presentation/screens/tasbih_screen.dart`
- **Dynamic Rotation Engine (`_effectiveDhikrs`)**:
  - Evaluates `isFriday` (via `widget.overrideIsFriday ?? ((widget.nowOverride ?? DateTime.now()).weekday == DateTime.friday)`).
  - **Friday Mode (`isFriday == true`)**: Yields 7 items in the dhikr selector rotation, seamlessly incorporating both compact Salawat upon the Prophet (ﷺ) and full Durood Ibrahim.
  - **Standard Mode (Saturday–Thursday)**: Yields strictly the standard 5 dhikrs (`subhanallah`, `alhamdulillah`, `allahu_akbar`, `astaghfirullah`, `la_ilaha_illallah`), completely excluding Friday items from the list.

### B. Salawat & Durood Ibrahim Dhikr Specification Contracts
1. **Compact Salawat**:
   - **Identifier**: `'salawat'`
   - **Target Recitation Count**: `100` beads (standard Islamic Sunnah milestone for Friday devotion).
   - **Arabic Text**: `اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ` (Allāhumma ṣalli 'alā Muḥammad)
   - **Typographic Treatment**: Rendered with standard 28pt Quranic typography.
   - **Localization**: Localized title (`l10n.dhikrSalawat`) and translation (`l10n.dhikrSalawatTranslation`) across all 19 supported locales.
2. **Full Durood Ibrahim (Durud)**:
   - **Identifier**: `'durood_ibrahim'`
   - **Target Recitation Count**: `33` beads (balanced devotional cycle for complete recitation).
   - **Arabic Text**: `اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ، اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ`
   - **Fully Visible Workspace Typography (Zero Sub-Scrolling)**: Long dhikrs (`arabic.length > 50`) render directly in a non-scrollable column with 100% full visibility. Arabic font size is calibrated to `15.5` (line height `1.65`, semi-bold `FontWeight.w600` for crisp Tashkeel diacritic clearance without ink smearing or density) in `AppTypography.quranicStyle`, paired with pronunciation font size `11.0` (height `1.35`) in `AppTypography.quoteTranslationStyle`. All lines of both Salawat and Barakah clauses remain completely visible simultaneously on screen with zero internal scroll fields. Viewport adaptation occurs at the page level on compact screens (`< 760px`).
   - **Dhikr Selector Chip Protection**: In `_DhikrSelectorCard`, Arabic text normalizes whitespace (`arabic.replaceAll('\n', ' ')`) and is locked with `maxLines: 1` and `TextOverflow.ellipsis` to preserve the 52px fixed chip height and avoid horizontal carousel distortion.
   - **Localization & Pronunciation Matrix**: Localized title (`l10n.dhikrDuroodIbrahim`) and authentic phonetic pronunciation transliteration (`l10n.dhikrDuroodIbrahimTranslation`) in native alphabets/scripts across all 19 supported locales.

### C. Deep Navigation & Persistent Day-of-Week Safety
- **Direct Navigation Targeting**:
  - `TasbihScreen` accepts `targetDhikrId` property and exposes `selectDhikrById(String id)` on its public state `TasbihScreenState`.
  - When the user taps "Do Salawat" from the Friday Companion Suite, `HomeScreen` navigates to index `2` and synchronously selects the `'salawat'` item.
- **Day-of-Week Boundary Resilience**:
  - Active selection is saved in `SharedPreferences` by dhikr ID (`'tasbih_dhikr_id'`).
  - If a user completes their Friday recitations with Salawat or Durood Ibrahim selected and launches the app on Saturday, `_loadPreferences()` verifies the saved ID against the active list. Since Friday items are excluded on Saturday, it safely falls back to SubhanAllah (`index = 0`), preventing index out-of-bounds errors or stale state crashes.

### D. Tactile Interaction & Feedback Parity
- Full participation in the Digital Tasbih physics engine:
  - Interactive tactile bead wheel with haptic feedback on every recitation.
  - Milestone sound and vibration triggers upon reaching target recitations (100 for Salawat, 33 for Durood Ibrahim).
  - Apple-inspired smooth progress ring and reset confirmations.

---

## 14. Friday Companion Suite & Surah Al-Kahf Manuscript Reader

### A. Architectural Overview & Context
- **Card Placement**: Located directly below `PrayerListCard` on the Home screen exclusively on Fridays (`overrideIsFriday || DateTime.now().weekday == DateTime.friday`).
- **Core Cards**:
  1. *Surah Al-Kahf Card*: Displays recitation status, hadith context, and expands smoothly into the manuscript reader popup via `CardExpandRoute`.
  2. *Salawat & Durood Ibrahim Card*: Quick direct action route jumping straight to the Digital Tasbih Friday rotation.
  3. *Friday Sunnah Etiquettes Card*: Checkable physical Sunnah habits (Ghusl, Siwak, Fragrance, Early to Mosque) with instant local persistence.
  4. *Sa'at al-Istijabah Card*: Real-time countdown tracking the sacred hour of supplication between Asr and Maghrib with live pulse animation.

### B. Surah Al-Kahf Expanding Manuscript Reader (`SurahKahfReaderPopup`)
- **Visual Aesthetic & Paper Continuum**:
  - **Shared Canvas Color**: Utilizes the identical authentic manuscript paper background token (`colors.paperBackground`, `#EFE4D6` in Light mode and `#26231F` in Dark mode) as `DailyReflectionCard` and `CardExpandRoute`.
  - **Expansion Transition (`CardExpandRoute`)**: Smooth continuous physical scale and morph transition from the resting card rect directly into the immersive reader surface, eliminating jarring page flashes or harsh color disconnections.
- **Header & Typographic Sacred Dignity**:
  - **Unboxed Sacred Bismillah Calligraphy**: Replaces boxed outlines with an unboxed, majestic Amiri Arabic calligraphy header and Lora italic translation, unified by a delicate center-fading hairline gold/theme divider.
  - **Zero Duplicate Hadith Clutter**: Excludes the resting card's hadith quote from inside the reader popup to maximize vertical reading focus.
- **Dual Reading Modes**:
  1. *Continuous Mushaf Mode*: Flowing Madinah Mushaf layout (`GoogleFonts.amiri`, default `22 pt`, `height: 2.8`, natural word kerning, optical page padding 22px) with authentic circular ayah medallions containing Arabic numerals (`_toArabicIndic(verse.number)`) in `colors.primary`.
  2. *Verse-by-Verse Mode*: Individual verse cards on tonal paper with clear Arabic recitation (`height: 2.4`, natural word kerning), hairline divider, and authentic Lora italic English translation.
- **Ergonomic Toolbar**:
  - Segmented capsule mode switch (`Mushaf` vs `Verse by Verse`) styled in subtle paper-harmonized tones.
  - Tactile physical font size stepper (`A-`, `22 pt` default, `A+`) without unnecessary horizontal slider bars.
  - Delicate hairline reading progress bar at the bottom edge of the toolbar showing real-time scroll completion percentage.
- **Sticky Footer Action Bar**:
  - Fixed at the bottom over paper background with subtle upper blur border.
  - "Close" outlined capsule button that dismisses the reader and preserves existing state.
  - "Mark as Read" elevated theme button that toggles completion state with tactile haptic feedback and updates the home card status badge immediately.

---

## 15. Origin-Aware Expanding Container Transform & Persistent Shared Header Motion Architecture

### A. Architectural Intent & Motion Philosophy
Eliminates jarring modal cutaways, full-screen pops, and bottom-sheet sliding disconnects. When an interactive card triggers a detailed reading or hadith guide window, the popup window physically **emerges directly out of the clickable card section** via a fluid, GPU-accelerated container transform.

### B. Standard Animation Vocabulary & Taxonomy
- **Origin-Aware Animation**: The popup dialog geometry grows outward from the exact physical screen coordinates and dimensions (`originRect`) of the tapped card.
- **Container Transform / Morph**: The rectangular card surface continuously interpolates into the centered popup dialog, morphing border radius (10.0/18.0dp to 24.0dp), elevation (1.5dp to 24.0dp), and dimensions simultaneously.
- **Spatial Permanence & The Non-Disappearing Header Law**:
  - In conventional crossfades, the origin card dissolves away, causing the title to momentarily vanish before the destination title fades in. This breaks visual tracking.
  - Under the Non-Disappearing Header Law, the shared title text (e.g., `"Surah Al-Kahf"`) and squircle icon badge **maintain 100% opacity throughout the entire forward and reverse transition**.
  - As the container expands, the title and icon smoothly glide, scale, and shift from their resting card offsets into the top header of the popup window.
  - For components where the title expands (e.g., `"Jumu'ah Sunnah Rulings"` to `"Sunnah Prayers of Jumu'ah: Hadith Guide"`), the text smoothly crossfades inline while continuously translating into position.
- **Staged 3-Layer Orchestration**:
  1. *Layer 1 (Card Body)*: Resting card body elements (badges, quotes, read buttons, before/after rows) dissolve early ($t \in [0.0, 0.18]$) within the expanding container.
  2. *Layer 2 (Popup Body)*: Destination popup contents (scrollable Quran verses, reading toolbar, or hadith reference cards) emerge smoothly ($t \in [0.14, 0.60]$) with a subtle 16px upward translation settle.
  3. *Layer 3 (Persistent Shared Header)*: Rendered on top of all content at 100% opacity throughout $t \in [0.0, 0.999)$. Glides continuously between card header and dialog header coordinates.
- **Zero-Ghosting Handoff Protocol**:
  - During flight ($t < 0.999$), the popup child's native header is rendered with `opacity: 0.0`. This prevents double-rendering or ghosted outlines beneath the moving shared header.
  - At $t \ge 0.999$, handoff to the child's interactive header is instantaneous and visually indistinguishable because coordinates, typography, and icon metrics are identical.
  - Upon closing (`Navigator.pop()`), the shared header immediately re-engages and smoothly glides back down into the resting card.

### C. Motion Dynamics & Calibrated Easing Tokens
- **Forward Opening Duration**: `300ms` (fast, instantaneous tactile response without sluggishness).
- **Reverse Closing Duration**: `240ms` (snappy acceleration back into origin bounds).
- **Forward Easing Curve**: `Cubic(0.08, 0.85, 0.15, 1.0)` — Asymmetric fluid deceleration curve. High initial velocity guarantees the card reacts immediately upon finger lift, followed by exponential, silky deceleration into the resting dialog coordinates.
- **Reverse Easing Curve**: `Cubic(0.35, 0.0, 0.20, 1.0)` — Snappy exit curve accelerating cleanly into the resting card.
- **Micro-Physics Pop**: A subtle z-plane scale factor (`1.0 + 0.012 * sin(t * pi)`) projects the card forward toward the user before settling into resting elevation.

### D. Frosted Backdrop Scrim
- **Atmospheric Blur**: Smoothly ramps `ImageFilter.blur(sigmaX: 7.0 * t, sigmaY: 7.0 * t)`.
- **Theme-Calibrated Scrim**: `Colors.black` with `alpha: (isDark ? 0.60 : 0.38) * t`.
- **Outside Tap Dismissal**: Tapping the backdrop barrier triggers `Navigator.of(context).maybePop()`, smoothly reversing the container transform back into the card.

### E. Component Matrix
| Trigger Component | Destination Popup | Shared Icon | Start Title | End Title | Start Radius | Target Height |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Surah Al-Kahf Card** (`friday_companion_suite.dart`) | `SurahKahfReaderPopup` (`surah_kahf_reader_popup.dart`) | `Icons.auto_stories_rounded` | `"Surah Al-Kahf"` | `"Surah Al-Kahf"` (Arabic + Makki subtitle fade-in) | `18.0` | Full height (`maxHeight`) |
| **Jumu'ah Sunnah Rulings Card** (`prayer_list_card.dart`) | `FridayHadithGuidePopup` (`friday_hadith_guide_popup.dart`) | `Icons.menu_book_rounded` | `"Jumu'ah Sunnah Rulings"` | `"Sunnah Prayers of Jumu'ah: Hadith Guide"` | `10.0` | Centered dialog (`560.0`) |

### F. Popup Action Bar Ergonomics & Symmetrical Spacing Invariants
1. **Pinned Bottom Action Bar Pattern**:
   - The primary dismissal control (`"Close Guide"` button) in `FridayHadithGuidePopup` is pinned outside the scrollable viewport as a persistent bottom action bar.
   - Prevents action controls from being buried off-screen under long hadith card content, ensuring immediate single-tap reachability without requiring user scroll gestures.
2. **Symmetrical Vertical Spacing Invariant**:
   - The action button is wrapped in uniform `14dp` vertical padding: exactly `14dp` between the bottom edge of the scroll content and the button, and exactly `14dp` between the bottom edge of the button and the rounded bottom border of the popup dialog window.
   - Symmetrical horizontal margins of `18dp` align the button edges with the hadith cards and header squircle icon.
3. **Adaptive Bounded Height Engine**:
   - Employs `LayoutBuilder` to detect finite vs unbounded container constraints, dynamically engaging `Expanded` inside bounded dialog routes while gracefully falling back to `Flexible` in unconstrained contexts.

---

## 16. Ergonomic Digital Tasbih Workspace & Conveyor Beads Architecture
Located inside the Tasbih screen (`lib/features/tasbih/presentation/screens/tasbih_screen.dart`).

### A. Architectural Intent & Problem Remediation
Remediates visual cramping, coordinate clipping escapes, and ergonomic button imbalances in the interactive Tasbih counter workspace:
- **Zero Coordinate Escapes**: Eliminated the negative coordinate badge positioning (`Positioned(bottom: -16)`) and unconstrained `clipBehavior: Clip.none` inside `_Illustrated2DTasbihBeads`. The Sunnah tip badge is extracted into an independent, flexible layout widget cleanly positioned beneath the beads with an `8dp` buffer.
- **Categorical & Spatial Balance**: Replaced the cramped combined row (which crowded targets against long Bengali/English toggles) with a dedicated, symmetrical `_TargetSegmentedControl` (`33`, `100`, `Custom`) and an independent `_AutoNextChip` toggle below it.
- **Red Round Reset Action Ergonomics**: The reset action is designed as an autonomous, high-visibility **38dp circular icon button** (`BoxShape.circle`) with rich crimson red surface, white refresh icon (`size: 18`), tactile scale (`0.92`), and zero text. Eliminates accidental taps while offering instant visual recognition without bloating the workspace.
- **Proportionate Compact Next Dhikr Action (`INV-UI-042`)**: Completely eliminated involuntary `Expanded` full-width stretching. Sized intrinsically with comfortable padding to fit content (`height: 38dp`, `14dp` corner radius, max width `200dp`). Uses bold primary surface styling, high-contrast typography, and a compact circular forward arrow pill badge (`18x18dp`). Centered alongside the Reset button to create an unbloated, balanced action cluster.

### B. 4-Group Visual Hierarchy Matrix
1. **Dhikr Display Group**: Displays the selected Dhikr in authentic Quranic Arabic font and localized meaning translation.
2. **Counter Group (`138dp`)**:
   - 7-slot continuous horizontal bead conveyor with smooth interpolation and zero pop.
   - Sized to calibrated `138dp` height with self-contained boundaries, completely preventing edge overflow across compact phones and tablet viewports.
   - Positioned above the `_SunnahTipBadge` featuring an emerald accent background, hand icon, and responsive text wrapping.
3. **Preferences Group**:
   - `_TargetSegmentedControl`: Apple-inspired segmented control (`33` | `100` | `Custom`) with `colors.surfaceHover` background, hairline border (`0.8`), and active segment filled with `colors.primary` and white text. Responsive `FittedBox` scaling prevents overflow on narrow screens.
   - `_AutoNextChip`: Dedicated pill toggle below targets featuring an active status dot indicator and subtle tactile depress.
4. **Action Group (Calibrated Compact 38dp Row - Anti-Bloat)**:
   - **Reset Button**: 38x38dp circular red button (`#DC2626` / `#E11D48`), pure white refresh icon (`18dp`), zero text label, 6dp red glow shadow, and tactile `0.92x` depress.
   - **Next Dhikr Button**: 38dp height, intrinsic compact pill button (`maxWidth: 200dp`) with solid `colors.primary` surface, 14dp corner radius, bold high-contrast text, 18x18dp circular arrow pill badge, and luminous theme shadow. Centered in a snug cluster alongside the Reset button without consuming horizontal card voids.

### C. Multi-Viewport Responsive Layout Hardening Engine
- **Short Viewports (<680dp or <760dp for extended texts)**: Wraps content in `SingleChildScrollView` with `BouncingScrollPhysics` to guarantee effortless thumb scrolling and zero coordinate clipping on compact devices (e.g. 360x520dp).
- **Standard & Tablet Viewports (>=680dp)**: Employs `Expanded(child: cardContainer)` governed by a defensive `LayoutBuilder` & `FittedBox(fit: BoxFit.scaleDown)` calibrated to a `330.0dp` natural minimum height. Adapts gracefully under system status bars and `AppBar` headers across all tablet and foldable viewport orientations (e.g., 1024x768 landscape) with 0px RenderFlex overflow.

---

## 17. Qibla Finder Calibration & Zero Emojis Policy
Located inside the Qibla screen (`lib/features/qibla/presentation/screens/qibla_screen.dart`).

### A. Strict Zero Emojis Policy (`INV-UI-030`)
- Strictly eliminated Unicode emojis (such as `♾️`) from all UI elements, labels, buttons, and bottom sheet dialogs.
- Spiritual and technical dignity is maintained using pure Material vector icons and crisp typographic hierarchy.

### B. Compass Calibration Guide Button & Sheet
- **Action Control**: `TextButton.icon` featuring `Icons.vibration_rounded` (`16dp`) and clean localized text label `"How to Calibrate Compass"`.
- **Figure-8 Gesture Card**: Prominently displays the authentic Material vector icon `Icons.all_inclusive_rounded` (`52dp`) in `colors.primary` alongside plain-English guidance `"Wave your phone in a Figure-8 motion in the air 3 times"` without informal emojis.






