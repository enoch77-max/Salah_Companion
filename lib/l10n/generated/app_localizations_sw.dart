// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

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
  String get remaining => 'iliyobaki';

  @override
  String get statusPrayed => 'Prayed';

  @override
  String get statusMissed => 'Missed';

  @override
  String get statusPending => 'Pending';

  @override
  String get qiblaCompassTitle => 'Dira ya Kibla';

  @override
  String get qiblaCalibrate => 'Kurekebisha';

  @override
  String get qiblaFacingKaaba => 'Mwelekeo sahihi wa Al-Kaaba';

  @override
  String get tasbihTitle => 'Tasbihi ya Kidijitali';

  @override
  String get tasbihReset => 'Weka upya';

  @override
  String get tasbihAutoNext => 'Endelea Kiotomatiki';

  @override
  String get tasbihBestOnFingers => 'Kuhesabu tasbihi kwa vidole ni sunnah';

  @override
  String get guidanceCategory => 'MWONGOZO';

  @override
  String get learnSalah => 'Kujifunza Sala';

  @override
  String get learnSalahSubtitle =>
      'Jifunze kuswali kulingana na sunnah na hadithi sahihi';

  @override
  String get savedItems => 'Vilivyohifadhiwa';

  @override
  String get savedItemsSubtitle => 'Hadithi, Aya & Dua';

  @override
  String get prayerTracker => 'Kifuatiliaji cha Sala';

  @override
  String get prayerTrackerSubtitle => 'Tazama takwimu za sala zako';

  @override
  String get widgetsTitle => 'Wijeti';

  @override
  String get widgetsSubtitle => 'Ongeza wijeti kwenye skrini ya kwanza';

  @override
  String get openSourcePrivacy => 'Chanzo Huria & Faragha';

  @override
  String get openSourcePrivacySubtitle =>
      '100% bila mtandao, bila ufuatiliaji & isiyo ya kibiashara';

  @override
  String get themeMode => 'MTAZAMO WA MANDHARI';

  @override
  String get themeSystem => 'Mfumo';

  @override
  String get themeLight => 'Mwangaza';

  @override
  String get themeDark => 'Giza';

  @override
  String notificationPrayerTitle(String prayer) {
    return 'Sala ya $prayer';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return 'Wakati wa sala ya $prayer umeingia. Jiandae kwa ajili ya sala.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'Kikumbusho cha Mwanzo wa Wakati — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return 'Dakika 15 zimepita tangu kuingia kwa $prayer. Je, umekwisha swali?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'Muhimu — Zimebaki Dakika 30 kwa $prayer';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return 'Zimebaki dakika 30 pekee kabla ya muda wa $prayer kumalizika.';
  }

  @override
  String get notificationDailyReflectionTitle => 'Mazingatio ya Kila Siku';

  @override
  String get notificationTestTitle => 'Taarifa ya Salah Companion';

  @override
  String get notificationTestBody =>
      'Arifa na sauti ya adhana zimewekwa kwa usahihi.';

  @override
  String get onboardingChooseLanguage => 'Chagua Lugha Yako';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'Chagua lugha unayopendelea kwa ajili ya nyakati za sala na miongozo.';

  @override
  String get onboardingWelcomeTitle => 'Karibu kwenye Salah Companion';

  @override
  String get onboardingWelcomeBody =>
      'Mwenzi wako wa kuaminika kwa ajili ya nyakati sahihi za sala, mwelekeo wa kibla na sunnah.';

  @override
  String get onboardingSwipeTitle =>
      'Telezesha kidole kutoka upande wa kushoto kwa menyu';

  @override
  String get onboardingSwipeBody =>
      'Telezesha kidole kutoka ukingo wa kushoto ili kufikia vilivyohifadhiwa na takwimu.';

  @override
  String get onboardingSunnahTitle => 'Sunnah Sahihi & Mwongozo';

  @override
  String get onboardingSunnahBody =>
      'Pata aya za kila siku, hadithi sahihi, dua na namna ya kuswali kulingana na mafundisho ya Mtume ﷺ.';

  @override
  String get onboardingCustomizationTitle => 'Kibla, Tasbihi & Mipangilio';

  @override
  String get onboardingCustomizationBody =>
      'Dira ya kibla, tasbihi ya kidijitali na mbinu za ukokotoaji wa nyakati za sala.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$current KATI YA $total';
  }

  @override
  String get onboardingSkip => 'Ruka';

  @override
  String get onboardingNext => 'Inayofuata';

  @override
  String get onboardingGetStarted => 'Anza';

  @override
  String get systemDefault => 'Lugha ya Mfumo';

  @override
  String get moreLanguages => 'Lugha Zingine';

  @override
  String get searchLanguagePlaceholder => 'Tafuta lugha...';

  @override
  String get settingsTitle => 'Mipangilio';

  @override
  String get settingsLanguage => 'Lugha';

  @override
  String get settingsLanguageSubtitle => 'Badilisha lugha ya programu';

  @override
  String get onboardingTrustTitle => 'Amana Yetu Takatifu Kwako';

  @override
  String get onboardingTrustSubtitle =>
      'Imejengwa kwa ajili ya Allah pekee — bila matangazo, bila ufuatiliaji, 100% ya faragha.';

  @override
  String get onboardingTrustOfflineTitle =>
      '100% Kwenye Kifaa & Nje ya Mtandao';

  @override
  String get onboardingTrustOfflineDesc =>
      'Mahali ulipo na kumbukumbu zako za swala hazitoki kamwe kwenye simu yako.';

  @override
  String get onboardingTrustNoAdsTitle => 'Bila Matangazo Milele';

  @override
  String get onboardingTrustNoAdsDesc =>
      'Hakuna mabango ya kibiashara wala usumbufu wowote katika ibada yako.';

  @override
  String get onboardingTrustNoTrackingTitle => 'Hakuna Ufuatiliaji wa Data';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'Hakuna ufuatiliaji wa Firebase, hakuna ukusanyaji wa taarifa binafsi.';

  @override
  String get onboardingTrustFreeTitle => 'Bure Milele kwa Ummah';

  @override
  String get onboardingTrustFreeDesc =>
      'Kama sadaka yenye kuendelea (Sadaqah Jariyah). Hakuna malipo.';

  @override
  String get onboardingFeaturesTitle => 'Sifa Kuu za Programu';

  @override
  String get onboardingFeaturesSubtitle =>
      'Nyakati sahihi za swala, Sunnah thabiti na zana za ibada.';

  @override
  String get onboardingFeaturePrayerTitle => 'Usahihi wa Kiastronomia';

  @override
  String get onboardingFeaturePrayerDesc =>
      'Hesabu kamili za nyakati za jua na vikumbusho vya swala za Sunnah.';

  @override
  String get onboardingFeatureQiblaTitle => 'Dira ya Qibla ya Moja kwa Moja';

  @override
  String get onboardingFeatureQiblaDesc =>
      'Uelekeo thabiti kuelekea Al-Kaaba Tukufu pamoja na mtikisiko wa hisia unaponyoka.';

  @override
  String get onboardingFeatureTasbihTitle => 'Tasbihi ya Kidijitali';

  @override
  String get onboardingFeatureTasbihDesc =>
      'Uzoefu wa kusoma dhikri kwa mtikisiko unaohisiwa kama vidole.';

  @override
  String get onboardingFeatureSunnahTitle => 'Sunnah Sahihi na Dua';

  @override
  String get onboardingFeatureSunnahDesc =>
      'Aya za kila siku na hadithi sahihi kutoka Bukhari na Muslim zenye marejeo.';

  @override
  String get onboardingFeatureQiblaAligned =>
      'Imeelekea Qibla • Makkah Al-Mukarramah';

  @override
  String get onboardingFeatureTapToCount => 'Gusa popote au vuta ili kuhesabu';

  @override
  String get onboardingPermissionsTitle => 'Mpangilio Rahisi';

  @override
  String get onboardingPermissionsSubtitle =>
      'Ruhusu idhini kwa ajili ya hesabu sahihi za swala na taarifa za adhana.';

  @override
  String get onboardingPermLocationTitle => 'Mahali Ulipo';

  @override
  String get onboardingPermLocationDesc =>
      'Inatumika tu ndani ya simu kukokotoa nyakati za mawio na machweo.';

  @override
  String get onboardingPermNotifTitle => 'Taarifa za Adhana na Swala';

  @override
  String get onboardingPermNotifDesc =>
      'Kutoa adhana kwa wakati na kukumbusha swala za Sunnah.';

  @override
  String get onboardingPermBatteryTitle => 'Utendaji Imara Chini kwa Chini';

  @override
  String get onboardingPermBatteryDesc =>
      'Inazuia uboreshaji wa betri ya Android kusimamisha adhana ya Alfajiri.';

  @override
  String get onboardingPermGrant => 'Ruhusu';

  @override
  String get onboardingPermGranted => 'Imeruhusiwa';

  @override
  String get onboardingPermEnableLater => 'Weka Baadaye Kwenye Mipangilio';

  @override
  String get onboardingDedicationVerse =>
      '“Hakika swala kwa waumini ni faradhi iliyowekewa nyakati maalum.”';

  @override
  String get onboardingDedicationReference => 'Surah An-Nisa (4:103)';

  @override
  String get onboardingBeginJourney => 'Bismillah • Anza Sasa';

  @override
  String get onboardingReplayTour => 'Rudia Maelezo ya Awali';

  @override
  String get onboardingReplayTourSubtitle =>
      'Tazama tena sifa za programu na ahadi ya faragha';

  @override
  String get onboardingBack => 'Nyuma';

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
  String get settingsBatteryExempt => 'Imeruhusiwa';

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
  String get categoryAll => 'Zote';

  @override
  String get categoryHadith => 'Hadithi';

  @override
  String get categoryAyah => 'Aya';

  @override
  String get categoryDua => 'Dua';

  @override
  String get categoryMorning => 'Asubuhi';

  @override
  String get categoryEvening => 'Jioni';

  @override
  String get categoryAfterPrayer => 'Baada ya Sala';

  @override
  String get categoryForgiveness => 'Msamaha';

  @override
  String get categoryProtection => 'Ulinzi';

  @override
  String get categoryDaily => 'Kila siku';

  @override
  String get categoryTravel => 'Safari';

  @override
  String get noSavedItems => 'Hakuna vitu vilivyohifadhiwa bado';

  @override
  String get noSavedItemsSubtitle =>
      'Gusa ikoni ya alamisho ili kuhifadhi hapa.';

  @override
  String get searchPlaceholder => 'Tafuta dua, tafsiri, au vyanzo...';

  @override
  String get sunnahPrayerHeader => 'SALA YA SUNNAH';

  @override
  String get sunnahFajrDesc => 'Rakaa 2 za Sunnah kabla ya Faradhi';

  @override
  String get sunnahDhuhrDesc => 'Rakaa 4 kabla & 2 baada ya Faradhi';

  @override
  String get sunnahAsrDesc => 'Rakaa 4 za Sunnah kabla ya Faradhi';

  @override
  String get sunnahMaghribDesc => 'Rakaa 2 za Sunnah baada ya Faradhi';

  @override
  String get sunnahIshaDesc => 'Rakaa 2 baada ya Faradhi + 3 za Witri';

  @override
  String get forbiddenNaflHeader => 'NYAKATI ZILIZOKATAZWA KUSWALI NAFL';

  @override
  String get forbiddenNaflBody =>
      'Swala za sunnah (Nafl) zimekatazwa wakati wa macheo ya jua (~dakika 20), jua likiwa utosini (~dakika 10 kabla ya Adhuhuri), na machweo (~dakika 20 kabla ya Maghribi). Kulipa swala za fardhi inajuzu. (Sahih Muslim 831)';

  @override
  String get forbiddenNaflSunriseHeader => 'WAKATI ULIOKATAZWA • MACHEO YA JUA';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'Jua linachomoza ($startTime – $endTime). Swala za sunnah zimekatazwa mpaka jua lichomoze kabisa. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflZawalHeader =>
      'WAKATI ULIOKATAZWA • ZAWAL (JUA UTOSINI)';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'Jua liko utosini ($startTime – $endTime). Swala za sunnah zimekatazwa wakati huu wa mchana. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'WAKATI ULIOKATAZWA • MACHWEO YA JUA';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'Jua linazama ($startTime – $endTime). Swala za sunnah zimekatazwa mpaka jua litue kabisa. (Sahih Muslim 831)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return 'Wakati wa sala ya $prayer bado haujaanza ($time)';
  }

  @override
  String get timeStart => 'Mwanzo';

  @override
  String get timeEnd => 'Mwisho';

  @override
  String get onboardingShowcasePrayerTitle => 'Nyakati Sahihi za Swala';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'Hesabu kamili za nyakati za swala 100% bila mtandao kulingana na mbinu rasmi za hisabati.';

  @override
  String get onboardingShowcaseQiblaTitle => 'Dira ya Kibla ya Uhakika';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'Pata mwelekeo sahihi wa Al-Kaaba popote ulipo duniani kupitia dira.';

  @override
  String get onboardingShowcaseTasbihTitle => 'Tasbihi ya Kidijitali';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'Kikaango cha dhikr chenye mtetemo murua na ubadilishaji wa kiotomatiki.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'Mazingatio ya Kila Siku, Hadithi & Dua';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'Aya za Qur\'ani, hadithi sahihi zilizothibitishwa, na dua muhimu za kila siku.';

  @override
  String get settingsPrayerNotifications => 'Taarifa za Swala';

  @override
  String get settingsAdhanReciterTone => 'Mwadhini na Sauti ya Adhana';

  @override
  String get settingsDailyReminderTime => 'Taarifa ya Ukumbusho wa Kila Siku';

  @override
  String settingsLiveWidgetsCount(int count) {
    return 'Widget $count Zinazofanya Kazi';
  }

  @override
  String get settingsFiqhAsr => 'Fiqh (Wakati wa Alasiri)';

  @override
  String get settingsFiqhStandardTitle => 'Shafi\'i / Kawaida (Chaguo-msingi)';

  @override
  String get settingsFiqhStandardDesc =>
      'Shafi\'i, Maliki & Hanbali (1x Kivuli)';

  @override
  String get settingsFiqhStandardSub =>
      'Urefu wa kivuli = 1x urefu wa kitu. Inafuatwa na Shafi\'i, Maliki, Hanbali na wengi.';

  @override
  String get settingsFiqhHanafiTitle => 'Hanafi';

  @override
  String get settingsFiqhHanafiDesc => 'Madhehebu ya Hanafi (2x Kivuli)';

  @override
  String get settingsFiqhHanafiSub =>
      'Urefu wa kivuli = 2x urefu wa kitu. Kulingana na madhehebu ya Hanafi.';

  @override
  String get settingsPreAdhanReminder => 'Ukumbusho Kabla ya Adhana';

  @override
  String get settingsBatteryRestricted => 'Imebanwa';

  @override
  String get settingsBatteryExemptDesc =>
      'Imeruhusiwa — Kengele za adhana zitalia kwa wakati';

  @override
  String get settingsBatteryNotExemptDesc =>
      'Haiko huru — Taarifa zinaweza kuchelewa nyuma';

  @override
  String get settingsCheckBatteryNow => 'Kagua Hali Sasa';

  @override
  String get settingsCheckBatterySubtitle =>
      'Thibitisha ruhusa za kufanya kazi chinichini';

  @override
  String get settingsWarnBattery => 'Onya Ikibanwa Tena';

  @override
  String get settingsWarnBatterySubtitle =>
      'Tahadharisha mfumo ukiwasha ubanaji betri tena';

  @override
  String get settingsOpenSourceFootnote =>
      '100% Bure na Chanzo Huria • Bila Matangazo • Hakuna Ukusanyaji Data';

  @override
  String get settingsAsrCalculationTitle => 'Njia ya Hesabu ya Alasiri (Fiqh)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'Chagua madhehebu ya kifiqhi kwa hesabu ya wakati wa Alasiri.';

  @override
  String get adhanVoiceMakkah => 'Makkah (Ali Mulla)';

  @override
  String get adhanVoiceMadinah => 'Madina (Abdul Majeed)';

  @override
  String get adhanVoiceAlAqsa => 'Al-Aqsa (Yasser Al-Dossari)';

  @override
  String get adhanVoiceSoft => 'Sauti Laini ya Jadi';

  @override
  String get calcMethodUmmAlQura => 'Umm Al-Qura (Saudi Arabia)';

  @override
  String get calcMethodMwl => 'Jumuiya ya Ulimwengu wa Kiislamu (MWL)';

  @override
  String get calcMethodEgyptian => 'Mamlaka Kuu ya Misri';

  @override
  String get calcMethodIsna => 'ISNA (Amerika ya Kaskazini)';

  @override
  String get calcMethodKarachi => 'Chuo Kikuu cha Sayansi za Kiislamu Karachi';

  @override
  String get calcMethodDubai => 'Mambo ya Kiislamu Dubai';

  @override
  String get calcMethodDiyanet => 'Diyanet (Uturuki)';

  @override
  String get calcMethodSingapore => 'MUIS (Singapore)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'Swalini kama mlivyoniona nikiswali';

  @override
  String get learnSalahAuthenticBadge => 'MWONGOZO WA SUNNAH SAHIHI';

  @override
  String get learnSalahSearchPlaceholder =>
      'Tafuta mkao, hatua au ushahidi wa Hadithi...';

  @override
  String get learnSalahLearningModules => 'MODULI ZA MAFUNZO';

  @override
  String get learnSalahStepByStepTitle => 'Mwongozo wa Swala Hatua kwa Hatua';

  @override
  String get learnSalahStepByStepSubtitle =>
      'Hatua 10 mfululizo zenye picha na ushahidi';

  @override
  String get learnSalahPillarsTitle => 'Nguzo 14 za Swala (Arkan)';

  @override
  String get learnSalahPillarsSubtitle =>
      'Misingi mikuu ya lazima katika swala';

  @override
  String get learnSalahObligationsTitle => 'Wajibu 8 za Swala (Wajibaat)';

  @override
  String get learnSalahObligationsSubtitle =>
      'Matendo ya wajibu yanayofidiwa kwa Sujudu Sahwi';

  @override
  String get learnSalahSunanTitle => 'Sunnah za Swala (Sunan)';

  @override
  String get learnSalahSunanSubtitle =>
      'Sunnah za maneno na vitendo vya Mtume ﷺ';

  @override
  String get learnSalahInvalidatorsTitle => 'Mambo Yanayobatilisha Swala';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'Mambo yanayovunja swala na kuifanya batili';

  @override
  String get learnSalahForbiddenTimesTitle => 'Nyakati Zilizokatazwa Kuswali';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'Nyakati ambazo swala za sunnah zimekatazwa';

  @override
  String get madhabShafi => 'Shafi\'i';

  @override
  String get madhabHanafi => 'Hanafi';

  @override
  String get eventIslamicNewYear => 'Mwaka Mpya wa Kiislamu';

  @override
  String get eventTasua => 'Siku ya Tasu\'a';

  @override
  String get eventAshura => 'Siku ya Ashura';

  @override
  String get eventMawlid => 'Maulid ya Mtume ﷺ';

  @override
  String get eventIsraMiraj => 'Isra na Mi\'raj';

  @override
  String get eventMidShaban => 'Nusu ya Sha\'ban';

  @override
  String get eventRamadanStart => 'Mwanzo wa Ramadhani';

  @override
  String get eventBattleOfBadr => 'Vita vya Badr';

  @override
  String get eventLaylatAlQadr => 'Usiku wa Lailatul Qadr';

  @override
  String get eventEidAlFitr => 'Eid al-Fitr';

  @override
  String get eventShawwalSixFasting => 'Siku 6 za Funga ya Shawwal';

  @override
  String get eventDhuAlHijjahStart => 'Mwanzo wa Dhul-Hijjah';

  @override
  String get eventDayOfArafah => 'Siku ya Arafah';

  @override
  String get eventEidAlAdha => 'Eid al-Adha';

  @override
  String get eventDaysOfTashreeq => 'Siku za Tashreeq';

  @override
  String get qiblaHeadingTrue => 'MWELEKEO SAHIHI';

  @override
  String get qiblaBearingLabel => 'KIPIMO CHA KIBLA';

  @override
  String get qiblaRetryLocation => 'Jaribu tena eneo';

  @override
  String get qiblaCalibClearInterference => 'Epuka muingiliano wa sumaku';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'Kaa mbali na meza za chuma, kompyuta au vifuniko vyenye sumaku.';

  @override
  String get qiblaCalibHoldFlat => 'Shikilia kifaa kikiwa tambarare';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'Shikilia simu yako ikiwa tambarare sawa na ardhi kwa usahihi wa juu.';

  @override
  String get qiblaCalibFigure8 => 'Zungusha kwa umbo la namba 8';

  @override
  String get qiblaCalibFigure8Desc =>
      'Zungusha simu yako hewani kwa mfano wa namba 8 kusawazisha dira.';

  @override
  String get stepPrevious => 'Iliyopita';

  @override
  String get stepNext => 'Hatua Inayofuata';

  @override
  String get stepFinishGuide => 'Kamilisha Mwongozo';

  @override
  String get widgetAddAnother => 'Ongeza Nyingine';

  @override
  String get widgetOpenSettings => 'Fungua Mipangilio';

  @override
  String get widgetGoToHome => 'Rudi Nyumbani';

  @override
  String get trackerWeeklyRate => 'Kiwango cha Wiki';

  @override
  String get trackerMonthlyRate => 'Kiwango cha Mwezi';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total Swala';
  }

  @override
  String get tasbihHadithTitle => 'HADITHI YA DHIKRI KWA KUTUMIA VIDOLE';

  @override
  String get tasbihHadithText =>
      '“Shikamaneni na kumtakasa Mwenyezi Mungu, kutangaza upweke Wake na kumtukuza, na hesabuni kwa ncha za vidole, kwani hakika vitaulizwa Siku ya Kiyama na vitazungumza.”';

  @override
  String get tasbihHadithReference => '— Sunan Abi Dawud 1496';

  @override
  String get dhikrSubhanAllah => 'Subhanallah';

  @override
  String get dhikrAlhamdulillah => 'Alhamdulillah';

  @override
  String get dhikrAllahuAkbar => 'Allahu Akbar';

  @override
  String get dhikrAstaghfirullah => 'Astaghfirullah';

  @override
  String get dhikrLaIlahaIllallah => 'La ilaha illallah';

  @override
  String get dhikrSubhanAllahTranslation =>
      'Ametakasika Mwenyezi Mungu na kila upungufu';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'Sifa zote njema na shukrani ni za Mwenyezi Mungu';

  @override
  String get dhikrAllahuAkbarTranslation =>
      'Mwenyezi Mungu ni Mkubwa zaidi ya kila kitu';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'Ninamwomba msamaha Mwenyezi Mungu kwa dhambi zangu';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'Hapana mola apasaye kuabudiwa kwa haki ila Mwenyezi Mungu';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'Inayofuata: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'Maalum';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'Maalum ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'Weka Idadi Maalum';

  @override
  String get tasbihTargetHint => 'Ingiza idadi unayotaka (mf. 50)';

  @override
  String get tasbihCancel => 'Ghairi';

  @override
  String get tasbihSetTarget => 'Thibitisha Idadi';

  @override
  String tasbihLap(String lap) {
    return 'Mzunguko $lap';
  }
}
