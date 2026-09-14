// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Albanian (`sq`).
class AppLocalizationsSq extends AppLocalizations {
  AppLocalizationsSq([String locale = 'sq']) : super(locale);

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
  String get remaining => 'mbetur';

  @override
  String get statusPrayed => 'Prayed';

  @override
  String get statusMissed => 'Missed';

  @override
  String get statusPending => 'Pending';

  @override
  String get qiblaCompassTitle => 'Kompasi i Kiblës';

  @override
  String get qiblaCalibrate => 'Kalibro';

  @override
  String get qiblaFacingKaaba => 'Drejtim i saktë drejt Qabes';

  @override
  String get tasbihTitle => 'Tesbih Dixhital';

  @override
  String get tasbihReset => 'Rivendos';

  @override
  String get tasbihAutoNext => 'Kalim automatik';

  @override
  String get tasbihBestOnFingers => 'Numërimi me gishta është sunet';

  @override
  String get guidanceCategory => 'UDHËZIME';

  @override
  String get learnSalah => 'Mësimi i Namazit';

  @override
  String get learnSalahSubtitle =>
      'Mësoni faljen e namazit sipas sunetit dhe haditheve të sakta';

  @override
  String get savedItems => 'Të ruajturat';

  @override
  String get savedItemsSubtitle => 'Hadithe, Ajete & Lutje';

  @override
  String get prayerTracker => 'Ndjekësi i Namazit';

  @override
  String get prayerTrackerSubtitle => 'Shikoni statistikat e namazit';

  @override
  String get widgetsTitle => 'Widget-et';

  @override
  String get widgetsSubtitle => 'Shto widget në ekranin kryesor';

  @override
  String get openSourcePrivacy => 'Kodi i Hapur & Privatësia';

  @override
  String get openSourcePrivacySubtitle =>
      '100% jashtë linje, pa gjurmim dhe jokomercial';

  @override
  String get themeMode => 'MODI I TEMËS';

  @override
  String get themeSystem => 'Sistemi';

  @override
  String get themeLight => 'E çelët';

  @override
  String get themeDark => 'E errët';

  @override
  String notificationPrayerTitle(String prayer) {
    return 'Namazi i $prayer';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return 'Ka hyrë koha për namazin e $prayer. Përgatituni për namaz.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'Përkujtues në fillim të kohës — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return 'Kanë kaluar 15 minuta nga koha e $prayer. A e keni falur namazin?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'Urgjente — 30 minuta deri në mbarim të $prayer';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return 'Kanë mbetur vetëm 30 minuta deri në mbarimin e kohës së $prayer.';
  }

  @override
  String get notificationDailyReflectionTitle => 'Përsiatja Ditore';

  @override
  String get notificationTestTitle => 'Njoftim nga Salah Companion';

  @override
  String get notificationTestBody =>
      'Njoftimet dhe audio e ezanit u konfiguruan me sukses.';

  @override
  String get onboardingChooseLanguage => 'Zgjidhni Gjuhën Tuaj';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'Zgjidhni gjuhën për kohët e namazit dhe udhëzimet ditore.';

  @override
  String get onboardingWelcomeTitle => 'Mirë se vini në Salah Companion';

  @override
  String get onboardingWelcomeBody =>
      'Shoqëruesi juaj i besueshëm për kohët e sakta të namazit, kiblën dhe sunetin autentik.';

  @override
  String get onboardingSwipeTitle => 'Rrëshqitni nga ana e majtë për menunë';

  @override
  String get onboardingSwipeBody =>
      'Rrëshqitni nga skaji i majtë i ekranit për qasje në të ruajturat dhe statistikat.';

  @override
  String get onboardingSunnahTitle => 'Suneti Autentik & Udhëzimi';

  @override
  String get onboardingSunnahBody =>
      'Ajete ditore të Kuranit, hadithe të sakta, lutje të transmetuara dhe mënyra e faljes.';

  @override
  String get onboardingCustomizationTitle => 'Kibla, Tesbihu & Cilësimet';

  @override
  String get onboardingCustomizationBody =>
      'Kompasi i kiblës, tesbihu dixhital dhe rregullimi i metodave të llogaritjes.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$current NGA $total';
  }

  @override
  String get onboardingSkip => 'Kalo';

  @override
  String get onboardingNext => 'Tjetra';

  @override
  String get onboardingGetStarted => 'Fillo';

  @override
  String get systemDefault => 'Gjuha e sistemit';

  @override
  String get moreLanguages => 'Gjuhë të tjera';

  @override
  String get searchLanguagePlaceholder => 'Kërko gjuhë...';

  @override
  String get settingsTitle => 'Cilësimet';

  @override
  String get settingsLanguage => 'Gjuha';

  @override
  String get settingsLanguageSubtitle => 'Ndrysho gjuhën e aplikacionit';

  @override
  String get onboardingTrustTitle => 'Amaneti ynë i shenjtë ndaj jush';

  @override
  String get onboardingTrustSubtitle =>
      'Ndërtuar vetëm për hir të Allahut — pa reklama, pa gjurmim, 100% private.';

  @override
  String get onboardingTrustOfflineTitle => '100% Në Pajisje dhe Jashtë Linje';

  @override
  String get onboardingTrustOfflineDesc =>
      'Vendndodhja dhe regjistrimet tuaja të namazit nuk largohen kurrë nga telefoni juaj.';

  @override
  String get onboardingTrustNoAdsTitle => 'Pa Reklama. Përgjithmonë.';

  @override
  String get onboardingTrustNoAdsDesc =>
      'Asnjë reklamë tregtare që mund t\'ju shpërqendrojë gjatë ibadetit.';

  @override
  String get onboardingTrustNoTrackingTitle => 'Zero Gjurmim dhe Analitikë';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'Pa gjurmues Firebase, pa mbledhje të të dhënave personale.';

  @override
  String get onboardingTrustFreeTitle => 'Falas Përgjithmonë për Ummetin';

  @override
  String get onboardingTrustFreeDesc =>
      'Ndërtuar si sadaka rrjedhëse (Sadaka Xharije). Pa pagesa.';

  @override
  String get onboardingFeaturesTitle => 'Karakteristikat Kryesore';

  @override
  String get onboardingFeaturesSubtitle =>
      'Kohë të sakta të namazit, sunet autentik dhe mjete të qeta për ibadet.';

  @override
  String get onboardingFeaturePrayerTitle => 'Saktësi Astronomike';

  @override
  String get onboardingFeaturePrayerDesc =>
      'Llogaritje precize diellore dhe rikujtues të namazeve sunet.';

  @override
  String get onboardingFeatureQiblaTitle => 'Busulla e Kiblës në Kohë Reale';

  @override
  String get onboardingFeatureQiblaDesc =>
      'Tregues i saktë drejt Qabesë me dridhje haptike kur orientohet saktë.';

  @override
  String get onboardingFeatureTasbihTitle => 'Tesbih Dixhital Haptik';

  @override
  String get onboardingFeatureTasbihDesc =>
      'Numërim me ndjesi prekjeje dhe dhikre autentike profetike.';

  @override
  String get onboardingFeatureSunnahTitle => 'Suneti Autentik dhe Lutjet';

  @override
  String get onboardingFeatureSunnahDesc =>
      'Ajete ditore kuranore dhe hadithe të sakta nga Buhariu dhe Muslimi.';

  @override
  String get onboardingFeatureQiblaAligned => 'Drejtuar nga Kibla • Meke';

  @override
  String get onboardingFeatureTapToCount =>
      'Prekni kudo ose rrëshqitni për të numëruar';

  @override
  String get onboardingPermissionsTitle => 'Konfigurim i Lehtë';

  @override
  String get onboardingPermissionsSubtitle =>
      'Aktivizoni lejet për llogaritjen e saktë të vaktit dhe njoftimet e ezanit.';

  @override
  String get onboardingPermLocationTitle => 'Vendndodhja e Saktë';

  @override
  String get onboardingPermLocationDesc =>
      'Përdoret rreptësisht në pajisje për llogaritjen e orareve të namazit.';

  @override
  String get onboardingPermNotifTitle => 'Njoftimet e Ezanit dhe Namazit';

  @override
  String get onboardingPermNotifDesc =>
      'Transmeton ezanin në kohë dhe rikujtuesit e lutjeve.';

  @override
  String get onboardingPermBatteryTitle => 'Funksionim i Sigurt në Sfond';

  @override
  String get onboardingPermBatteryDesc =>
      'Parandalon mbylljen e alarmit të sabahut nga optimizimi i baterisë.';

  @override
  String get onboardingPermGrant => 'Jep Leje';

  @override
  String get onboardingPermGranted => 'Leja u Dha';

  @override
  String get onboardingPermEnableLater => 'Konfiguro më vonë te Cilësimet';

  @override
  String get onboardingDedicationVerse =>
      '«Vërtet, namazi është detyrë e përcaktuar në kohë për besimtarët.»';

  @override
  String get onboardingDedicationReference => 'Sure En-Nisa (4:103)';

  @override
  String get onboardingBeginJourney => 'Bismilah • Fillo';

  @override
  String get onboardingReplayTour => 'Rishiko Turit Prezantues';

  @override
  String get onboardingReplayTourSubtitle =>
      'Shikoni sërish veçoritë e aplikacionit dhe përkushtimin ndaj privatësisë';

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
  String get settingsBatteryExempt => 'I Përjashtuar';

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
  String get sunnahPrayerHeader => 'NAMAZI I SUNETIT';

  @override
  String get sunnahFajrDesc => '2 rekate sunet para farzit';

  @override
  String get sunnahDhuhrDesc => '4 rekate para dhe 2 pas farzit';

  @override
  String get sunnahAsrDesc => '4 rekate sunet para farzit';

  @override
  String get sunnahMaghribDesc => '2 rekate sunet pas farzit';

  @override
  String get sunnahIshaDesc => '2 rekate pas farzit + 3 rekate vitër';

  @override
  String get forbiddenNaflHeader => 'KOHËT E NDALUARA PËR NAMAZET NAFELE';

  @override
  String get forbiddenNaflBody =>
      'Namazi nafele është i ndaluar gjatë lindjes së diellit (~20 min), zenitit (~10 min para Dreke) dhe perëndimit të diellit (~20 min para Akshamit). Falja e namazeve kaza është e lejuar. (Sahih Muslim 831)';

  @override
  String get forbiddenNaflSunriseHeader => 'KOHË E NDALUAR • LINDJA E DIELLIT';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'Dielli po lind ($startTime – $endTime). Namazi nafele është i ndaluar derisa dielli të ngrihet plotësisht. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflZawalHeader => 'KOHË E NDALUAR • ZENITI (ZEVALI)';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'Dielli është në zenit ($startTime – $endTime). Namazi nafele është i ndaluar në mesditë. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflSunsetHeader =>
      'KOHË E NDALUAR • PERËNDIMI I DIELLIT';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'Dielli po perëndon ($startTime – $endTime). Namazi nafele është i ndaluar derisa të përfundojë perëndimi. (Sahih Muslim 831)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return 'Koha e namazit të $prayer nuk ka filluar ende ($time)';
  }

  @override
  String get timeStart => 'Fillimi';

  @override
  String get timeEnd => 'Fundi';

  @override
  String get onboardingShowcasePrayerTitle => 'Kohët e Sakta të Namazit';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'Llogaritje astronomike e saktë e kohëve të namazit 100% pa internet.';

  @override
  String get onboardingShowcaseQiblaTitle => 'Busulla e Sakte e Kiblës';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'Gjeni drejtimin e saktë të Qabes nga çdo vend i botës.';

  @override
  String get onboardingShowcaseTasbihTitle => 'Tasbih Dixhital Taktil';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'Numërues inteligjent i dhikrit me dridhje haptike dhe ndryshim automatik.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'Reflektime Ditore, Hadithe dhe Lutje';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'Ajete kuranore të verifikuara, hadithe të sakta dhe lutje thelbësore ditore.';

  @override
  String get settingsPrayerNotifications => 'Njoftimet e Namazit';

  @override
  String get settingsAdhanReciterTone => 'Myezini dhe Toni i Ezanit';

  @override
  String get settingsDailyReminderTime => 'Koha e Kujtesës Ditore';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count Widgete Aktive';
  }

  @override
  String get settingsFiqhAsr => 'Fikhu (Koha e Iqindisë)';

  @override
  String get settingsFiqhStandardTitle => 'Shafi\'i / Standard (E paracaktuar)';

  @override
  String get settingsFiqhStandardDesc => 'Shafi\'i, Maliki & Hanbeli (1x Hije)';

  @override
  String get settingsFiqhStandardSub =>
      'Gjatësia e hijes = 1x lartësia e objektit. Ndiqet nga Shafi\'i, Maliki, Hanbeli.';

  @override
  String get settingsFiqhHanafiTitle => 'Hanefi';

  @override
  String get settingsFiqhHanafiDesc => 'Medhhebi Hanefi (2x Hije)';

  @override
  String get settingsFiqhHanafiSub =>
      'Gjatësia e hijes = 2x lartësia e objektit. Sipas medhhebit Hanefi.';

  @override
  String get settingsPreAdhanReminder => 'Kujtesë Para Ezanit';

  @override
  String get settingsBatteryRestricted => 'I Kufizuar';

  @override
  String get settingsBatteryExemptDesc =>
      'I përjashtuar — Njoftimet e ezanit do të bien në kohë';

  @override
  String get settingsBatteryNotExemptDesc =>
      'I kufizuar — Njoftimet mund të vonohen në sfond';

  @override
  String get settingsCheckBatteryNow => 'Kontrollo Gjendjen Tani';

  @override
  String get settingsCheckBatterySubtitle =>
      'Verifikoni lejet e punës në sfond';

  @override
  String get settingsWarnBattery => 'Paralajmëro nëse Rikufizohet';

  @override
  String get settingsWarnBatterySubtitle =>
      'Njofto nëse sistemi riaktivizon kursimin e baterisë';

  @override
  String get settingsOpenSourceFootnote =>
      '100% Falas dhe me Kod të Hapur • Pa Reklama • Pa Mbledhje të Dhënash';

  @override
  String get settingsAsrCalculationTitle =>
      'Metoda e Llogaritjes së Iqindisë (Fikh)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'Zgjidhni shkollën juridike për llogaritjen e kohës së Iqindisë.';

  @override
  String get adhanVoiceMakkah => 'Mekë (Ali Mulla)';

  @override
  String get adhanVoiceMadinah => 'Medinë (Abdul Mexhid)';

  @override
  String get adhanVoiceAlAqsa => 'Al-Aksa (Jaser Al-Dosari)';

  @override
  String get adhanVoiceSoft => 'Ton Tradicional i Butë';

  @override
  String get calcMethodUmmAlQura => 'Umm Al-Kura (Arabia Saudite)';

  @override
  String get calcMethodMwl => 'Lidhja Botërore Islame (MWL)';

  @override
  String get calcMethodEgyptian => 'Autoriteti i Përgjithshëm Egjiptian';

  @override
  String get calcMethodIsna => 'ISNA (Amerika e Veriut)';

  @override
  String get calcMethodKarachi => 'Universiteti i Shkencave Islame Karaçi';

  @override
  String get calcMethodDubai => 'Çështjet Islame të Dubait';

  @override
  String get calcMethodDiyanet => 'Diyanet (Turqi)';

  @override
  String get calcMethodSingapore => 'MUIS (Singapor)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'Faluni ashtu siç më keni parë mua duke u falur';

  @override
  String get learnSalahAuthenticBadge => 'UDHËZUES I SUNETIT AUTENTIK';

  @override
  String get learnSalahSearchPlaceholder =>
      'Kërko qëndrim, hap ose argument nga Hadithi...';

  @override
  String get learnSalahLearningModules => 'MODULET MËSIMORE';

  @override
  String get learnSalahStepByStepTitle => 'Udhëzues i Namazit Hap pas Hapi';

  @override
  String get learnSalahStepByStepSubtitle =>
      '10 Hapa sekuencialë me ilustrime 2D dhe argumente';

  @override
  String get learnSalahPillarsTitle => '14 Shtyllat e Namazit (Ruknet)';

  @override
  String get learnSalahPillarsSubtitle =>
      'Themelet thelbësore dhe të domosdoshme të namazit';

  @override
  String get learnSalahObligationsTitle => '8 Obligimet e Namazit (Vaxhibatet)';

  @override
  String get learnSalahObligationsSubtitle =>
      'Vepra të detyrueshme që kompensohen me Sechden e Harresës';

  @override
  String get learnSalahSunanTitle => 'Sunetet e Namazit (Sunan)';

  @override
  String get learnSalahSunanSubtitle =>
      'Sunetet me fjalë dhe vepra të Profetit Muhamed ﷺ';

  @override
  String get learnSalahInvalidatorsTitle => 'Prishësit e Namazit (Mubtilaat)';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'Gjërat që e prishin namazin dhe e bëjnë të pavlefshëm';

  @override
  String get learnSalahForbiddenTimesTitle => 'Kohët e Ndaluara për Falje';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'Kohët kur falja e namazeve vullnetare është rreptësisht e ndaluar';

  @override
  String get madhabShafi => 'Shafi\'i';

  @override
  String get madhabHanafi => 'Hanefi';

  @override
  String get eventIslamicNewYear => 'Viti i Ri Hixhri';

  @override
  String get eventTasua => 'Dita e Tasu\'as';

  @override
  String get eventAshura => 'Dita e Ashures';

  @override
  String get eventMawlid => 'Mevludi i Pejgamberit ﷺ';

  @override
  String get eventIsraMiraj => 'Nata e Isra dhe Mi\'raxhit';

  @override
  String get eventMidShaban => 'Nata e Beratit (Mesi i Sha\'banit)';

  @override
  String get eventRamadanStart => 'Dita e Parë e Ramazanit';

  @override
  String get eventBattleOfBadr => 'Beteja e Bedrit';

  @override
  String get eventLaylatAlQadr => 'Nata e Kadrit';

  @override
  String get eventEidAlFitr => 'Fitër Bajrami';

  @override
  String get eventShawwalSixFasting => 'Agjërimi i 6 Ditëve të Shevalit';

  @override
  String get eventDhuAlHijjahStart => 'Fillimi i Dhul-Hixhes';

  @override
  String get eventDayOfArafah => 'Dita e Arafatit';

  @override
  String get eventEidAlAdha => 'Kurban Bajrami';

  @override
  String get eventDaysOfTashreeq => 'Ditët e Teshrikut';

  @override
  String get qiblaHeadingTrue => 'DREJTIMI I VËRTETË';

  @override
  String get qiblaBearingLabel => 'KËNDI I KIBLËS';

  @override
  String get qiblaRetryLocation => 'Riprovo vendndodhjen';

  @override
  String get qiblaCalibClearInterference => 'Shmangni interferencat magnetike';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'Largohuni nga tavolinat metalike, kompjuterët ose këllëfët magnetikë.';

  @override
  String get qiblaCalibHoldFlat => 'Mbajeni pajisjen horizontalisht të sheshtë';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'Mbajeni telefonin paralel me tokën për saktësi maksimale.';

  @override
  String get qiblaCalibFigure8 => 'Bëni lëvizje në formë të numrit 8';

  @override
  String get qiblaCalibFigure8Desc =>
      'Lëvizeni telefonin butësisht në ajër duke formuar një 8 për kalibrim.';

  @override
  String get stepPrevious => 'Mbrapa';

  @override
  String get stepNext => 'Hapi Tjetër';

  @override
  String get stepFinishGuide => 'Përfundo Udhëzuesin';

  @override
  String get widgetAddAnother => 'Shto një Tjetër';

  @override
  String get widgetOpenSettings => 'Hap Cilësimet';

  @override
  String get widgetGoToHome => 'Shko te Kreu';

  @override
  String get trackerWeeklyRate => 'Norma Javore';

  @override
  String get trackerMonthlyRate => 'Norma Mujore';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total Namaze';
  }

  @override
  String get tasbihHadithTitle => 'HADITHI MBI NUMËRIMIN E DHIKRIT ME GISHTA';

  @override
  String get tasbihHadithText =>
      '“Përmbajuni lartësimit të Allahut, njëshmërisë dhe shenjtërimit të Tij, dhe numëroni me majat e gishtave, sepse me të vërtetë ata do të pyeten në Ditën e Gjykimit dhe do të flasin.”';

  @override
  String get tasbihHadithReference => '— Sunen Ebi Davud 1496';

  @override
  String get dhikrSubhanAllah => 'Subhanallah';

  @override
  String get dhikrAlhamdulillah => 'Elhamdulilah';

  @override
  String get dhikrAllahuAkbar => 'Allahu Ekber';

  @override
  String get dhikrAstaghfirullah => 'Estagfirullah';

  @override
  String get dhikrLaIlahaIllallah => 'La ilahe il-lallah';

  @override
  String get dhikrSubhanAllahTranslation =>
      'I Lavdëruar dhe i Pastër nga çdo e metë është Allahu';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'Çdo lavdërim dhe falënderim i takon vetëm Allahut';

  @override
  String get dhikrAllahuAkbarTranslation =>
      'Allahu është më i Madhi mbi çdo gjë';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'I kërkoj falje Allahut për mëkatet e mia';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'Nuk ka të adhuruar tjetër me të drejtë përveç Allahut';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'Tjetri: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'Të personalizuar';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'Përshtatur ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'Cakto numrin e dëshiruar';

  @override
  String get tasbihTargetHint => 'Shkruani numrin e synuar (p.sh. 50)';

  @override
  String get tasbihCancel => 'Anulo';

  @override
  String get tasbihSetTarget => 'Vendos numrin';

  @override
  String tasbihLap(String lap) {
    return 'Rrethi $lap';
  }
}
