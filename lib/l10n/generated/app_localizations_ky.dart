// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kirghiz Kyrgyz (`ky`).
class AppLocalizationsKy extends AppLocalizations {
  AppLocalizationsKy([String locale = 'ky']) : super(locale);

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
  String get remaining => 'калды';

  @override
  String get statusPrayed => 'Prayed';

  @override
  String get statusMissed => 'Missed';

  @override
  String get statusPending => 'Pending';

  @override
  String get qiblaCompassTitle => 'Кыбыла компасы';

  @override
  String get qiblaCalibrate => 'Калибрлөө';

  @override
  String get qiblaFacingKaaba => 'Кааба багытына так багытталган';

  @override
  String get tasbihTitle => 'Электрондук таспих';

  @override
  String get tasbihReset => 'Нөлдөө';

  @override
  String get tasbihAutoNext => 'Авто өтүү';

  @override
  String get tasbihBestOnFingers => 'Таспихти манжалар менен саноо — сүннөт';

  @override
  String get guidanceCategory => 'ЖОЛ-ЖОБО';

  @override
  String get learnSalah => 'Намаз үйрөнүү';

  @override
  String get learnSalahSubtitle =>
      'Сахих сүннөт жана хадистер боюнча намаз окуу тартиби';

  @override
  String get savedItems => 'Сакталгандар';

  @override
  String get savedItemsSubtitle => 'Хадистер, Аяттар жана Дубалар';

  @override
  String get prayerTracker => 'Намаз күндөлүгү';

  @override
  String get prayerTrackerSubtitle => 'Намаз статистикасын көрүү';

  @override
  String get widgetsTitle => 'Виджеттер';

  @override
  String get widgetsSubtitle => 'Башкы экранга виджет кошуу';

  @override
  String get openSourcePrivacy => 'Ачык булак жана купуялуулук';

  @override
  String get openSourcePrivacySubtitle =>
      '100% офлайн, көзөмөлсүз жана коммерциялык эмес';

  @override
  String get themeMode => 'ТЕМА РЕЖИМИ';

  @override
  String get themeSystem => 'Системалык';

  @override
  String get themeLight => 'Ачык';

  @override
  String get themeDark => 'Караңгы';

  @override
  String notificationPrayerTitle(String prayer) {
    return '$prayer намазы';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return '$prayer намазынын убактысы кирди. Намазга даярданыңыз.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'Убакыттын башындагы эскертүү — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return '$prayer убактысынан 15 мүнөт өттү. Намаз окудуңузбу?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'Маанилүү — $prayer намазынын бүтүшүнө 30 мүнөт калды';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return '$prayer намазынын убактысы чыгып кетишине болгону 30 мүнөт калды.';
  }

  @override
  String get notificationDailyReflectionTitle => 'Күндөлүк ой жүгүртүү';

  @override
  String get notificationTestTitle => 'Salah Companion эскертүүсү';

  @override
  String get notificationTestBody =>
      'Билдирмелер жана азан үнү ийгиликтүү жөндөлдү.';

  @override
  String get onboardingChooseLanguage => 'Тилди тандаңыз';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'Намаз убактылары жана жол-жоболор үчүн керектүү тилди тандаңыз.';

  @override
  String get onboardingWelcomeTitle =>
      'Salah Companion тиркемесине кош келиңиз';

  @override
  String get onboardingWelcomeBody =>
      'Так намаз убактылары, кыбыла багыты жана сахих сүннөттөр үчүн ишенимдүү шеригиңиз.';

  @override
  String get onboardingSwipeTitle => 'Меню үчүн сол четинен серпиңиз';

  @override
  String get onboardingSwipeBody =>
      'Сакталгандарга жана намаз статистикасына жетүү үчүн экрандын сол четинен серпиңиз.';

  @override
  String get onboardingSunnahTitle => 'Сахих сүннөт жана туура жол';

  @override
  String get onboardingSunnahBody =>
      'Күндөлүк Куран аяттары, сахих хадистер, дубалар жана намаз окуу эрежелери.';

  @override
  String get onboardingCustomizationTitle => 'Кыбыла, Таспих жана Жөндөөлөр';

  @override
  String get onboardingCustomizationBody =>
      'Кыбыла компасы, электрондук таспих жана эсептөө ыкмаларын жөндөңүз.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$total ИЧИНЕН $current';
  }

  @override
  String get onboardingSkip => 'Өткөрүп жиберүү';

  @override
  String get onboardingNext => 'Кийинки';

  @override
  String get onboardingGetStarted => 'Баштоо';

  @override
  String get systemDefault => 'Система тили';

  @override
  String get moreLanguages => 'Башка тилдер';

  @override
  String get searchLanguagePlaceholder => 'Тилди издөө...';

  @override
  String get settingsTitle => 'Жөндөөлөр';

  @override
  String get settingsLanguage => 'Тил';

  @override
  String get settingsLanguageSubtitle => 'Колдонмонун тилин өзгөртүү';

  @override
  String get onboardingTrustTitle => 'Сизге болгон ыйык аманатыбыз';

  @override
  String get onboardingTrustSubtitle =>
      'Аллахтын ыраазычылыгы үчүн гана жасалган — жарнамасыз, көзөмөлсүз, 100% сыр сакталат.';

  @override
  String get onboardingTrustOfflineTitle => '100% Түзмөктө жана Офлайн';

  @override
  String get onboardingTrustOfflineDesc =>
      'Сиздин жайгашкан жериңиз жана намаз маалыматтарыңыз телефонуңуздан тышкары чыкпайт.';

  @override
  String get onboardingTrustNoAdsTitle => 'Жарнама такыр жок';

  @override
  String get onboardingTrustNoAdsDesc =>
      'Ибадатыңызга тоскоол боло турган эч кандай коммерциялык жарнамалар жок.';

  @override
  String get onboardingTrustNoTrackingTitle =>
      'Көзөмөл жана маалымат топтоо жок';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'Firebase көзөмөлү жок, жеке маалыматтар чогултулбайт.';

  @override
  String get onboardingTrustFreeTitle => 'Үммөт үчүн түбөлүк акысыз';

  @override
  String get onboardingTrustFreeDesc =>
      'Садака жария катары арналган. Эч кандай акы төлөнбөйт.';

  @override
  String get onboardingFeaturesTitle => 'Негизги мүмкүнчүлүктөр';

  @override
  String get onboardingFeaturesSubtitle =>
      'Так намаз убактылары, сахих сүннөт жана ибадат куралдары.';

  @override
  String get onboardingFeaturePrayerTitle => 'Астрономиялык тактык';

  @override
  String get onboardingFeaturePrayerDesc =>
      'Күн багытына жараша так убакыттар жана сүннөт намаздарды эскертүү.';

  @override
  String get onboardingFeatureQiblaTitle => 'Кыбыла компасы';

  @override
  String get onboardingFeatureQiblaDesc =>
      'Ыйык Кааба багытын так аныктоо жана кыбылага дал келгенде титирөө.';

  @override
  String get onboardingFeatureTasbihTitle => 'Санарип тасбих';

  @override
  String get onboardingFeatureTasbihDesc =>
      'Манжа менен тарткандай сезилген титирөө жана сүннөт зикирлер.';

  @override
  String get onboardingFeatureSunnahTitle => 'Сахих сүннөт жана дубалар';

  @override
  String get onboardingFeatureSunnahDesc =>
      'Ишенимдүү булактардан алынган сахих хадистер жана күнүмдүк аяттар.';

  @override
  String get onboardingFeatureQiblaAligned => 'Кыбыла багыты аныкталды • Мекке';

  @override
  String get onboardingFeatureTapToCount =>
      'Саноо үчүн каалаган жерди басыңыз же серпиңиз';

  @override
  String get onboardingPermissionsTitle => 'Оңой орнотуу';

  @override
  String get onboardingPermissionsSubtitle =>
      'Намаз убактысын так эсептөө жана азан билдирмелери үчүн уруксат бериңиз.';

  @override
  String get onboardingPermLocationTitle => 'Так жайгашкан жер';

  @override
  String get onboardingPermLocationDesc =>
      'Жергиликтүү күн чыгуу жана батуу убактысын эсептөө үчүн гана колдонулат.';

  @override
  String get onboardingPermNotifTitle => 'Азан жана намаз билдирмелери';

  @override
  String get onboardingPermNotifDesc =>
      'Азанды өз убагында чакырып, сүннөт намаздарды эсиңизге салат.';

  @override
  String get onboardingPermBatteryTitle => 'Фондук режимде ишенимдүү иштөө';

  @override
  String get onboardingPermBatteryDesc =>
      'Батарея үнөмдөгүч багымдат азанын өчүрүп салбашы үчүн керек.';

  @override
  String get onboardingPermGrant => 'Уруксат берүү';

  @override
  String get onboardingPermGranted => 'Уруксат берилди';

  @override
  String get onboardingPermEnableLater => 'Кийинчерээк жөндөөлөрдөн күйгүзүү';

  @override
  String get onboardingDedicationVerse =>
      '«Чындыгында, намаз момундарга белгиленген убакытта парз кылынды.»';

  @override
  String get onboardingDedicationReference => 'Ниса сүрөсү (103)';

  @override
  String get onboardingBeginJourney => 'Бисмиллах • Баштоо';

  @override
  String get onboardingReplayTour => 'Таанышуу турун кайра көрүү';

  @override
  String get onboardingReplayTourSubtitle =>
      'Колдонмо мүмкүнчүлүктөрүн кайрадан карап чыгыңыз';

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
  String get settingsBatteryExempt => 'Чектелбеген';

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
  String get sunnahPrayerHeader => 'СҮННӨТ НАМАЗЫ';

  @override
  String get sunnahFajrDesc => 'Парздан мурда 2 рекет сүннөт';

  @override
  String get sunnahDhuhrDesc => 'Парздан мурда 4 жана кийин 2 рекет';

  @override
  String get sunnahAsrDesc => 'Парздан мурда 4 рекет сүннөт';

  @override
  String get sunnahMaghribDesc => 'Парздан кийин 2 рекет сүннөт';

  @override
  String get sunnahIshaDesc => 'Парздан кийин 2 рекет сүннөт + 3 рекет витир';

  @override
  String get forbiddenNaflHeader =>
      'НАФИЛ НАМАЗ ОКУУГА ТЫЮУ САЛЫНГАН УБАКЫТТАР';

  @override
  String get forbiddenNaflBody =>
      'Күн чыгып жатканда (~20 мүн), күн төбөгө келгенде (~10 мүн) жана күн батып жатканда (~20 мүн) нафил намаз окууга тыюу салынат. Каза намаздарды окууга болот. (Сахих Муслим 831)';

  @override
  String get forbiddenNaflSunriseHeader => 'ТЫЮУ САЛЫНГАН УБАКЫТ • КҮН ЧЫГЫШЫ';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'Күн чыгууда ($startTime – $endTime). Күн толук көтөрүлгөнгө чейин нафил намаз окулбайт. (Сахих Муслим 831)';
  }

  @override
  String get forbiddenNaflZawalHeader => 'ТЫЮУ САЛЫНГАН УБАКЫТ • ЗАВАЛ';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'Күн дал төбөдө турат ($startTime – $endTime). Бул убакта нафил намаз окууга болбойт. (Сахих Муслим 831)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'ТЫЮУ САЛЫНГАН УБАКЫТ • КҮН БАТЫШЫ';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'Күн батууда ($startTime – $endTime). Күн толук батканга чейин нафил намаз окулбайт. (Сахих Муслим 831)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return '$prayer намазынын убактысы али кире элек ($time)';
  }

  @override
  String get timeStart => 'Башталышы';

  @override
  String get timeEnd => 'Аякташы';

  @override
  String get onboardingShowcasePrayerTitle => 'Так Намаз Убактылары';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'Эл аралык ишенимдүү ыкмалар боюнча 100% оффлайн так эсептөө.';

  @override
  String get onboardingShowcaseQiblaTitle => 'Чыныгы Кыбыла Компасы';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'Дүйнөнүн каалаган жеринен Каабанын багытын оңой табыңыз.';

  @override
  String get onboardingShowcaseTasbihTitle => 'Санариптик Тасбих жана Зикир';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'Вибрация белгиси жана автоматтык өтүүсү бар акылдуу зикир эсептегич.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'Күнүмдүк Аяттар, Хадистер жана Дубалар';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'Сахих хадистер, Куран аяттары жана күндөлүк зарыл дубалар.';

  @override
  String get settingsPrayerNotifications => 'Намаз Билдирмелери';

  @override
  String get settingsAdhanReciterTone => 'Азанчы жана Азан Үнү';

  @override
  String get settingsDailyReminderTime => 'Күндөлүк Ой Жүгүртүү Убактысы';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count Жандуу Виджет';
  }

  @override
  String get settingsFiqhAsr => 'Фикх (Аср Убактысы)';

  @override
  String get settingsFiqhStandardTitle => 'Шафий / Стандарттуу (Баштапкы)';

  @override
  String get settingsFiqhStandardDesc =>
      'Шафий, Маликий жана Ханбалий (1x Көлөкө)';

  @override
  String get settingsFiqhStandardSub =>
      'Көлөкө узундугу = нерсенин бою (1 эсе). Шафий, Маликий, Ханбалий мектеби.';

  @override
  String get settingsFiqhHanafiTitle => 'Ханафий';

  @override
  String get settingsFiqhHanafiDesc => 'Ханафий Мазхабы (2x Көлөкө)';

  @override
  String get settingsFiqhHanafiSub =>
      'Көлөкө узундугу = нерсенин боюнун 2 эсеси. Ханафий мазхабы боюнча.';

  @override
  String get settingsPreAdhanReminder => 'Азанга Чейинки Эскертүү';

  @override
  String get settingsBatteryRestricted => 'Чектелген';

  @override
  String get settingsBatteryExemptDesc =>
      'Чектелбеген — Азан билдирмелери убагында берилет';

  @override
  String get settingsBatteryNotExemptDesc =>
      'Чектелген — Билдирмелер кечигиши мүмкүн';

  @override
  String get settingsCheckBatteryNow => 'Абалды Азыр Текшерүү';

  @override
  String get settingsCheckBatterySubtitle =>
      'Фондо иштөө уруксаттарын текшериңиз';

  @override
  String get settingsWarnBattery => 'Кайра Чектелсе Эскертүү';

  @override
  String get settingsWarnBatterySubtitle =>
      'Система батареяны үнөмдөөнү иштетсе кабарлаңыз';

  @override
  String get settingsOpenSourceFootnote =>
      '100% Акысыз жана Ачык Коддуу • Жарнамасыз • Маалымат Чогултулбайт';

  @override
  String get settingsAsrCalculationTitle => 'Асрды Эсептөө Ыкмасы (Фикх)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'Аср намазынын башталуу убактысы үчүн мазхабды тандаңыз.';

  @override
  String get adhanVoiceMakkah => 'Мекке (Али Мулла)';

  @override
  String get adhanVoiceMadinah => 'Медина (Абдул Мажид)';

  @override
  String get adhanVoiceAlAqsa => 'Аль-Акса (Ясир ад-Даусари)';

  @override
  String get adhanVoiceSoft => 'Салттуу Жумшак Үн';

  @override
  String get calcMethodUmmAlQura => 'Умм аль-Кура (Сауд Арабиясы)';

  @override
  String get calcMethodMwl => 'Бүткүл Дүйнөлүк Ислам Лигасы (MWL)';

  @override
  String get calcMethodEgyptian => 'Египет Башкы Геодезия Башкармалыгы';

  @override
  String get calcMethodIsna => 'ISNA (Түндүк Америка)';

  @override
  String get calcMethodKarachi => 'Карачи Ислам Илимдери Университети';

  @override
  String get calcMethodDubai => 'Дубай Ислам Иштери Департаменти';

  @override
  String get calcMethodDiyanet => 'Диянет (Түркия)';

  @override
  String get calcMethodSingapore => 'MUIS (Сингапур)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'Мен кандай намаз окуп жатканымды көрсөңүздөр, ошондой окуңуздар';

  @override
  String get learnSalahAuthenticBadge => 'САХИХ СҮННӨТ БОЮНЧА КОЛДОНМО';

  @override
  String get learnSalahSearchPlaceholder =>
      'Кыймыл, кадам же хадис далилин издөө...';

  @override
  String get learnSalahLearningModules => 'ОКУТУУ МОДУЛДАРЫ';

  @override
  String get learnSalahStepByStepTitle => 'Кадам-кадам менен Намаз Колдонмосу';

  @override
  String get learnSalahStepByStepSubtitle =>
      'Иллюстрациялар жана далилдер менен 10 ырааттуу кадам';

  @override
  String get learnSalahPillarsTitle => 'Намаздын 14 Парзы (Рукундары)';

  @override
  String get learnSalahPillarsSubtitle =>
      'Намаздын эч качан ташталбай турган негизги түркүктөрү';

  @override
  String get learnSalahObligationsTitle => 'Намаздын 8 Важиби';

  @override
  String get learnSalahObligationsSubtitle =>
      'Саждаи сахв менен толукталчу важиб амалдар';

  @override
  String get learnSalahSunanTitle => 'Намаз Сүннөттөрү';

  @override
  String get learnSalahSunanSubtitle =>
      'Пайгамбарыбыздын ﷺ сөздүк жана иш-аракеттик сүннөттөрү';

  @override
  String get learnSalahInvalidatorsTitle => 'Намазды Бузуучу Нерселер';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'Намазды жараксыз кылган жана кайра окууну талап кылган нерселер';

  @override
  String get learnSalahForbiddenTimesTitle =>
      'Намаз Окууга Тыюу Салынган Убактар';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'Напил намаздарды окууга тыюу салынган маалдар';

  @override
  String get madhabShafi => 'Шафий';

  @override
  String get madhabHanafi => 'Ханафий';

  @override
  String get eventIslamicNewYear => 'Хижра Жаңы Жылы';

  @override
  String get eventTasua => 'Тасууа Күнү';

  @override
  String get eventAshura => 'Ашура Күнү';

  @override
  String get eventMawlid => 'Мавлид майрамы ﷺ';

  @override
  String get eventIsraMiraj => 'Мираж Түнү';

  @override
  String get eventMidShaban => 'Бараат Түнү';

  @override
  String get eventRamadanStart => 'Рамазан Айынын Биринчи Күнү';

  @override
  String get eventBattleOfBadr => 'Бадр Согушу';

  @override
  String get eventLaylatAlQadr => 'Кадыр Түн';

  @override
  String get eventEidAlFitr => 'Орозо Айт';

  @override
  String get eventShawwalSixFasting => 'Шаввал айынын 6 күн орозосу';

  @override
  String get eventDhuAlHijjahStart => 'Зул-Хижжа айынын башталышы';

  @override
  String get eventDayOfArafah => 'Арапа Күнү';

  @override
  String get eventEidAlAdha => 'Курман Айт';

  @override
  String get eventDaysOfTashreeq => 'Ташрик Күндөрү';

  @override
  String get qiblaHeadingTrue => 'ЧЫНЫГЫ БАГЫТ';

  @override
  String get qiblaBearingLabel => 'КЫБЛА БУРЧУ';

  @override
  String get qiblaRetryLocation => 'Жайгашкан жерди кайра аныктоо';

  @override
  String get qiblaCalibClearInterference =>
      'Магниттик тоскоолдуктардан алыс болуңуз';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'Металл үстөлдөрдөн, компьютерлерден же магниттик каптардан алыстаңыз.';

  @override
  String get qiblaCalibHoldFlat => 'Телефонду түз горизонталдуу кармаңыз';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'Жогорку тактык үчүн телефонду жерге параллель түз кармаңыз.';

  @override
  String get qiblaCalibFigure8 => '8 саны формасында кыймылдатыңыз';

  @override
  String get qiblaCalibFigure8Desc =>
      'Компасты тууралоо үчүн телефонду абада 8 саны сыяктуу жылдырыңыз.';

  @override
  String get stepPrevious => 'Артка';

  @override
  String get stepNext => 'Кийинки кадам';

  @override
  String get stepFinishGuide => 'Бүтүрүү';

  @override
  String get widgetAddAnother => 'Дагы кошуу';

  @override
  String get widgetOpenSettings => 'Орнотууларды ачуу';

  @override
  String get widgetGoToHome => 'Башкы бетке өтүү';

  @override
  String get trackerWeeklyRate => 'Апталык көрсөткүч';

  @override
  String get trackerMonthlyRate => 'Айлык көрсөткүч';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total Намаз';
  }

  @override
  String get tasbihHadithTitle => 'МАНЖА МЕНЕН ТАСПИХ САНОО ТУУРАЛУУ ХАДИС';

  @override
  String get tasbihHadithText =>
      '«Аллахты даңазалоону, Анын жалгыздыгын даңазалоону бекем кармангыла жана манжаларыңар менен санагыла, анткени Кыямат күнү манжалардан суралып, алар сүйлөшөт.»';

  @override
  String get tasbihHadithReference => '— Сүнөн Абу Дауд 1496';

  @override
  String get dhikrSubhanAllah => 'Субханаллах';

  @override
  String get dhikrAlhamdulillah => 'Алхамдулиллах';

  @override
  String get dhikrAllahuAkbar => 'Аллаху Акбар';

  @override
  String get dhikrAstaghfirullah => 'Астагфируллах';

  @override
  String get dhikrLaIlahaIllallah => 'Лаа илааха иллаллах';

  @override
  String get dhikrSubhanAllahTranslation =>
      'Аллах бардык кемчиликтерден аруу жана таза';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'Бардык мактоолор жана шүгүрлөр бир гана Аллахка таандык';

  @override
  String get dhikrAllahuAkbarTranslation => 'Аллах бардыгынан улук жана бийик';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'Аллахтан күнөөлөрүм үчүн кечирим сурайм';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'Бир Аллахтан башка сыйынууга татыктуу кудай жок';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'Кийинки: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'Ыңгайлаштырылган';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'Ыңгайлаштырылган ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'Жеке максатты коюу';

  @override
  String get tasbihTargetHint => 'Максат санын жазыңыз (мис. 50)';

  @override
  String get tasbihCancel => 'Жокко чыгаруу';

  @override
  String get tasbihSetTarget => 'Максатты бекитүү';

  @override
  String tasbihLap(String lap) {
    return 'Айлануу $lap';
  }
}
