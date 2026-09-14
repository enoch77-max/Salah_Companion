// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'صلاۃ کمپینین';

  @override
  String get navHome => 'ہوم';

  @override
  String get navDuas => 'دعائیں';

  @override
  String get navTasbih => 'تسبیح';

  @override
  String get navQibla => 'قبلہ';

  @override
  String get navCalendar => 'کیلنڈر';

  @override
  String get prayerFajr => 'فجر';

  @override
  String get prayerSunrise => 'طلوع آفتاب';

  @override
  String get prayerDhuhr => 'ظہر';

  @override
  String get prayerAsr => 'عصر';

  @override
  String get prayerMaghrib => 'مغرب';

  @override
  String get prayerIsha => 'عشاء';

  @override
  String get upcomingPrayer => 'اگلی نماز';

  @override
  String get currentSalah => 'موجودہ وقت';

  @override
  String get remaining => 'باقی وقت';

  @override
  String get statusPrayed => 'ادا شدہ';

  @override
  String get statusMissed => 'قضا';

  @override
  String get statusPending => 'منتظر';

  @override
  String get qiblaCompassTitle => 'قبلہ قطب نما';

  @override
  String get qiblaCalibrate => 'کیلیبریٹ کریں';

  @override
  String get qiblaFacingKaaba => 'کعبہ شریف کی بالکل درست سمت';

  @override
  String get tasbihTitle => 'ڈیجیٹل تسبیح';

  @override
  String get tasbihReset => 'ری سیٹ';

  @override
  String get tasbihAutoNext => 'خودکار اگلا';

  @override
  String get tasbihBestOnFingers => 'انگلیوں کے پوروں پر گننا مسنون ہے';

  @override
  String get guidanceCategory => 'رہنمائی';

  @override
  String get learnSalah => 'طریقہ نماز';

  @override
  String get learnSalahSubtitle =>
      'مسنون طریقہ نماز اور صحیح احادیث کے مطابق سیکھیں';

  @override
  String get savedItems => 'محفوظ شدہ';

  @override
  String get savedItemsSubtitle => 'احادیث، آیات اور دعائیں';

  @override
  String get prayerTracker => 'نماز ٹریکر';

  @override
  String get prayerTrackerSubtitle => 'نماز کے اعداد و شمار دیکھیں';

  @override
  String get widgetsTitle => 'وجیٹس';

  @override
  String get widgetsSubtitle => 'ہوم اسکرین پر وجیٹس شامل کریں';

  @override
  String get openSourcePrivacy => 'اوپن سورس اور پرائیویسی';

  @override
  String get openSourcePrivacySubtitle =>
      'مکمل آف لائن، بغیر ٹریکنگ اور غیر تجارتی';

  @override
  String get themeMode => 'تھیم موڈ';

  @override
  String get themeSystem => 'سسٹم';

  @override
  String get themeLight => 'لائٹ';

  @override
  String get themeDark => 'ڈارک';

  @override
  String notificationPrayerTitle(String prayer) {
    return '$prayer کی نماز';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return '$prayer کا وقت ہو گیا ہے۔ نماز کی تیاری کریں۔';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'اوّل وقت کی یاد دہانی — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return '$prayer کے وقت میں سے 15 منٹ گزر چکے ہیں۔ کیا آپ نے نماز پڑھ لی؟';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'اہم — $prayer کے وقت میں 30 منٹ باقی ہیں';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return '$prayer کی نماز کا وقت ختم ہونے میں صرف 30 منٹ باقی ہیں۔';
  }

  @override
  String get notificationDailyReflectionTitle => 'روزانہ کا تدبر';

  @override
  String get notificationTestTitle => 'صلاۃ کمپینین الرٹ';

  @override
  String get notificationTestBody =>
      'نوٹیفکیشن اور اذان کی آواز کامیابی سے سیٹ ہو چکی ہے۔';

  @override
  String get onboardingChooseLanguage => 'اپنی زبان منتخب کریں';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'نماز کے اوقات، رہنمائی اور روزانہ کے اذکار کے لیے زبان کا انتخاب کریں۔';

  @override
  String get onboardingWelcomeTitle => 'صلاۃ کمپینین میں خوش آمدید';

  @override
  String get onboardingWelcomeBody =>
      'نماز کے درست اوقات، قبلہ رخ اور مستند احادیث و سنن کے لیے آپ کا بااعتماد ساتھی۔';

  @override
  String get onboardingSwipeTitle => 'مینو کے لیے بائیں طرف سے سوائپ کریں';

  @override
  String get onboardingSwipeBody =>
      'محفوظ شدہ اشیاء اور نماز کے اعداد و شمار کے لیے اسکرین کے بائیں کنارے سے سوائپ کریں۔';

  @override
  String get onboardingSunnahTitle => 'مستند سنت اور شرعی رہنمائی';

  @override
  String get onboardingSunnahBody =>
      'روزانہ قرآنی آیات، صحیح احادیث، مسنون دعائیں اور نماز کے طریقہ کار تک رسائی۔';

  @override
  String get onboardingCustomizationTitle => 'قبلہ، تسبیح اور ترتیبات';

  @override
  String get onboardingCustomizationBody =>
      'قبلہ قطب نما، ڈیجیٹل تسبیح اور فقہی حساب کے طریقے کسی بھی وقت ترتیب دیں۔';

  @override
  String onboardingStepOf(int current, int total) {
    return '$total میں سے $current';
  }

  @override
  String get onboardingSkip => 'چھوڑیں';

  @override
  String get onboardingNext => 'اگلا';

  @override
  String get onboardingGetStarted => 'شروع کریں';

  @override
  String get systemDefault => 'سسٹم ڈیفالٹ';

  @override
  String get moreLanguages => 'مزید زبانیں';

  @override
  String get searchLanguagePlaceholder => 'زبان تلاش کریں...';

  @override
  String get settingsTitle => 'ترتیبات';

  @override
  String get settingsLanguage => 'زبان';

  @override
  String get settingsLanguageSubtitle => 'ایپلی کیشن کی زبان تبدیل کریں';

  @override
  String get onboardingTrustTitle => 'ہمارا آپ سے مقدس عہد';

  @override
  String get onboardingTrustSubtitle =>
      'خالص اللہ کی رضا کے لیے — بغیر کسی اشتہار، بغیر کسی ٹریکنگ کے، 100% پرائیویٹ۔';

  @override
  String get onboardingTrustOfflineTitle => '100% محفوظ اور آف لائن';

  @override
  String get onboardingTrustOfflineDesc =>
      'آپ کا مقام اور نماز کا ریکارڈ کبھی آپ کے فون سے باہر نہیں جاتا۔ تمام فلکیاتی حسابات بغیر انٹرنیٹ کے ہوتے ہیں۔';

  @override
  String get onboardingTrustNoAdsTitle => 'کوئی اشتہار نہیں، کبھی بھی';

  @override
  String get onboardingTrustNoAdsDesc =>
      'نہ کوئی بینر، نہ کوئی پوپ اپ، آپ کی عبادت میں کوئی خلل نہیں۔';

  @override
  String get onboardingTrustNoTrackingTitle => 'صفر ٹریکنگ اور اینالیٹکس';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'کوئی فائر بیس ٹریکنگ نہیں، کوئی ذاتی ڈیٹا اکٹھا نہیں کیا جاتا۔';

  @override
  String get onboardingTrustFreeTitle => 'امت کے لیے ہمیشہ مفت';

  @override
  String get onboardingTrustFreeDesc =>
      'صدقہ جاریہ کے طور پر بنایا گیا، کوئی فیس یا سبسکرپشن نہیں۔';

  @override
  String get onboardingFeaturesTitle => 'نمایاں خصوصیات';

  @override
  String get onboardingFeaturesSubtitle =>
      'نماز کے درست اوقات، مستند سنن اور پرسکون عبادات کے ٹولز۔';

  @override
  String get onboardingFeaturePrayerTitle => 'درست ترین فلکیاتی اوقات';

  @override
  String get onboardingFeaturePrayerDesc =>
      'سورج کے زاویوں پر مبنی مستند اوقات اور سنت نمازوں کی یاد دہانی۔';

  @override
  String get onboardingFeatureQiblaTitle => 'قبلہ نما قطب نما';

  @override
  String get onboardingFeatureQiblaDesc =>
      'خانہ کعبہ کی درست سمت کے لیے مقناطیسی سینسر کے ساتھ لائیو قطب نما۔';

  @override
  String get onboardingFeatureTasbihTitle => 'ڈیجیٹل تسبیح کاؤنٹر';

  @override
  String get onboardingFeatureTasbihDesc =>
      'مسنون اذکار اور انگلیوں کے احساس جیسے ہیپٹک فیڈ بیک کے ساتھ۔';

  @override
  String get onboardingFeatureSunnahTitle => 'مستند احادیث اور دعائیں';

  @override
  String get onboardingFeatureSunnahDesc =>
      'صحیح بخاری و مسلم کی مستند احادیث اور روزمرہ کی دعائیں مکمل حوالہ جات کے ساتھ۔';

  @override
  String get onboardingFeatureQiblaAligned => 'قبلہ رخ • مکہ مکرمہ';

  @override
  String get onboardingFeatureTapToCount => 'کہیں بھی ٹیپ کریں یا سوائپ کریں';

  @override
  String get onboardingPermissionsTitle => 'آسان سیٹ اپ';

  @override
  String get onboardingPermissionsSubtitle =>
      'نماز کے اوقات اور اذان کے بروقت نوٹیفکیشن کے لیے اجازت دیں۔';

  @override
  String get onboardingPermLocationTitle => 'درست لوکیشن';

  @override
  String get onboardingPermLocationDesc =>
      'صرف آپ کے فون میں نماز کے اوقات کا حساب لگانے کے لیے استعمال ہوتی ہے۔';

  @override
  String get onboardingPermNotifTitle => 'اذان اور نماز کے الرٹس';

  @override
  String get onboardingPermNotifDesc =>
      'وقت پر اذان اور سنتوں کے یاد دہانی کے پیغامات۔';

  @override
  String get onboardingPermBatteryTitle => 'پس منظر میں درست الارم';

  @override
  String get onboardingPermBatteryDesc =>
      'اینڈرائیڈ بیٹری آپٹیمائزیشن کو فجر کے الارم روکنے سے روکتا ہے۔';

  @override
  String get onboardingPermGrant => 'اجازت دیں';

  @override
  String get onboardingPermGranted => 'اجازت مل گئی';

  @override
  String get onboardingPermEnableLater => 'بعد میں ترتیبات سے ترتیب دیں';

  @override
  String get onboardingDedicationVerse =>
      '”بے شک نماز مومنوں پر مقررہ وقتوں میں فرض ہے۔“';

  @override
  String get onboardingDedicationReference => 'سورۃ النساء (۱۰۳)';

  @override
  String get onboardingBeginJourney => 'بسم اللہ • شروع کریں';

  @override
  String get onboardingReplayTour => 'تعارفی ٹور دوبارہ دیکھیں';

  @override
  String get onboardingReplayTourSubtitle =>
      'ایپ کی خصوصیات اور رازداری کا عہد دوبارہ دیکھیں';

  @override
  String get onboardingBack => 'پیچھے';

  @override
  String get navTracker => 'ٹریکر';

  @override
  String get prayerSunset => 'غروب آفتاب';

  @override
  String get statusNotPrayed => 'ادا نہیں کی';

  @override
  String get statusUpcoming => 'اگلی نماز';

  @override
  String get statusNotYet => 'ابھی نہیں';

  @override
  String get todaysPrayers => 'آج کی نمازیں';

  @override
  String startsAt(String time) {
    return 'شروع $time';
  }

  @override
  String periodRange(String start, String end) {
    return 'وقت: $start – $end';
  }

  @override
  String get locating => 'مقام کا تعین ہو رہا ہے...';

  @override
  String get drawerNavigation => 'نیویگیشن';

  @override
  String get drawerOpenSourcePrivacy => 'اوپن سورس اور رازداری';

  @override
  String get drawerQuickActions => 'فوری اقدامات';

  @override
  String get prayerAndReflection => 'نماز اور تذکیر';

  @override
  String get settingsNotifications => 'اطلاعات اور اذان';

  @override
  String get settingsCalculationFiqh => 'حساب اور فقہ';

  @override
  String get settingsBattery => 'بیٹری کی ترتیبات';

  @override
  String get settingsAppearance => 'ظاہری شکل اور وائبریشن';

  @override
  String get settingsGuideOnboarding => 'رہنمائی اور تعارف';

  @override
  String get settingsAboutPrivacy => 'معلومات اور رازداری';

  @override
  String get settingsAdhanAudio => 'اذان کی آواز';

  @override
  String get settingsAdhanVoice => 'مؤذن کی آواز';

  @override
  String get settingsDailyReflection => 'روزانہ کا سبق';

  @override
  String get settingsDailyReflectionSubtitle =>
      'صبح کی آیت اور حدیث کی یاد دہانی';

  @override
  String get settingsCalculationMethod => 'اوقاتِ نماز کا طریقہ';

  @override
  String get settingsJuristicMethod => 'عصر کا فقہی طریقہ (مسلک)';

  @override
  String get settingsHighLatitude => 'بلند عرض البلد کا اصول';

  @override
  String get settingsHijriAdjustment => 'ہجری تاریخ کی ترتیب';

  @override
  String get settingsBatteryHeader => 'پس منظر میں چلنا';

  @override
  String get settingsBatteryDesc =>
      'فجر کے الارم کے بروقت بجنے کے لیے ایپ کو بیٹری آپٹمائزیشن سے مستثنیٰ کریں۔';

  @override
  String get settingsBatteryExempt => 'مستثنیٰ';

  @override
  String get settingsBatteryNotExempt =>
      'بیٹری کی بچت: فعال (ٹھیک کرنے کے لیے کلک کریں)';

  @override
  String get settingsCheckBattery => 'بیٹری کی حالت چیک کریں';

  @override
  String get settingsTheme => 'تھیم کا انداز';

  @override
  String get settingsHaptics => 'ہپٹک فیڈ بیک';

  @override
  String get settingsHapticsSubtitle => 'کلک اور ایونٹس پر وائبریشن';

  @override
  String get settingsPrivacyPolicy => 'رازداری کی پالیسی';

  @override
  String get settingsOpenSource => '100% اوپن سورس (GitHub)';

  @override
  String get settingsTerms => 'شرائط و ضوابط';

  @override
  String get settingsCalculationDocs => 'حساب کی درستگی اور عمومی سوالات';

  @override
  String get settingsCalculationDocsSubtitle =>
      'اوقات نماز اور شمسی زاویوں کے حساب کے بارے میں جانیں';

  @override
  String get sunnahMuakkadah => 'سنت مؤکدہ';

  @override
  String get sunnahGhairMuakkadah => 'سنت غیر مؤکدہ';

  @override
  String get sunnahWajibWitr => 'سنت اور واجب وتر';

  @override
  String get sunnahVoluntary => 'نفل نماز';

  @override
  String get categoryAll => 'سب';

  @override
  String get categoryHadith => 'احادیث';

  @override
  String get categoryAyah => 'قرآنی آیات';

  @override
  String get categoryDua => 'دعائیں و اذکار';

  @override
  String get categoryMorning => 'صبح';

  @override
  String get categoryEvening => 'شام';

  @override
  String get categoryAfterPrayer => 'نماز کے بعد';

  @override
  String get categoryForgiveness => 'توبہ و استغفار';

  @override
  String get categoryProtection => 'حفاظت و پناہ';

  @override
  String get categoryDaily => 'روزمرہ';

  @override
  String get categoryTravel => 'سفر';

  @override
  String get noSavedItems => 'ابھی تک کوئی محفوظ کردہ مواد نہیں ہے';

  @override
  String get noSavedItemsSubtitle =>
      'محفوظ کرنے کے لیے بک مارک آئیکن پر ٹیپ کریں۔';

  @override
  String get searchPlaceholder => 'دعائیں، ترجمہ یا حوالہ تلاش کریں...';

  @override
  String get sunnahPrayerHeader => 'سنت نماز';

  @override
  String get sunnahFajrDesc => 'فرض سے پہلے ۲ رکعت سنت مؤکدہ';

  @override
  String get sunnahDhuhrDesc => 'فرض سے پہلے ۴ رکعت اور بعد میں ۲ رکعت سنت';

  @override
  String get sunnahAsrDesc => 'فرض سے پہلے ۴ رکعت سنت غیر مؤکدہ';

  @override
  String get sunnahMaghribDesc => 'فرض کے بعد ۲ رکعت سنت مؤکدہ';

  @override
  String get sunnahIshaDesc => 'فرض کے بعد ۲ رکعت سنت + ۳ رکعت وتر';

  @override
  String get forbiddenNaflHeader => 'نفل نماز کے ممنوع اوقات';

  @override
  String get forbiddenNaflBody =>
      'طلوع آفتاب (~۲۰ منٹ)، زوال آفتاب (~۱۰ منٹ) اور غروب آفتاب (~۲۰ منٹ) کے دوران نفل نماز پڑھنا ممنوع ہے۔ قضا نماز جائز ہے۔ (صحیح مسلم ۸۳۱)';

  @override
  String get forbiddenNaflSunriseHeader => 'ممنوع وقت • طلوع آفتاب';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'سورج نکل رہا ہے ($startTime – $endTime)۔ سورج مکمل بلند ہونے تک نفل نماز ممنوع ہے۔ (صحیح مسلم ۸۳۱)';
  }

  @override
  String get forbiddenNaflZawalHeader => 'ممنوع وقت • زوال آفتاب';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'سورج عین نصف النہار پر ہے ($startTime – $endTime)۔ اس وقت نفل نماز ممنوع ہے۔ (صحیح مسلم ۸۳۱)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'ممنوع وقت • غروب آفتاب';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'سورج ڈوب رہا ہے ($startTime – $endTime)۔ غروب مکمل ہونے تک نفل نماز ممنوع ہے۔ (صحیح مسلم ۸۳۱)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return '$prayer کا وقت ابھی شروع نہیں ہوا ($time)';
  }

  @override
  String get timeStart => 'شروع';

  @override
  String get timeEnd => 'ختم';

  @override
  String get onboardingShowcasePrayerTitle => 'نماز کے بالکل درست اوقات';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'سو فیصد آف لائن عالمی مستند طریقوں کے مطابق نماز کے اوقات کا درست حساب۔';

  @override
  String get onboardingShowcaseQiblaTitle => 'قبلہ نما قطب نما';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'دنیا کے کسی بھی کونے سے خانہ کعبہ کی درست سمت کی باآسانی رہنمائی۔';

  @override
  String get onboardingShowcaseTasbihTitle => 'ڈیجیٹل تسبیح و اذکار';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'لمسی ارتعاش (ہپٹک) کے ساتھ اذکار و تسبیحات کے لیے خوبصورت ڈیجیٹل کاؤنٹر۔';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'روزانہ آیات، احادیث اور مسنون دعائیں';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'مستند اردو تراجم کے ساتھ صحیح احادیث، قرآنی آیات اور روزمرہ کی دعائیں۔';

  @override
  String get settingsPrayerNotifications => 'نماز کی اطلاعات';

  @override
  String get settingsAdhanReciterTone => 'مؤذن اور اذان کی آواز';

  @override
  String get settingsDailyReminderTime => 'تأمل کا نوٹیفکیشن';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count لائیو وجٹس';
  }

  @override
  String get settingsFiqhAsr => 'فقہ (وقت عصر)';

  @override
  String get settingsFiqhStandardTitle => 'شافعی / جمہور (طے شدہ)';

  @override
  String get settingsFiqhStandardDesc => 'شافعی، مالکی، حنبلی (ایک مثل سایا)';

  @override
  String get settingsFiqhStandardSub =>
      'سائے کی لمبائی = چیز کے برابر (ایک مثل)۔ شافعی، مالکی، حنبلی اور اکثر اسلامی ادارے۔';

  @override
  String get settingsFiqhHanafiTitle => 'حنفی';

  @override
  String get settingsFiqhHanafiDesc => 'حنفی مسلک (دو مثل سایا)';

  @override
  String get settingsFiqhHanafiSub =>
      'سائے کی لمبائی = چیز سے دوگنا (دو مثل)۔ امام ابو حنیفہ رحمہ اللہ کے فقہ حنفی کے مطابق۔';

  @override
  String get settingsPreAdhanReminder => 'اذان سے پہلے یاد دہانی';

  @override
  String get settingsBatteryRestricted => 'محدود';

  @override
  String get settingsBatteryExemptDesc =>
      'مستثنیٰ — اذان کی اطلاعات وقت پر ملیں گی';

  @override
  String get settingsBatteryNotExemptDesc =>
      'محدود — پس منظر میں نوٹیفکیشن میں تاخیر ہو سکتی ہے';

  @override
  String get settingsCheckBatteryNow => 'ابھی صورتحال چیک کریں';

  @override
  String get settingsCheckBatterySubtitle => 'بیک گراؤنڈ پرمیشنز کی تصدیق کریں';

  @override
  String get settingsWarnBattery => 'دوبارہ محدود ہونے پر متنبہ کریں';

  @override
  String get settingsWarnBatterySubtitle => 'او ایس بیٹری سیور آن کرنے پر الرٹ';

  @override
  String get settingsOpenSourceFootnote =>
      'سو فیصد مفت اور اوپن سورس • بغیر اشتہارات • ڈیٹا جمع نہیں کیا جاتا';

  @override
  String get settingsAsrCalculationTitle => 'طریقۂ حسابِ عصر (فقہ)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'نمازِ عصر کے وقت کے لیے فقہی مسلک منتخب کریں۔';

  @override
  String get adhanVoiceMakkah => 'مکہ مکرمہ (علی ملا)';

  @override
  String get adhanVoiceMadinah => 'مدینہ منورہ (عبد المجید)';

  @override
  String get adhanVoiceAlAqsa => 'مسجد اقصی (یاسر الدوسری)';

  @override
  String get adhanVoiceSoft => 'روایتی پرسکون آواز';

  @override
  String get calcMethodUmmAlQura => 'ام القریٰ (سعودی عرب)';

  @override
  String get calcMethodMwl => 'رابطۃ العالم الاسلامی';

  @override
  String get calcMethodEgyptian => 'مصری جنرل اتھارٹی برائے سروے';

  @override
  String get calcMethodIsna => 'اسنا (شمالی امریکہ)';

  @override
  String get calcMethodKarachi => 'جامعۃ العلوم الاسلامیہ کراچی';

  @override
  String get calcMethodDubai => 'دبئی (متحدہ عرب امارات)';

  @override
  String get calcMethodDiyanet => 'دیانت (ترکی)';

  @override
  String get calcMethodSingapore => 'مجلس اگاما اسلام سنگاپور (MUIS)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'نماز ایسے پڑھو جیسے مجھے پڑھتے دیکھا';

  @override
  String get learnSalahAuthenticBadge => 'صحیح سنت گائیڈ';

  @override
  String get learnSalahSearchPlaceholder =>
      'نماز کی ہیئت، مرحلہ یا حدیث کا حوالہ تلاش کریں...';

  @override
  String get learnSalahLearningModules => 'تعلیمی ماڈیولز';

  @override
  String get learnSalahStepByStepTitle => 'مرحلہ وار نبوی نماز گائیڈ';

  @override
  String get learnSalahStepByStepSubtitle =>
      '10 مسلسل مراحل تصویری خاکوں اور دلائل کے ساتھ';

  @override
  String get learnSalahPillarsTitle => 'نماز کے 14 ارکان (فرائض)';

  @override
  String get learnSalahPillarsSubtitle =>
      'نماز کی بنیادی بنیادیں جو کسی حال میں ساقط نہیں ہوتیں';

  @override
  String get learnSalahObligationsTitle => 'نماز کے 8 واجبات';

  @override
  String get learnSalahObligationsSubtitle =>
      'واجب اعمال جو سجدہ سہو سے پورے کیے جاتے ہیں';

  @override
  String get learnSalahSunanTitle => 'نماز کی سنتیں (اقوال و افعال)';

  @override
  String get learnSalahSunanSubtitle => 'نبی کریم ﷺ کی قولی و فعلی سنتیں';

  @override
  String get learnSalahInvalidatorsTitle => 'نماز کو باطل کرنے والی چیزیں';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'وہ امور جن سے نماز ٹوٹ جاتی ہے اور اعادہ لازم ہوتا ہے';

  @override
  String get learnSalahForbiddenTimesTitle => 'نماز کے ممنوعہ اوقات';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'وہ اوقات جن میں نفل نماز پڑھنا ممنوع ہے';

  @override
  String get madhabShafi => 'شافعی';

  @override
  String get madhabHanafi => 'حنفی';

  @override
  String get eventIslamicNewYear => 'اسلامی نیا سال';

  @override
  String get eventTasua => 'تاسوعاء';

  @override
  String get eventAshura => 'یوم عاشوراء';

  @override
  String get eventMawlid => 'میلاد النبی ﷺ';

  @override
  String get eventIsraMiraj => 'شب معراج';

  @override
  String get eventMidShaban => 'شب برأت (نصف شعبان)';

  @override
  String get eventRamadanStart => 'رمضان المبارک کا پہلا دن';

  @override
  String get eventBattleOfBadr => 'غزوہ بدر';

  @override
  String get eventLaylatAlQadr => 'لیلتہ القدر';

  @override
  String get eventEidAlFitr => 'عید الفطر';

  @override
  String get eventShawwalSixFasting => 'شوال کے چھ روزے';

  @override
  String get eventDhuAlHijjahStart => 'ذوالحجہ کا پہلا دن';

  @override
  String get eventDayOfArafah => 'یوم عرفہ';

  @override
  String get eventEidAlAdha => 'عید الاضحیٰ';

  @override
  String get eventDaysOfTashreeq => 'ایام تشریق';

  @override
  String get qiblaHeadingTrue => 'حقیقی سمت';

  @override
  String get qiblaBearingLabel => 'قبلہ رخ';

  @override
  String get qiblaRetryLocation => 'مقام کی دوبارہ کوشش کریں';

  @override
  String get qiblaCalibClearInterference => 'مقناطیسی مداخلت سے دور رہیں';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'دھاتی میزوں، کمپیوٹرز یا مقناطیسی کور سے دور رہیں۔';

  @override
  String get qiblaCalibHoldFlat => 'فون کو بالکل سیدھا رکھیں';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'درست ترین سمت کے لیے فون کو زمین کے متوازی سیدھا رکھیں۔';

  @override
  String get qiblaCalibFigure8 => 'فون کو 8 کی شکل میں گھمائیں';

  @override
  String get qiblaCalibFigure8Desc =>
      'کمپاس کی درستگی کے لیے فون کو ہوا میں انگریزی ہندسے 8 کی شکل میں گھمائیں۔';

  @override
  String get stepPrevious => 'پچھلا';

  @override
  String get stepNext => 'اگلا مرحلہ';

  @override
  String get stepFinishGuide => 'مکمل کریں';

  @override
  String get widgetAddAnother => 'ایک اور شامل کریں';

  @override
  String get widgetOpenSettings => 'ترتیبات کھولیں';

  @override
  String get widgetGoToHome => 'مرکزی صفحہ پر جائیں';

  @override
  String get trackerWeeklyRate => 'ہفتہ وار تناسب';

  @override
  String get trackerMonthlyRate => 'ماہانہ تناسب';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total نمازیں';
  }

  @override
  String get tasbihHadithTitle => 'تسبیح کے فضائل پر حدیثِ نبوی';

  @override
  String get tasbihHadithText =>
      '”تسبیح، تہلیل اور تقدیس کو لازم پکڑو اور انگلیوں کے پوروں پر گنو، کیونکہ ان سے قیامت کے دن بازپرس ہوگی اور ان سے بولنے کو کہا جائے گا۔“';

  @override
  String get tasbihHadithReference => '— سنن ابی داؤد 1496';

  @override
  String get dhikrSubhanAllah => 'سبحان اللہ';

  @override
  String get dhikrAlhamdulillah => 'الحمد للہ';

  @override
  String get dhikrAllahuAkbar => 'اللہ اکبر';

  @override
  String get dhikrAstaghfirullah => 'استغفر اللہ';

  @override
  String get dhikrLaIlahaIllallah => 'لا الہ الا اللہ';

  @override
  String get dhikrSubhanAllahTranslation => 'اللہ ہر عیب اور نقص سے پاک ہے';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'تمام تعریفیں اور شکر صرف اللہ ہی کے لیے ہیں';

  @override
  String get dhikrAllahuAkbarTranslation => 'اللہ سب سے بڑا اور بلند و برتر ہے';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'میں اللہ سے اپنے گناہوں کی بخشش مانگتا ہوں';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'اللہ کے سوا کوئی سچا معبود نہیں ہے';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'اگلا: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'اپنی مرضی';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'اپنی مرضی ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'مخصوص ہدف مقرر کریں';

  @override
  String get tasbihTargetHint => 'ہدف نمبر درج کریں (مثلاً 50)';

  @override
  String get tasbihCancel => 'منسوخ';

  @override
  String get tasbihSetTarget => 'ہدف مقرر کریں';

  @override
  String tasbihLap(String lap) {
    return 'چکر $lap';
  }
}
