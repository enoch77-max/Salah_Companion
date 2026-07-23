# Salah Companion — Master PRD (v2)

This document supersedes the original PRD and the interim research notes. It merges: the original feature spec, the competitive-research corrections, the battery re-check flow, the iOS-inspired design system, the daily Hadith/Ayah card, and a follow-up round of changes to that card's sourcing, algorithm, and Favorites feature, plus the final color tokens from the user's tested design files.

---

## 0. Read first — rules for whoever/whatever builds this

These exist because this app touches two domains where a plausible-sounding wrong answer causes real damage: religious text, and background-execution behavior that varies by OEM. Follow them literally, not in spirit.

1. **No hadith, Quran text, translation, or grading is ever generated from model knowledge.** Not a placeholder, not a "close enough" paraphrase, not during testing. Every piece of religious content in this app comes from the sourcing pipeline in Section 6.3, is captured once into a static JSON file, and is human-reviewed before it ships. If a coding assistant is asked to "add more daily hadith entries" and doesn't have API access at that moment, the correct action is to leave the pool as-is and flag it — not to invent entries that look right.
2. **Every hadith entry must carry a grade of exactly "Sahih" and cite who graded it.** No entry without both fields ships. See 6.3.
3. **Do not assume current package APIs or versions from training data.** Flutter/Dart packages listed here (drift, adhan_dart, geolocator, etc.) should be checked against pub.dev at implementation time for their current API surface — the PRD tells you *which* package to use and *why*, not the exact method signatures, because those drift.
4. **Do not use Apple's SF Symbols or SF Pro font.** Both are license-restricted to apps running on Apple's own operating systems (see Section 5.1). This app ships on Android. Use the specified open-licensed substitutes.
5. **Numbers in this document (cooldowns, truncation lengths, pool minimums, default offsets) are the actual spec, not examples.** If you think a different number is better, that's a conversation to have with the product owner, not a silent substitution.
6. Anywhere this document says "confirm with the user" or "open decision," that means stop and ask rather than pick a default.

---

## 1. What changed from v1, and why

| Area | v1 | v2 | Why |
|---|---|---|---|
| Location framing | "VPN-proof" | "GPS-derived, network-independent" | GPS is unaffected by VPNs by construction (VPNs route network traffic, not satellite signal). The real problem being solved is device-clock/timezone mismatch, not VPN detection. Renamed so the engineering matches the actual threat model. |
| Hijri package | `hijri_gregorian_calendar` | `hijri_calendar` | Original package had a version history in the 0.0.x–0.1.x range with minimal adoption at time of research. `hijri_calendar` is more established and already supports moon-sighting adjustment offsets, which the PRD requires. |
| Qibla | `flutter_qiblah` for bearing + sensor | `adhan_dart`'s built-in qibla math for bearing, `flutter_compass` for raw heading | `adhan_dart` already computes qibla bearing from coordinates — a second package for the same math is redundant. `flutter_qiblah` showed signs of stalling maintenance (a community fork existed to keep pace with current Flutter). One fewer dependency, less risk. |
| Battery reliability | Not addressed | Full detection + recovery flow (Section 4) | The single most common failure mode in every competing app's reviews is the adhan silently not firing because Samsung/Xiaomi/Huawei kill background alarms. Not designing for this means shipping the same complaint. |
| Default calculation method | Flat dropdown, no default logic | Auto-select by detected country on first launch (Section 7) | Apps that test as most accurate auto-select method by country instead of defaulting to MWL globally and hoping the user finds the setting. |
| Widgets | Not present | Added to Phase 5 (home + lock screen) | Competitor widgets are widely reported as buggy; doing this correctly is a real differentiator for a "check it in 2 seconds" app. |
| Design language | Generic Material, no specifics | iOS/iPadOS/macOS-inspired skin over Material substrate (Section 5) | User preference, refined with concrete tokens and legal constraints around Apple's actual assets. |
| Daily content | Not present | Full feature spec (Section 6) | New request this session. |
| Color tokens | Seed values ("night blue + desaturated teal") | Final values from user-tested CSVs — warm charcoal/parchment base, amber primary, sage/terracotta status colors (Section 5.3) | User supplied actual tested-and-liked design tokens. **Note the contradiction this creates with the original brief — flagged explicitly in the chat response, not silently resolved.** |
| Hadith source scope | Musnad Ahmad only | All individually-graded-Sahih hadith across collections, weighted toward Musnad Ahmad and Sahih al-Bukhari (Section 6.2–6.3) | User broadened the requirement — narrowing to one collection was never necessary for the "Sahih only" goal. |
| Content selection | Deterministic date-hash, same for every install | Per-install weighted random pick with a no-repeat window, overridable by a manually "featured" entry pushed to all users (Section 6.5, 6.9) | User wants organic variation across users plus the ability to manually surface something important to everyone. |
| Favorites | Not present | New screen in the side menu; star action on any hadith/ayah card (Section 6.10) | New request this session. |

---

## 2. Tech stack (final)

| Concern | Package | Notes |
|---|---|---|
| Framework | Flutter 3.x (Dart) | — |
| State | `flutter_riverpod` | — |
| DB | `drift` (SQLite) + `shared_preferences` | — |
| Prayer calc | `adhan_dart` | Also provides qibla bearing math — do not duplicate this with a second package |
| Hijri calendar | `hijri_calendar` | Replaces `hijri_gregorian_calendar` from v1 |
| Qibla heading sensor | `flutter_compass` | Bearing math comes from `adhan_dart`, not this package |
| Location | `geolocator` (GPS hardware) + `geocoding` | — |
| Notifications | `flutter_local_notifications` + `timezone` + `just_audio` | — |
| Battery-exemption UI | `permission_handler` for the request flow, **native platform channel for the status check** (Section 4.1 — do not trust the plugin's status alone) | — |
| Animations | `flutter_animate` + `lottie` | — |
| Background | `workmanager` (midnight recompute only — not a substitute for exact-alarm scheduling) | — |
| Fonts | `google_fonts` (Inter, Lora, Amiri — see Section 5.2) | — |
| Icons | `lucide_icons` (verify current package name/status on pub.dev at build time) | — |
| Testing | `flutter_test`, `mocktail`, `golden_toolkit` | — |

---

## 3. Location & timezone architecture

Unchanged in substance from v1, renamed for accuracy:

- **GPS hardware priority** (`geolocator`, `highAccuracy`) — real satellite fix, not IP/network-derived.
- **Offline reverse geocoding**: bundled lat/lng → timezone + city dataset, timezone derived from coordinates, never from `DateTime.now().timeZone`.
- **Device-clock/timezone mismatch detection**: compare device timezone to GPS-derived timezone; if they differ, show a subtle non-blocking indicator ("Using GPS location — device timezone differs"). This is the feature that was previously mislabeled "VPN-proof."
- **Manual override**: Settings → manual city or coordinates.
- **Cache last known good location** to DB for instant offline startup.

---

## 4. Battery optimization detection & recovery

### 4.1 Why the naive approach fails

`permission_handler`'s `Permission.ignoreBatteryOptimizations.status` has documented reliability problems: it has returned false "denied" results on Xiaomi/Redmi devices on Android 14, and the request dialog has a known crash-on-cancel bug on some versions. **Do not treat the plugin's status check as ground truth.** Use it only to trigger the OS request dialog. For the actual status check, call Android's `PowerManager.isIgnoringBatteryOptimizations(packageName)` directly via a platform channel.

### 4.2 Native channel spec

- Channel name: `com.salahcompanion/battery`
- Method: `isIgnoringBatteryOptimizations` → returns `bool`
- Android implementation: in `MainActivity`, get `PowerManager` via `getSystemService(POWER_SERVICE)`, call `isIgnoringBatteryOptimizations(packageName)`.
- iOS: this entire feature is Android-only. There is no equivalent OS concept on iOS — do not build an iOS branch for this.

### 4.3 Detection + re-prompt flow

Runs on every app resume (`WidgetsBindingObserver.didChangeAppLifecycleState == resumed`), Android only:

```
isExempt = await BatteryChannel.isIgnoringBatteryOptimizations()
lastKnownExempt = SettingsRepo.getBool('battery_opt_last_known_exempt')  // default: null on first run
nagDisabled = SettingsRepo.getBool('battery_opt_nag_disabled') ?? false
lastPromptAt = SettingsRepo.getDateTime('battery_opt_last_prompt_at')

if isExempt != lastKnownExempt:
    SettingsRepo.setBool('battery_opt_last_known_exempt', isExempt)

if isExempt == false AND nagDisabled == false:
    cooldownExpired = lastPromptAt == null OR (now - lastPromptAt) > Duration(hours: 24)
    if cooldownExpired:
        show dismissible bottom sheet:
            title: "Prayer alerts may be delayed"
            body: "Battery optimization is on for Salah Companion. Some devices delay or block the adhan when this is enabled."
            primary action: "Fix it" → request exemption (4.4)
            secondary action: "Remind me later" → dismiss, set lastPromptAt = now
            tertiary action: "Don't ask again" → set nagDisabled = true
        SettingsRepo.setDateTime('battery_opt_last_prompt_at', now)
```

This satisfies the requirement: if the user (or the OS, or an OEM cleanup tool) re-enables battery optimization after the user had previously disabled it, the app detects the change on next resume and re-prompts — but never more than once per 24 hours, and never again if the user explicitly opts out.

Also add a manual **"Check now"** button in Settings → Notifications that runs the same check outside the cooldown, for users who fixed it themselves and want the warning to clear immediately.

### 4.4 Requesting the exemption

- Primary path: `Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS)` with the app's package URI, wrapped in try/catch.
- Fallback (some OEM ROMs block or don't implement this dialog): open `Settings.ACTION_APPLICATION_DETAILS_SETTINGS` for the app and show in-app instructions with a screenshot/illustration of where the battery setting lives.
- Detect OEM (`Build.MANUFACTURER`) and show manufacturer-specific autostart/battery guidance text for Samsung, Xiaomi, Huawei, Oppo, Vivo at minimum — these five account for the large majority of complaints in this category and are the dominant brands in the Gulf region.

### 4.5 Settings additions

- Toggle: "Warn me if battery optimization turns back on" (on by default; turning it off is equivalent to permanently dismissing).
- Button: "Check battery optimization status now."
- Read-only status line showing current state ("Exempt" / "Not exempt — alerts may be delayed").

---

## 5. Design system — iOS/iPadOS/macOS-inspired

### 5.1 Hard constraint: no Apple-owned assets

SF Symbols and the SF Pro font are licensed **solely for apps running on Apple's own operating systems** (iOS, iPadOS, macOS, tvOS, watchOS) — Apple's license text is explicit about this, and it's been confirmed repeatedly by Apple's own developer relations staff on their forums. A Flutter app that also ships to Android cannot legally bundle either. This isn't a style choice — it's the reason to build a "same spirit, different assets" system rather than trying to import Apple's actual files.

**Approach:** keep Material 3 as the widget substrate (for correct platform behavior — back gestures, accessibility services, text scaling), but reskin it fully via `ThemeData` to read as iOS/macOS-inspired. Do not switch to Flutter's `Cupertino` widget set wholesale — that produces an app that looks foreign on Android and fights Android's own navigation conventions. Reskinning Material is the more correct engineering choice for a cross-platform app that wants an Apple-adjacent feel.

### 5.2 Typography

| Role | Font | License | Notes |
|---|---|---|---|
| UI chrome (Latin) | Inter | SIL Open Font License | Closest widely available open proxy to SF Pro's neutral geometric feel |
| UI chrome (Arabic, settings/menus) | Noto Sans Arabic or IBM Plex Sans Arabic | Open | For interface text, not Quranic script |
| Quranic/hadith Arabic script | Amiri (or Amiri Quran variant if diacritic rendering needs improve) | SIL Open Font License | Classical Naskh style, designed for Quranic typesetting |
| Quote/translation text (the daily card) | Lora or Source Serif 4 | Open, via `google_fonts` | Gives the "quote" feel the user asked for, visually distinct from UI sans |

### 5.3 Color tokens (final — from user-tested design files)

These replace the earlier "night blue + teal" seed values. They're taken directly from the three token files the user tested and confirmed they like. Two things worth being explicit about rather than quietly absorbing:

- **This is not night-blue/teal.** It's a warm charcoal (dark mode) / warm parchment (light mode) base with an amber primary and sage/terracotta status colors. If the intent was still night-blue somewhere else in the product, that's now inconsistent with this token set — flag it back if so.
- **The primary color is amber** (`#D4A574` dark / `#A67C52` light), and the source file itself labels it "Amber." The original brief for this app said no golden color, anywhere. This palette uses one as the primary accent — the single most visually dominant color in the app (active prayer state, brand, stats). Both things are true at once; this document isn't going to silently pick one. Treat the "no gold" rule as superseded by this token set unless told otherwise.

**Dark mode**

| Role | Hex / value | Usage |
|---|---|---|
| Background | `#0D0F14` | App canvas |
| Elevated BG | `#12151C` | Hero gradient end |
| Surface | `#181B22` | Cards, panels |
| Surface Hover | `#1E222C` | Card hover state |
| Primary | `#D4A574` | Active prayer, stats, brand, accents |
| Primary Soft | `rgba(212, 165, 116, 0.12)` | Subtle glow backgrounds |
| Primary Glow | `rgba(212, 165, 116, 0.18)` | Drop shadows, halos |
| Primary Text | `#E8C9A0` | Arabic names, secondary emphasis |
| Success | `#7DB89A` | Prayed state, checkmarks, live dot |
| Success Soft | `rgba(125, 184, 154, 0.10)` | Prayed card background tint |
| Success Glow | `rgba(125, 184, 154, 0.15)` | Prayed icon shadow |
| Success Text | `#A3D4BC` | Prayed label/time color |
| Missed | `#C97B6B` | Missed state, compass needle |
| Missed Soft | `rgba(201, 123, 107, 0.10)` | Missed card background tint |
| Missed Text | `#E0A090` | Missed label/time color |
| Text Primary | `#F0EDE8` | Headings, names, times |
| Text Secondary | `#8B9099` | Labels, subtitles, countdown |
| Text Tertiary | `#5A5F68` | Section titles, footer |
| Divider | `rgba(255, 255, 255, 0.05)` | Card borders, hairlines |
| Divider Strong | `rgba(255, 255, 255, 0.09)` | Input borders, active edges |
| Shadow | `rgba(0, 0, 0, 0.50)` | Card elevation |

**Light mode**

| Role | Hex / value | Usage |
|---|---|---|
| Background | `#F5F2EE` | App canvas (warm parchment) |
| Elevated BG | `#EDE9E4` | Hero gradient end |
| Surface | `#FFFFFF` | Cards, panels |
| Surface Hover | `#FAF8F5` | Card hover state |
| Primary | `#A67C52` | Active prayer, stats, brand (deeper for contrast) |
| Primary Soft | `rgba(166, 124, 82, 0.10)` | Subtle glow backgrounds |
| Primary Glow | `rgba(166, 124, 82, 0.12)` | Drop shadows, halos |
| Primary Text | `#8A633F` | Arabic names, secondary emphasis |
| Success | `#4A8F6E` | Prayed state, checkmarks, live dot |
| Success Soft | `rgba(74, 143, 110, 0.08)` | Prayed card background tint |
| Success Glow | `rgba(74, 143, 110, 0.10)` | Prayed icon shadow |
| Success Text | `#3A7A5C` | Prayed label/time color |
| Missed | `#A85E4F` | Missed state, compass needle |
| Missed Soft | `rgba(168, 94, 79, 0.08)` | Missed card background tint |
| Missed Text | `#8C4A3D` | Missed label/time color |
| Text Primary | `#1A1D23` | Headings, names, times |
| Text Secondary | `#6B6F76` | Labels, subtitles, countdown |
| Text Tertiary | `#A0A5AD` | Section titles, footer |
| Divider | `rgba(0, 0, 0, 0.06)` | Card borders, hairlines |
| Divider Strong | `rgba(0, 0, 0, 0.10)` | Input borders, active edges |
| Shadow | `rgba(0, 0, 0, 0.06)` | Card elevation |

**Color logic (from the user's own notes, kept verbatim in spirit):** active prayer reads as warm amber ("this is your focus now"); prayed reads as sage, not clinical green; missed reads as terracotta — a human slip, not an alarm; background is always warm charcoal or parchment, never cold blue-gray, never pure white.

### 5.4 Component language

- **Corners:** use `ContinuousRectangleBorder` (Flutter's built-in squircle-style border) at 18–20pt radius for cards, 12pt for buttons/chips/input fields — this is what produces the "continuous curvature" look of iOS cards rather than a plain circular-arc rounded rect.
- **Shadows:** soft and diffuse, not sharp Material elevation. Use the `Shadow` token from 5.3 (`rgba(0,0,0,0.50)` dark / `rgba(0,0,0,0.06)` light) as the shadow color, large blur radius (20–24px), small vertical offset (6–8px) — e.g. `BoxShadow(color: <Shadow token>, blurRadius: 24, offset: Offset(0, 8))`.
- **Translucency:** `BackdropFilter` + `ImageFilter.blur` for the bottom navigation bar and modal sheets, echoing iOS's frosted-glass materials.
- **Navigation:** bottom tab bar, icon + label, blurred background, consistent with the frosted-glass direction above.
- **Icons:** Lucide icon set (verify current Flutter package availability at build time) — thin, consistent stroke weight, closest open-licensed cousin to SF Symbols' visual language.
- **Motion:** the countdown ring, blinking LED dot, and compass rotation from v1 stand — implement with `AnimatedBuilder`/`flutter_animate` as originally specified. Keep easing curves gentle (`Curves.easeOutCubic` family) rather than bouncy, consistent with iOS's restrained motion style.

---

## 6. Daily Hadith/Ayah reflection card

### 6.1 What this feature is

A card on the Home dashboard showing one hadith or Quran ayah, refreshed on a randomized rotation (not a fixed daily formula — see 6.5), in a decorated quote style. Selection is weighted toward the current Islamic occasion (Ramadan, Eid al-Fitr, Eid al-Adha, Ashura, etc.) when one is active, and toward preferred sources (Musnad Ahmad, Sahih al-Bukhari) otherwise. The product owner can manually feature a specific entry to override the rotation for all users at once. Users can star any shown entry to save it to a dedicated Favorites screen. Optional push notification. Fully toggleable, independent of prayer notifications.

### 6.2 The non-negotiable rule

**Only hadith individually graded "Sahih" are eligible, from any collection — not restricted to Musnad Ahmad.** This corrects a scoping error from the original request: **Musnad Ahmad ibn Hanbal is not, on its own, a sahih-only collection.** Unlike Sahih al-Bukhari and Sahih Muslim (which were compiled specifically to contain only what their authors judged authentic), Musnad Ahmad is a large general collection — roughly 30,000+ narrations by companion — containing a mix of sahih, hasan, and da'if narrations. Scholars have produced individual gradings of it (e.g., Shu'ayb Al-Arna'ut's edition), and only entries carrying a "Sahih" grade from a named grading source are eligible for this app's pool, regardless of which collection they come from.

**Eligible source collections:** any collection covered by the sourcing pipeline in 6.3 — in practice this means Sahih al-Bukhari, Sahih Muslim, Musnad Ahmad, Sunan Abi Dawud, Jami` at-Tirmidhi, Sunan an-Nasa'i, Sunan Ibn Majah, Riyad as-Salihin, and others — filtered by the same rule every time: individually graded "Sahih," named grader recorded, no exceptions. **Preference, not restriction:** Musnad Ahmad and Sahih al-Bukhari get a higher selection weight than other eligible sources (see 6.5's weighting system), because that's what the user asked for — but the pool isn't limited to those two. This also gives you a pool large enough to hit the minimum sizes in 6.4 without straining a single collection's supply of graded-Sahih entries.

### 6.3 Sourcing pipeline (build-time, human-reviewed — not a runtime dependency)

This app is offline-first. Daily content is **not** fetched live from an API at runtime. It's curated once (and re-curated whenever the pool needs expanding), reviewed by a human, and shipped as a bundled static JSON asset.

**Hadith source:** the official sunnah.com API (`sunnah.stoplight.io/docs/api`), queried across all the collections it covers — not just Musnad Ahmad. Request an API key via their GitHub repo (their process — open an issue), or request their offline data dump directly, which exists specifically for this kind of use case. Their data includes per-hadith grading fields. Do **not** use unofficial scraper-based wrappers as the source of truth for a shipped dataset — they explicitly describe themselves as liable to break and unsuitable as a stable dependency.

**Quran source:** Quran Foundation's official API (`api-docs.quran.foundation`) or the long-established AlQuran Cloud API (`alquran.cloud/api`), both offering verified text with translations. Pick one English translation and use it consistently (e.g., Saheeh International or The Clear Quran) — do not mix translators across entries, since attribution has to be per-entry-consistent, not per-app-inconsistent.

**Curation script (build once, re-run to expand pool):**
1. Pull candidate entries from the API(s) above, across all eligible collections listed in 6.2.
2. For hadith: keep only entries where `grade == "Sahih"`; record `graded_by`.
3. For both types: require every field in the schema below to be non-empty — if a field can't be verified, drop the entry rather than filling it with a guess.
4. Assign `source_weight`: `1.5` for entries from Musnad Ahmad or Sahih al-Bukhari, `1.0` for every other eligible collection. This is the mechanical half of "preferred sources" — see 6.5 for how it's used.
5. Tag entries with `occasion_tags` by hand (this is a judgment call — e.g., a hadith about fasting's reward gets tagged `["ramadan"]`) — this tagging is not automatable without human review, don't try to infer it programmatically from keyword matching alone.
6. Output to `assets/data/daily_content.json`, reviewed by a human (ideally someone with the religious literacy to sanity-check grading and tagging) before it ships.

**Extending this later:** if more selection preferences come up (e.g., "prefer shorter entries," "prefer entries about a specific theme"), add them as additional weight-modifier fields on the same entries (Section 6.5's algorithm is built as a chain of weight modifiers precisely so this doesn't require touching the core selection logic) rather than inventing a parallel filtering system.

### 6.4 Data schema

```json
{
  "id": "hadith:musnad_ahmad:12747",
  "type": "hadith",
  "arabic_text": "...",
  "translation_text": "...",
  "translation_source": "Musnad Ahmad, trans. Nasir Khattab",
  "reference": "Musnad Ahmad 12747",
  "grade": "Sahih",
  "graded_by": "Shu'ayb Al-Arna'ut",
  "source_weight": 1.5,
  "occasion_tags": ["ramadan"],
  "source_url": "https://sunnah.com/ahmad/..."
}
```

For `type: "ayah"`, `grade` and `graded_by` are omitted (not applicable); `source_weight` defaults to `1.0` (ayat aren't part of the Musnad Ahmad/Bukhari preference, which is hadith-specific); `reference` is the Surah:Ayah citation (e.g., "Al-Baqarah 2:255"); `translation_source` names the translator (e.g., "Saheeh International").

**Minimum pool sizes:** general pool ≥ 180 entries at launch (ideally 365, to avoid a visible repeat cycle within a season). Occasion pools should exceed the occasion's day count where possible (e.g., more than 30 entries tagged `ramadan`) — see 6.5 for why.

### 6.5 Selection algorithm — per-install random, weighted, overridable

This is intentionally not a single fixed formula. It's a small pipeline so new preferences can be bolted on without rewriting the core: **filter → weight → pick**, with an override check ahead of all of it.

**Why per-install, not global:** the user asked for content that "refreshes randomly," and separately asked for the ability to manually push one specific entry to *every* user when something important comes up. Those two requirements only make sense together if the default behavior varies per install — otherwise there'd be nothing distinctive about the manual push. So: normal days, each installation gets its own random pick. On a day the product owner sets a featured entry, everyone gets that instead.

**State needed per install:** a one-time-generated `installation_seed` (random UUID, created on first launch, stored locally — never sent anywhere), and a rolling log of recently shown content IDs.

```
function resolveTodayContent(installationSeed, today, pools, noRepeatDays = 45):

    // 1. Override check — runs first, short-circuits everything else
    override = FeaturedContentService.getOverrideFor(today)   // see 6.9; returns null if offline or none set
    if override != null:
        return override

    // 2. Filter — occasion pool if one is active, else general pool,
    //    excluding anything shown to this install in the last N days
    activeOccasion = HijriEventsCalendar.matchOccasion(today's Hijri date)
    basePool = (activeOccasion != null AND pools[activeOccasion] not empty)
                 ? pools[activeOccasion] : pools["general"]
    recentIds = ShownLog.idsShownInLast(noRepeatDays)
    eligible = basePool.filter(entry -> entry.id not in recentIds)
    if eligible.isEmpty:
        eligible = basePool   // pool smaller than the no-repeat window — fall back to the full pool rather than fail

    // 3. Weight — composed from independent modifier functions;
    //    add more here later without touching steps 1/2/4
    weight(entry) = entry.source_weight
                    // future modifiers multiply in here, e.g. * themeModifier(entry) * lengthModifier(entry)

    // 4. Pick — weighted random, seeded so it's stable for this install today
    rngSeed = hash(installationSeed + today.toIso8601String())
    picked = weightedRandomChoice(eligible, weight, seed: rngSeed)

    ShownLog.record(picked.id, today)
    return picked
```

**What this gives you:** the pick varies by user and by day (satisfies "refreshed randomly"), the same install sees the same card all day (needed for the star/favorite action in 6.10 to point at something stable), Musnad Ahmad/Bukhari entries show up more often than other sources without being exclusive (satisfies the preference request), and adding a new selection preference later is a one-line addition to the weight function, not a rewrite.

**Caching:** once resolved, cache the day's pick permanently in `daily_content_cache` (`date` → `content_id`), read from cache on subsequent opens the same day. This also protects against a future app update changing the pool and silently rewriting what "was shown" on a past date — history stays stable even if the underlying pool changes.

### 6.6 Card UI — vintage paper treatment

This is a deliberately different surface from the rest of the app's cards, in the "solid warm paper tone, no texture image, well-decorated through type and framing rather than pattern" style the user pointed to. Applies identically here and on the Favorites screen (6.10) for consistency.

- Placed on the Home dashboard, below the prayer list.
- **Background: flat solid fill using the `Elevated BG` token from 5.3** (`#12151C` dark / `#EDE9E4` light) — not the regular `Surface` token used by other cards, and not a gradient. This is what gives the "paper" read: the token set's own background family is already warm-charcoal/parchment, not stark black/white, so no separate color needs inventing.
- **No texture, no grain image, no pattern overlay on this specific card** — this overrides the general Islamic-geometric-pattern-overlay note from the original design system for this one surface. Decoration comes entirely from typography and framing: a thin hairline border using the `Divider Strong` token, an oversized decorative quotation glyph in `Primary Soft`, generous padding, centered layout.
- Arabic text in Amiri, right-to-left, larger size; translation below in Lora/Source Serif italic, in `Text Primary`.
- Small caption line: reference + (for hadith) grade + graded-by, in the UI sans font (Inter), `Text Secondary` color.
- **Star/favorite action:** a star icon (Lucide) in a corner of the card. Filled `Primary` color when favorited, outline `Text Secondary` when not. Tapping toggles favorite status immediately (optimistic UI, no confirmation dialog) — see 6.10 for what this writes to.
- Optional (not required for launch, cheap to add if time allows): a share action that renders the card to an image via `RepaintBoundary` for sharing outside the app.

### 6.7 Notification integration

- New, independent settings category: **"Daily Reflection"** — separate toggle group from the five per-prayer notification toggles, so users can run these fully independently.
- Master on/off toggle (default: on).
- Time picker, default suggestion: 30 minutes after Fajr (ties it to the user's own prayer rhythm rather than an arbitrary clock time) — **confirm this default with the user before implementation; it's a reasonable default, not a requirement.**
- Respects the existing DND quiet-hours setting.
- Scheduling: computed at the same midnight refresh job that recomputes prayer times (Phase 5's `workmanager` job) — resolve tomorrow's content via 6.5, cache it, schedule one `flutter_local_notifications` zoned notification for the configured time. No new background mechanism needed.
- Notification content: title = `reference` field; body = `translation_text` truncated to 120 characters, cut at the last whitespace before the limit (never mid-word), with "…" appended if truncated. Tapping opens the Home dashboard scrolled to the card.

### 6.8 Licensing — must be checked before shipping, not assumed

Whichever hadith/Quran translation source is finally chosen has its own redistribution terms, and *bundling text into a static app asset is a different use than calling a live API* — the terms for one don't automatically cover the other. Before shipping:
- Confirm sunnah.com's terms permit bundling their translation text into a distributed app (their offline-dump option exists for exactly this kind of use case, but confirm the terms of that specific offering).
- Confirm the Quran translation source's terms similarly.
- If the app carries ads (per the monetization plans in the original PRD), do not use any dataset licensed CC-BY-NC (non-commercial) without separately obtaining commercial permission — a few of the well-curated hadith datasets found during research use exactly this license, and it would conflict with an ad-supported app.
- Add an in-app "Sources & Attribution" screen crediting the collection(s), translator(s), and API/dataset providers, both because it's good practice and because it's often a condition of these terms.

### 6.9 Featured content override — pushing one entry to every user

This is the mechanism behind "when I find something important, I want to share it with everyone." It has to stay optional and fail silently offline, since the app is offline-first everywhere else — this feature does not get to be the exception that requires connectivity.

**Recommended mechanism: Firebase Remote Config.** It's built for exactly this shape of problem (push a small value from a console, client fetches it with a built-in default fallback, no custom backend to run and maintain), has a real-time update listener available for Flutter, and — important for a solo/small team — needs no server of your own. Set a single remote key, e.g. `featured_content_id` (the content `id` from the bundled dataset) plus `featured_content_date` (the date it applies to, so an old value doesn't linger and keep overriding after you meant it to stop). A plain static JSON file on any host, fetched with a short timeout, is a viable lower-effort alternative if you'd rather not add Firebase as a dependency — either way, the client contract is the same: return a content ID for today, or nothing.

**Known gotcha:** Remote Config's default fetch timeout is 60 seconds, and there's a documented Android SDK issue where a custom shorter `fetchTimeout` is sometimes ignored. Don't fetch this on the UI thread or block app startup on it. Fetch it inside the existing midnight-refresh `workmanager` job (same job that recomputes prayer times and resolves tomorrow's random pick) — if the fetch is slow or fails, the job's own logic simply proceeds to the normal random-pick path from 6.5. The user never sees a loading state for this.

**Flow:**
```
at midnight refresh:
    override = try fetch featured_content_id/date for tomorrow, else null (on any failure/timeout)
    resolvedContent = override ?? resolveTodayContent(...)   // 6.5's algorithm
    cache resolvedContent for tomorrow's date
    schedule tomorrow's notification (if enabled) using resolvedContent
```

- If the override ID doesn't match anything in the local bundled dataset (e.g. app hasn't been updated to include a newly-referenced entry yet), ignore the override and fall back to the normal algorithm — don't crash, don't show a broken card.
- The override is a manual action on the product owner's side (updating one value in a console), not an in-app admin feature — no admin UI needs building for v1.

### 6.10 Favorites

- **Entry point:** new item named **"Favorites"** in the 3-line side menu, alongside Settings.
- **Action:** the star on the daily card (6.6) and, if a Duas favorite-style interaction is wanted later, the same pattern extends to Duas — but for this feature, scope is hadith/ayah only.
- **Storage:** `favorite_daily_content` table, storing just the `content_id` and the timestamp favorited — the actual text/reference/grading is looked up from the bundled dataset at render time, not duplicated into the favorites table. This means a favorite always reflects the current canonical text; it can't drift out of sync with the source data.
- **Screen:** reverse-chronological list (most recently favorited first) of cards, rendered in the same vintage paper style as 6.6 — same background token, same border/quote-glyph decoration, same typography. Each item shows the star filled (tap to unfavorite, with the item removed from the list immediately).
- **Empty state:** simple message + illustration when nothing's been favorited yet — no dark pattern nudging, just a plain "Nothing saved yet" state.

---

## 7. Feature/screen list (condensed — full detail as in v1 unless noted)

1. **Onboarding** — as v1, plus: country auto-detected → default calculation method set accordingly (not a bare MWL default), battery-exemption step added after notification permission (Section 4.4).
2. **Home Dashboard** — as v1 (live countdown, 5 prayers + sunrise, one-tap tracking, Hijri strip, time-of-day gradient), plus the daily reflection card with its star/favorite action (Section 6).
3. **Prayer Tracker/Stats** — unchanged from v1.
4. **Qibla Compass** — unchanged in feature scope; package change per Section 2.
5. **Tasbih/Dhikr Counter** — unchanged from v1.
6. **Hijri Calendar** — unchanged from v1; this is the same event calendar reused by Section 6.5.
7. **Duas & Azkar** — unchanged from v1.
8. **Favorites** — new, in the side menu (Section 6.10). Saved hadith/ayah entries only, in the same vintage-paper card style as the Home dashboard.
9. **Home + lock screen widgets** — new, added to Phase 5. Next prayer + countdown only; keep it simple and correct rather than feature-rich, since widget bugs are a widely reported competitor weakness.
10. **Settings** — as v1, plus: default-calculation-method auto-detect, battery-optimization controls (4.5), Daily Reflection notification controls (6.7).

---

## 8. Data schema additions (drift)

All tables from v1 remain. Additions:

```
battery_opt_state       — last_known_exempt (bool), nag_disabled (bool), last_prompt_at (timestamp)
daily_content_cache     — date (TEXT, primary key), content_id (TEXT), resolved_at (timestamp)
daily_content_shown_log — content_id (TEXT), shown_date (TEXT) — backs the no-repeat window in Section 6.5
favorite_daily_content  — content_id (TEXT, primary key), favorited_at (timestamp) — Section 6.10
app_metadata             — (existing table from v1) also stores installation_seed (TEXT, generated once on first launch) used by Section 6.5's selection algorithm
```

`daily_content.json` itself is a bundled asset, not a DB table — it's static content shipped with the app, updated via app updates, not user-generated data.

---

## 9. Updated phased implementation plan (deltas from v1 only)

- **Phase 2:** add country-detection → default calculation method mapping.
- **Phase 3:** add Home dashboard daily reflection card UI with star action (Section 6.6) once the Home dashboard base is built; add the Favorites screen (Section 6.10).
- **Phase 5:** add battery-optimization detection/recovery flow (Section 4); add home + lock screen widgets; add Daily Reflection notification scheduling (Section 6.7) and the featured-content override fetch (Section 6.9), both piggybacking on the existing midnight-refresh job.
- **Phase 6:** add per-OEM manual QA pass (Samsung + Xiaomi minimum) specifically testing adhan firing after 8+ hours screen-off — untestable on emulators, and the actual real-world failure mode; add a content-review pass confirming every shipped hadith entry has `grade: "Sahih"` and a non-empty `graded_by` before the data file is finalized.

---

## 10. Acceptance criteria (testable)

- [ ] Prayer times correct for the user's real location, verified against a reference source when online.
- [ ] App fully functional offline after first launch, including the daily reflection card (no live API calls at runtime for content).
- [ ] Device-timezone-mismatch indicator appears correctly when device and GPS-derived timezone disagree.
- [ ] Default calculation method on first launch matches the detected country, not a hardcoded global default.
- [ ] Battery-optimization prompt appears within one app-resume cycle of the OS-level exemption being revoked, respects the 24-hour cooldown, and never reappears once "Don't ask again" is selected.
- [ ] Every hadith entry in the shipped dataset has `grade: "Sahih"` and non-empty `graded_by`; zero entries fail this check, regardless of which collection they came from.
- [ ] The shipped hadith pool includes entries from at least Musnad Ahmad, Sahih al-Bukhari, and one additional collection — not exclusively Musnad Ahmad.
- [ ] Daily reflection card shows the same content across multiple app opens on the same calendar day for a given install, and a randomized different entry on other days, without needing a network call for the base (non-featured) case.
- [ ] Two different installs are not guaranteed to see the same entry on a given non-featured day (confirms per-install randomness, not a shared deterministic formula).
- [ ] Setting a featured-content override is reflected for all users with connectivity that day, and installs without connectivity fall back to their normal random pick without error.
- [ ] Starring a card persists it to Favorites and is visible there after an app restart; unstarring removes it.
- [ ] Daily Reflection notifications can be toggled fully independently of the five prayer notification toggles.
- [ ] No SF Symbols or SF Pro assets present anywhere in the shipped app.
- [ ] Shipped palette matches the token values in Section 5.3 exactly, in both dark and light mode — including the amber primary (this app's "no gold" constraint was explicitly superseded by the tested palette; do not silently reintroduce a non-amber primary in its place).
- [ ] Home + lock screen widgets show correct, non-stale next-prayer data.
- [ ] Local notifications fire on time for all five prayers and pass the OEM-specific screen-off test in Phase 6.

---

## 11. Open decisions — confirm before or during implementation

- Default Daily Reflection notification time (Section 6.7 suggests 30 min after Fajr — confirm or override).
- Final choice of Quran translation (Saheeh International vs. Clear Quran vs. other) — pick one and use it consistently.
- Final choice of hadith translator/source per collection beyond Musnad Ahmad's Nasir Khattab translation, for the Bukhari/Muslim/other entries being added to round out the pool.
- Whether the share-as-image action (Section 6.6) is in scope for v1 or deferred.
- Confirm the "no gold" constraint is genuinely superseded by the tested color tokens (Section 5.3) — this document is proceeding on that assumption because the CSVs were provided as the explicit final answer, but it directly contradicts the original brief and deserves an explicit yes.
- Confirm whether "night blue + desaturated teal," mentioned earlier as the chosen direction, was superseded by the warm charcoal/parchment/amber tokens, or whether those were meant for a different part of the product.
- Pick the featured-content override mechanism (Firebase Remote Config vs. a self-hosted static JSON file — Section 6.9) — both are viable, this is a judgment call on how much infrastructure you want to own.
- Confirm the no-repeat window (45 days, Section 6.5) and minimum pool sizes (Section 6.4) still make sense now that the pool spans multiple collections rather than one.
