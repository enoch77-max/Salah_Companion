// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'رفيق الصلاة';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navDuas => 'الأدعية';

  @override
  String get navTasbih => 'التسبيح';

  @override
  String get navQibla => 'القبلة';

  @override
  String get navCalendar => 'التقويم';

  @override
  String get prayerFajr => 'الفجر';

  @override
  String get prayerSunrise => 'الشروق';

  @override
  String get prayerDhuhr => 'الظهر';

  @override
  String get prayerAsr => 'العصر';

  @override
  String get prayerMaghrib => 'المغرب';

  @override
  String get prayerIsha => 'العشاء';

  @override
  String get upcomingPrayer => 'الصلاة القادمة';

  @override
  String get currentSalah => 'وقت الصلاة الحالي';

  @override
  String get remaining => 'المتبقي';

  @override
  String get statusPrayed => 'تمت الصلاة';

  @override
  String get statusMissed => 'فائتة';

  @override
  String get statusPending => 'قيد الانتظار';

  @override
  String get qiblaCompassTitle => 'بوصلة القبلة';

  @override
  String get qiblaCalibrate => 'معايرة البوصلة';

  @override
  String get qiblaFacingKaaba => 'اتجاه الكعبة المشرفة بدقة';

  @override
  String get tasbihTitle => 'المسبحة الإلكترونية';

  @override
  String get tasbihReset => 'إعادة ضبط';

  @override
  String get tasbihAutoNext => 'الانتقال التلقائي';

  @override
  String get tasbihBestOnFingers => 'عقد التسبيح بالأنامل سنة';

  @override
  String get guidanceCategory => 'الإرشاد والتوجيه';

  @override
  String get learnSalah => 'صفة الصلاة';

  @override
  String get learnSalahSubtitle =>
      'تعلم صفة صلاة النبي ﷺ بالسنن والأحاديث الصحيحة';

  @override
  String get savedItems => 'المحفوظات';

  @override
  String get savedItemsSubtitle => 'الأحاديث والآيات والأدعية';

  @override
  String get prayerTracker => 'سجل الصلوات';

  @override
  String get prayerTrackerSubtitle => 'متابعة أداء الصلوات وإحصائياتها';

  @override
  String get widgetsTitle => 'الويدجت';

  @override
  String get widgetsSubtitle => 'إضافة ويدجت للشاشة الرئيسية';

  @override
  String get openSourcePrivacy => 'المصدر المفتوح والخصوصية';

  @override
  String get openSourcePrivacySubtitle =>
      'يعمل كلياً دون اتصال، بدون تتبع، وغير تجاري';

  @override
  String get themeMode => 'المظهر';

  @override
  String get themeSystem => 'حسب النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String notificationPrayerTitle(String prayer) {
    return 'صلاة $prayer';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return 'حان الآن موعد أذان $prayer. حي على الصلاة.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'تذكير أول الوقت — صلاة $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return 'مضت ١٥ دقيقة من وقت $prayer. هل صليت؟';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'تنبيه — بقي ٣٠ دقيقة على انتهاء $prayer';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return 'بقي فقط ٣٠ دقيقة على خروج وقت صلاة $prayer. بادر بأدائها.';
  }

  @override
  String get notificationDailyReflectionTitle => 'تأمل اليوم';

  @override
  String get notificationTestTitle => 'تنبيه رفيق الصلاة';

  @override
  String get notificationTestBody => 'تم ضبط الإشعارات وصوت الأذان بنجاح.';

  @override
  String get onboardingChooseLanguage => 'اختر لغتك';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'حدد لغتك المفضلة لمواقيت الصلاة، والتوجيه، والتأملات اليومية.';

  @override
  String get onboardingWelcomeTitle => 'مرحبًا بك في رفيق الصلاة';

  @override
  String get onboardingWelcomeBody =>
      'رفيقك النقي الخالي من التشتيت لمواقيت الصلاة الدقيقة، وتأملات اليوم، واتجاه القبلة، والسنن النبوية الصحيحة.';

  @override
  String get onboardingSwipeTitle => 'اسحب من الحافة اليسرى للقائمة';

  @override
  String get onboardingSwipeBody =>
      'اسحب من أقصى حافة الشاشة للوصول المباشر للمحفوظات، وسجل الصلاة، والمظهر في أي مكان.';

  @override
  String get onboardingSunnahTitle => 'السنن النبوية والإرشاد الصحيح';

  @override
  String get onboardingSunnahBody =>
      'آيات قرآنية يومية، وأحاديث صحيحة، وأدعية مأثورة، وصفة الصلاة بسند موثوق.';

  @override
  String get onboardingCustomizationTitle => 'القبلة والتسبيح والتخصيص';

  @override
  String get onboardingCustomizationBody =>
      'بوصلة القبلة، والمسبحة الإلكترونية، وإعدادات طرق الحساب والمذاهب والأذان.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$current من $total';
  }

  @override
  String get onboardingSkip => 'تخطي';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingGetStarted => 'ابدأ الآن';

  @override
  String get systemDefault => 'لغة النظام';

  @override
  String get moreLanguages => 'لغات أخرى';

  @override
  String get searchLanguagePlaceholder => 'بحث عن لغة...';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsLanguageSubtitle => 'تغيير لغة التطبيق';

  @override
  String get onboardingTrustTitle => 'عهدنا وأمانتنا إليك';

  @override
  String get onboardingTrustSubtitle =>
      'صُمم خالصاً لوجه الله تعالى — بلا إعلانات، بلا تتبع، وبخصوصية تامة 100%.';

  @override
  String get onboardingTrustOfflineTitle => 'حساب محلي 100% وبخصوصية مطلقة';

  @override
  String get onboardingTrustOfflineDesc =>
      'موقعك وسجلات صلواتك لا تغادر جهازك أبداً. جميع الحسابات الفلكية تُجرى داخل الهاتف دون أي اتصال بالإنترنت.';

  @override
  String get onboardingTrustNoAdsTitle => 'بلا أي إعلانات نهائياً';

  @override
  String get onboardingTrustNoAdsDesc =>
      'لا لافتات تجارية، ولا نوافذ منبثقة، ولا مشتتات بينك وبين مناجاة ربك.';

  @override
  String get onboardingTrustNoTrackingTitle => 'بلا تتبع أو جمع بيانات';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'لا نستخدم أدوات تتبع، ولا نجمع بيانات شخصية، ولا تحليلات سلوكية إطلاقاً.';

  @override
  String get onboardingTrustFreeTitle => 'مجاني دائماً لعموم الأمة';

  @override
  String get onboardingTrustFreeDesc =>
      'وقف خالص وصدقة جارية. لا اشتراكات، لا ميزات مدفوعة، ولا أي ربح مادي.';

  @override
  String get onboardingFeaturesTitle => 'استكشف ميزات التطبيق';

  @override
  String get onboardingFeaturesSubtitle =>
      'دقة متناهية في المواقيت، وسنن نبوية مؤكدة، وأدوات متقنة للعبادة.';

  @override
  String get onboardingFeaturePrayerTitle => 'دقة فلكية فائقة';

  @override
  String get onboardingFeaturePrayerDesc =>
      'حساب دقيق لمدار الشمس وفق مختلف الهيئات الفلكية مع تنبيهات السنن.';

  @override
  String get onboardingFeatureQiblaTitle => 'بوصلة القبلة الدقيقة';

  @override
  String get onboardingFeatureQiblaDesc =>
      'تحديد اتجاه الكعبة المشرفة مع معايرة جيومغناطيسية دقيقة واهتزاز تفاعلي.';

  @override
  String get onboardingFeatureTasbihTitle => 'مسبحة إلكترونية بلمس حيوي';

  @override
  String get onboardingFeatureTasbihDesc =>
      'محاكاة حبات التسبيح مع أذكار نبوية واهتزاز لمسي يحاكي العقد بالأنامل.';

  @override
  String get onboardingFeatureSunnahTitle => 'السنة الصحيحة والأدعية';

  @override
  String get onboardingFeatureSunnahDesc =>
      'خواطر قرآنية يومية وأحاديث صحيحة موثقة من أمهات كتب الحديث الشريف.';

  @override
  String get onboardingFeatureQiblaAligned => 'باتجاه القبلة • مكة المكرمة';

  @override
  String get onboardingFeatureTapToCount => 'انقر في أي مكان أو اسحب للتسبيح';

  @override
  String get onboardingPermissionsTitle => 'إعداد سهل وسلس';

  @override
  String get onboardingPermissionsSubtitle =>
      'مَنح الأذونات يضمن دقة حساب المواقيت وتنبيهات الأذان في وقتها.';

  @override
  String get onboardingPermLocationTitle => 'الموقع الجغرافي';

  @override
  String get onboardingPermLocationDesc =>
      'يُستخدم داخل جهازك فقط لحساب زوايا الشروق والغروب بدقة متناهية.';

  @override
  String get onboardingPermNotifTitle => 'تنبيهات الأذان والصلوات';

  @override
  String get onboardingPermNotifDesc =>
      'لإرسال الأذان في حينه وتذكيرك بالسنن الرواتب والأذكار.';

  @override
  String get onboardingPermBatteryTitle => 'التشغيل الخلفي الثابت';

  @override
  String get onboardingPermBatteryDesc =>
      'يمنع النظام من إيقاف منبه صلاة الفجر والمهام المجدولة عند منتصف الليل.';

  @override
  String get onboardingPermGrant => 'منح الإذن';

  @override
  String get onboardingPermGranted => 'تم التفعيل';

  @override
  String get onboardingPermEnableLater => 'الضبط لاحقاً من الإعدادات';

  @override
  String get onboardingDedicationVerse =>
      '﴿إِنَّ الصَّلَاةَ كَانَتْ عَلَى الْمُؤْمِنِينَ كِتَابًا مَّوْقُوتًا﴾';

  @override
  String get onboardingDedicationReference => 'سورة النساء (١٠٣)';

  @override
  String get onboardingBeginJourney => 'بسم الله • ابدأ الآن';

  @override
  String get onboardingReplayTour => 'إعادة الجولة التعريفية';

  @override
  String get onboardingReplayTourSubtitle =>
      'استكشف ميزات التطبيق وميثاق الخصوصية مرة أخرى';

  @override
  String get onboardingBack => 'رجوع';

  @override
  String get navTracker => 'المتابعة';

  @override
  String get prayerSunset => 'الغروب';

  @override
  String get statusNotPrayed => 'لم تصلى';

  @override
  String get statusUpcoming => 'القادمة';

  @override
  String get statusNotYet => 'ليس بعد';

  @override
  String get todaysPrayers => 'صلوات اليوم';

  @override
  String startsAt(String time) {
    return 'يبدأ عند $time';
  }

  @override
  String periodRange(String start, String end) {
    return 'الفترة: $start – $end';
  }

  @override
  String get locating => 'جاري تحديد الموقع...';

  @override
  String get drawerNavigation => 'التنقل';

  @override
  String get drawerOpenSourcePrivacy => 'المصدر المفتوح والخصوصية';

  @override
  String get drawerQuickActions => 'إجراءات سريعة';

  @override
  String get prayerAndReflection => 'الصلاة والتأمل';

  @override
  String get settingsNotifications => 'الإشعارات والأذان';

  @override
  String get settingsCalculationFiqh => 'الحساب والفقه';

  @override
  String get settingsBattery => 'تحسين البطارية';

  @override
  String get settingsAppearance => 'المظهر والاهتزاز';

  @override
  String get settingsGuideOnboarding => 'الدليل والتعريف';

  @override
  String get settingsAboutPrivacy => 'حول التطبيق والخصوصية';

  @override
  String get settingsAdhanAudio => 'صوت الأذان';

  @override
  String get settingsAdhanVoice => 'صوت المؤذن';

  @override
  String get settingsDailyReflection => 'التأمل اليومي';

  @override
  String get settingsDailyReflectionSubtitle => 'تذكير صباحي بآية وحديث شريف';

  @override
  String get settingsCalculationMethod => 'طريقة الحساب';

  @override
  String get settingsJuristicMethod => 'مذهب حساب صلاة العصر';

  @override
  String get settingsHighLatitude => 'قاعدة خطوط العرض العليا';

  @override
  String get settingsHijriAdjustment => 'تعديل التاريخ الهجري';

  @override
  String get settingsBatteryHeader => 'التشغيل في الخلفية';

  @override
  String get settingsBatteryDesc =>
      'استثنِ التطبيق من تحسين البطارية لضمان دقة منبهات الفجر والأذان.';

  @override
  String get settingsBatteryExempt => 'مستثنى';

  @override
  String get settingsBatteryNotExempt => 'تحسين البطارية: مقيد (انقر للإصلاح)';

  @override
  String get settingsCheckBattery => 'فحص حالة البطارية';

  @override
  String get settingsTheme => 'المظهر';

  @override
  String get settingsHaptics => 'الاستجابة اللمسية';

  @override
  String get settingsHapticsSubtitle => 'اهتزازات تفاعلية عند النقر';

  @override
  String get settingsPrivacyPolicy => 'سياسة الخصوصية';

  @override
  String get settingsOpenSource => 'مفتوح المصدر ١٠٠٪ (GitHub)';

  @override
  String get settingsTerms => 'الشروط والأحكام';

  @override
  String get settingsCalculationDocs => 'دقة الحساب والأسئلة الشائعة';

  @override
  String get settingsCalculationDocsSubtitle =>
      'تعرف على كيفية حساب مواقيت الصلاة والزوايا الفلكية';

  @override
  String get sunnahMuakkadah => 'سنة مؤكدة';

  @override
  String get sunnahGhairMuakkadah => 'سنة غير مؤكدة';

  @override
  String get sunnahWajibWitr => 'سنة والوتر واجب';

  @override
  String get sunnahVoluntary => 'صلاة نافلة';

  @override
  String get categoryAll => 'الكل';

  @override
  String get categoryHadith => 'أحاديث';

  @override
  String get categoryAyah => 'آيات';

  @override
  String get categoryDua => 'أدعية';

  @override
  String get categoryMorning => 'الصباح';

  @override
  String get categoryEvening => 'المساء';

  @override
  String get categoryAfterPrayer => 'بعد الصلاة';

  @override
  String get categoryForgiveness => 'الاستغفار';

  @override
  String get categoryProtection => 'الحفظ والوقاية';

  @override
  String get categoryDaily => 'يومية';

  @override
  String get categoryTravel => 'السفر';

  @override
  String get noSavedItems => 'لا توجد عناصر محفوظة حتى الآن';

  @override
  String get noSavedItemsSubtitle =>
      'انقر على رمز الإشارة المرجعية لحفظ أي محتوى هنا.';

  @override
  String get searchPlaceholder => 'ابحث في الأدعية أو الترجمات أو المصادر...';

  @override
  String get sunnahPrayerHeader => 'صلاة السنة';

  @override
  String get sunnahFajrDesc => 'ركعتان قبل الفريضة (سنة مؤكدة)';

  @override
  String get sunnahDhuhrDesc => '٤ ركعات قبل الفريضة و ٢ بعدها';

  @override
  String get sunnahAsrDesc => '٤ ركعات قبل الفريضة (سنة غير مؤكدة)';

  @override
  String get sunnahMaghribDesc => 'ركعتان بعد الفريضة (سنة مؤكدة)';

  @override
  String get sunnahIshaDesc => 'ركعتان بعد الفريضة + ٣ ركعات وتر';

  @override
  String get forbiddenNaflHeader => 'أوقات النهي عن صلاة النوافل';

  @override
  String get forbiddenNaflBody =>
      'تُكره صلاة النفل عند شروق الشمس (~٢٠ دقيقة)، وعند استواء الشمس في كبد السماء قبل الظهر (~١٠ دقائق)، وعند غروب الشمس (~٢٠ دقيقة). وتصح قضاء الفوائت. (صحيح مسلم ٨٣١)';

  @override
  String get forbiddenNaflSunriseHeader => 'وقت النهي عن النوافل • الشروق';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'الشمس تشرق الآن ($startTime – $endTime). يُنهى عن صلاة النفل حتى ترتفع الشمس. (صحيح مسلم ٨٣١)';
  }

  @override
  String get forbiddenNaflZawalHeader =>
      'وقت النهي عن النوافل • الزوال (الظهيرة)';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'الشمس في كبد السماء ($startTime – $endTime). يُنهى عن صلاة النفل في هذا الوقت. (صحيح مسلم ٨٣١)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'وقت النهي عن النوافل • الغروب';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'الشمس تغرب الآن ($startTime – $endTime). يُنهى عن صلاة النفل حتى يكتمل الغروب. (صحيح مسلم ٨٣١)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return 'لم يحن وقت صلاة $prayer بعد ($time)';
  }

  @override
  String get timeStart => 'البداية';

  @override
  String get timeEnd => 'النهاية';

  @override
  String get onboardingShowcasePrayerTitle => 'مواقيت صلاة فلكية دقيقة';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'حساب دقيق للمواقيت محلياً ١٠٠٪ دون إنترنت وفق معايير الهيئات الإسلامية العالمية.';

  @override
  String get onboardingShowcaseQiblaTitle => 'بوصلة القبلة الدقيقة';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'تحديد اتجاه الكعبة المشرفة من أي مكان في العالم باستخدام مستشعرات الجيروسكوب.';

  @override
  String get onboardingShowcaseTasbihTitle => 'مسبحة إلكترونية متطورة';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'عداد تسبيح تفاعلي بالاهتزاز التكتيكي مع انتقال تلقائي للأذكار.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'خواطر إيمانية، أحاديث وأدعية';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'آيات قرآنية مختارة، أحاديث نبوية صحيحة ومأثورة، وأدعية يومية مباركة.';

  @override
  String get settingsPrayerNotifications => 'إشعارات الصلاة';

  @override
  String get settingsAdhanReciterTone => 'مؤذن ونغمة الأذان';

  @override
  String get settingsDailyReminderTime => 'إشعار التأمل اليومي';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count ويدجت نشطة';
  }

  @override
  String get settingsFiqhAsr => 'الفقه (وقت العصر)';

  @override
  String get settingsFiqhStandardTitle => 'الشافعي / الجمهور (افتراضي)';

  @override
  String get settingsFiqhStandardDesc =>
      'الشافعي، المالكي، والحنبلي (ظل المثل)';

  @override
  String get settingsFiqhStandardSub =>
      'طول الظل = مثل طول الشيء. مذهب الشافعي والمالكي والحنبلي وأغلب الهيئات الإسلامية.';

  @override
  String get settingsFiqhHanafiTitle => 'الحنفي';

  @override
  String get settingsFiqhHanafiDesc => 'المذهب الحنفي (مثلي الظل)';

  @override
  String get settingsFiqhHanafiSub =>
      'طول الظل = مثلي طول الشيء. وفق مذهب الإمام أبي حنيفة رحمه الله.';

  @override
  String get settingsPreAdhanReminder => 'تنبيه ما قبل الأذان';

  @override
  String get settingsBatteryRestricted => 'مقيد';

  @override
  String get settingsBatteryExemptDesc =>
      'مستثنى — ستعمل تنبيهات الأذان بدقة وموثوقية';

  @override
  String get settingsBatteryNotExemptDesc =>
      'غير مستثنى — قد تتأخر التنبيهات في الخلفية';

  @override
  String get settingsCheckBatteryNow => 'التحقق من الحالة الآن';

  @override
  String get settingsCheckBatterySubtitle =>
      'التحقق من أذونات العمل في الخلفية';

  @override
  String get settingsWarnBattery => 'التنبيه عند إعادة التقييد';

  @override
  String get settingsWarnBatterySubtitle =>
      'تنبيه عند تفعيل توفير الطاقة التلقائي';

  @override
  String get settingsOpenSourceFootnote =>
      '١٠٠٪ مجاني ومفتوح المصدر • بلا إعلانات • بلا جمع بيانات';

  @override
  String get settingsAsrCalculationTitle => 'طريقة حساب العصر (الفقه)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'اختر المذهب الفقهي لحساب بداية وقت صلاة العصر.';

  @override
  String get adhanVoiceMakkah => 'مكة المكرمة (علي ملا)';

  @override
  String get adhanVoiceMadinah => 'المدينة المنورة (عبد المجيد السريحي)';

  @override
  String get adhanVoiceAlAqsa => 'المسجد الأقصى (ياسر الدوسري)';

  @override
  String get adhanVoiceSoft => 'نغمة هادئة تقليدية';

  @override
  String get calcMethodUmmAlQura => 'أم القرى (المملكة العربية السعودية)';

  @override
  String get calcMethodMwl => 'رابطة العالم الإسلامي';

  @override
  String get calcMethodEgyptian => 'الهيئة المصرية العامة للمساحة';

  @override
  String get calcMethodIsna => 'الجمعية الإسلامية لأمريكا الشمالية (ISNA)';

  @override
  String get calcMethodKarachi => 'جامعة العلوم الإسلامية بكراتشي';

  @override
  String get calcMethodDubai => 'دائرة الشؤون الإسلامية بدبي';

  @override
  String get calcMethodDiyanet => 'رئاسة الشؤون الدينية التركية (ديانت)';

  @override
  String get calcMethodSingapore => 'المجلس الإسلامي بسنغافورة (MUIS)';

  @override
  String get learnSalahProphetQuoteTitle => 'صلوا كما رأيتموني أصلي';

  @override
  String get learnSalahAuthenticBadge => 'دليل السنة النبوية الصحيحة';

  @override
  String get learnSalahSearchPlaceholder =>
      'ابحث عن وضعية أو خطوة أو دليل حديثي...';

  @override
  String get learnSalahLearningModules => 'الوحدات التعليمية';

  @override
  String get learnSalahStepByStepTitle => 'دليل الصلاة خطوة بخطوة';

  @override
  String get learnSalahStepByStepSubtitle =>
      '١٠ خطوات متسلسلة مع الرسوم التوضيحية والأدلة';

  @override
  String get learnSalahPillarsTitle => 'أركان الصلاة الـ ١٤';

  @override
  String get learnSalahPillarsSubtitle => 'الأسس والفرائض التي لا تسقط بحال';

  @override
  String get learnSalahObligationsTitle => 'واجبات الصلاة الـ ٨';

  @override
  String get learnSalahObligationsSubtitle => 'أفعال واجبة يجبرها سجود السهو';

  @override
  String get learnSalahSunanTitle => 'سنن الصلاة القولية والفعلية';

  @override
  String get learnSalahSunanSubtitle => 'السنن القولية والفعلية عن النبي ﷺ';

  @override
  String get learnSalahInvalidatorsTitle => 'مبطلات ومفسدات الصلاة';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'الأمور التي تبطل الصلاة وتوجب إعادتها';

  @override
  String get learnSalahForbiddenTimesTitle => 'الأوقات المنهي عن الصلاة فيها';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'الأوقات التي يحرم أو يكره فيها صلاة النوافل';

  @override
  String get madhabShafi => 'الشافعي';

  @override
  String get madhabHanafi => 'الحنفي';

  @override
  String get eventIslamicNewYear => 'رأس السنة الهجرية';

  @override
  String get eventTasua => 'تاسوعاء';

  @override
  String get eventAshura => 'يوم عاشوراء';

  @override
  String get eventMawlid => 'المولد النبوي الشريف';

  @override
  String get eventIsraMiraj => 'الإسراء والمعراج';

  @override
  String get eventMidShaban => 'ليلة النصف من شعبان';

  @override
  String get eventRamadanStart => 'أول أيام شهر رمضان المبارك';

  @override
  String get eventBattleOfBadr => 'غزوة بدر الكبرى';

  @override
  String get eventLaylatAlQadr => 'ليلة القدر';

  @override
  String get eventEidAlFitr => 'عيد الفطر المبارك';

  @override
  String get eventShawwalSixFasting => 'صيام الست من شوال';

  @override
  String get eventDhuAlHijjahStart => 'غرة شهر ذي الحجة';

  @override
  String get eventDayOfArafah => 'يوم عرفة';

  @override
  String get eventEidAlAdha => 'عيد الأضحى المبارك';

  @override
  String get eventDaysOfTashreeq => 'أيام التشريق';

  @override
  String get qiblaHeadingTrue => 'الاتجاه الحقيقي';

  @override
  String get qiblaBearingLabel => 'زاوية القبلة';

  @override
  String get qiblaRetryLocation => 'إعادة محاولة تحديد الموقع';

  @override
  String get qiblaCalibClearInterference => 'تجنب التداخل المغناطيسي';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'ابتعد عن المكاتب المعدنية، الحواسيب أو أغطية الهاتف المغناطيسية.';

  @override
  String get qiblaCalibHoldFlat => 'امسك الهاتف بشكل أفقي مسطح';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'اجعل هاتفك مسطحاً وموازياً للأرض لأعلى درجات الدقة.';

  @override
  String get qiblaCalibFigure8 => 'حرك الهاتف على شكل رقم 8';

  @override
  String get qiblaCalibFigure8Desc =>
      'حرك هاتفك بسلاسة في الهواء على شكل الرقم 8 لمعايرة البوصلة.';

  @override
  String get stepPrevious => 'السابق';

  @override
  String get stepNext => 'الخطوة التالية';

  @override
  String get stepFinishGuide => 'إنهاء الدليل';

  @override
  String get widgetAddAnother => 'إضافة أخرى';

  @override
  String get widgetOpenSettings => 'فتح الإعدادات';

  @override
  String get widgetGoToHome => 'الانتقال إلى الرئيسية';

  @override
  String get trackerWeeklyRate => 'المعدل الأسبوعي';

  @override
  String get trackerMonthlyRate => 'المعدل الشهري';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total صلوات';
  }

  @override
  String get tasbihHadithTitle => 'حديث في فضل التسبيح بالأنامل';

  @override
  String get tasbihHadithText =>
      '«عَلَيْكُنَّ بِالتَّسْبِيحِ وَالتَّهْلِيلِ وَالتَّقْدِيسِ، وَاعْقِدْنَ بِالأَنَامِلِ فَإِنَّهُنَّ مَسْئُولَاتٌ مُسْتَنْطَقَاتٌ»';

  @override
  String get tasbihHadithReference => '— سنن أبي داود ١٤٩٦';

  @override
  String get dhikrSubhanAllah => 'سُبْحَانَ اللَّهِ';

  @override
  String get dhikrAlhamdulillah => 'الْحَمْدُ لِلَّهِ';

  @override
  String get dhikrAllahuAkbar => 'اللَّهُ أَكْبَرُ';

  @override
  String get dhikrAstaghfirullah => 'أَسْتَغْفِرُ اللَّهَ';

  @override
  String get dhikrLaIlahaIllallah => 'لَا إِلَٰهَ إِلَّا اللَّهُ';

  @override
  String get dhikrSubhanAllahTranslation =>
      'تنزيه الله تعالى عن كل نقص وبراءة له';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'الثناء الكامل والشكر لله وحده على نعمه';

  @override
  String get dhikrAllahuAkbarTranslation => 'الله أعظم وأجلّ وأكبر من كل شيء';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'طلب المغفرة والصفح والتوبة من الله';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'لا معبود بحق إلا الله وحده لا شريك له';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'التالي: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'مخصص';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'مخصص ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'تحديد عدد مخصص';

  @override
  String get tasbihTargetHint => 'أدخل العدد المستهدف (مثال: 50)';

  @override
  String get tasbihCancel => 'إلغاء';

  @override
  String get tasbihSetTarget => 'تأكيد الهدف';

  @override
  String tasbihLap(String lap) {
    return 'الدورة $lap';
  }
}
