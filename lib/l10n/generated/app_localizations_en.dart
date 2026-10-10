// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Salah Companion';

  @override
  String get navHome => 'Home';

  @override
  String get navDuas => 'Duas';

  @override
  String get navTasbih => 'Tasbih';

  @override
  String get navQibla => 'Qibla';

  @override
  String get navCalendar => 'Calendar';

  @override
  String get prayerFajr => 'Fajr';

  @override
  String get prayerSunrise => 'Sunrise';

  @override
  String get prayerDhuhr => 'Dhuhr';

  @override
  String get prayerAsr => 'Asr';

  @override
  String get prayerMaghrib => 'Maghrib';

  @override
  String get prayerIsha => 'Isha';

  @override
  String get upcomingPrayer => 'UPCOMING PRAYER';

  @override
  String get currentSalah => 'CURRENT SALAH';

  @override
  String get remaining => 'remaining';

  @override
  String get statusPrayed => 'Prayed';

  @override
  String get statusMissed => 'Missed';

  @override
  String get statusPending => 'Pending';

  @override
  String get qiblaCompassTitle => 'Qibla Compass';

  @override
  String get qiblaCalibrate => 'Calibrate';

  @override
  String get qiblaFacingKaaba => 'Perfect alignment with Kaaba';

  @override
  String get tasbihTitle => 'Digital Tasbih';

  @override
  String get tasbihReset => 'Reset';

  @override
  String get tasbihAutoNext => 'Auto Next';

  @override
  String get tasbihBestOnFingers => 'It\'s best to count on fingers';

  @override
  String get guidanceCategory => 'GUIDANCE';

  @override
  String get learnSalah => 'Learn Salah';

  @override
  String get learnSalahSubtitle =>
      'Learn Salah with authentic Sunnah and Hadith';

  @override
  String get savedItems => 'Saved';

  @override
  String get savedItemsSubtitle => 'Hadiths, Verses & Duas';

  @override
  String get prayerTracker => 'Prayer Tracker';

  @override
  String get prayerTrackerSubtitle => 'View your prayer statistics';

  @override
  String get widgetsTitle => 'Widgets';

  @override
  String get widgetsSubtitle => 'Add widgets to home screen';

  @override
  String get openSourcePrivacy => 'Open Source & Privacy';

  @override
  String get openSourcePrivacySubtitle =>
      '100% offline, zero tracking & Non-Commercial';

  @override
  String get themeMode => 'THEME MODE';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String notificationPrayerTitle(String prayer) {
    return '$prayer Prayer';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return 'It is time for $prayer prayer. Prepare yourself for prayer.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'Early Prayer Reminder — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return '15 minutes into $prayer time. Have you prayed yet?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'Urgent — 30 Mins Left for $prayer';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return 'Only 30 minutes left for $prayer prayer. Have you prayed yet?';
  }

  @override
  String get notificationDailyReflectionTitle => 'Daily Reflection';

  @override
  String get notificationTestTitle => 'Salah Companion Alert';

  @override
  String get notificationTestBody =>
      'Notifications and Adhan audio are configured properly.';

  @override
  String get onboardingChooseLanguage => 'Choose Your Language';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'Select your preferred language for prayer times, guidance, and reflections.';

  @override
  String get onboardingWelcomeTitle => 'Welcome to Salah Companion';

  @override
  String get onboardingWelcomeBody =>
      'Your authentic, distraction-free companion for accurate prayer times, daily reflections, Qibla directional guidance, and authentic Sunnah practices.';

  @override
  String get onboardingSwipeTitle => 'Swipe Left Edge for Menu';

  @override
  String get onboardingSwipeBody =>
      'Swipe from the far-left edge of your screen to immediately reveal your Saved items, Prayer Tracker statistics, and Theme preferences anywhere in the app.';

  @override
  String get onboardingSunnahTitle => 'Authentic Sunnah & Guidance';

  @override
  String get onboardingSunnahBody =>
      'Access daily Quranic verses, Sahih Hadiths, authentic Duas, and Sunnah Raka\'at prayer guidance without clutter or unverified content.';

  @override
  String get onboardingCustomizationTitle => 'Qibla, Tasbih & Customization';

  @override
  String get onboardingCustomizationBody =>
      'Use the Qibla compass, digital Tasbih counter, and top-right Settings to customize calculation methods, notifications, and Madhab options anytime.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$current OF $total';
  }

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get systemDefault => 'System Default';

  @override
  String get moreLanguages => 'More Languages';

  @override
  String get searchLanguagePlaceholder => 'Search language...';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSubtitle => 'Change application language';

  @override
  String get onboardingTrustTitle => 'Our Sacred Trust to You';

  @override
  String get onboardingTrustSubtitle =>
      'Built purely for the sake of Allah — zero ads, zero tracking, 100% private.';

  @override
  String get onboardingTrustOfflineTitle => '100% On-Device & Private';

  @override
  String get onboardingTrustOfflineDesc =>
      'Your location and prayer records never leave your phone. All astronomical solar math is calculated locally with zero network calls.';

  @override
  String get onboardingTrustNoAdsTitle => 'No Advertisements. Ever.';

  @override
  String get onboardingTrustNoAdsDesc =>
      'Zero banners, zero commercial popups, and zero distractions between you and your Creator.';

  @override
  String get onboardingTrustNoTrackingTitle => 'Zero Analytics & Tracking';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'No Firebase tracking, no user profiling, no data collection, and no background telemetry.';

  @override
  String get onboardingTrustFreeTitle => 'Free Forever for the Ummah';

  @override
  String get onboardingTrustFreeDesc =>
      'Built as a pure Sadaqah Jariyah. No paywalls, no subscriptions, no monetization.';

  @override
  String get onboardingFeaturesTitle => 'Explore Core Features';

  @override
  String get onboardingFeaturesSubtitle =>
      'Experience precision prayer times, authentic Sunnah, and mindful worship tools.';

  @override
  String get onboardingFeaturePrayerTitle => 'Astronomical Precision';

  @override
  String get onboardingFeaturePrayerDesc =>
      'Exact solar calculation with custom angle methods and gentle Sunnah reminders.';

  @override
  String get onboardingFeatureQiblaTitle => 'Real-Time Qibla Compass';

  @override
  String get onboardingFeatureQiblaDesc =>
      'Geomagnetically stabilized directional pointer to the Holy Kaaba.';

  @override
  String get onboardingFeatureTasbihTitle => 'Tactile Digital Tasbih';

  @override
  String get onboardingFeatureTasbihDesc =>
      'Physical bead simulation with authentic Prophetic Dhikr and haptic taps.';

  @override
  String get onboardingFeatureSunnahTitle => 'Authentic Sunnah & Duas';

  @override
  String get onboardingFeatureSunnahDesc =>
      'Daily Quranic reflections and verified Sahih Hadiths with full scholarly citations.';

  @override
  String get onboardingFeatureQiblaAligned =>
      'Qibla Aligned • Makkah Al-Mukarramah';

  @override
  String get onboardingFeatureTapToCount => 'Tap anywhere or drag to count';

  @override
  String get onboardingPermissionsTitle => 'Seamless Setup';

  @override
  String get onboardingPermissionsSubtitle =>
      'Enable permissions for accurate solar calculations and timely Adhan notifications.';

  @override
  String get onboardingPermLocationTitle => 'Precise Location';

  @override
  String get onboardingPermLocationDesc =>
      'Used strictly on-device to compute solar prayer times for your coordinates.';

  @override
  String get onboardingPermNotifTitle => 'Adhan & Prayer Alerts';

  @override
  String get onboardingPermNotifDesc =>
      'Delivers gentle Adhan calls and Sunnah reminders right on time.';

  @override
  String get onboardingPermBatteryTitle => 'Reliable Background Alarms';

  @override
  String get onboardingPermBatteryDesc =>
      'Prevents Android battery optimization from canceling scheduled Fajr and midnight alarms.';

  @override
  String get onboardingPermGrant => 'Grant Access';

  @override
  String get onboardingPermGranted => 'Granted';

  @override
  String get onboardingPermEnableLater => 'Configure Later in Settings';

  @override
  String get onboardingDedicationVerse =>
      '“Indeed, prayer has been decreed upon the believers a decree of specified times.”';

  @override
  String get onboardingDedicationReference => 'Surah An-Nisa (4:103)';

  @override
  String get onboardingBeginJourney => 'Bismillah • Get Started';

  @override
  String get onboardingReplayTour => 'Replay Onboarding Tour';

  @override
  String get onboardingReplayTourSubtitle =>
      'Explore app features, privacy commitment, and setup again';

  @override
  String get onboardingBack => 'Back';

  @override
  String get navTracker => 'Tracker';

  @override
  String get prayerSunset => 'Sunset';

  @override
  String get statusNotPrayed => 'Not Prayed';

  @override
  String get statusUpcoming => 'Upcoming';

  @override
  String get statusNotYet => 'Not yet';

  @override
  String get todaysPrayers => 'TODAY\'S PRAYERS';

  @override
  String startsAt(String time) {
    return 'Starts at $time';
  }

  @override
  String periodRange(String start, String end) {
    return 'Period: $start – $end';
  }

  @override
  String get locating => 'Locating...';

  @override
  String get drawerNavigation => 'NAVIGATION';

  @override
  String get drawerOpenSourcePrivacy => 'OPEN SOURCE & PRIVACY';

  @override
  String get drawerQuickActions => 'QUICK ACTIONS';

  @override
  String get prayerAndReflection => 'Prayer & Reflection';

  @override
  String get settingsNotifications => 'NOTIFICATIONS';

  @override
  String get settingsCalculationFiqh => 'CALCULATION & FIQH';

  @override
  String get settingsBattery => 'BATTERY OPTIMIZATION';

  @override
  String get settingsAppearance => 'APPEARANCE & HAPTICS';

  @override
  String get settingsGuideOnboarding => 'GUIDE & ONBOARDING';

  @override
  String get settingsAboutPrivacy => 'ABOUT & PRIVACY';

  @override
  String get settingsAdhanAudio => 'Adhan Audio';

  @override
  String get settingsAdhanVoice => 'Adhan Voice';

  @override
  String get settingsDailyReflection => 'Daily Reflection';

  @override
  String get settingsDailyReflectionSubtitle =>
      'Morning verse & Hadith reminder';

  @override
  String get settingsCalculationMethod => 'Calculation Method';

  @override
  String get settingsJuristicMethod => 'Asr Juristic Method (Madhab)';

  @override
  String get settingsHighLatitude => 'High Latitude Rule';

  @override
  String get settingsHijriAdjustment => 'Hijri Date Adjustment';

  @override
  String get settingsBatteryHeader => 'Background Execution';

  @override
  String get settingsBatteryDesc =>
      'Exclude Salah Companion from OS battery optimization to ensure accurate Fajr and scheduled notifications.';

  @override
  String get settingsBatteryExempt => 'Exempt';

  @override
  String get settingsBatteryNotExempt =>
      'Battery Optimization: Active (Tap to Fix)';

  @override
  String get settingsCheckBattery => 'Check Battery Status';

  @override
  String get settingsTheme => 'Theme Mode';

  @override
  String get settingsHaptics => 'Haptic Feedback';

  @override
  String get settingsHapticsSubtitle =>
      'Tactile vibrations for taps and events';

  @override
  String get settingsPrivacyPolicy => 'Privacy Policy';

  @override
  String get settingsOpenSource => '100% Open Source (GitHub)';

  @override
  String get settingsTerms => 'Terms & Conditions';

  @override
  String get settingsCalculationDocs => 'Calculation Accuracy & FAQ';

  @override
  String get settingsCalculationDocsSubtitle =>
      'Learn how prayer times and solar angles are calculated';

  @override
  String get sunnahMuakkadah => 'Sunnah Mu\'akkadah';

  @override
  String get sunnahGhairMuakkadah => 'Sunnah Ghair Mu\'akkadah';

  @override
  String get sunnahWajibWitr => 'Sunnah & Wajib Witr';

  @override
  String get sunnahVoluntary => 'Voluntary Prayer';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryHadith => 'Hadiths';

  @override
  String get categoryAyah => 'Verses';

  @override
  String get categoryDua => 'Duas';

  @override
  String get categoryMorning => 'Morning';

  @override
  String get categoryEvening => 'Evening';

  @override
  String get categoryAfterPrayer => 'After Prayer';

  @override
  String get categoryForgiveness => 'Forgiveness';

  @override
  String get categoryProtection => 'Protection';

  @override
  String get categoryDaily => 'Daily';

  @override
  String get categoryTravel => 'Travel';

  @override
  String get noSavedItems => 'No saved items yet';

  @override
  String get noSavedItemsSubtitle =>
      'Tap the bookmark icon on any content to save it here.';

  @override
  String get searchPlaceholder => 'Search duas, translations, or sources...';

  @override
  String get sunnahPrayerHeader => 'SUNNAH PRAYER';

  @override
  String get sunnahFajrDesc => '2 Raka\'at Sunnah Before (Emphasized)';

  @override
  String get sunnahDhuhrDesc => '4 Raka\'at Before & 2 After';

  @override
  String get sunnahAsrDesc => '4 Raka\'at Sunnah Before';

  @override
  String get sunnahMaghribDesc => '2 Raka\'at Sunnah After';

  @override
  String get sunnahIshaDesc => '2 Raka\'at After + 3 Witr';

  @override
  String get forbiddenNaflHeader => 'FORBIDDEN TIMES FOR NAFL PRAYERS';

  @override
  String get forbiddenNaflBody =>
      'Voluntary (Nafl) prayers are prohibited during sunrise (~20m), solar zenith (~10m before Dhuhr), and sunset (~20m before Maghrib). Obligatory (Fard) make-ups remain valid. (Sahih Muslim 831)';

  @override
  String get forbiddenNaflSunriseHeader => 'FORBIDDEN NAFL TIME • SUNRISE';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'Sun is rising ($startTime – $endTime). Voluntary (Nafl) prayers are prohibited until the sun is fully risen. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflZawalHeader => 'FORBIDDEN NAFL TIME • ZENITH (ZAWAL)';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'Sun is at its zenith ($startTime – $endTime). Nafl prayers are prohibited during this midday peak. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'FORBIDDEN NAFL TIME • SUNSET';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'Sun is setting ($startTime – $endTime). Nafl prayers are prohibited until sunset is complete. (Sahih Muslim 831)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return '$prayer prayer time has not started yet ($time)';
  }

  @override
  String get timeStart => 'Start';

  @override
  String get timeEnd => 'End';

  @override
  String get onboardingShowcasePrayerTitle =>
      'Astronomical Precision Prayer Times';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'Exact prayer calculations computed 100% offline using trusted global calculation methods.';

  @override
  String get onboardingShowcaseQiblaTitle => 'Instant True-North Qibla';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'Find the exact direction of the Kaaba anywhere on Earth with smooth gyroscopic guidance.';

  @override
  String get onboardingShowcaseTasbihTitle => 'Tactile Digital Tasbih';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'Immersive dhikr counter with physical haptic vibrations and seamless auto-progression.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'Daily Spiritual Reflections & Duas';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'Carefully verified Quranic verses, authentic Sahih Hadiths, and essential daily supplications.';

  @override
  String get settingsPrayerNotifications => 'Prayer Notifications';

  @override
  String get settingsAdhanReciterTone => 'Adhan Reciter & Tone';

  @override
  String get settingsDailyReminderTime => 'Reflection Notification';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count Live Widgets';
  }

  @override
  String get settingsFiqhAsr => 'Fiqh (Asr Timing)';

  @override
  String get settingsFiqhStandardTitle => 'Shafi / Standard (Default)';

  @override
  String get settingsFiqhStandardDesc => 'Shafi, Maliki & Hanbali (1x Shadow)';

  @override
  String get settingsFiqhStandardSub =>
      'Shadow length = 1x object height. Followed by Shafi, Maliki, Hanbali & most global authorities.';

  @override
  String get settingsFiqhHanafiTitle => 'Hanafi';

  @override
  String get settingsFiqhHanafiDesc => 'Hanafi School (2x Shadow)';

  @override
  String get settingsFiqhHanafiSub =>
      'Shadow length = 2x object height. Followed by the Hanafi school of jurisprudence.';

  @override
  String get settingsPreAdhanReminder => 'Pre-Adhan Reminder';

  @override
  String get settingsBatteryRestricted => 'Restricted';

  @override
  String get settingsBatteryExemptDesc =>
      'Exempt — Adhan alerts will fire reliably';

  @override
  String get settingsBatteryNotExemptDesc =>
      'Not exempt — alerts may be delayed';

  @override
  String get settingsCheckBatteryNow => 'Check Status Now';

  @override
  String get settingsCheckBatterySubtitle =>
      'Verify background wake permissions';

  @override
  String get settingsWarnBattery => 'Warn if Re-optimized';

  @override
  String get settingsWarnBatterySubtitle =>
      'Alert if OS turns power saver back on';

  @override
  String get settingsOpenSourceFootnote =>
      '100% Free & Open Source • Zero Ads • No Data Collection';

  @override
  String get settingsAsrCalculationTitle => 'Asr Calculation Method (Fiqh)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'Select juristic school for computing Asr prayer start time.';

  @override
  String get adhanVoiceMakkah => 'Makkah (Ali Mulla)';

  @override
  String get adhanVoiceMadinah => 'Madinah (Abdul Majeed)';

  @override
  String get adhanVoiceAlAqsa => 'Al-Aqsa (Yasser Al-Dossari)';

  @override
  String get adhanVoiceSoft => 'Traditional Soft Tone';

  @override
  String get calcMethodUmmAlQura => 'Umm Al-Qura (Saudi Arabia)';

  @override
  String get calcMethodMwl => 'Muslim World League';

  @override
  String get calcMethodEgyptian => 'Egyptian General Authority';

  @override
  String get calcMethodIsna => 'ISNA (North America)';

  @override
  String get calcMethodKarachi => 'Karachi (Pakistan/India)';

  @override
  String get calcMethodDubai => 'Dubai (UAE)';

  @override
  String get calcMethodDiyanet => 'Diyanet (Turkey)';

  @override
  String get calcMethodSingapore => 'MUIS (Singapore)';

  @override
  String get learnSalahProphetQuoteTitle => 'Pray as the Prophet ﷺ Prayed';

  @override
  String get learnSalahAuthenticBadge => 'AUTHENTIC SUNNAH GUIDE';

  @override
  String get learnSalahSearchPlaceholder =>
      'Search posture, step, or Hadith proof...';

  @override
  String get learnSalahLearningModules => 'LEARNING MODULES';

  @override
  String get learnSalahStepByStepTitle => 'Step-by-Step Prophetic Guide';

  @override
  String get learnSalahStepByStepSubtitle =>
      '10 Sequential steps with 2D postures & proofs';

  @override
  String get learnSalahPillarsTitle => 'The 14 Pillars of Salah (Arkan)';

  @override
  String get learnSalahPillarsSubtitle =>
      'Must-do essential foundations of prayer';

  @override
  String get learnSalahObligationsTitle => 'The 8 Obligations (Waajibaat)';

  @override
  String get learnSalahObligationsSubtitle =>
      'Mandatory acts compensated by Sujood as-Sahw';

  @override
  String get learnSalahSunanTitle => 'Sunnah Practices (Sunan)';

  @override
  String get learnSalahSunanSubtitle =>
      'Verbal & action Sunnahs of Prophet Muhammad ﷺ';

  @override
  String get learnSalahInvalidatorsTitle => 'Invalidators of Salah (Mubtilaat)';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'Things that break or invalidate your prayer';

  @override
  String get learnSalahForbiddenTimesTitle => 'Forbidden Prayer Times';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'Times when voluntary Salah is strictly prohibited';

  @override
  String get madhabShafi => 'Shafi';

  @override
  String get madhabHanafi => 'Hanafi';

  @override
  String get eventIslamicNewYear => 'Islamic New Year';

  @override
  String get eventTasua => 'Tasu\'a';

  @override
  String get eventAshura => 'Day of Ashura';

  @override
  String get eventMawlid => 'Mawlid al-Nabi';

  @override
  String get eventIsraMiraj => 'Isra and Mi\'raj';

  @override
  String get eventMidShaban => 'Mid-Sha\'ban';

  @override
  String get eventRamadanStart => 'First Day of Ramadan';

  @override
  String get eventBattleOfBadr => 'Battle of Badr';

  @override
  String get eventLaylatAlQadr => 'Laylat al-Qadr';

  @override
  String get eventEidAlFitr => 'Eid al-Fitr';

  @override
  String get eventShawwalSixFasting => 'Six Days of Shawwal Fasting';

  @override
  String get eventDhuAlHijjahStart => 'First Day of Dhu al-Hijjah';

  @override
  String get eventDayOfArafah => 'Day of Arafah';

  @override
  String get eventEidAlAdha => 'Eid al-Adha';

  @override
  String get eventDaysOfTashreeq => 'Days of Tashreeq';

  @override
  String get qiblaHeadingTrue => 'HEADING (TRUE)';

  @override
  String get qiblaBearingLabel => 'QIBLA BEARING';

  @override
  String get qiblaRetryLocation => 'Retry Location';

  @override
  String get qiblaCalibClearInterference => 'Clear Magnetic Interference';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'Step away from metal desks, computers, or magnetic phone covers.';

  @override
  String get qiblaCalibHoldFlat => 'Hold Device Flat Horizontal';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'Keep your phone flat horizontal parallel to the ground for peak precision.';

  @override
  String get qiblaCalibFigure8 => 'Perform Figure-8 Sweep';

  @override
  String get qiblaCalibFigure8Desc =>
      'Sweep your phone smoothly along an 8-shaped loop in the air.';

  @override
  String get stepPrevious => 'Previous';

  @override
  String get stepNext => 'Next Step';

  @override
  String get stepFinishGuide => 'Finish Guide';

  @override
  String get widgetAddAnother => 'Add Another';

  @override
  String get widgetOpenSettings => 'Open Settings';

  @override
  String get widgetGoToHome => 'Go to Home Screen';

  @override
  String get trackerWeeklyRate => 'Weekly Rate';

  @override
  String get trackerMonthlyRate => 'Monthly Rate';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total Prayers';
  }

  @override
  String get tasbihHadithTitle => 'HADITH ON TASBIH';

  @override
  String get tasbihHadithText =>
      '“Glorify Allah, declare His oneness, and exalt His holiness, and count your remembrance on your fingertips—for indeed, your fingers will be questioned on the Day of Judgment and made to speak.”';

  @override
  String get tasbihHadithReference => '— Sunan Abi Dawud 1496';

  @override
  String get dhikrSubhanAllah => 'SubhanAllah';

  @override
  String get dhikrAlhamdulillah => 'Alhamdulillah';

  @override
  String get dhikrAllahuAkbar => 'Allahu Akbar';

  @override
  String get dhikrAstaghfirullah => 'Astaghfirullah';

  @override
  String get dhikrLaIlahaIllallah => 'La ilaha illallah';

  @override
  String get dhikrSalawat => 'Salawat';

  @override
  String get dhikrSubhanAllahTranslation => 'Glory be to Allah';

  @override
  String get dhikrAlhamdulillahTranslation => 'Praise be to Allah';

  @override
  String get dhikrAllahuAkbarTranslation => 'Allah is the Greatest';

  @override
  String get dhikrAstaghfirullahTranslation => 'I seek forgiveness from Allah';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'There is no deity except Allah';

  @override
  String get dhikrSalawatTranslation => 'O Allah, send blessings upon Muhammad';

  @override
  String get dhikrDuroodIbrahim => 'Durood Ibrahim';

  @override
  String get dhikrDuroodIbrahimTranslation =>
      'Allahumma salli \'ala Muhammadin wa \'ala ali Muhammad, kama sallayta \'ala Ibrahima wa \'ala ali Ibrahim, innaka Hamidun Majid. Allahumma barik \'ala Muhammadin wa \'ala ali Muhammad, kama barakta \'ala Ibrahima wa \'ala ali Ibrahim, innaka Hamidun Majid.';

  @override
  String get doSalawat => 'Do Salawat';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'Next: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'Custom';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'Custom ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'Set Custom Target';

  @override
  String get tasbihTargetHint => 'Enter target number (e.g. 50)';

  @override
  String get tasbihCancel => 'Cancel';

  @override
  String get tasbihSetTarget => 'Set Target';

  @override
  String tasbihLap(String lap) {
    return 'Lap $lap';
  }

  @override
  String get forbiddenTimesNotificationTitle => 'Forbidden Time Notifications';

  @override
  String get forbiddenTimesNotificationSubtitle =>
      'Alert for prohibited nafl time';

  @override
  String get forbiddenNaflUpcomingSunriseHeader =>
      'UPCOMING FORBIDDEN TIME • SUNRISE';

  @override
  String forbiddenNaflUpcomingSunriseBody(String time) {
    return 'Voluntary (Nafl) prayers become prohibited at $time as the sun rises. Conclude voluntary prayers before this time.';
  }

  @override
  String get forbiddenNaflUpcomingZawalHeader =>
      'UPCOMING FORBIDDEN TIME • ZENITH (ZAWAL)';

  @override
  String forbiddenNaflUpcomingZawalBody(String time) {
    return 'Voluntary (Nafl) prayers become prohibited at $time during solar zenith. Conclude voluntary prayers before this time.';
  }

  @override
  String get forbiddenNaflUpcomingSunsetHeader =>
      'UPCOMING FORBIDDEN TIME • SUNSET';

  @override
  String forbiddenNaflUpcomingSunsetBody(String time) {
    return 'Voluntary (Nafl) prayers become prohibited at $time before sunset. Conclude voluntary prayers before this time.';
  }

  @override
  String get forbiddenNaflConcludedHeader => 'FORBIDDEN TIME CONCLUDED';

  @override
  String get forbiddenNaflConcludedBody =>
      'The prohibited window has ended. Voluntary (Nafl) prayers are now permissible.';

  @override
  String get solarTimingsTitle => 'Solar Timings';

  @override
  String get daylightWindowNote =>
      'Daylight Window: Fajr ends promptly at sunrise. Maghrib begins at sunset.';

  @override
  String get prayerStarts => 'Starts';

  @override
  String get prayerStarted => 'Started';

  @override
  String get prayerEnds => 'Ends';

  @override
  String get badgeCurrent => 'CURRENT';

  @override
  String get badgeNext => 'NEXT';

  @override
  String get shuruqBadge => 'Shuruq';

  @override
  String get continueToPrayerTimes => 'Continue to Prayer Times';

  @override
  String tomorrowAt(String time) {
    return 'Tomorrow at $time';
  }

  @override
  String get fridayJumuahTitle => 'Jumu\'ah';

  @override
  String get fridayLocationLabel => 'Location';

  @override
  String get fridayAtMosque => 'At Mosque';

  @override
  String get fridayAtHome => 'At Home';

  @override
  String get fridaySunnahRulingsTitle => 'Jumu\'ah Sunnah Rulings';

  @override
  String get fridayBeforeLabel => 'Before';

  @override
  String get fridayAfterLabel => 'After';

  @override
  String get fridayMosqueBeforeDesc =>
      'Tahiyyat al-Masjid & general voluntary prayers until Khutbah begins.';

  @override
  String get fridayMosqueAfterDesc =>
      '4 Sunnah Rak\'ahs (at mosque) or 2 Sunnah Rak\'ahs (if prayed at home).';

  @override
  String get fridayHomeBeforeDesc =>
      '4 Sunnah Rak\'ahs before Dhuhr (for those praying Dhuhr at home).';

  @override
  String get fridayHomeAfterDesc =>
      '2 Sunnah Rak\'ahs after Dhuhr (for those praying Dhuhr at home).';

  @override
  String get fridayClickToReadFull =>
      'Tap to view authentic rulings and hadith references';

  @override
  String get fridaySuiteHeader => 'JUMU\'AH SUNNAH & SPECIAL DEEDS';

  @override
  String get fridayTodayOnly => 'Available on Jumu\'ah';

  @override
  String get surahKahfTitle => 'Surah Al-Kahf';

  @override
  String get surahKahfBadge => 'Light Between Two Jumu\'ahs';

  @override
  String get surahKahfHadith =>
      'Whoever recites Surah Al-Kahf on Jumu\'ah will have a light shining for him between the two Jumu\'ahs. (Al-Bayhaqi)';

  @override
  String get markAsRead => 'Mark as Read';

  @override
  String get readCompleted => 'Completed';

  @override
  String get salawatTitle => 'Abundant Salawat upon the Prophet ﷺ';

  @override
  String get salawatBadge => 'Presented Directly';

  @override
  String get salawatHadith =>
      'Increase your supplications for blessings upon me on Jumu\'ah, for your supplications are presented to me. (Abu Dawud)';

  @override
  String get salawatCountLabel => 'Recitations Today';

  @override
  String get salawatTapBtn => 'Send Salawat (+1)';

  @override
  String get fridayEtiquettesTitle => 'Sunnahs & Etiquettes of Jumu\'ah';

  @override
  String get fridayEtiquettesRef => 'Authentic Traditions of Jumu\'ah';

  @override
  String get fridayGhusl => 'Ghusl (Ritual Bath) before prayer';

  @override
  String get fridaySiwak => 'Using the Siwak (Tooth-stick) & perfume';

  @override
  String get fridayCleanClothes => 'Wearing one\'s best and cleanest garments';

  @override
  String get fridayEarlyMosque => 'Arriving early to the mosque for Khutbah';

  @override
  String get istijabahTitle => 'Hour of Response (Sa\'at al-Istijabah)';

  @override
  String get istijabahBadge => 'Supplication Accepted';

  @override
  String get istijabahHadith =>
      'On Jumu\'ah there is an hour when no Muslim servant asks Allah for something good but He grants it to him — seek it in the last hour after Asr. (Abu Dawud, An-Nasa\'i)';

  @override
  String get fridayHadithGuideSheetTitle =>
      'Sunnah Prayers of Jumu\'ah: Hadith Guide';

  @override
  String get fridayHadithBeforeCardTitle => 'Before Jumu\'ah / Dhuhr Prayer';

  @override
  String get fridayHadithBeforeCardDesc =>
      'At the mosque: When you enter, pray Tahiyyat al-Masjid (2 Rak\'ahs), then voluntary prayers until the Imam ascends the pulpit. At home (Dhuhr): Pray 4 Rak\'ahs Sunnah Mu\'akkadah before Dhuhr.';

  @override
  String get fridayHadithAfterMosqueTitle =>
      'After Jumu\'ah at the Mosque (4 Rak\'ahs)';

  @override
  String get fridayHadithAfterMosqueDesc =>
      'Abu Hurairah reported: The Messenger of Allah ﷺ said: \'When one of you prays Jumu\'ah, let him pray four Rak\'ahs after it.\' (Sahih Muslim 881)';

  @override
  String get fridayHadithAfterHomeTitle =>
      'After Jumu\'ah at Home (2 Rak\'ahs)';

  @override
  String get fridayHadithAfterHomeDesc =>
      'Ibn Umar reported: \'The Prophet ﷺ would not pray after Jumu\'ah until he departed, and then he would pray two Rak\'ahs in his house.\' (Sahih al-Bukhari 937, Sahih Muslim 882)';

  @override
  String get closeGuideBtn => 'Close Guide';
}
