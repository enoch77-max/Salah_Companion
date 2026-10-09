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
  - Strong Dividers & Outlines: Stone contour (`#D6CBC3`)
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
  - Typography: Primary bone (`#F0EDE8`), Secondary mist (`#8B9099`), Tertiary slate (`#5A5F68`)
- **10% Accent Tokens**:
  - **Signature Warm Gold Primary**: `#D4A574` (Active floating prayer card border & glow, primary controls, active text `#E8C9A0`)
  - **Success Emerald**: `#10B981` (Prayed state, streak indicators)
  - **Missed Terracotta**: `#C97B6B` (Missed prayers)
  - **Amber Alert**: `#F59E0B` (Upcoming prayer warnings, upcoming forbidden time alerts)

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

## 11. Compact & Short Screen Ergonomic Hardening (Qibla & Tasbih)

### A. Qibla Screen Responsive Scaling
- **Dynamic Dial Sizing (`LayoutBuilder`)**:
  - `dialSize`: `math.min(constraints.maxWidth - 24, 300.0).clamp(220.0, 320.0)`.
  - `painterSize`: `(dialSize - 10.0).clamp(210.0, 310.0)`.
  - Replaces hardcoded 300px dial and 290px painter sizes. On a 320px screen width (288px padded space), `dialSize` scales proportionally to 264px without distortion or overflow, maintaining full needle and compass dial clarity.
- **Header & Metric Row Flex Adaptation**:
  - Screen title: Wrapped in `Expanded` with single-line ellipsis to prevent collision with calibration button on narrow viewports.
  - Numeric metrics tile: `_MetricDisplayTile` elements wrapped in `Expanded` with `FittedBox(fit: BoxFit.scaleDown)` typography, preventing horizontal RenderFlex overflows on screens <= 320px width.

### B. Digital Tasbih Screen Height-Adaptive Ergonomics
- Styled as a sleek rounded capsule (`BorderRadius.circular(9999)`), featuring `Icons.menu_book_rounded` (10px) and `Text` strictly locked to a single line (`maxLines: 1`, `softWrap: false`, `fontSize: 9.5`, `FontWeight.w600`).
- **Padding & Alignment**: Calibrated `EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5)` with `CrossAxisAlignment.center` and 4px icon-to-text spacing to guarantee zero text crowding or edge clipping.

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

## 13. Compact & Short Screen Ergonomic Hardening (Qibla & Tasbih)

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

## 14. Friday Jumu'ah & Companion Suite Localization & Token Contract
- **Contract Coverage**: Full 19-language parity (`en`, `ar`, `az`, `bn`, `bs`, `de`, `fa`, `fr`, `hi`, `id`, `kk`, `ky`, `ms`, `ru`, `sq`, `sw`, `tr`, `ur`, `uz`).
- **Core Key Registry (41 Keys)**:
  - **Jumu'ah Mode & Location**: `fridayJumuahTitle`, `fridayLocationLabel`, `fridayAtMosque`, `fridayAtHome`.
  - **Sunnah Rulings & Sub-strip**: `fridaySunnahRulingsTitle`, `fridayBeforeLabel`, `fridayAfterLabel`, `fridayMosqueBeforeDesc`, `fridayMosqueAfterDesc`, `fridayHomeBeforeDesc`, `fridayHomeAfterDesc`, `fridayClickToReadFull`.
  - **Special Deeds Suite**: `fridaySuiteHeader`, `fridayTodayOnly`.
  - **Surah Al-Kahf Action**: `surahKahfTitle`, `surahKahfBadge`, `surahKahfHadith`, `markAsRead`, `readCompleted`.
  - **Salawat Counter**: `salawatTitle`, `salawatBadge`, `salawatHadith`, `salawatCountLabel`, `salawatTapBtn`.
  - **Friday Etiquettes (Sunan)**: `fridayEtiquettesTitle`, `fridayEtiquettesRef`, `fridayGhusl`, `fridaySiwak`, `fridayCleanClothes`, `fridayEarlyMosque`.
  - **Hour of Response (Sa'at al-Istijabah)**: `istijabahTitle`, `istijabahBadge`, `istijabahHadith`.
  - **Hadith Evidence Modal Guide**: `fridayHadithGuideSheetTitle`, `fridayHadithBeforeCardTitle`, `fridayHadithBeforeCardDesc`, `fridayHadithAfterMosqueTitle`, `fridayHadithAfterMosqueDesc`, `fridayHadithAfterHomeTitle`, `fridayHadithAfterHomeDesc`, `closeGuideBtn`.
- **Zero Drift Invariant**: Core calculation algorithms, Saturday–Thursday rendering pipelines, and astronomical calculation matrices are strictly isolated and untouched.

---

## 15. In-Card Friday Jumu'ah & Sunnah Rulings Implementation

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
  - Pill capsules (`_buildLocationCapsule`) for "At Mosque" and "At Home" with active accent fill (180ms easeOutCubic transition).
  - Micro-icons: `Icons.mosque_rounded` and `Icons.home_rounded` at 11.5px.
- **Compact Friday Sunnah Card (`_buildCompactFridaySunnahCard`)**:
  - Replaces single-line generic strip on Friday with a dedicated 2-tier structured card:
    - **Header**: Book icon + `fridaySunnahRulingsTitle` + open-in-new external prompt icon.
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

## 16. Friday Companion Suite Specification & Invariants

### A. Architectural Placement & Conditional Lifecycle
- **Target File**: `lib/features/home/presentation/widgets/friday_companion_suite.dart`
- **Dashboard Insertion**: Mounted inside `HomeScreen` (Tab 0) directly beneath `PrayerListCard` and above `DailyReflectionCard`.
- **Conditional Visibility**:
  ```dart
  if ((widget.overrideIsFriday ?? ((widget.nowOverride ?? DateTime.now()).weekday == DateTime.friday))) ...
  ```
  Outside of Fridays, the widget tree completely skips mounting or returns `SizedBox.shrink()` (0 pixels footprint).

### B. The Four Sacred Friday Practice Cards
1. **Surah Al-Kahf (`_buildKahfCard`)**:
   - Features `110 Ayat` chapter badge and localized `surahKahfBadge` ("Light Between Two Fridays").
   - Authentic citation from Al-Bayhaqi.
   - Interactive completion button toggles between "Mark as Read" and "Completed" (`l10n.readCompleted`), backed by persistent key `'friday_kahf_completed'`.
2. **Abundant Salawat Counter (`_buildSalawatCard`)**:
   - Badged with `salawatBadge` ("Presented Directly") and Abu Dawud Hadith citation.
   - Large tactile recitation display with responsive tap button (`l10n.salawatTapBtn`, "Send Salawat (+1)").
   - Fires `AppHaptics.light()` on every tap, persisting real-time counts to `'friday_salawat_count'`.
   - Subtle contextual reset button (`Icons.refresh_rounded`) enabled when count > 0.
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
- **Clean Suite Section Header**: Rendered as a clean, single-row typographic header matching standard app category headers (`Icons.auto_awesome_rounded` + `labelSmall` with `1.2` letterSpacing), completely omitting redundant pill badges to provide full horizontal span and eliminate awkward multi-line word breaks.
- **Zero Hardcoded Strings**: 100% of titles, badges, hadith citations, and button labels consume `AppLocalizations.of(context)` across all 19 supported locales.
- **Zero Emojis**: Pure typographic and vector icon styling across all cards.
- **Zero-Truncation Invariant (`softWrap: true` & Zero Ellipsis Dots)**:
  - Strict eradication of text truncation (`TextOverflow.ellipsis` and hard `maxLines` clamps) across all Friday section headers, titles, location toggles, checklists, and Sunnah cards.
  - All textual elements utilize `softWrap: true` to wrap naturally across lines, ensuring full, complete unclipped readability in every language without any `...` dots.
- **Narrow Viewport Resilience & Fluid Layouts (<= 320px - 360px)**:
  - Location selectors utilize responsive `Wrap` (`WrapAlignment.spaceBetween`, `runSpacing: 4-5`) to guarantee 0px RenderFlex overflow across narrow viewports and expansive locales (e.g. German, Russian, French).
  - All card badges utilize `Wrap` with `runSpacing: 4`, and action controls employ `Flexible` with `FittedBox(fit: BoxFit.scaleDown)` to guarantee pristine layout integrity across all form factors.
- **Zero Core Drift**: Core astronomical calculation algorithms, timing windows, and Saturday–Thursday execution pathways remain strictly untouched.

