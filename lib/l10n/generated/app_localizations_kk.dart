// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

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
  String get remaining => 'қалды';

  @override
  String get statusPrayed => 'Prayed';

  @override
  String get statusMissed => 'Missed';

  @override
  String get statusPending => 'Pending';

  @override
  String get qiblaCompassTitle => 'Құбыла компасы';

  @override
  String get qiblaCalibrate => 'Калибрлеу';

  @override
  String get qiblaFacingKaaba => 'Қағба бағытына тура бағытталған';

  @override
  String get tasbihTitle => 'Электронды тәспі';

  @override
  String get tasbihReset => 'Нөлдеу';

  @override
  String get tasbihAutoNext => 'Авто ауысу';

  @override
  String get tasbihBestOnFingers => 'Тәспіні саусақ буындарымен санау — сүннет';

  @override
  String get guidanceCategory => 'БАҒЫТ-БАҒДАР';

  @override
  String get learnSalah => 'Намаз үйрену';

  @override
  String get learnSalahSubtitle =>
      'Сахих сүннет пен хадистер бойынша намаз оқу үлгісі';

  @override
  String get savedItems => 'Сақталғандар';

  @override
  String get savedItemsSubtitle => 'Хадистер, Аяттар және Дұғалар';

  @override
  String get prayerTracker => 'Намаз күнделігі';

  @override
  String get prayerTrackerSubtitle => 'Намаз статистикасын көру';

  @override
  String get widgetsTitle => 'Виджеттер';

  @override
  String get widgetsSubtitle => 'Басты экранға виджет қосу';

  @override
  String get openSourcePrivacy => 'Ашық код және құпиялылық';

  @override
  String get openSourcePrivacySubtitle =>
      '100% офлайн, бақылаусыз және коммерциялық емес';

  @override
  String get themeMode => 'ТАҚЫРЫП РЕЖИМІ';

  @override
  String get themeSystem => 'Жүйелік';

  @override
  String get themeLight => 'Ашық';

  @override
  String get themeDark => 'Күңгірт';

  @override
  String notificationPrayerTitle(String prayer) {
    return '$prayer намазы';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return '$prayer намазының уақыты кірді. Намазға дайындалыңыз.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'Уақыттың басында еске салу — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return '$prayer уақытынан 15 минут өтті. Намазыңызды оқыдыңыз ба?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'Маңызды — $prayer намазының бітуіне 30 минут қалды';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return '$prayer намазы уақытының шығуына небәрі 30 минут қалды.';
  }

  @override
  String get notificationDailyReflectionTitle => 'Күнделікті ғибрат';

  @override
  String get notificationTestTitle => 'Salah Companion ескертуі';

  @override
  String get notificationTestBody =>
      'Хабарландырулар мен азан дыбысы сәтті бапталды.';

  @override
  String get onboardingChooseLanguage => 'Тілді таңдаңыз';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'Намаз уақыттары мен нұсқаулықтар үшін қалаған тіліңізді таңдаңыз.';

  @override
  String get onboardingWelcomeTitle =>
      'Salah Companion қолданбасына қош келдіңіз';

  @override
  String get onboardingWelcomeBody =>
      'Дәл намаз уақыттары, құбыла бағыты және сахих сүннеттер бойынша сенімді серігіңіз.';

  @override
  String get onboardingSwipeTitle => 'Мәзір үшін сол жақ жиектен сырғытыңыз';

  @override
  String get onboardingSwipeBody =>
      'Сақталғандар мен намаз статистикасына қол жеткізу үшін экранның сол жағынан сырғытыңыз.';

  @override
  String get onboardingSunnahTitle => 'Сахих сүннет және тура жол';

  @override
  String get onboardingSunnahBody =>
      'Күнделікті Құран аяттары, сахих хадистер, маснұн дұғалар және намаз оқу үлгісі.';

  @override
  String get onboardingCustomizationTitle => 'Құбыла, Тәспі және Баптаулар';

  @override
  String get onboardingCustomizationBody =>
      'Құбыла компасы, электронды тәспі және намаз есептеу әдістерін баптаңыз.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$total ІШІНЕН $current';
  }

  @override
  String get onboardingSkip => 'Өткізу';

  @override
  String get onboardingNext => 'Келесі';

  @override
  String get onboardingGetStarted => 'Бастау';

  @override
  String get systemDefault => 'Жүйелік тіл';

  @override
  String get moreLanguages => 'Басқа тілдер';

  @override
  String get searchLanguagePlaceholder => 'Тілді іздеу...';

  @override
  String get settingsTitle => 'Баптаулар';

  @override
  String get settingsLanguage => 'Тіл';

  @override
  String get settingsLanguageSubtitle => 'Қолданба тілін өзгерту';

  @override
  String get onboardingTrustTitle => 'Сізге деген қасиетті аманатымыз';

  @override
  String get onboardingTrustSubtitle =>
      'Тек Алланың разылығы үшін жасалған — жарнамасыз, бақылаусыз, 100% құпия.';

  @override
  String get onboardingTrustOfflineTitle => '100% Құрылғыда және Офлайн';

  @override
  String get onboardingTrustOfflineDesc =>
      'Орналасқан жеріңіз бен намаз деректеріңіз ешқашан телефоннан тыс кетпейді. Барлық есептеулер жергілікті түрде орындалады.';

  @override
  String get onboardingTrustNoAdsTitle => 'Жарнама мүлдем жоқ';

  @override
  String get onboardingTrustNoAdsDesc =>
      'Ешқандай баннерлер немесе кедергі келтіретін коммерциялық хабарландырулар жоқ.';

  @override
  String get onboardingTrustNoTrackingTitle =>
      'Бақылау және деректер жинау жоқ';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'Firebase бақылауы жоқ, жеке деректерді жинау жоқ.';

  @override
  String get onboardingTrustFreeTitle => 'Үммет үшін мәңгі тегін';

  @override
  String get onboardingTrustFreeDesc =>
      'Садақа жария ретінде жасалған. Ешқандай ақылы жазылым жоқ.';

  @override
  String get onboardingFeaturesTitle => 'Негізгі мүмкіндіктер';

  @override
  String get onboardingFeaturesSubtitle =>
      'Дәл намаз уақыттары, сахих сүннеттер және құлшылық құралдары.';

  @override
  String get onboardingFeaturePrayerTitle => 'Астрономиялық дәлдік';

  @override
  String get onboardingFeaturePrayerDesc =>
      'Күн қозғалысына сай дәл намаз уақыттары мен сүннет намаздар туралы ескерту.';

  @override
  String get onboardingFeatureQiblaTitle => 'Құбыла компасы';

  @override
  String get onboardingFeatureQiblaDesc =>
      'Қағба бағытын нақты көрсету және құбылаға дөп келгенде сезілетін діріл.';

  @override
  String get onboardingFeatureTasbihTitle => 'Ыңғайлы цифрлық тәспі';

  @override
  String get onboardingFeatureTasbihDesc =>
      'Саусақпен тартқандай діріл әсері және сүннет зікірлер жинағы.';

  @override
  String get onboardingFeatureSunnahTitle => 'Сахих сүннет және дұғалар';

  @override
  String get onboardingFeatureSunnahDesc =>
      'Сенімді хадис жинақтарынан алынған сахих хадистер мен күнделікті аяттар.';

  @override
  String get onboardingFeatureQiblaAligned => 'Құбыла бағыты анықталды • Мекке';

  @override
  String get onboardingFeatureTapToCount =>
      'Санау үшін экранды түртіңіз немесе сырғытыңыз';

  @override
  String get onboardingPermissionsTitle => 'Оңай баптау';

  @override
  String get onboardingPermissionsSubtitle =>
      'Намаз уақытын дәл есептеу және азан шақыру үшін рұқсат беріңіз.';

  @override
  String get onboardingPermLocationTitle => 'Орналасқан жер';

  @override
  String get onboardingPermLocationDesc =>
      'Тек сіздің өңіріңізге сай күннің шығуы мен батуын есептеу үшін қолданылады.';

  @override
  String get onboardingPermNotifTitle => 'Азан мен намаз ескертулері';

  @override
  String get onboardingPermNotifDesc =>
      'Азанды уақытында шақырып, сүннет намаздарды еске салады.';

  @override
  String get onboardingPermBatteryTitle => 'Тұрақты фондық жұмыс';

  @override
  String get onboardingPermBatteryDesc =>
      'Android батареясын үнемдеу жүйесі таңғы азанды өшіріп тастауынан қорғайды.';

  @override
  String get onboardingPermGrant => 'Рұқсат беру';

  @override
  String get onboardingPermGranted => 'Рұқсат берілді';

  @override
  String get onboardingPermEnableLater => 'Кейін баптаулардан қосу';

  @override
  String get onboardingDedicationVerse =>
      '«Шын мәнінде намаз мүміндерге белгіленген уақытта парыз етілді.»';

  @override
  String get onboardingDedicationReference => 'Ниса сүресі (103)';

  @override
  String get onboardingBeginJourney => 'Бисмилләһ • Бастау';

  @override
  String get onboardingReplayTour => 'Таныстыру турды қайта қарау';

  @override
  String get onboardingReplayTourSubtitle =>
      'Қолданба мүмкіндіктері мен құпиялылық ережелерін қайта көру';

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
  String get settingsBatteryExempt => 'Шектелмеген';

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
  String get sunnahPrayerHeader => 'СҮННЕТ НАМАЗЫ';

  @override
  String get sunnahFajrDesc => 'Парыздан бұрын 2 рәкәғат сүннет';

  @override
  String get sunnahDhuhrDesc => 'Парыздан бұрын 4 және кейін 2 рәкәғат';

  @override
  String get sunnahAsrDesc => 'Парыздан бұрын 4 рәкәғат сүннет';

  @override
  String get sunnahMaghribDesc => 'Парыздан кейін 2 рәкәғат сүннет';

  @override
  String get sunnahIshaDesc => 'Парыздан кейін 2 рәкәғат сүннет + 3 үтір';

  @override
  String get forbiddenNaflHeader => 'НӘПІЛ НАМАЗ ОҚУҒА ТЫЙЫМ САЛЫНҒАН УАҚЫТТАР';

  @override
  String get forbiddenNaflBody =>
      'Күн шыққанда (~20 мин), күн төбеде тұрғанда (~10 мин) және күн батып бара жатқанда (~20 мин) нәпіл намаз оқуға тыйым салынады. Қаза намаздарды өтеуге болады. (Сахих Муслим 831)';

  @override
  String get forbiddenNaflSunriseHeader => 'ТЫЙЫМ САЛЫНҒАН УАҚЫТ • КҮН ШЫҒУЫ';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'Күн шығып жатыр ($startTime – $endTime). Күн толық көтерілгенше нәпіл намаз оқылмайды. (Сахих Муслим 831)';
  }

  @override
  String get forbiddenNaflZawalHeader => 'ТЫЙЫМ САЛЫНҒАН УАҚЫТ • ЗӘУАЛ';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'Күн төбеде тұр ($startTime – $endTime). Бұл уақытта нәпіл намаз оқуға болмайды. (Сахих Муслим 831)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'ТЫЙЫМ САЛЫНҒАН УАҚЫТ • КҮН БАТУЫ';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'Күн батып барады ($startTime – $endTime). Күн толық батқанша нәпіл намаз оқылмайды. (Сахих Муслим 831)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return '$prayer намазының уақыты әлі кірген жоқ ($time)';
  }

  @override
  String get timeStart => 'Басталуы';

  @override
  String get timeEnd => 'Аяқталуы';

  @override
  String get onboardingShowcasePrayerTitle => 'Дәл Намаз Уақыттары';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'Халықаралық сенімді әдістер бойынша 100% офлайн дәл есептеу.';

  @override
  String get onboardingShowcaseQiblaTitle => 'Нақты Құбыла Компасы';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'Әлемнің кез келген нүктесінен Қағбаның бағытын оңай табыңыз.';

  @override
  String get onboardingShowcaseTasbihTitle => 'Ыңғайлы Сандық Тәспі';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'Діріл сигналы мен автоматты ауысуы бар ақылды зікір санауыш.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'Күнделікті Аяттар, Хадистер мен Дұғалар';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'Сахих хадистер, Құран аяттары және күнделікті қажетті дұғалар.';

  @override
  String get settingsPrayerNotifications => 'Намаз Хабарландырулары';

  @override
  String get settingsAdhanReciterTone => 'Азаншы және Азан Үні';

  @override
  String get settingsDailyReminderTime => 'Күнделікті Ой Салу Уақыты';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count Белсенді Виджет';
  }

  @override
  String get settingsFiqhAsr => 'Фиқһ (Екінті Уақыты)';

  @override
  String get settingsFiqhStandardTitle => 'Шафиғи / Стандартты (Әдепкі)';

  @override
  String get settingsFiqhStandardDesc =>
      'Шафиғи, Малики және Ханбали (1x Көлеңке)';

  @override
  String get settingsFiqhStandardSub =>
      'Көлеңке ұзындығы = зат бойы (1 есе). Шафиғи, Малики, Ханбали мектебі.';

  @override
  String get settingsFiqhHanafiTitle => 'Ханафи';

  @override
  String get settingsFiqhHanafiDesc => 'Ханафи Мәзһабы (2x Көлеңке)';

  @override
  String get settingsFiqhHanafiSub =>
      'Көлеңке ұзындығы = зат бойының 2 есесі. Ханафи мәзһабы бойынша.';

  @override
  String get settingsPreAdhanReminder => 'Азанға Дейінгі Ескерту';

  @override
  String get settingsBatteryRestricted => 'Шектелген';

  @override
  String get settingsBatteryExemptDesc =>
      'Шектелмеген — Азан хабарландырулары уақытында беріледі';

  @override
  String get settingsBatteryNotExemptDesc =>
      'Шектелген — Хабарландырулар кешігуі мүмкін';

  @override
  String get settingsCheckBatteryNow => 'Күйді Қазір Тексеру';

  @override
  String get settingsCheckBatterySubtitle =>
      'Фондық жұмыс рұқсаттарын растаңыз';

  @override
  String get settingsWarnBattery => 'Қайта Шектелсе Ескерту';

  @override
  String get settingsWarnBatterySubtitle =>
      'Жүйе батарея үнемдеуді қосса хабарлаңыз';

  @override
  String get settingsOpenSourceFootnote =>
      '100% Тегін және Ашық Кодты • Жарнамасыз • Дерек Жиналмайды';

  @override
  String get settingsAsrCalculationTitle => 'Екінтіні Есептеу Әдісі (Фиқһ)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'Екінті намазының басталу уақыты үшін мәзһабты таңдаңыз.';

  @override
  String get adhanVoiceMakkah => 'Мекке (Әли Мулла)';

  @override
  String get adhanVoiceMadinah => 'Медина (Абдул Мәжит)';

  @override
  String get adhanVoiceAlAqsa => 'Әл-Ақса (Ясир әл-Даусари)';

  @override
  String get adhanVoiceSoft => 'Дәстүрлі Жұмсақ Үн';

  @override
  String get calcMethodUmmAlQura => 'Умм әл-Құра (Сауд Арабиясы)';

  @override
  String get calcMethodMwl => 'Дүниежүзілік Ислам Лигасы (MWL)';

  @override
  String get calcMethodEgyptian => 'Мысыр Бас Геодезия Басқармасы';

  @override
  String get calcMethodIsna => 'ISNA (Солтүстік Америка)';

  @override
  String get calcMethodKarachi => 'Карачи Ислам Ғылымдары Университеті';

  @override
  String get calcMethodDubai => 'Дубай Ислам Істері Департаменті';

  @override
  String get calcMethodDiyanet => 'Диянет (Түркия)';

  @override
  String get calcMethodSingapore => 'MUIS (Сингапур)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'Менің қалай намаз оқығанымды көрсеңіздер, солай оқыңыздар';

  @override
  String get learnSalahAuthenticBadge => 'САХИХ СҮННЕТ БОЙЫНША НҰСҚАУЛЫҚ';

  @override
  String get learnSalahSearchPlaceholder =>
      'Қимыл, қадам немесе хадис дәлелін іздеу...';

  @override
  String get learnSalahLearningModules => 'ОҚЫТУ МОДУЛЬДЕРІ';

  @override
  String get learnSalahStepByStepTitle => 'Қадам-қадаммен Намаз Оқу Нұсқаулығы';

  @override
  String get learnSalahStepByStepSubtitle =>
      'Иллюстрациялар мен дәлелдермен 10 реттік қадам';

  @override
  String get learnSalahPillarsTitle => 'Намаздың 14 Парызы (Рукіндері)';

  @override
  String get learnSalahPillarsSubtitle =>
      'Намаздың ешқашан тасталмайтын басты негіздері';

  @override
  String get learnSalahObligationsTitle => 'Намаздың 8 Уәжібі';

  @override
  String get learnSalahObligationsSubtitle =>
      'Сәһу сәждесімен толтырылатын уәжіп амалдар';

  @override
  String get learnSalahSunanTitle => 'Намаз Сүннеттері';

  @override
  String get learnSalahSunanSubtitle =>
      'Пайғамбарымыздың ﷺ сөздік және іс-әрекеттік сүннеттері';

  @override
  String get learnSalahInvalidatorsTitle => 'Намазды Бұзатын Жағдайлар';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'Намазды жарамсыз ететін және қайта оқуды талап ететін амалдар';

  @override
  String get learnSalahForbiddenTimesTitle =>
      'Намаз Оқуға Тыйым Салынған Уақыттар';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'Нәпіл намаздарды оқуға қатаң тыйым салынған уақыттар';

  @override
  String get madhabShafi => 'Шафиғи';

  @override
  String get madhabHanafi => 'Ханафи';

  @override
  String get eventIslamicNewYear => 'Хижра Жаңа Жылы';

  @override
  String get eventTasua => 'Тасуға Күні';

  @override
  String get eventAshura => 'Ашура Күні';

  @override
  String get eventMawlid => 'Мәуліт мерекесі ﷺ';

  @override
  String get eventIsraMiraj => 'Миғраж Түні';

  @override
  String get eventMidShaban => 'Бараат Түні';

  @override
  String get eventRamadanStart => 'Рамазан Айның Алғашқы Күні';

  @override
  String get eventBattleOfBadr => 'Бәдір Шайқасы';

  @override
  String get eventLaylatAlQadr => 'Қадір Түні';

  @override
  String get eventEidAlFitr => 'Ораза Айт';

  @override
  String get eventShawwalSixFasting => 'Шәууәл айының 6 күндік оразасы';

  @override
  String get eventDhuAlHijjahStart => 'Зүл-хижжа айының басталуы';

  @override
  String get eventDayOfArafah => 'Арапа Күні';

  @override
  String get eventEidAlAdha => 'Құрбан Айт';

  @override
  String get eventDaysOfTashreeq => 'Тәшриқ Күндері';

  @override
  String get qiblaHeadingTrue => 'НАҚТЫ БАҒЫТ';

  @override
  String get qiblaBearingLabel => 'ҚҰБЫЛА БҰРЫШЫ';

  @override
  String get qiblaRetryLocation => 'Орынды қайта анықтау';

  @override
  String get qiblaCalibClearInterference =>
      'Магниттік кедергілерден аулақ болыңыз';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'Металл үстелдерден, компьютерлерден немесе магнитті қаптардан алшақтаңыз.';

  @override
  String get qiblaCalibHoldFlat => 'Құрылғыны көлденең ұстаңыз';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'Жоғары дәлдік үшін телефонды жерге параллель тегіс ұстаңыз.';

  @override
  String get qiblaCalibFigure8 => '8 саны түрінде қимылдатыңыз';

  @override
  String get qiblaCalibFigure8Desc =>
      'Компас баптау үшін телефонды ауада 8 саны бейнесінде қозғаңыз.';

  @override
  String get stepPrevious => 'Артқа';

  @override
  String get stepNext => 'Келесі қадам';

  @override
  String get stepFinishGuide => 'Аяқтау';

  @override
  String get widgetAddAnother => 'Тағы қосу';

  @override
  String get widgetOpenSettings => 'Параметрлерді ашу';

  @override
  String get widgetGoToHome => 'Басты бетке өту';

  @override
  String get trackerWeeklyRate => 'Апталық көрсеткіш';

  @override
  String get trackerMonthlyRate => 'Айлық көрсеткіш';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total Намаз';
  }

  @override
  String get tasbihHadithTitle => 'САУСАҚПЕН ТӘСПІ САНАУ ТУРАЛЫ ХАДИС';

  @override
  String get tasbihHadithText =>
      '«Аллаһты пәктеуді, Оның жалғыздығын ұлықтауды үзбеңдер және саусақ буындарымен санаңдар, өйткені Қиямет күні саусақтардан сұралып, олар сөйлейтін болады.»';

  @override
  String get tasbihHadithReference => '— Сүнән Әбу Дәуіт 1496';

  @override
  String get dhikrSubhanAllah => 'Субханаллаһ';

  @override
  String get dhikrAlhamdulillah => 'Әлхамдулилләһ';

  @override
  String get dhikrAllahuAkbar => 'Аллаһу Әкбар';

  @override
  String get dhikrAstaghfirullah => 'Астағфируллаһ';

  @override
  String get dhikrLaIlahaIllallah => 'Лә иләһә илләллаһ';

  @override
  String get dhikrSubhanAllahTranslation =>
      'Аллаһ кемшілік атаулыдан пәк әрі таза';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'Барлық мақтау-мадақ бір Аллаһқа лайық';

  @override
  String get dhikrAllahuAkbarTranslation => 'Аллаһ бәрінен де ұлық әрі жоғары';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'Аллаһтан күнәларым үшін кешірім тілеймін';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'Бір Аллаһтан басқа ғибадатқа лайықты құдай жоқ';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'Келесі: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'Таңдамалы';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'Таңдамалы ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'Арнайы мақсатты белгілеу';

  @override
  String get tasbihTargetHint => 'Мақсат санын енгізіңіз (мыс. 50)';

  @override
  String get tasbihCancel => 'Бас тарту';

  @override
  String get tasbihSetTarget => 'Мақсатты бекіту';

  @override
  String tasbihLap(String lap) {
    return 'Айналым $lap';
  }
}
