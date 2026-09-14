// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'همراه نماز';

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
  String get remaining => 'باقی‌مانده';

  @override
  String get statusPrayed => 'Prayed';

  @override
  String get statusMissed => 'Missed';

  @override
  String get statusPending => 'Pending';

  @override
  String get qiblaCompassTitle => 'قبله‌نما';

  @override
  String get qiblaCalibrate => 'کالیبراسیون';

  @override
  String get qiblaFacingKaaba => 'جهت دقیق به سمت کعبه مشرفه';

  @override
  String get tasbihTitle => 'تسبیح دیجیتال';

  @override
  String get tasbihReset => 'بازنشانی';

  @override
  String get tasbihAutoNext => 'انتقال خودکار';

  @override
  String get tasbihBestOnFingers => 'شمارش تسبیح با سرانگشتان سنت است';

  @override
  String get guidanceCategory => 'راهنمایی و هدایت';

  @override
  String get learnSalah => 'آموزش نماز';

  @override
  String get learnSalahSubtitle => 'آموزش صفة الصلاة پیامبر ﷺ با احادیث صحیح';

  @override
  String get savedItems => 'ذخیره‌شده‌ها';

  @override
  String get savedItemsSubtitle => 'احادیث، آیات و ادعیه';

  @override
  String get prayerTracker => 'ثبت نمازها';

  @override
  String get prayerTrackerSubtitle => 'مشاهده آمار و پیگیری نمازها';

  @override
  String get widgetsTitle => 'ابزارک‌ها';

  @override
  String get widgetsSubtitle => 'افزودن ابزارک به صفحه اصلی';

  @override
  String get openSourcePrivacy => 'متن‌باز و حریم خصوصی';

  @override
  String get openSourcePrivacySubtitle =>
      'کاملاً آفلاین، بدون رهگیری و غیرتجاری';

  @override
  String get themeMode => 'حالت پوسته';

  @override
  String get themeSystem => 'سیستم';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeDark => 'تاریک';

  @override
  String notificationPrayerTitle(String prayer) {
    return 'نماز $prayer';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return 'وقت اذان $prayer فرا رسید. برای اقامه نماز آماده شوید.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'یادآوری اول وقت — نماز $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return '۱۵ دقیقه از وقت $prayer گذشت. آیا نماز خوانده‌اید؟';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'هشدار — ۳۰ دقیقه تا پایان وقت $prayer';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return 'تنها ۳۰ دقیقه تا پایان وقت نماز $prayer باقی مانده است.';
  }

  @override
  String get notificationDailyReflectionTitle => 'تأمل روزانه';

  @override
  String get notificationTestTitle => 'اعلان همراه نماز';

  @override
  String get notificationTestBody =>
      'اعلان‌ها و صدای اذان با موفقیت تنظیم شدند.';

  @override
  String get onboardingChooseLanguage => 'زبان خود را انتخاب کنید';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'زبان مورد نظر خود را برای اوقات شرعی، راهنمایی و تدبر انتخاب کنید.';

  @override
  String get onboardingWelcomeTitle => 'به همراه نماز خوش آمدید';

  @override
  String get onboardingWelcomeBody =>
      'همراه مطمئن و بدون حواس‌پرتی شما برای اوقات شرعی دقیق، قبله‌نما و سنت‌های نبوی.';

  @override
  String get onboardingSwipeTitle => 'سوایپ از لبه چپ برای منو';

  @override
  String get onboardingSwipeBody =>
      'از لبه سمت چپ صفحه سوایپ کنید تا ذخیره‌شده‌ها و تنظیمات ظاهر شوند.';

  @override
  String get onboardingSunnahTitle => 'سنت صحیح و هدایت اسلامی';

  @override
  String get onboardingSunnahBody =>
      'دسترسی به آیات روزانه، احادیث صحیح، دعاهای ماثوره و صفة الصلاة.';

  @override
  String get onboardingCustomizationTitle => 'قبله، تسبیح و تنظیمات';

  @override
  String get onboardingCustomizationBody =>
      'استفاده از قبله‌نما، تسبیح شمار دیجیتال و تنظیمات مذهب و روش‌های محاسبه.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$current از $total';
  }

  @override
  String get onboardingSkip => 'رد شدن';

  @override
  String get onboardingNext => 'بعدی';

  @override
  String get onboardingGetStarted => 'شروع کنید';

  @override
  String get systemDefault => 'پیش‌فرض سیستم';

  @override
  String get moreLanguages => 'سایر زبان‌ها';

  @override
  String get searchLanguagePlaceholder => 'جستجوی زبان...';

  @override
  String get settingsTitle => 'تنظیمات';

  @override
  String get settingsLanguage => 'زبان';

  @override
  String get settingsLanguageSubtitle => 'تغییر زبان برنامه';

  @override
  String get onboardingTrustTitle => 'تعهد و امانت ما به شما';

  @override
  String get onboardingTrustSubtitle =>
      'خالصانه برای رضای خداوند — بدون تبلیغات، بدون رهگیری، ۱۰۰٪ خصوصی.';

  @override
  String get onboardingTrustOfflineTitle => 'محاسبه ۱۰۰٪ محلی و آفلاین';

  @override
  String get onboardingTrustOfflineDesc =>
      'موقعیت مکانی و سوابق نماز شما هرگز از گوشی شما خارج نمی‌شود. محاسبات نجومی کاملاً آفلاین انجام می‌شود.';

  @override
  String get onboardingTrustNoAdsTitle => 'بدون هیچ‌گونه تبلیغات';

  @override
  String get onboardingTrustNoAdsDesc =>
      'بدون بنر، بدون پنجره‌های بازشو و بدون هیچ مانعی در عبادت شما.';

  @override
  String get onboardingTrustNoTrackingTitle => 'عدم ردیابی و ذخیره داده';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'هیچ ابزار تحلیلی یا رهگیری کاربری در برنامه وجود ندارد.';

  @override
  String get onboardingTrustFreeTitle => 'رایگان برای همیشه';

  @override
  String get onboardingTrustFreeDesc =>
      'به عنوان صدقه جاریه برای امت اسلامی ساخته شده است.';

  @override
  String get onboardingFeaturesTitle => 'امکانات کلیدی برنامه';

  @override
  String get onboardingFeaturesSubtitle =>
      'اوقات دقیق شرعی، سنت نبوی و ابزارهای آرامش‌بخش عبادی.';

  @override
  String get onboardingFeaturePrayerTitle => 'اوقات دقیق شرعی';

  @override
  String get onboardingFeaturePrayerDesc =>
      'محاسبه نجومی دقیق زاویه خورشید به همراه یادآوری نوافل.';

  @override
  String get onboardingFeatureQiblaTitle => 'قبله‌نمای هوشمند';

  @override
  String get onboardingFeatureQiblaDesc =>
      'جهت‌یابی دقیق به سمت کعبه مشرفه با لرزش لمسی.';

  @override
  String get onboardingFeatureTasbihTitle => 'تسبیح دیجیتال لمسی';

  @override
  String get onboardingFeatureTasbihDesc =>
      'شبیه‌سازی دانه‌های تسبیح با اذکار مأثوره و بازخورد هپتیک.';

  @override
  String get onboardingFeatureSunnahTitle => 'احادیث و ادعیه معتبر';

  @override
  String get onboardingFeatureSunnahDesc =>
      'آیات روزانه قرآن و احادیث صحیح با ارجاع به منابع معتبر.';

  @override
  String get onboardingFeatureQiblaAligned => 'رو به قبله • مکه مکرمه';

  @override
  String get onboardingFeatureTapToCount => 'برای شمارش روی صفحه ضربه بزنید';

  @override
  String get onboardingPermissionsTitle => 'تنظیمات اولیه';

  @override
  String get onboardingPermissionsSubtitle =>
      'برای دقت در اوقات شرعی و پخش به موقع اذان مجوزها را فعال کنید.';

  @override
  String get onboardingPermLocationTitle => 'موقعیت مکانی';

  @override
  String get onboardingPermLocationDesc =>
      'صرفاً درون دستگاه شما برای محاسبه طلوع و غروب آفتاب استفاده می‌شود.';

  @override
  String get onboardingPermNotifTitle => 'اعلان اذان و نماز';

  @override
  String get onboardingPermNotifDesc =>
      'ارسال یادآوری و اذان در زمان دقیق نمازها.';

  @override
  String get onboardingPermBatteryTitle => 'عملکرد پس‌زمینه پایدار';

  @override
  String get onboardingPermBatteryDesc =>
      'جلوگیری از توقف اذان صبح توسط بهینه‌ساز باتری اندروید.';

  @override
  String get onboardingPermGrant => 'اعطای مجوز';

  @override
  String get onboardingPermGranted => 'فعال شد';

  @override
  String get onboardingPermEnableLater => 'تنظیم بعدی در تنظیمات';

  @override
  String get onboardingDedicationVerse =>
      '«همانا نماز بر مؤمنان در اوقات معین واجب شده است.»';

  @override
  String get onboardingDedicationReference => 'سوره نساء (۱۰۳)';

  @override
  String get onboardingBeginJourney => 'بسم الله • شروع کنید';

  @override
  String get onboardingReplayTour => 'بازپخش راهنمای برنامه';

  @override
  String get onboardingReplayTourSubtitle =>
      'مرور مجدد امکانات و تعهد حریم خصوصی';

  @override
  String get onboardingBack => 'بازگشت';

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
  String get settingsBatteryExempt => 'مستثنی';

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
  String get categoryAll => 'همه';

  @override
  String get categoryHadith => 'احادیث';

  @override
  String get categoryAyah => 'آیات';

  @override
  String get categoryDua => 'دعاها';

  @override
  String get categoryMorning => 'صبح';

  @override
  String get categoryEvening => 'عصر';

  @override
  String get categoryAfterPrayer => 'بعد از نماز';

  @override
  String get categoryForgiveness => 'استغفار و توبه';

  @override
  String get categoryProtection => 'حفاظت';

  @override
  String get categoryDaily => 'روزمره';

  @override
  String get categoryTravel => 'سفر';

  @override
  String get noSavedItems => 'هنوز موردی ذخیره نشده است';

  @override
  String get noSavedItemsSubtitle =>
      'برای ذخیره محتوا در اینجا، روی نشانک ضربه بزنید.';

  @override
  String get searchPlaceholder => 'جستجوی ادعیه، ترجمه یا منابع...';

  @override
  String get sunnahPrayerHeader => 'نماز سنت';

  @override
  String get sunnahFajrDesc => '۲ رکعت سنت قبل از فرض';

  @override
  String get sunnahDhuhrDesc => '۴ رکعت قبل و ۲ رکعت بعد از فرض';

  @override
  String get sunnahAsrDesc => '۴ رکعت سنت قبل از فرض';

  @override
  String get sunnahMaghribDesc => '۲ رکعت سنت بعد از فرض';

  @override
  String get sunnahIshaDesc => '۲ رکعت بعد از فرض + ۳ رکعت وتر';

  @override
  String get forbiddenNaflHeader => 'اوقات مکروه برای نماز نفل';

  @override
  String get forbiddenNaflBody =>
      'نمازهای نفل در هنگام طلوع خورشید (~۲۰ دقیقه)، استوای آفتاب (~۱۰ دقیقه قبل از ظهر) و غروب آفتاب (~۲۰ دقیقه قبل از مغرب) مکروه و ممنوع است. قضای نمازهای واجب صحیح است. (صحیح مسلم ۸۳۱)';

  @override
  String get forbiddenNaflSunriseHeader => 'وقت مکروه • طلوع خورشید';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'خورشید در حال طلوع است ($startTime – $endTime). نماز نفل تا بلند شدن کامل خورشید ممنوع است. (صحیح مسلم ۸۳۱)';
  }

  @override
  String get forbiddenNaflZawalHeader => 'وقت مکروه • زوال آفتاب';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'خورشید در وسط آسمان است ($startTime – $endTime). نماز نفل در این زمان مکروه است. (صحیح مسلم ۸۳۱)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'وقت مکروه • غروب خورشید';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'خورشید در حال غروب است ($startTime – $endTime). نماز نفل تا پایان غروب ممنوع است. (صحیح مسلم ۸۳۱)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return 'وقت نماز $prayer هنوز فرا نرسیده است ($time)';
  }

  @override
  String get timeStart => 'شروع';

  @override
  String get timeEnd => 'پایان';

  @override
  String get onboardingShowcasePrayerTitle => 'اوقات شرعی با دقت نجومی';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'محاسبه دقیق اوقات نماز به صورت ۱۰۰٪ آفلاین با روش‌های معتبر جهانی.';

  @override
  String get onboardingShowcaseQiblaTitle => 'قطب‌نمای دقیق قبله';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'یافتن جهت دقیق کعبه در هر نقطه از کره زمین با سنسور ژیروسکوپ.';

  @override
  String get onboardingShowcaseTasbihTitle => 'صلوات‌شمار و تسبیح دیجیتال';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'شمارنده ذکر با بازخورد لرزشی و تعویض خودکار اذکار.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'تأملات روزانه، احادیث و ادعیه';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'آیات نورانی قرآن، احادیث صحیح و معتبر و دعاهای روزمره اهل‌بیت و پیامبر (ص).';

  @override
  String get settingsPrayerNotifications => 'اعلان‌های اوقات شرعی';

  @override
  String get settingsAdhanReciterTone => 'مؤذن و نوای اذان';

  @override
  String get settingsDailyReminderTime => 'زمان اعلان تأمل روزانه';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count ویجت فعال';
  }

  @override
  String get settingsFiqhAsr => 'فقه (محاسبه وقت عصر)';

  @override
  String get settingsFiqhStandardTitle => 'شافعی / جمهور (پیش‌فرض)';

  @override
  String get settingsFiqhStandardDesc => 'شافعی، مالکی و حنبلی (۱ برابر سایه)';

  @override
  String get settingsFiqhStandardSub =>
      'طول سایه = ۱ برابر ارتفاع شیء. طبق نظر اکثریت فقها و نهادهای اسلامی.';

  @override
  String get settingsFiqhHanafiTitle => 'حنفی';

  @override
  String get settingsFiqhHanafiDesc => 'فقه حنفی (۲ برابر سایه)';

  @override
  String get settingsFiqhHanafiSub =>
      'طول سایه = ۲ برابر ارتفاع شیء. طبق نظر فقه حنفی.';

  @override
  String get settingsPreAdhanReminder => 'یادآوری پیش از اذان';

  @override
  String get settingsBatteryRestricted => 'محدود';

  @override
  String get settingsBatteryExemptDesc =>
      'مستثنی — اعلان‌های اذان به موقع پخش می‌شوند';

  @override
  String get settingsBatteryNotExemptDesc =>
      'محدود — ممکن است در پس‌زمینه تأخیر داشته باشد';

  @override
  String get settingsCheckBatteryNow => 'بررسی وضعیت اکنون';

  @override
  String get settingsCheckBatterySubtitle => 'بررسی دسترسی‌های پس‌زمینه سیستم';

  @override
  String get settingsWarnBattery => 'هشدار در صورت بهینه‌سازی مجدد';

  @override
  String get settingsWarnBatterySubtitle =>
      'هشدار در صورت فعال شدن حالت ذخیره انرژی';

  @override
  String get settingsOpenSourceFootnote =>
      '۱۰۰٪ رایگان و متن‌باز • بدون تبلیغات • بدون جمع‌آوری داده';

  @override
  String get settingsAsrCalculationTitle => 'روش محاسبه وقت عصر (فقه)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'مذهب فقهی را برای تعیین وقت نماز عصر انتخاب کنید.';

  @override
  String get adhanVoiceMakkah => 'مکه مکرمه (علی ملا)';

  @override
  String get adhanVoiceMadinah => 'مدینه منوره (عبدالمجید)';

  @override
  String get adhanVoiceAlAqsa => 'مسجد الاقصی (یاسر الدوسری)';

  @override
  String get adhanVoiceSoft => 'نوای سنتی ملایم';

  @override
  String get calcMethodUmmAlQura => 'ام‌القری (عربستان سعودی)';

  @override
  String get calcMethodMwl => 'رابطة العالم الاسلامی';

  @override
  String get calcMethodEgyptian => 'سازمان عمومی مساحی مصر';

  @override
  String get calcMethodIsna => 'جامعه اسلامی آمریکای شمالی (ISNA)';

  @override
  String get calcMethodKarachi => 'دانشگاه علوم اسلامی کراچی';

  @override
  String get calcMethodDubai => 'اداره امور اسلامی دبی';

  @override
  String get calcMethodDiyanet => 'دیانت (ترکیه)';

  @override
  String get calcMethodSingapore => 'شورای اسلامی سنگاپور (MUIS)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'نماز بخوانید همان‌گونه که دیدید من نماز می‌خوانم';

  @override
  String get learnSalahAuthenticBadge => 'راهنمای سنت صحیح نبوی';

  @override
  String get learnSalahSearchPlaceholder =>
      'جستجوی حالت، مرحله یا دلیل حدیثی...';

  @override
  String get learnSalahLearningModules => 'بخش‌های آموزشی';

  @override
  String get learnSalahStepByStepTitle => 'راهنمای گام‌به‌گام نماز نبوی';

  @override
  String get learnSalahStepByStepSubtitle =>
      '۱۰ مرحله متوالی همراه با تصاویر و دلایل';

  @override
  String get learnSalahPillarsTitle => '۱۴ رکن نماز (ارکان)';

  @override
  String get learnSalahPillarsSubtitle =>
      'پایه‌های اصلی نماز که هرگز ساقط نمی‌شوند';

  @override
  String get learnSalahObligationsTitle => '۸ واجب نماز (واجبات)';

  @override
  String get learnSalahObligationsSubtitle =>
      'اعمال واجبی که با سجده سهو جبران می‌شوند';

  @override
  String get learnSalahSunanTitle => 'سنت‌های نماز (سنن)';

  @override
  String get learnSalahSunanSubtitle => 'سنت‌های گفتاری و رفتاری پیامبر ﷺ';

  @override
  String get learnSalahInvalidatorsTitle => 'مبطلات نماز';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'مواردی که نماز را باطل می‌کنند و اعاده لازم است';

  @override
  String get learnSalahForbiddenTimesTitle => 'اوقات ممنوعه برای نماز';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'زمان‌هایی که خواندن نماز نفل در آنها نهی شده است';

  @override
  String get madhabShafi => 'شافعی';

  @override
  String get madhabHanafi => 'حنفی';

  @override
  String get eventIslamicNewYear => 'آغاز سال نو هجری قمری';

  @override
  String get eventTasua => 'تاسوعا';

  @override
  String get eventAshura => 'عاشورا';

  @override
  String get eventMawlid => 'میلاد پیامبر اکرم ﷺ';

  @override
  String get eventIsraMiraj => 'معراج پیامبر ﷺ';

  @override
  String get eventMidShaban => 'نیمه شعبان';

  @override
  String get eventRamadanStart => 'آغاز ماه مبارک رمضان';

  @override
  String get eventBattleOfBadr => 'غزوه بدر';

  @override
  String get eventLaylatAlQadr => 'شب قدر';

  @override
  String get eventEidAlFitr => 'عید سعید فطر';

  @override
  String get eventShawwalSixFasting => 'شش روز روزه شوال';

  @override
  String get eventDhuAlHijjahStart => 'آغاز ماه ذی‌الحجه';

  @override
  String get eventDayOfArafah => 'روز عرفه';

  @override
  String get eventEidAlAdha => 'عید سعید قربان';

  @override
  String get eventDaysOfTashreeq => 'ایام تشریق';

  @override
  String get qiblaHeadingTrue => 'جهت واقعی';

  @override
  String get qiblaBearingLabel => 'زاویه قبله';

  @override
  String get qiblaRetryLocation => 'تلاش مجدد برای موقعیت مکانی';

  @override
  String get qiblaCalibClearInterference => 'دوری از تداخل مغناطیسی';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'از میزهای فلزی، رایانه‌ها یا قاب‌های مغناطیسی فاصله بگیرید.';

  @override
  String get qiblaCalibHoldFlat => 'دستگاه را افقی نگه دارید';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'برای حداکثر دقت، گوشی را صاف و موازی زمین نگه دارید.';

  @override
  String get qiblaCalibFigure8 => 'حرکت شکل 8 انجام دهید';

  @override
  String get qiblaCalibFigure8Desc =>
      'گوشی را به آرامی به صورت شکل عدد 8 در هوا حرکت دهید تا قطب‌نما تنظیم شود.';

  @override
  String get stepPrevious => 'قبلی';

  @override
  String get stepNext => 'مرحله بعد';

  @override
  String get stepFinishGuide => 'پایان راهنما';

  @override
  String get widgetAddAnother => 'افزودن دیگری';

  @override
  String get widgetOpenSettings => 'باز کردن تنظیمات';

  @override
  String get widgetGoToHome => 'رفتن به صفحه اصلی';

  @override
  String get trackerWeeklyRate => 'میانگین هفتگی';

  @override
  String get trackerMonthlyRate => 'میانگین ماهانه';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total نماز';
  }

  @override
  String get tasbihHadithTitle => 'حدیث نبوی درباره تسبیح با سرانگشتان';

  @override
  String get tasbihHadithText =>
      '«بر شما باد به تسبیح، تهلیل و تقدیس خداوند، و اذکار را با سرانگشتان خود بشمارید؛ زیرا در روز قیامت از انگشتان بازخواست خواهد شد و به سخن درمی‌آیند.»';

  @override
  String get tasbihHadithReference => '— سنن ابی داود ۱۴۹۶';

  @override
  String get dhikrSubhanAllah => 'سبحان الله';

  @override
  String get dhikrAlhamdulillah => 'الحمد لله';

  @override
  String get dhikrAllahuAkbar => 'الله اکبر';

  @override
  String get dhikrAstaghfirullah => 'استغفر الله';

  @override
  String get dhikrLaIlahaIllallah => 'لا اله الا الله';

  @override
  String get dhikrSubhanAllahTranslation =>
      'خداوند از هر عیب و نقصی منزه و پاک است';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'همه ستایش‌ها و سپاس‌ها مخصوص خداوند است';

  @override
  String get dhikrAllahuAkbarTranslation =>
      'خداوند بزرگ‌تر و والاتر از هر چیز است';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'از پیشگاه خداوند طلب آمرزش و مغفرت دارم';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'هیچ معبودی جز خدای یگانه به حق نیست';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'بعدی: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'سفارشی';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'سفارشی ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'تعیین هدف سفارشی';

  @override
  String get tasbihTargetHint => 'تعداد مورد نظر را وارد کنید (مثلاً ۵۰)';

  @override
  String get tasbihCancel => 'لغو';

  @override
  String get tasbihSetTarget => 'ثبت هدف';

  @override
  String tasbihLap(String lap) {
    return 'دور $lap';
  }
}
