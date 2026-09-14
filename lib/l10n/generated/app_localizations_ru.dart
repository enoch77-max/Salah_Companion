// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

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
  String get remaining => 'осталось';

  @override
  String get statusPrayed => 'Prayed';

  @override
  String get statusMissed => 'Missed';

  @override
  String get statusPending => 'Pending';

  @override
  String get qiblaCompassTitle => 'Компас Киблы';

  @override
  String get qiblaCalibrate => 'Калибровка';

  @override
  String get qiblaFacingKaaba => 'Точное направление на Каабу';

  @override
  String get tasbihTitle => 'Электронный тасбих';

  @override
  String get tasbihReset => 'Сброс';

  @override
  String get tasbihAutoNext => 'Автопереход';

  @override
  String get tasbihBestOnFingers =>
      'Считать тасбих по фалангам пальцев — сунна';

  @override
  String get guidanceCategory => 'НАСТАВЛЕНИЕ';

  @override
  String get learnSalah => 'Обучение намазу';

  @override
  String get learnSalahSubtitle =>
      'Обучение намазу по достоверной сунне и хадисам';

  @override
  String get savedItems => 'Сохраненное';

  @override
  String get savedItemsSubtitle => 'Хадисы, Аяты и Дуа';

  @override
  String get prayerTracker => 'Трекер намазов';

  @override
  String get prayerTrackerSubtitle => 'Просмотр статистики молитв';

  @override
  String get widgetsTitle => 'Виджеты';

  @override
  String get widgetsSubtitle => 'Добавить виджеты на главный экран';

  @override
  String get openSourcePrivacy => 'Открытый код и приватность';

  @override
  String get openSourcePrivacySubtitle =>
      '100% офлайн, без трекеров и коммерции';

  @override
  String get themeMode => 'РЕЖИМ ТЕМЫ';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Темная';

  @override
  String notificationPrayerTitle(String prayer) {
    return 'Намаз $prayer';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return 'Наступило время намаза $prayer. Приготовьтесь к молитве.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'Напоминание о начале времени — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return 'Прошло 15 минут от начала времени $prayer. Вы уже совершили молитву?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'Срочно — осталось 30 минут до конца $prayer';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return 'Осталось всего 30 минут до окончания времени намаза $prayer.';
  }

  @override
  String get notificationDailyReflectionTitle => 'Ежедневное размышление';

  @override
  String get notificationTestTitle => 'Уведомление Salah Companion';

  @override
  String get notificationTestBody =>
      'Уведомления и звук азана успешно настроены.';

  @override
  String get onboardingChooseLanguage => 'Выберите ваш язык';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'Выберите предпочтительный язык для расписания намазов и наставлений.';

  @override
  String get onboardingWelcomeTitle => 'Добро пожаловать в Salah Companion';

  @override
  String get onboardingWelcomeBody =>
      'Ваш надежный помощник для точного времени намаза, направления Киблы и сунны.';

  @override
  String get onboardingSwipeTitle => 'Смахните от левого края для меню';

  @override
  String get onboardingSwipeBody =>
      'Смахните от самого левого края экрана для доступа к сохраненному и трекеру.';

  @override
  String get onboardingSunnahTitle => 'Достоверная Сунна и Наставление';

  @override
  String get onboardingSunnahBody =>
      'Ежедневные аяты Корана, достоверные хадисы, дуа и описание намаза пророка ﷺ.';

  @override
  String get onboardingCustomizationTitle => 'Кибла, Тасбих и Настройки';

  @override
  String get onboardingCustomizationBody =>
      'Компас Киблы, электронный тасбих и настройка методов расчета намаза.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$current ИЗ $total';
  }

  @override
  String get onboardingSkip => 'Пропустить';

  @override
  String get onboardingNext => 'Далее';

  @override
  String get onboardingGetStarted => 'Начать';

  @override
  String get systemDefault => 'Системный язык';

  @override
  String get moreLanguages => 'Другие языки';

  @override
  String get searchLanguagePlaceholder => 'Поиск языка...';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsLanguageSubtitle => 'Изменить язык приложения';

  @override
  String get onboardingTrustTitle => 'Наш священный завет перед вами';

  @override
  String get onboardingTrustSubtitle =>
      'Создано исключительно ради Аллаха — без рекламы, без слежки, 100% приватность.';

  @override
  String get onboardingTrustOfflineTitle => '100% Автономно и Конфиденциально';

  @override
  String get onboardingTrustOfflineDesc =>
      'Ваше местоположение и записи о намазах никогда не покидают телефон. Все астрономические расчеты производятся локально.';

  @override
  String get onboardingTrustNoAdsTitle => 'Никакой рекламы. Никогда.';

  @override
  String get onboardingTrustNoAdsDesc =>
      'Никаких баннеров, всплывающих окон и посторонних факторов между вами и Творцом.';

  @override
  String get onboardingTrustNoTrackingTitle => 'Ноль аналитики и слежки';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'Без трекеров Firebase, без сбора личных данных и без скрытой фоновой телеметрии.';

  @override
  String get onboardingTrustFreeTitle => 'Бесплатно навсегда для Уммы';

  @override
  String get onboardingTrustFreeDesc =>
      'Создано как садака-джария. Без платных подписок и скрытых платежей.';

  @override
  String get onboardingFeaturesTitle => 'Возможности приложения';

  @override
  String get onboardingFeaturesSubtitle =>
      'Точное расписание намаза, достоверная Сунна и удобные инструменты для поклонения.';

  @override
  String get onboardingFeaturePrayerTitle => 'Астрономическая точность';

  @override
  String get onboardingFeaturePrayerDesc =>
      'Вычисление точного положения солнца и напоминания о суннат-намазах.';

  @override
  String get onboardingFeatureQiblaTitle => 'Компас Киблы в реальном времени';

  @override
  String get onboardingFeatureQiblaDesc =>
      'Указатель направления на Священную Каабу с тактильной вибрацией при наведении.';

  @override
  String get onboardingFeatureTasbihTitle => 'Тактильный цифровой тасбих';

  @override
  String get onboardingFeatureTasbihDesc =>
      'Эмуляция четок с мягкой вибрацией и достоверными поминаниями Аллаха.';

  @override
  String get onboardingFeatureSunnahTitle => 'Достоверная Сунна и Дуа';

  @override
  String get onboardingFeatureSunnahDesc =>
      'Ежедневные аяты и достоверные хадисы из сборников аль-Бухари и Муслима.';

  @override
  String get onboardingFeatureQiblaAligned => 'Направление на Киблу • Мекка';

  @override
  String get onboardingFeatureTapToCount => 'Нажмите в любом месте для счета';

  @override
  String get onboardingPermissionsTitle => 'Простая настройка';

  @override
  String get onboardingPermissionsSubtitle =>
      'Предоставьте разрешения для точного расчета времени и своевременного азана.';

  @override
  String get onboardingPermLocationTitle => 'Точное местоположение';

  @override
  String get onboardingPermLocationDesc =>
      'Используется строго внутри устройства для расчета времени восхода и захода солнца.';

  @override
  String get onboardingPermNotifTitle => 'Азан и оповещения о намазе';

  @override
  String get onboardingPermNotifDesc =>
      'Своевременный азан и деликатные напоминания о наступлении молитвы.';

  @override
  String get onboardingPermBatteryTitle => 'Надежная работа в фоне';

  @override
  String get onboardingPermBatteryDesc =>
      'Защищает сигналы утреннего намаза Фаджр от остановки оптимизацией батареи Android.';

  @override
  String get onboardingPermGrant => 'Разрешить';

  @override
  String get onboardingPermGranted => 'Разрешено';

  @override
  String get onboardingPermEnableLater => 'Настроить позже в настройках';

  @override
  String get onboardingDedicationVerse =>
      '«Воистину, намаз предписан верующим в строго определенное время.»';

  @override
  String get onboardingDedicationReference => 'Сура Ан-Ниса (4:103)';

  @override
  String get onboardingBeginJourney => 'Бисмиллях • Начать';

  @override
  String get onboardingReplayTour => 'Повторить знакомство с приложением';

  @override
  String get onboardingReplayTourSubtitle =>
      'Посмотреть функции и принципы конфиденциальности снова';

  @override
  String get onboardingBack => 'Назад';

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
  String get settingsBatteryExempt => 'Исключено';

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
  String get categoryAll => 'Все';

  @override
  String get categoryHadith => 'Хадисы';

  @override
  String get categoryAyah => 'Аяты';

  @override
  String get categoryDua => 'Дуа';

  @override
  String get categoryMorning => 'Утро';

  @override
  String get categoryEvening => 'Вечер';

  @override
  String get categoryAfterPrayer => 'После намаза';

  @override
  String get categoryForgiveness => 'Покаяние';

  @override
  String get categoryProtection => 'Защита';

  @override
  String get categoryDaily => 'Повседневные';

  @override
  String get categoryTravel => 'В пути';

  @override
  String get noSavedItems => 'Нет сохраненных элементов';

  @override
  String get noSavedItemsSubtitle =>
      'Нажмите на значок закладки, чтобы сохранить сюда материал.';

  @override
  String get searchPlaceholder => 'Поиск дуа, переводов или источников...';

  @override
  String get sunnahPrayerHeader => 'СУННА НАМАЗ';

  @override
  String get sunnahFajrDesc => '2 ракаата сунны до фарда';

  @override
  String get sunnahDhuhrDesc => '4 ракаата до и 2 ракаата после фарда';

  @override
  String get sunnahAsrDesc => '4 ракаата сунны до фарда';

  @override
  String get sunnahMaghribDesc => '2 ракаата сунны после фарда';

  @override
  String get sunnahIshaDesc => '2 ракаата после фарда + 3 ракаата витр';

  @override
  String get forbiddenNaflHeader => 'ЗАПРЕТНЫЕ ВРЕМЕНА ДЛЯ НАФЛЬ НАМАЗОВ';

  @override
  String get forbiddenNaflBody =>
      'Добровольные (нафль) молитвы запрещены во время восхода солнца (~20 мин), зенита (~10 мин до Зухра) и заката (~20 мин до Магриба). Восполнение пропущенных фард намазов разрешено. (Сахих Муслим 831)';

  @override
  String get forbiddenNaflSunriseHeader => 'ЗАПРЕТНОЕ ВРЕМЯ • ВОСХОД СОЛНЦА';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'Солнце восходит ($startTime – $endTime). Нафль намазы запрещены до полного восхода. (Сахих Муслим 831)';
  }

  @override
  String get forbiddenNaflZawalHeader => 'ЗАПРЕТНОЕ ВРЕМЯ • ЗЕНИТ (ЗАВАЛЬ)';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'Солнце в зените ($startTime – $endTime). Нафль намазы запрещены в полдень. (Сахих Муслим 831)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'ЗАПРЕТНОЕ ВРЕМЯ • ЗАКАТ';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'Солнце садится ($startTime – $endTime). Нафль намазы запрещены до полного заката. (Сахих Муслим 831)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return 'Время намаза $prayer еще не наступило ($time)';
  }

  @override
  String get timeStart => 'Начало';

  @override
  String get timeEnd => 'Конец';

  @override
  String get onboardingShowcasePrayerTitle =>
      'Точное Астрономическое Время Намаза';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'Точный расчет времен молитв на 100% офлайн по мировым исламским стандартам.';

  @override
  String get onboardingShowcaseQiblaTitle => 'Точный Компас Киблы';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'Определяйте точное направление на Каабу в любой точке земного шара.';

  @override
  String get onboardingShowcaseTasbihTitle => 'Тактильный Электронный Тасбих';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'Удобный счетчик зикра с виброоткликом и автоматическим переключением.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'Ежедневные Аяты, Хадисы и Дуа';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'Проверенные аяты Корана, достоверные хадисы и важные повседневные мольбы.';

  @override
  String get settingsPrayerNotifications => 'Уведомления о Намазе';

  @override
  String get settingsAdhanReciterTone => 'Муэдзин и Звук Азана';

  @override
  String get settingsDailyReminderTime => 'Время Напоминания Размышления';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count Активных Виджетов';
  }

  @override
  String get settingsFiqhAsr => 'Фикх (Время Асра)';

  @override
  String get settingsFiqhStandardTitle => 'Шафии / Стандартный (По умолч.)';

  @override
  String get settingsFiqhStandardDesc => 'Шафии, Малики и Ханбали (1x Тень)';

  @override
  String get settingsFiqhStandardSub =>
      'Длина тени = длине предмета (1x). Мнение Шафии, Малики, Ханбали и большинства.';

  @override
  String get settingsFiqhHanafiTitle => 'Ханафи';

  @override
  String get settingsFiqhHanafiDesc => 'Ханафитский Мазхаб (2x Тень)';

  @override
  String get settingsFiqhHanafiSub =>
      'Длина тени = удвоенной длине предмета (2x). По ханафитскому мазхабу.';

  @override
  String get settingsPreAdhanReminder => 'Напоминание Перед Азаном';

  @override
  String get settingsBatteryRestricted => 'Ограничено';

  @override
  String get settingsBatteryExemptDesc =>
      'Исключено — Азан будет звучать строго вовремя';

  @override
  String get settingsBatteryNotExemptDesc =>
      'Не исключено — Уведомления могут задерживаться';

  @override
  String get settingsCheckBatteryNow => 'Проверить Статус Сейчас';

  @override
  String get settingsCheckBatterySubtitle =>
      'Проверить разрешения фоновой работы';

  @override
  String get settingsWarnBattery => 'Предупреждать при Оптимизации';

  @override
  String get settingsWarnBatterySubtitle =>
      'Оповещать, если система включит энергосбережение';

  @override
  String get settingsOpenSourceFootnote =>
      '100% Бесплатно и Открытый Код • Без Рекламы • Без Сбора Данных';

  @override
  String get settingsAsrCalculationTitle => 'Метод Расчета Асра (Фикх)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'Выберите мазхаб для расчета начала времени Асра.';

  @override
  String get adhanVoiceMakkah => 'Мекка (Али Мулла)';

  @override
  String get adhanVoiceMadinah => 'Медина (Абдул Маджид)';

  @override
  String get adhanVoiceAlAqsa => 'Аль-Акса (Ясир ад-Даусари)';

  @override
  String get adhanVoiceSoft => 'Традиционный Мягкий Тон';

  @override
  String get calcMethodUmmAlQura => 'Умм аль-Кура (Саудовская Аравия)';

  @override
  String get calcMethodMwl => 'Всемирная исламская лига (MWL)';

  @override
  String get calcMethodEgyptian => 'Египетское генеральное управление';

  @override
  String get calcMethodIsna => 'ISNA (Северная Америка)';

  @override
  String get calcMethodKarachi => 'Университет исламских наук Карачи';

  @override
  String get calcMethodDubai => 'Департамент исламских дел Дубая';

  @override
  String get calcMethodDiyanet => 'Диянет (Турция)';

  @override
  String get calcMethodSingapore => 'MUIS (Сингапур)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'Совершайте намаз так, как вы видели меня совершающим его';

  @override
  String get learnSalahAuthenticBadge => 'РУКОВОДСТВО ПО ДОСТОВЕРНОЙ СУННЕ';

  @override
  String get learnSalahSearchPlaceholder =>
      'Поиск позы, шага или довода из хадиса...';

  @override
  String get learnSalahLearningModules => 'ОБУЧАЮЩИЕ МОДУЛИ';

  @override
  String get learnSalahStepByStepTitle => 'Пошаговое Руководство по Намазу';

  @override
  String get learnSalahStepByStepSubtitle =>
      '10 Последовательных шагов с 2D иллюстрациями и доводами';

  @override
  String get learnSalahPillarsTitle => '14 Столпов Намаза (Арканы)';

  @override
  String get learnSalahPillarsSubtitle =>
      'Обязательные основы, без которых намаз недействителен';

  @override
  String get learnSalahObligationsTitle =>
      '8 Обязательных Действий (Ваджибаты)';

  @override
  String get learnSalahObligationsSubtitle =>
      'Обязанности, восполняемые саджда ас-сахв';

  @override
  String get learnSalahSunanTitle => 'Сунны Намаза (Сунан)';

  @override
  String get learnSalahSunanSubtitle =>
      'Словесные и практические сунны Пророка Мухаммада ﷺ';

  @override
  String get learnSalahInvalidatorsTitle => 'Действия, Нарушающие Намаз';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'Факторы, делающие намаз недействительным';

  @override
  String get learnSalahForbiddenTimesTitle => 'Запретные Времена для Намаза';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'Времена, когда дополнительные намазы строго запрещены';

  @override
  String get madhabShafi => 'Шафии';

  @override
  String get madhabHanafi => 'Ханафи';

  @override
  String get eventIslamicNewYear => 'Мусульманский Новый год';

  @override
  String get eventTasua => 'День Тасуа';

  @override
  String get eventAshura => 'День Ашура';

  @override
  String get eventMawlid => 'Мавлид ан-Наби ﷺ';

  @override
  String get eventIsraMiraj => 'Исра и Мирадж';

  @override
  String get eventMidShaban => 'Ночь Бараат (середина Шаабана)';

  @override
  String get eventRamadanStart => 'Начало месяца Рамадан';

  @override
  String get eventBattleOfBadr => 'Битва при Бадре';

  @override
  String get eventLaylatAlQadr => 'Ночь Предопределения (Ляйлят аль-Кадр)';

  @override
  String get eventEidAlFitr => 'Ураза-байрам (Ид аль-Фитр)';

  @override
  String get eventShawwalSixFasting => 'Шесть дней поста месяца Шавваль';

  @override
  String get eventDhuAlHijjahStart => 'Начало месяца Зуль-Хиджа';

  @override
  String get eventDayOfArafah => 'День Арафа';

  @override
  String get eventEidAlAdha => 'Курбан-байрам (Ид аль-Адха)';

  @override
  String get eventDaysOfTashreeq => 'Дни Ташрика';

  @override
  String get qiblaHeadingTrue => 'ИСТИННЫЙ КУРС';

  @override
  String get qiblaBearingLabel => 'НАПРАВЛЕНИЕ КИБЛЫ';

  @override
  String get qiblaRetryLocation => 'Повторить определение геопозиции';

  @override
  String get qiblaCalibClearInterference => 'Устраните магнитные помехи';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'Отойдите от металлических предметов, компьютеров или магнитных чехлов.';

  @override
  String get qiblaCalibHoldFlat => 'Держите устройство горизонтально';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'Держите телефон ровно параллельно земле для максимальной точности.';

  @override
  String get qiblaCalibFigure8 => 'Опишите в воздухе восьмерку';

  @override
  String get qiblaCalibFigure8Desc =>
      'Плавно опишите телефоном в воздухе фигуру в форме восьмерки.';

  @override
  String get stepPrevious => 'Назад';

  @override
  String get stepNext => 'Следующий шаг';

  @override
  String get stepFinishGuide => 'Завершить';

  @override
  String get widgetAddAnother => 'Добавить еще';

  @override
  String get widgetOpenSettings => 'Открыть настройки';

  @override
  String get widgetGoToHome => 'На главную';

  @override
  String get trackerWeeklyRate => 'Недельная норма';

  @override
  String get trackerMonthlyRate => 'Месячная норма';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total Намазов';
  }

  @override
  String get tasbihHadithTitle => 'ХАДИС О ПОМИНАНИИ АЛЛАХА НА ПАЛЬЦАХ';

  @override
  String get tasbihHadithText =>
      '«Неуклонно поминайте Аллаха, прославляйте Его, возвеличивайте Его святость и ведите счёт на кончиках пальцев, ибо они будут спрошены в Судный день и заговорят.»';

  @override
  String get tasbihHadithReference => '— Сунан Абу Давуд 1496';

  @override
  String get dhikrSubhanAllah => 'Субханаллах';

  @override
  String get dhikrAlhamdulillah => 'Альхамдулиллях';

  @override
  String get dhikrAllahuAkbar => 'Аллаху Акбар';

  @override
  String get dhikrAstaghfirullah => 'Астагфируллах';

  @override
  String get dhikrLaIlahaIllallah => 'Ля иляха илляллах';

  @override
  String get dhikrSubhanAllahTranslation =>
      'Пречист Аллах от всякого недостатка и несовершенства';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'Вся хвала и благодарность принадлежит только Аллаху';

  @override
  String get dhikrAllahuAkbarTranslation =>
      'Аллах — Превелик, превыше всего сущего';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'Прошу прощения у Аллаха и каюсь перед Ним';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'Нет истинного божества, кроме Единого Аллаха';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'Далее: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'Свой выбор';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'Свой ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'Установить свою цель';

  @override
  String get tasbihTargetHint => 'Введите целевое число (напр. 50)';

  @override
  String get tasbihCancel => 'Отмена';

  @override
  String get tasbihSetTarget => 'Применить';

  @override
  String tasbihLap(String lap) {
    return 'Круг $lap';
  }
}
