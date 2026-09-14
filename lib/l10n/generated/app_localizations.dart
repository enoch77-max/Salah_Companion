import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_az.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_bs.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ky.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sq.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('az'),
    Locale('bn'),
    Locale('bs'),
    Locale('de'),
    Locale('en'),
    Locale('fa'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('kk'),
    Locale('ky'),
    Locale('ms'),
    Locale('ru'),
    Locale('sq'),
    Locale('sw'),
    Locale('tr'),
    Locale('ur'),
    Locale('uz'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Salah Companion'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navDuas.
  ///
  /// In en, this message translates to:
  /// **'Duas'**
  String get navDuas;

  /// No description provided for @navTasbih.
  ///
  /// In en, this message translates to:
  /// **'Tasbih'**
  String get navTasbih;

  /// No description provided for @navQibla.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get navQibla;

  /// No description provided for @navCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get navCalendar;

  /// No description provided for @prayerFajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get prayerFajr;

  /// No description provided for @prayerSunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get prayerSunrise;

  /// No description provided for @prayerDhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get prayerDhuhr;

  /// No description provided for @prayerAsr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get prayerAsr;

  /// No description provided for @prayerMaghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get prayerMaghrib;

  /// No description provided for @prayerIsha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get prayerIsha;

  /// No description provided for @upcomingPrayer.
  ///
  /// In en, this message translates to:
  /// **'UPCOMING PRAYER'**
  String get upcomingPrayer;

  /// No description provided for @currentSalah.
  ///
  /// In en, this message translates to:
  /// **'CURRENT SALAH'**
  String get currentSalah;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'remaining'**
  String get remaining;

  /// No description provided for @statusPrayed.
  ///
  /// In en, this message translates to:
  /// **'Prayed'**
  String get statusPrayed;

  /// No description provided for @statusMissed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get statusMissed;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @qiblaCompassTitle.
  ///
  /// In en, this message translates to:
  /// **'Qibla Compass'**
  String get qiblaCompassTitle;

  /// No description provided for @qiblaCalibrate.
  ///
  /// In en, this message translates to:
  /// **'Calibrate'**
  String get qiblaCalibrate;

  /// No description provided for @qiblaFacingKaaba.
  ///
  /// In en, this message translates to:
  /// **'Perfect alignment with Kaaba'**
  String get qiblaFacingKaaba;

  /// No description provided for @tasbihTitle.
  ///
  /// In en, this message translates to:
  /// **'Digital Tasbih'**
  String get tasbihTitle;

  /// No description provided for @tasbihReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get tasbihReset;

  /// No description provided for @tasbihAutoNext.
  ///
  /// In en, this message translates to:
  /// **'Auto Next'**
  String get tasbihAutoNext;

  /// No description provided for @tasbihBestOnFingers.
  ///
  /// In en, this message translates to:
  /// **'It\'s best to count on fingers'**
  String get tasbihBestOnFingers;

  /// No description provided for @guidanceCategory.
  ///
  /// In en, this message translates to:
  /// **'GUIDANCE'**
  String get guidanceCategory;

  /// No description provided for @learnSalah.
  ///
  /// In en, this message translates to:
  /// **'Learn Salah'**
  String get learnSalah;

  /// No description provided for @learnSalahSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn Salah with authentic Sunnah and Hadith'**
  String get learnSalahSubtitle;

  /// No description provided for @savedItems.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get savedItems;

  /// No description provided for @savedItemsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hadiths, Verses & Duas'**
  String get savedItemsSubtitle;

  /// No description provided for @prayerTracker.
  ///
  /// In en, this message translates to:
  /// **'Prayer Tracker'**
  String get prayerTracker;

  /// No description provided for @prayerTrackerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View your prayer statistics'**
  String get prayerTrackerSubtitle;

  /// No description provided for @widgetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Widgets'**
  String get widgetsTitle;

  /// No description provided for @widgetsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add widgets to home screen'**
  String get widgetsSubtitle;

  /// No description provided for @openSourcePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Open Source & Privacy'**
  String get openSourcePrivacy;

  /// No description provided for @openSourcePrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'100% offline, zero tracking & Non-Commercial'**
  String get openSourcePrivacySubtitle;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'THEME MODE'**
  String get themeMode;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// Notification title for prayer start
  ///
  /// In en, this message translates to:
  /// **'{prayer} Prayer'**
  String notificationPrayerTitle(String prayer);

  /// Notification body for prayer start
  ///
  /// In en, this message translates to:
  /// **'It is time for {prayer} prayer. Prepare yourself for prayer.'**
  String notificationPrayerStartBody(String prayer);

  /// Notification title for early 15-minute reminder
  ///
  /// In en, this message translates to:
  /// **'Early Prayer Reminder — {prayer}'**
  String notificationEarlyReminderTitle(String prayer);

  /// Notification body for early 15-minute reminder
  ///
  /// In en, this message translates to:
  /// **'15 minutes into {prayer} time. Have you prayed yet?'**
  String notificationEarlyReminderBody(String prayer);

  /// Notification title for 30 minutes left
  ///
  /// In en, this message translates to:
  /// **'Urgent — 30 Mins Left for {prayer}'**
  String notificationUrgentWarningTitle(String prayer);

  /// Notification body for 30 minutes left
  ///
  /// In en, this message translates to:
  /// **'Only 30 minutes left for {prayer} prayer. Have you prayed yet?'**
  String notificationUrgentWarningBody(String prayer);

  /// No description provided for @notificationDailyReflectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Reflection'**
  String get notificationDailyReflectionTitle;

  /// No description provided for @notificationTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Salah Companion Alert'**
  String get notificationTestTitle;

  /// No description provided for @notificationTestBody.
  ///
  /// In en, this message translates to:
  /// **'Notifications and Adhan audio are configured properly.'**
  String get notificationTestBody;

  /// No description provided for @onboardingChooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Language'**
  String get onboardingChooseLanguage;

  /// No description provided for @onboardingChooseLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language for prayer times, guidance, and reflections.'**
  String get onboardingChooseLanguageSubtitle;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Salah Companion'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Your authentic, distraction-free companion for accurate prayer times, daily reflections, Qibla directional guidance, and authentic Sunnah practices.'**
  String get onboardingWelcomeBody;

  /// No description provided for @onboardingSwipeTitle.
  ///
  /// In en, this message translates to:
  /// **'Swipe Left Edge for Menu'**
  String get onboardingSwipeTitle;

  /// No description provided for @onboardingSwipeBody.
  ///
  /// In en, this message translates to:
  /// **'Swipe from the far-left edge of your screen to immediately reveal your Saved items, Prayer Tracker statistics, and Theme preferences anywhere in the app.'**
  String get onboardingSwipeBody;

  /// No description provided for @onboardingSunnahTitle.
  ///
  /// In en, this message translates to:
  /// **'Authentic Sunnah & Guidance'**
  String get onboardingSunnahTitle;

  /// No description provided for @onboardingSunnahBody.
  ///
  /// In en, this message translates to:
  /// **'Access daily Quranic verses, Sahih Hadiths, authentic Duas, and Sunnah Raka\'at prayer guidance without clutter or unverified content.'**
  String get onboardingSunnahBody;

  /// No description provided for @onboardingCustomizationTitle.
  ///
  /// In en, this message translates to:
  /// **'Qibla, Tasbih & Customization'**
  String get onboardingCustomizationTitle;

  /// No description provided for @onboardingCustomizationBody.
  ///
  /// In en, this message translates to:
  /// **'Use the Qibla compass, digital Tasbih counter, and top-right Settings to customize calculation methods, notifications, and Madhab options anytime.'**
  String get onboardingCustomizationBody;

  /// No description provided for @onboardingStepOf.
  ///
  /// In en, this message translates to:
  /// **'{current} OF {total}'**
  String onboardingStepOf(int current, int total);

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingGetStarted;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @moreLanguages.
  ///
  /// In en, this message translates to:
  /// **'More Languages'**
  String get moreLanguages;

  /// No description provided for @searchLanguagePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search language...'**
  String get searchLanguagePlaceholder;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change application language'**
  String get settingsLanguageSubtitle;

  /// No description provided for @onboardingTrustTitle.
  ///
  /// In en, this message translates to:
  /// **'Our Sacred Trust to You'**
  String get onboardingTrustTitle;

  /// No description provided for @onboardingTrustSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Built purely for the sake of Allah — zero ads, zero tracking, 100% private.'**
  String get onboardingTrustSubtitle;

  /// No description provided for @onboardingTrustOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'100% On-Device & Private'**
  String get onboardingTrustOfflineTitle;

  /// No description provided for @onboardingTrustOfflineDesc.
  ///
  /// In en, this message translates to:
  /// **'Your location and prayer records never leave your phone. All astronomical solar math is calculated locally with zero network calls.'**
  String get onboardingTrustOfflineDesc;

  /// No description provided for @onboardingTrustNoAdsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Advertisements. Ever.'**
  String get onboardingTrustNoAdsTitle;

  /// No description provided for @onboardingTrustNoAdsDesc.
  ///
  /// In en, this message translates to:
  /// **'Zero banners, zero commercial popups, and zero distractions between you and your Creator.'**
  String get onboardingTrustNoAdsDesc;

  /// No description provided for @onboardingTrustNoTrackingTitle.
  ///
  /// In en, this message translates to:
  /// **'Zero Analytics & Tracking'**
  String get onboardingTrustNoTrackingTitle;

  /// No description provided for @onboardingTrustNoTrackingDesc.
  ///
  /// In en, this message translates to:
  /// **'No Firebase tracking, no user profiling, no data collection, and no background telemetry.'**
  String get onboardingTrustNoTrackingDesc;

  /// No description provided for @onboardingTrustFreeTitle.
  ///
  /// In en, this message translates to:
  /// **'Free Forever for the Ummah'**
  String get onboardingTrustFreeTitle;

  /// No description provided for @onboardingTrustFreeDesc.
  ///
  /// In en, this message translates to:
  /// **'Built as a pure Sadaqah Jariyah. No paywalls, no subscriptions, no monetization.'**
  String get onboardingTrustFreeDesc;

  /// No description provided for @onboardingFeaturesTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore Core Features'**
  String get onboardingFeaturesTitle;

  /// No description provided for @onboardingFeaturesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Experience precision prayer times, authentic Sunnah, and mindful worship tools.'**
  String get onboardingFeaturesSubtitle;

  /// No description provided for @onboardingFeaturePrayerTitle.
  ///
  /// In en, this message translates to:
  /// **'Astronomical Precision'**
  String get onboardingFeaturePrayerTitle;

  /// No description provided for @onboardingFeaturePrayerDesc.
  ///
  /// In en, this message translates to:
  /// **'Exact solar calculation with custom angle methods and gentle Sunnah reminders.'**
  String get onboardingFeaturePrayerDesc;

  /// No description provided for @onboardingFeatureQiblaTitle.
  ///
  /// In en, this message translates to:
  /// **'Real-Time Qibla Compass'**
  String get onboardingFeatureQiblaTitle;

  /// No description provided for @onboardingFeatureQiblaDesc.
  ///
  /// In en, this message translates to:
  /// **'Geomagnetically stabilized directional pointer to the Holy Kaaba.'**
  String get onboardingFeatureQiblaDesc;

  /// No description provided for @onboardingFeatureTasbihTitle.
  ///
  /// In en, this message translates to:
  /// **'Tactile Digital Tasbih'**
  String get onboardingFeatureTasbihTitle;

  /// No description provided for @onboardingFeatureTasbihDesc.
  ///
  /// In en, this message translates to:
  /// **'Physical bead simulation with authentic Prophetic Dhikr and haptic taps.'**
  String get onboardingFeatureTasbihDesc;

  /// No description provided for @onboardingFeatureSunnahTitle.
  ///
  /// In en, this message translates to:
  /// **'Authentic Sunnah & Duas'**
  String get onboardingFeatureSunnahTitle;

  /// No description provided for @onboardingFeatureSunnahDesc.
  ///
  /// In en, this message translates to:
  /// **'Daily Quranic reflections and verified Sahih Hadiths with full scholarly citations.'**
  String get onboardingFeatureSunnahDesc;

  /// No description provided for @onboardingFeatureQiblaAligned.
  ///
  /// In en, this message translates to:
  /// **'Qibla Aligned • Makkah Al-Mukarramah'**
  String get onboardingFeatureQiblaAligned;

  /// No description provided for @onboardingFeatureTapToCount.
  ///
  /// In en, this message translates to:
  /// **'Tap anywhere or drag to count'**
  String get onboardingFeatureTapToCount;

  /// No description provided for @onboardingPermissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Seamless Setup'**
  String get onboardingPermissionsTitle;

  /// No description provided for @onboardingPermissionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable permissions for accurate solar calculations and timely Adhan notifications.'**
  String get onboardingPermissionsSubtitle;

  /// No description provided for @onboardingPermLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Precise Location'**
  String get onboardingPermLocationTitle;

  /// No description provided for @onboardingPermLocationDesc.
  ///
  /// In en, this message translates to:
  /// **'Used strictly on-device to compute solar prayer times for your coordinates.'**
  String get onboardingPermLocationDesc;

  /// No description provided for @onboardingPermNotifTitle.
  ///
  /// In en, this message translates to:
  /// **'Adhan & Prayer Alerts'**
  String get onboardingPermNotifTitle;

  /// No description provided for @onboardingPermNotifDesc.
  ///
  /// In en, this message translates to:
  /// **'Delivers gentle Adhan calls and Sunnah reminders right on time.'**
  String get onboardingPermNotifDesc;

  /// No description provided for @onboardingPermBatteryTitle.
  ///
  /// In en, this message translates to:
  /// **'Reliable Background Alarms'**
  String get onboardingPermBatteryTitle;

  /// No description provided for @onboardingPermBatteryDesc.
  ///
  /// In en, this message translates to:
  /// **'Prevents Android battery optimization from canceling scheduled Fajr and midnight alarms.'**
  String get onboardingPermBatteryDesc;

  /// No description provided for @onboardingPermGrant.
  ///
  /// In en, this message translates to:
  /// **'Grant Access'**
  String get onboardingPermGrant;

  /// No description provided for @onboardingPermGranted.
  ///
  /// In en, this message translates to:
  /// **'Granted'**
  String get onboardingPermGranted;

  /// No description provided for @onboardingPermEnableLater.
  ///
  /// In en, this message translates to:
  /// **'Configure Later in Settings'**
  String get onboardingPermEnableLater;

  /// No description provided for @onboardingDedicationVerse.
  ///
  /// In en, this message translates to:
  /// **'“Indeed, prayer has been decreed upon the believers a decree of specified times.”'**
  String get onboardingDedicationVerse;

  /// No description provided for @onboardingDedicationReference.
  ///
  /// In en, this message translates to:
  /// **'Surah An-Nisa (4:103)'**
  String get onboardingDedicationReference;

  /// No description provided for @onboardingBeginJourney.
  ///
  /// In en, this message translates to:
  /// **'Bismillah • Get Started'**
  String get onboardingBeginJourney;

  /// No description provided for @onboardingReplayTour.
  ///
  /// In en, this message translates to:
  /// **'Replay Onboarding Tour'**
  String get onboardingReplayTour;

  /// No description provided for @onboardingReplayTourSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore app features, privacy commitment, and setup again'**
  String get onboardingReplayTourSubtitle;

  /// No description provided for @onboardingBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboardingBack;

  /// No description provided for @navTracker.
  ///
  /// In en, this message translates to:
  /// **'Tracker'**
  String get navTracker;

  /// No description provided for @prayerSunset.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get prayerSunset;

  /// No description provided for @statusNotPrayed.
  ///
  /// In en, this message translates to:
  /// **'Not Prayed'**
  String get statusNotPrayed;

  /// No description provided for @statusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get statusUpcoming;

  /// No description provided for @statusNotYet.
  ///
  /// In en, this message translates to:
  /// **'Not yet'**
  String get statusNotYet;

  /// No description provided for @todaysPrayers.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S PRAYERS'**
  String get todaysPrayers;

  /// No description provided for @startsAt.
  ///
  /// In en, this message translates to:
  /// **'Starts at {time}'**
  String startsAt(String time);

  /// No description provided for @periodRange.
  ///
  /// In en, this message translates to:
  /// **'Period: {start} – {end}'**
  String periodRange(String start, String end);

  /// No description provided for @locating.
  ///
  /// In en, this message translates to:
  /// **'Locating...'**
  String get locating;

  /// No description provided for @drawerNavigation.
  ///
  /// In en, this message translates to:
  /// **'NAVIGATION'**
  String get drawerNavigation;

  /// No description provided for @drawerOpenSourcePrivacy.
  ///
  /// In en, this message translates to:
  /// **'OPEN SOURCE & PRIVACY'**
  String get drawerOpenSourcePrivacy;

  /// No description provided for @drawerQuickActions.
  ///
  /// In en, this message translates to:
  /// **'QUICK ACTIONS'**
  String get drawerQuickActions;

  /// No description provided for @prayerAndReflection.
  ///
  /// In en, this message translates to:
  /// **'Prayer & Reflection'**
  String get prayerAndReflection;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'NOTIFICATIONS'**
  String get settingsNotifications;

  /// No description provided for @settingsCalculationFiqh.
  ///
  /// In en, this message translates to:
  /// **'CALCULATION & FIQH'**
  String get settingsCalculationFiqh;

  /// No description provided for @settingsBattery.
  ///
  /// In en, this message translates to:
  /// **'BATTERY OPTIMIZATION'**
  String get settingsBattery;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'APPEARANCE & HAPTICS'**
  String get settingsAppearance;

  /// No description provided for @settingsGuideOnboarding.
  ///
  /// In en, this message translates to:
  /// **'GUIDE & ONBOARDING'**
  String get settingsGuideOnboarding;

  /// No description provided for @settingsAboutPrivacy.
  ///
  /// In en, this message translates to:
  /// **'ABOUT & PRIVACY'**
  String get settingsAboutPrivacy;

  /// No description provided for @settingsAdhanAudio.
  ///
  /// In en, this message translates to:
  /// **'Adhan Audio'**
  String get settingsAdhanAudio;

  /// No description provided for @settingsAdhanVoice.
  ///
  /// In en, this message translates to:
  /// **'Adhan Voice'**
  String get settingsAdhanVoice;

  /// No description provided for @settingsDailyReflection.
  ///
  /// In en, this message translates to:
  /// **'Daily Reflection'**
  String get settingsDailyReflection;

  /// No description provided for @settingsDailyReflectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Morning verse & Hadith reminder'**
  String get settingsDailyReflectionSubtitle;

  /// No description provided for @settingsCalculationMethod.
  ///
  /// In en, this message translates to:
  /// **'Calculation Method'**
  String get settingsCalculationMethod;

  /// No description provided for @settingsJuristicMethod.
  ///
  /// In en, this message translates to:
  /// **'Asr Juristic Method (Madhab)'**
  String get settingsJuristicMethod;

  /// No description provided for @settingsHighLatitude.
  ///
  /// In en, this message translates to:
  /// **'High Latitude Rule'**
  String get settingsHighLatitude;

  /// No description provided for @settingsHijriAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Hijri Date Adjustment'**
  String get settingsHijriAdjustment;

  /// No description provided for @settingsBatteryHeader.
  ///
  /// In en, this message translates to:
  /// **'Background Execution'**
  String get settingsBatteryHeader;

  /// No description provided for @settingsBatteryDesc.
  ///
  /// In en, this message translates to:
  /// **'Exclude Salah Companion from OS battery optimization to ensure accurate Fajr and scheduled notifications.'**
  String get settingsBatteryDesc;

  /// No description provided for @settingsBatteryExempt.
  ///
  /// In en, this message translates to:
  /// **'Exempt'**
  String get settingsBatteryExempt;

  /// No description provided for @settingsBatteryNotExempt.
  ///
  /// In en, this message translates to:
  /// **'Battery Optimization: Active (Tap to Fix)'**
  String get settingsBatteryNotExempt;

  /// No description provided for @settingsCheckBattery.
  ///
  /// In en, this message translates to:
  /// **'Check Battery Status'**
  String get settingsCheckBattery;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get settingsTheme;

  /// No description provided for @settingsHaptics.
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get settingsHaptics;

  /// No description provided for @settingsHapticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tactile vibrations for taps and events'**
  String get settingsHapticsSubtitle;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsOpenSource.
  ///
  /// In en, this message translates to:
  /// **'100% Open Source (GitHub)'**
  String get settingsOpenSource;

  /// No description provided for @settingsTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get settingsTerms;

  /// No description provided for @settingsCalculationDocs.
  ///
  /// In en, this message translates to:
  /// **'Calculation Accuracy & FAQ'**
  String get settingsCalculationDocs;

  /// No description provided for @settingsCalculationDocsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn how prayer times and solar angles are calculated'**
  String get settingsCalculationDocsSubtitle;

  /// No description provided for @sunnahMuakkadah.
  ///
  /// In en, this message translates to:
  /// **'Sunnah Mu\'akkadah'**
  String get sunnahMuakkadah;

  /// No description provided for @sunnahGhairMuakkadah.
  ///
  /// In en, this message translates to:
  /// **'Sunnah Ghair Mu\'akkadah'**
  String get sunnahGhairMuakkadah;

  /// No description provided for @sunnahWajibWitr.
  ///
  /// In en, this message translates to:
  /// **'Sunnah & Wajib Witr'**
  String get sunnahWajibWitr;

  /// No description provided for @sunnahVoluntary.
  ///
  /// In en, this message translates to:
  /// **'Voluntary Prayer'**
  String get sunnahVoluntary;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryHadith.
  ///
  /// In en, this message translates to:
  /// **'Hadiths'**
  String get categoryHadith;

  /// No description provided for @categoryAyah.
  ///
  /// In en, this message translates to:
  /// **'Verses'**
  String get categoryAyah;

  /// No description provided for @categoryDua.
  ///
  /// In en, this message translates to:
  /// **'Duas'**
  String get categoryDua;

  /// No description provided for @categoryMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get categoryMorning;

  /// No description provided for @categoryEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get categoryEvening;

  /// No description provided for @categoryAfterPrayer.
  ///
  /// In en, this message translates to:
  /// **'After Prayer'**
  String get categoryAfterPrayer;

  /// No description provided for @categoryForgiveness.
  ///
  /// In en, this message translates to:
  /// **'Forgiveness'**
  String get categoryForgiveness;

  /// No description provided for @categoryProtection.
  ///
  /// In en, this message translates to:
  /// **'Protection'**
  String get categoryProtection;

  /// No description provided for @categoryDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get categoryDaily;

  /// No description provided for @categoryTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get categoryTravel;

  /// No description provided for @noSavedItems.
  ///
  /// In en, this message translates to:
  /// **'No saved items yet'**
  String get noSavedItems;

  /// No description provided for @noSavedItemsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the bookmark icon on any content to save it here.'**
  String get noSavedItemsSubtitle;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search duas, translations, or sources...'**
  String get searchPlaceholder;

  /// No description provided for @sunnahPrayerHeader.
  ///
  /// In en, this message translates to:
  /// **'SUNNAH PRAYER'**
  String get sunnahPrayerHeader;

  /// No description provided for @sunnahFajrDesc.
  ///
  /// In en, this message translates to:
  /// **'2 Raka\'at Sunnah Before (Emphasized)'**
  String get sunnahFajrDesc;

  /// No description provided for @sunnahDhuhrDesc.
  ///
  /// In en, this message translates to:
  /// **'4 Raka\'at Before & 2 After'**
  String get sunnahDhuhrDesc;

  /// No description provided for @sunnahAsrDesc.
  ///
  /// In en, this message translates to:
  /// **'4 Raka\'at Sunnah Before'**
  String get sunnahAsrDesc;

  /// No description provided for @sunnahMaghribDesc.
  ///
  /// In en, this message translates to:
  /// **'2 Raka\'at Sunnah After'**
  String get sunnahMaghribDesc;

  /// No description provided for @sunnahIshaDesc.
  ///
  /// In en, this message translates to:
  /// **'2 Raka\'at After + 3 Witr'**
  String get sunnahIshaDesc;

  /// No description provided for @forbiddenNaflHeader.
  ///
  /// In en, this message translates to:
  /// **'FORBIDDEN TIMES FOR NAFL PRAYERS'**
  String get forbiddenNaflHeader;

  /// No description provided for @forbiddenNaflBody.
  ///
  /// In en, this message translates to:
  /// **'Voluntary (Nafl) prayers are prohibited during sunrise (~20m), solar zenith (~10m before Dhuhr), and sunset (~20m before Maghrib). Obligatory (Fard) make-ups remain valid. (Sahih Muslim 831)'**
  String get forbiddenNaflBody;

  /// No description provided for @forbiddenNaflSunriseHeader.
  ///
  /// In en, this message translates to:
  /// **'FORBIDDEN NAFL TIME • SUNRISE'**
  String get forbiddenNaflSunriseHeader;

  /// No description provided for @forbiddenNaflSunriseBody.
  ///
  /// In en, this message translates to:
  /// **'Sun is rising ({startTime} – {endTime}). Voluntary (Nafl) prayers are prohibited until the sun is fully risen. (Sahih Muslim 831)'**
  String forbiddenNaflSunriseBody(String startTime, String endTime);

  /// No description provided for @forbiddenNaflZawalHeader.
  ///
  /// In en, this message translates to:
  /// **'FORBIDDEN NAFL TIME • ZENITH (ZAWAL)'**
  String get forbiddenNaflZawalHeader;

  /// No description provided for @forbiddenNaflZawalBody.
  ///
  /// In en, this message translates to:
  /// **'Sun is at its zenith ({startTime} – {endTime}). Nafl prayers are prohibited during this midday peak. (Sahih Muslim 831)'**
  String forbiddenNaflZawalBody(String startTime, String endTime);

  /// No description provided for @forbiddenNaflSunsetHeader.
  ///
  /// In en, this message translates to:
  /// **'FORBIDDEN NAFL TIME • SUNSET'**
  String get forbiddenNaflSunsetHeader;

  /// No description provided for @forbiddenNaflSunsetBody.
  ///
  /// In en, this message translates to:
  /// **'Sun is setting ({startTime} – {endTime}). Nafl prayers are prohibited until sunset is complete. (Sahih Muslim 831)'**
  String forbiddenNaflSunsetBody(String startTime, String endTime);

  /// No description provided for @prayerNotStartedYet.
  ///
  /// In en, this message translates to:
  /// **'{prayer} prayer time has not started yet ({time})'**
  String prayerNotStartedYet(String prayer, String time);

  /// No description provided for @timeStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get timeStart;

  /// No description provided for @timeEnd.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get timeEnd;

  /// No description provided for @onboardingShowcasePrayerTitle.
  ///
  /// In en, this message translates to:
  /// **'Astronomical Precision Prayer Times'**
  String get onboardingShowcasePrayerTitle;

  /// No description provided for @onboardingShowcasePrayerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Exact prayer calculations computed 100% offline using trusted global calculation methods.'**
  String get onboardingShowcasePrayerSubtitle;

  /// No description provided for @onboardingShowcaseQiblaTitle.
  ///
  /// In en, this message translates to:
  /// **'Instant True-North Qibla'**
  String get onboardingShowcaseQiblaTitle;

  /// No description provided for @onboardingShowcaseQiblaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find the exact direction of the Kaaba anywhere on Earth with smooth gyroscopic guidance.'**
  String get onboardingShowcaseQiblaSubtitle;

  /// No description provided for @onboardingShowcaseTasbihTitle.
  ///
  /// In en, this message translates to:
  /// **'Tactile Digital Tasbih'**
  String get onboardingShowcaseTasbihTitle;

  /// No description provided for @onboardingShowcaseTasbihSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Immersive dhikr counter with physical haptic vibrations and seamless auto-progression.'**
  String get onboardingShowcaseTasbihSubtitle;

  /// No description provided for @onboardingShowcaseReflectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Spiritual Reflections & Duas'**
  String get onboardingShowcaseReflectionTitle;

  /// No description provided for @onboardingShowcaseReflectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Carefully verified Quranic verses, authentic Sahih Hadiths, and essential daily supplications.'**
  String get onboardingShowcaseReflectionSubtitle;

  /// No description provided for @settingsPrayerNotifications.
  ///
  /// In en, this message translates to:
  /// **'Prayer Notifications'**
  String get settingsPrayerNotifications;

  /// No description provided for @settingsAdhanReciterTone.
  ///
  /// In en, this message translates to:
  /// **'Adhan Reciter & Tone'**
  String get settingsAdhanReciterTone;

  /// No description provided for @settingsDailyReminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reflection Notification'**
  String get settingsDailyReminderTime;

  /// Number of live home widgets
  ///
  /// In en, this message translates to:
  /// **'{count} Live Widgets'**
  String settingsLiveWidgetsCount(int count);

  /// No description provided for @settingsFiqhAsr.
  ///
  /// In en, this message translates to:
  /// **'Fiqh (Asr Timing)'**
  String get settingsFiqhAsr;

  /// No description provided for @settingsFiqhStandardTitle.
  ///
  /// In en, this message translates to:
  /// **'Shafi / Standard (Default)'**
  String get settingsFiqhStandardTitle;

  /// No description provided for @settingsFiqhStandardDesc.
  ///
  /// In en, this message translates to:
  /// **'Shafi, Maliki & Hanbali (1x Shadow)'**
  String get settingsFiqhStandardDesc;

  /// No description provided for @settingsFiqhStandardSub.
  ///
  /// In en, this message translates to:
  /// **'Shadow length = 1x object height. Followed by Shafi, Maliki, Hanbali & most global authorities.'**
  String get settingsFiqhStandardSub;

  /// No description provided for @settingsFiqhHanafiTitle.
  ///
  /// In en, this message translates to:
  /// **'Hanafi'**
  String get settingsFiqhHanafiTitle;

  /// No description provided for @settingsFiqhHanafiDesc.
  ///
  /// In en, this message translates to:
  /// **'Hanafi School (2x Shadow)'**
  String get settingsFiqhHanafiDesc;

  /// No description provided for @settingsFiqhHanafiSub.
  ///
  /// In en, this message translates to:
  /// **'Shadow length = 2x object height. Followed by the Hanafi school of jurisprudence.'**
  String get settingsFiqhHanafiSub;

  /// No description provided for @settingsPreAdhanReminder.
  ///
  /// In en, this message translates to:
  /// **'Pre-Adhan Reminder'**
  String get settingsPreAdhanReminder;

  /// No description provided for @settingsBatteryRestricted.
  ///
  /// In en, this message translates to:
  /// **'Restricted'**
  String get settingsBatteryRestricted;

  /// No description provided for @settingsBatteryExemptDesc.
  ///
  /// In en, this message translates to:
  /// **'Exempt — Adhan alerts will fire reliably'**
  String get settingsBatteryExemptDesc;

  /// No description provided for @settingsBatteryNotExemptDesc.
  ///
  /// In en, this message translates to:
  /// **'Not exempt — alerts may be delayed'**
  String get settingsBatteryNotExemptDesc;

  /// No description provided for @settingsCheckBatteryNow.
  ///
  /// In en, this message translates to:
  /// **'Check Status Now'**
  String get settingsCheckBatteryNow;

  /// No description provided for @settingsCheckBatterySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Verify background wake permissions'**
  String get settingsCheckBatterySubtitle;

  /// No description provided for @settingsWarnBattery.
  ///
  /// In en, this message translates to:
  /// **'Warn if Re-optimized'**
  String get settingsWarnBattery;

  /// No description provided for @settingsWarnBatterySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Alert if OS turns power saver back on'**
  String get settingsWarnBatterySubtitle;

  /// No description provided for @settingsOpenSourceFootnote.
  ///
  /// In en, this message translates to:
  /// **'100% Free & Open Source • Zero Ads • No Data Collection'**
  String get settingsOpenSourceFootnote;

  /// No description provided for @settingsAsrCalculationTitle.
  ///
  /// In en, this message translates to:
  /// **'Asr Calculation Method (Fiqh)'**
  String get settingsAsrCalculationTitle;

  /// No description provided for @settingsAsrCalculationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select juristic school for computing Asr prayer start time.'**
  String get settingsAsrCalculationSubtitle;

  /// No description provided for @adhanVoiceMakkah.
  ///
  /// In en, this message translates to:
  /// **'Makkah (Ali Mulla)'**
  String get adhanVoiceMakkah;

  /// No description provided for @adhanVoiceMadinah.
  ///
  /// In en, this message translates to:
  /// **'Madinah (Abdul Majeed)'**
  String get adhanVoiceMadinah;

  /// No description provided for @adhanVoiceAlAqsa.
  ///
  /// In en, this message translates to:
  /// **'Al-Aqsa (Yasser Al-Dossari)'**
  String get adhanVoiceAlAqsa;

  /// No description provided for @adhanVoiceSoft.
  ///
  /// In en, this message translates to:
  /// **'Traditional Soft Tone'**
  String get adhanVoiceSoft;

  /// No description provided for @calcMethodUmmAlQura.
  ///
  /// In en, this message translates to:
  /// **'Umm Al-Qura (Saudi Arabia)'**
  String get calcMethodUmmAlQura;

  /// No description provided for @calcMethodMwl.
  ///
  /// In en, this message translates to:
  /// **'Muslim World League'**
  String get calcMethodMwl;

  /// No description provided for @calcMethodEgyptian.
  ///
  /// In en, this message translates to:
  /// **'Egyptian General Authority'**
  String get calcMethodEgyptian;

  /// No description provided for @calcMethodIsna.
  ///
  /// In en, this message translates to:
  /// **'ISNA (North America)'**
  String get calcMethodIsna;

  /// No description provided for @calcMethodKarachi.
  ///
  /// In en, this message translates to:
  /// **'Karachi (Pakistan/India)'**
  String get calcMethodKarachi;

  /// No description provided for @calcMethodDubai.
  ///
  /// In en, this message translates to:
  /// **'Dubai (UAE)'**
  String get calcMethodDubai;

  /// No description provided for @calcMethodDiyanet.
  ///
  /// In en, this message translates to:
  /// **'Diyanet (Turkey)'**
  String get calcMethodDiyanet;

  /// No description provided for @calcMethodSingapore.
  ///
  /// In en, this message translates to:
  /// **'MUIS (Singapore)'**
  String get calcMethodSingapore;

  /// No description provided for @learnSalahProphetQuoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Pray as the Prophet ﷺ Prayed'**
  String get learnSalahProphetQuoteTitle;

  /// No description provided for @learnSalahAuthenticBadge.
  ///
  /// In en, this message translates to:
  /// **'AUTHENTIC SUNNAH GUIDE'**
  String get learnSalahAuthenticBadge;

  /// No description provided for @learnSalahSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search posture, step, or Hadith proof...'**
  String get learnSalahSearchPlaceholder;

  /// No description provided for @learnSalahLearningModules.
  ///
  /// In en, this message translates to:
  /// **'LEARNING MODULES'**
  String get learnSalahLearningModules;

  /// No description provided for @learnSalahStepByStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Step-by-Step Prophetic Guide'**
  String get learnSalahStepByStepTitle;

  /// No description provided for @learnSalahStepByStepSubtitle.
  ///
  /// In en, this message translates to:
  /// **'10 Sequential steps with 2D postures & proofs'**
  String get learnSalahStepByStepSubtitle;

  /// No description provided for @learnSalahPillarsTitle.
  ///
  /// In en, this message translates to:
  /// **'The 14 Pillars of Salah (Arkan)'**
  String get learnSalahPillarsTitle;

  /// No description provided for @learnSalahPillarsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Must-do essential foundations of prayer'**
  String get learnSalahPillarsSubtitle;

  /// No description provided for @learnSalahObligationsTitle.
  ///
  /// In en, this message translates to:
  /// **'The 8 Obligations (Waajibaat)'**
  String get learnSalahObligationsTitle;

  /// No description provided for @learnSalahObligationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mandatory acts compensated by Sujood as-Sahw'**
  String get learnSalahObligationsSubtitle;

  /// No description provided for @learnSalahSunanTitle.
  ///
  /// In en, this message translates to:
  /// **'Sunnah Practices (Sunan)'**
  String get learnSalahSunanTitle;

  /// No description provided for @learnSalahSunanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Verbal & action Sunnahs of Prophet Muhammad ﷺ'**
  String get learnSalahSunanSubtitle;

  /// No description provided for @learnSalahInvalidatorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalidators of Salah (Mubtilaat)'**
  String get learnSalahInvalidatorsTitle;

  /// No description provided for @learnSalahInvalidatorsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Things that break or invalidate your prayer'**
  String get learnSalahInvalidatorsSubtitle;

  /// No description provided for @learnSalahForbiddenTimesTitle.
  ///
  /// In en, this message translates to:
  /// **'Forbidden Prayer Times'**
  String get learnSalahForbiddenTimesTitle;

  /// No description provided for @learnSalahForbiddenTimesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Times when voluntary Salah is strictly prohibited'**
  String get learnSalahForbiddenTimesSubtitle;

  /// No description provided for @madhabShafi.
  ///
  /// In en, this message translates to:
  /// **'Shafi'**
  String get madhabShafi;

  /// No description provided for @madhabHanafi.
  ///
  /// In en, this message translates to:
  /// **'Hanafi'**
  String get madhabHanafi;

  /// No description provided for @eventIslamicNewYear.
  ///
  /// In en, this message translates to:
  /// **'Islamic New Year'**
  String get eventIslamicNewYear;

  /// No description provided for @eventTasua.
  ///
  /// In en, this message translates to:
  /// **'Tasu\'a'**
  String get eventTasua;

  /// No description provided for @eventAshura.
  ///
  /// In en, this message translates to:
  /// **'Day of Ashura'**
  String get eventAshura;

  /// No description provided for @eventMawlid.
  ///
  /// In en, this message translates to:
  /// **'Mawlid al-Nabi'**
  String get eventMawlid;

  /// No description provided for @eventIsraMiraj.
  ///
  /// In en, this message translates to:
  /// **'Isra and Mi\'raj'**
  String get eventIsraMiraj;

  /// No description provided for @eventMidShaban.
  ///
  /// In en, this message translates to:
  /// **'Mid-Sha\'ban'**
  String get eventMidShaban;

  /// No description provided for @eventRamadanStart.
  ///
  /// In en, this message translates to:
  /// **'First Day of Ramadan'**
  String get eventRamadanStart;

  /// No description provided for @eventBattleOfBadr.
  ///
  /// In en, this message translates to:
  /// **'Battle of Badr'**
  String get eventBattleOfBadr;

  /// No description provided for @eventLaylatAlQadr.
  ///
  /// In en, this message translates to:
  /// **'Laylat al-Qadr'**
  String get eventLaylatAlQadr;

  /// No description provided for @eventEidAlFitr.
  ///
  /// In en, this message translates to:
  /// **'Eid al-Fitr'**
  String get eventEidAlFitr;

  /// No description provided for @eventShawwalSixFasting.
  ///
  /// In en, this message translates to:
  /// **'Six Days of Shawwal Fasting'**
  String get eventShawwalSixFasting;

  /// No description provided for @eventDhuAlHijjahStart.
  ///
  /// In en, this message translates to:
  /// **'First Day of Dhu al-Hijjah'**
  String get eventDhuAlHijjahStart;

  /// No description provided for @eventDayOfArafah.
  ///
  /// In en, this message translates to:
  /// **'Day of Arafah'**
  String get eventDayOfArafah;

  /// No description provided for @eventEidAlAdha.
  ///
  /// In en, this message translates to:
  /// **'Eid al-Adha'**
  String get eventEidAlAdha;

  /// No description provided for @eventDaysOfTashreeq.
  ///
  /// In en, this message translates to:
  /// **'Days of Tashreeq'**
  String get eventDaysOfTashreeq;

  /// No description provided for @qiblaHeadingTrue.
  ///
  /// In en, this message translates to:
  /// **'HEADING (TRUE)'**
  String get qiblaHeadingTrue;

  /// No description provided for @qiblaBearingLabel.
  ///
  /// In en, this message translates to:
  /// **'QIBLA BEARING'**
  String get qiblaBearingLabel;

  /// No description provided for @qiblaRetryLocation.
  ///
  /// In en, this message translates to:
  /// **'Retry Location'**
  String get qiblaRetryLocation;

  /// No description provided for @qiblaCalibClearInterference.
  ///
  /// In en, this message translates to:
  /// **'Clear Magnetic Interference'**
  String get qiblaCalibClearInterference;

  /// No description provided for @qiblaCalibClearInterferenceDesc.
  ///
  /// In en, this message translates to:
  /// **'Step away from metal desks, computers, or magnetic phone covers.'**
  String get qiblaCalibClearInterferenceDesc;

  /// No description provided for @qiblaCalibHoldFlat.
  ///
  /// In en, this message translates to:
  /// **'Hold Device Flat Horizontal'**
  String get qiblaCalibHoldFlat;

  /// No description provided for @qiblaCalibHoldFlatDesc.
  ///
  /// In en, this message translates to:
  /// **'Keep your phone flat horizontal parallel to the ground for peak precision.'**
  String get qiblaCalibHoldFlatDesc;

  /// No description provided for @qiblaCalibFigure8.
  ///
  /// In en, this message translates to:
  /// **'Perform Figure-8 Sweep'**
  String get qiblaCalibFigure8;

  /// No description provided for @qiblaCalibFigure8Desc.
  ///
  /// In en, this message translates to:
  /// **'Sweep your phone smoothly along an 8-shaped loop in the air.'**
  String get qiblaCalibFigure8Desc;

  /// No description provided for @stepPrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get stepPrevious;

  /// No description provided for @stepNext.
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get stepNext;

  /// No description provided for @stepFinishGuide.
  ///
  /// In en, this message translates to:
  /// **'Finish Guide'**
  String get stepFinishGuide;

  /// No description provided for @widgetAddAnother.
  ///
  /// In en, this message translates to:
  /// **'Add Another'**
  String get widgetAddAnother;

  /// No description provided for @widgetOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get widgetOpenSettings;

  /// No description provided for @widgetGoToHome.
  ///
  /// In en, this message translates to:
  /// **'Go to Home Screen'**
  String get widgetGoToHome;

  /// No description provided for @trackerWeeklyRate.
  ///
  /// In en, this message translates to:
  /// **'Weekly Rate'**
  String get trackerWeeklyRate;

  /// No description provided for @trackerMonthlyRate.
  ///
  /// In en, this message translates to:
  /// **'Monthly Rate'**
  String get trackerMonthlyRate;

  /// No description provided for @trackerPrayersRatio.
  ///
  /// In en, this message translates to:
  /// **'{prayed} / {total} Prayers'**
  String trackerPrayersRatio(String prayed, String total);

  /// No description provided for @tasbihHadithTitle.
  ///
  /// In en, this message translates to:
  /// **'HADITH ON TASBIH'**
  String get tasbihHadithTitle;

  /// No description provided for @tasbihHadithText.
  ///
  /// In en, this message translates to:
  /// **'“Glorify Allah, declare His oneness, and exalt His holiness, and count your remembrance on your fingertips—for indeed, your fingers will be questioned on the Day of Judgment and made to speak.”'**
  String get tasbihHadithText;

  /// No description provided for @tasbihHadithReference.
  ///
  /// In en, this message translates to:
  /// **'— Sunan Abi Dawud 1496'**
  String get tasbihHadithReference;

  /// No description provided for @dhikrSubhanAllah.
  ///
  /// In en, this message translates to:
  /// **'SubhanAllah'**
  String get dhikrSubhanAllah;

  /// No description provided for @dhikrAlhamdulillah.
  ///
  /// In en, this message translates to:
  /// **'Alhamdulillah'**
  String get dhikrAlhamdulillah;

  /// No description provided for @dhikrAllahuAkbar.
  ///
  /// In en, this message translates to:
  /// **'Allahu Akbar'**
  String get dhikrAllahuAkbar;

  /// No description provided for @dhikrAstaghfirullah.
  ///
  /// In en, this message translates to:
  /// **'Astaghfirullah'**
  String get dhikrAstaghfirullah;

  /// No description provided for @dhikrLaIlahaIllallah.
  ///
  /// In en, this message translates to:
  /// **'La ilaha illallah'**
  String get dhikrLaIlahaIllallah;

  /// No description provided for @dhikrSubhanAllahTranslation.
  ///
  /// In en, this message translates to:
  /// **'Glory be to Allah'**
  String get dhikrSubhanAllahTranslation;

  /// No description provided for @dhikrAlhamdulillahTranslation.
  ///
  /// In en, this message translates to:
  /// **'Praise be to Allah'**
  String get dhikrAlhamdulillahTranslation;

  /// No description provided for @dhikrAllahuAkbarTranslation.
  ///
  /// In en, this message translates to:
  /// **'Allah is the Greatest'**
  String get dhikrAllahuAkbarTranslation;

  /// No description provided for @dhikrAstaghfirullahTranslation.
  ///
  /// In en, this message translates to:
  /// **'I seek forgiveness from Allah'**
  String get dhikrAstaghfirullahTranslation;

  /// No description provided for @dhikrLaIlahaIllallahTranslation.
  ///
  /// In en, this message translates to:
  /// **'There is no deity except Allah'**
  String get dhikrLaIlahaIllallahTranslation;

  /// Button label to switch to next dhikr
  ///
  /// In en, this message translates to:
  /// **'Next: {dhikr}'**
  String tasbihNextDhikr(String dhikr);

  /// No description provided for @tasbihCustomTarget.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get tasbihCustomTarget;

  /// Chip label showing active custom target count
  ///
  /// In en, this message translates to:
  /// **'Custom ({count})'**
  String tasbihCustomTargetCount(String count);

  /// No description provided for @tasbihSetCustomTarget.
  ///
  /// In en, this message translates to:
  /// **'Set Custom Target'**
  String get tasbihSetCustomTarget;

  /// No description provided for @tasbihTargetHint.
  ///
  /// In en, this message translates to:
  /// **'Enter target number (e.g. 50)'**
  String get tasbihTargetHint;

  /// No description provided for @tasbihCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get tasbihCancel;

  /// No description provided for @tasbihSetTarget.
  ///
  /// In en, this message translates to:
  /// **'Set Target'**
  String get tasbihSetTarget;

  /// Lap counter tag on tasbih bead
  ///
  /// In en, this message translates to:
  /// **'Lap {lap}'**
  String tasbihLap(String lap);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'az',
    'bn',
    'bs',
    'de',
    'en',
    'fa',
    'fr',
    'hi',
    'id',
    'kk',
    'ky',
    'ms',
    'ru',
    'sq',
    'sw',
    'tr',
    'ur',
    'uz',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'az':
      return AppLocalizationsAz();
    case 'bn':
      return AppLocalizationsBn();
    case 'bs':
      return AppLocalizationsBs();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'kk':
      return AppLocalizationsKk();
    case 'ky':
      return AppLocalizationsKy();
    case 'ms':
      return AppLocalizationsMs();
    case 'ru':
      return AppLocalizationsRu();
    case 'sq':
      return AppLocalizationsSq();
    case 'sw':
      return AppLocalizationsSw();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
