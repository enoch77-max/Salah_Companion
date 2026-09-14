// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'সালাহ কম্প্যানিয়ন';

  @override
  String get navHome => 'হোম';

  @override
  String get navDuas => 'দুয়া';

  @override
  String get navTasbih => 'তাসবীহ';

  @override
  String get navQibla => 'কিবলা';

  @override
  String get navCalendar => 'ক্যালেন্ডার';

  @override
  String get prayerFajr => 'ফজর';

  @override
  String get prayerSunrise => 'সূর্যোদয়';

  @override
  String get prayerDhuhr => 'যোহর';

  @override
  String get prayerAsr => 'আসর';

  @override
  String get prayerMaghrib => 'মাগরিব';

  @override
  String get prayerIsha => 'ইশা';

  @override
  String get upcomingPrayer => 'পরবর্তী সালাত';

  @override
  String get currentSalah => 'বর্তমান সালাতের ওয়াক্ত';

  @override
  String get remaining => 'বাকি সময়';

  @override
  String get statusPrayed => 'আদায়কৃত';

  @override
  String get statusMissed => 'কাজা / মিস';

  @override
  String get statusPending => 'অপেক্ষমাণ';

  @override
  String get qiblaCompassTitle => 'কিবলা কম্পাস';

  @override
  String get qiblaCalibrate => 'ক্যালিব্রেট';

  @override
  String get qiblaFacingKaaba => 'কাবার নিখুঁত দিকনির্দেশনা';

  @override
  String get tasbihTitle => 'ডিজিটাল তাসবীহ';

  @override
  String get tasbihReset => 'রিসেট';

  @override
  String get tasbihAutoNext => 'স্বয়ংক্রিয় পরবর্তী';

  @override
  String get tasbihBestOnFingers => 'আঙুলের কড়ে গণনা করা সুন্নাহ';

  @override
  String get guidanceCategory => 'নির্দেশনা';

  @override
  String get learnSalah => 'নামায শিক্ষা';

  @override
  String get learnSalahSubtitle => 'সহীহ সুন্নাহ ও হাদীসের আলোকে নামাযের নিয়ম';

  @override
  String get savedItems => 'সংরক্ষিত';

  @override
  String get savedItemsSubtitle => 'হাদীস, আয়াত ও দুআ';

  @override
  String get prayerTracker => 'নামায ট্র্যাকার';

  @override
  String get prayerTrackerSubtitle => 'নামাযের পরিসংখ্যান দেখুন';

  @override
  String get widgetsTitle => 'উইজেট';

  @override
  String get widgetsSubtitle => 'হোম স্ক্রিনে উইজেট যোগ করুন';

  @override
  String get openSourcePrivacy => 'ওপেন সোর্স ও গোপনীয়তা';

  @override
  String get openSourcePrivacySubtitle =>
      '১০০% অফলাইন, ট্র্যাকিংহীন ও অ-বাণিজ্যিক';

  @override
  String get themeMode => 'থিম মোড';

  @override
  String get themeSystem => 'সিস্টেম';

  @override
  String get themeLight => 'লাইট';

  @override
  String get themeDark => 'ডার্ক';

  @override
  String notificationPrayerTitle(String prayer) {
    return '$prayer নামাযের সময়';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return '$prayer নামাযের ওয়াক্ত হয়েছে। নামাযের জন্য প্রস্তুত হোন।';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'ওয়াক্তের প্রাথমিক স্মরণ — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return '$prayer নামাযের ওয়াক্তের ১৫ মিনিট অতিক্রান্ত হয়েছে। আপনি কি নামায আদায় করেছেন?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'জরুরী — $prayer নামাযের ওয়াক্ত শেষ হতে ৩০ মিনিট বাকী';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return '$prayer নামাযের সময় শেষ হতে আর মাত্র ৩০ মিনিট বাকি আছে।';
  }

  @override
  String get notificationDailyReflectionTitle => 'দৈনিক তাদাব্বুর';

  @override
  String get notificationTestTitle => 'সালাহ কম্প্যানিয়ন সতর্কবার্তা';

  @override
  String get notificationTestBody =>
      'বিজ্ঞপ্তি এবং আযানের অডিও সফলভাবে নির্ধারিত হয়েছে।';

  @override
  String get onboardingChooseLanguage => 'আপনার ভাষা নির্বাচন করুন';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'নামাযের সময়সূচী ও সহীহ সুন্নাহর জন্য আপনার পছন্দের ভাষা বেছে নিন।';

  @override
  String get onboardingWelcomeTitle => 'সালাহ কম্প্যানিয়নে স্বাগতম';

  @override
  String get onboardingWelcomeBody =>
      'সঠিক নামাযের ওয়াক্ত, কিবলা দিক এবং সহীহ সুন্নাহর জন্য আপনার বিশ্বস্ত সঙ্গী।';

  @override
  String get onboardingSwipeTitle => 'মেনুর জন্য বাম পাশ থেকে সোয়াইপ করুন';

  @override
  String get onboardingSwipeBody =>
      'সংরক্ষিত বিষয় ও নামাযের পরিসংখ্যান দেখতে স্ক্রীনের বাম প্রান্ত থেকে সোয়াইপ করুন।';

  @override
  String get onboardingSunnahTitle => 'সহীহ সুন্নাহ ও নির্ভরযোগ্য নির্দেশনা';

  @override
  String get onboardingSunnahBody =>
      'দৈনিক কুরআন আয়াত, সহীহ হাদীস, মাছুর দুআ এবং নামাযের সহীহ পদ্ধতি।';

  @override
  String get onboardingCustomizationTitle => 'কিবলা, তাসবীহ ও সেটিংস';

  @override
  String get onboardingCustomizationBody =>
      'কিবলা কম্পাস, ডিজিটাল তাসবীহ এবং নামায হিসাবের পদ্ধতি কাস্টমাইজ করুন।';

  @override
  String onboardingStepOf(int current, int total) {
    return '$total এর মধ্যে $current';
  }

  @override
  String get onboardingSkip => 'এড়িয়ে যান';

  @override
  String get onboardingNext => 'পরবর্তী';

  @override
  String get onboardingGetStarted => 'শুরু করুন';

  @override
  String get systemDefault => 'ডিভাইস ডিফল্ট';

  @override
  String get moreLanguages => 'অন্যান্য ভাষা';

  @override
  String get searchLanguagePlaceholder => 'ভাষা অনুসন্ধান করুন...';

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get settingsLanguage => 'ভাষা';

  @override
  String get settingsLanguageSubtitle => 'অ্যাপ্লিকেশনের ভাষা পরিবর্তন করুন';

  @override
  String get onboardingTrustTitle => 'আপনার প্রতি আমাদের পবিত্র আমানত';

  @override
  String get onboardingTrustSubtitle =>
      'শুধুমাত্র আল্লাহর সন্তুষ্টির জন্য নির্মিত — কোনো বিজ্ঞাপন নেই, কোনো ট্র্যাকিং নেই, ১০০% গোপনীয়।';

  @override
  String get onboardingTrustOfflineTitle => '১০০% অফলাইন এবং ডিভাইসে সংরক্ষিত';

  @override
  String get onboardingTrustOfflineDesc =>
      'আপনার অবস্থান ও নামাজের কোনো তথ্য ফোন থেকে বের হয় না। সমস্ত হিসাব ইন্টারনেট ছাড়াই ফোনে সম্পন্ন হয়।';

  @override
  String get onboardingTrustNoAdsTitle => 'চিরতরে বিজ্ঞাপনমুক্ত';

  @override
  String get onboardingTrustNoAdsDesc =>
      'কোনো ব্যানার বা পপ-আপ নেই, ইবাদতের একাগ্রতায় কোনো ব্যাঘাত নেই।';

  @override
  String get onboardingTrustNoTrackingTitle => 'শূন্য ট্র্যাকিং ও ডেটা সংগ্রহ';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'কোনো ফায়ারবেস ট্র্যাকিং নেই, ব্যক্তিগত কোনো তথ্য সংগ্রহ করা হয় না।';

  @override
  String get onboardingTrustFreeTitle => 'উম্মাহর জন্য আজীবন বিনামূল্যে';

  @override
  String get onboardingTrustFreeDesc =>
      'সদকায়ে জারিয়া হিসেবে নিবেদিত। কোনো ফি বা সাবস্ক্রিপশন নেই।';

  @override
  String get onboardingFeaturesTitle => 'অ্যাপের প্রধান বৈশিষ্ট্যসমূহ';

  @override
  String get onboardingFeaturesSubtitle =>
      'নামাজের নির্ভুল সময়সূচি, বিশুদ্ধ সুন্নাহ এবং ইবাদতের সুবিন্যস্ত মাধ্যম।';

  @override
  String get onboardingFeaturePrayerTitle => 'নির্ভুল জ্যোতির্বৈজ্ঞানিক সময়';

  @override
  String get onboardingFeaturePrayerDesc =>
      'সূর্যের অবস্থানের ওপর ভিত্তি করে নিখুঁত নামাজের সময় ও সুন্নত সালাতের রিমাইন্ডার।';

  @override
  String get onboardingFeatureQiblaTitle => 'রিয়েল-টাইম কিবলা কম্পাস';

  @override
  String get onboardingFeatureQiblaDesc =>
      'বায়তুল্লাহ শরিফের সঠিক দিক নির্দেশক এবং কিবলামুখী হলে ভাইব্রেশন সংকেত।';

  @override
  String get onboardingFeatureTasbihTitle => 'ডিজিটাল তসবিহ কাউন্টার';

  @override
  String get onboardingFeatureTasbihDesc =>
      'আঙুলে গণনার মতো হ্যাপটিক স্পর্শ অনুভূতি ও সহিহ মাসনুন জিকির।';

  @override
  String get onboardingFeatureSunnahTitle => 'বিশুদ্ধ সুন্নাহ ও দোয়া';

  @override
  String get onboardingFeatureSunnahDesc =>
      'সহিহ বুখারি ও মুসলিমের সহিহ হাদিস এবং প্রতিদিনের নির্বাচিত কুরআনিক আয়াত।';

  @override
  String get onboardingFeatureQiblaAligned =>
      'কিবলামুখী সম্পন্ন • মক্কা মুকাররমা';

  @override
  String get onboardingFeatureTapToCount =>
      'গণনা করতে যেকোনো স্থানে ট্যাপ করুন বা সোয়াইপ করুন';

  @override
  String get onboardingPermissionsTitle => 'সহজ প্রাথমিক সেটআপ';

  @override
  String get onboardingPermissionsSubtitle =>
      'সঠিক নামাজের সময় এবং আজান নোটিফিকেশনের জন্য অনুমতি প্রদান করুন।';

  @override
  String get onboardingPermLocationTitle => 'সঠিক লোকেশন';

  @override
  String get onboardingPermLocationDesc =>
      'আপনার অবস্থানের ওপর ভিত্তি করে সূর্যোদয় ও সূর্যাস্তের সময় নির্ধারণে ব্যবহৃত হয়।';

  @override
  String get onboardingPermNotifTitle => 'আজান ও নামাজের নোটিফিকেশন';

  @override
  String get onboardingPermNotifDesc =>
      'সময়মতো আজান প্রদান এবং সুন্নত নামাজের স্মরণ করিয়ে দেওয়ার জন্য।';

  @override
  String get onboardingPermBatteryTitle =>
      'নির্ভরযোগ্য ব্যাকগ্রাউন্ড অ্যালার্ম';

  @override
  String get onboardingPermBatteryDesc =>
      'অ্যান্ড্রয়েড ব্যাটারি অপটিমাইজেশন যাতে ফজরের আজান অ্যালার্ম বন্ধ না করে।';

  @override
  String get onboardingPermGrant => 'অনুমতি দিন';

  @override
  String get onboardingPermGranted => 'অনুমতি দেওয়া হয়েছে';

  @override
  String get onboardingPermEnableLater => 'পরে সেটিংসে গিয়ে চালু করুন';

  @override
  String get onboardingDedicationVerse =>
      '“নিশ্চয়ই নামাজ মুমিনদের ওপর নির্ধারিত সময়ে ফরজ করা হয়েছে।”';

  @override
  String get onboardingDedicationReference => 'সূরা আন-নিসা (৪:১০৩)';

  @override
  String get onboardingBeginJourney => 'বিসমিল্লাহ • শুরু করুন';

  @override
  String get onboardingReplayTour => 'পরিচিতি ট্যুর পুনরায় দেখুন';

  @override
  String get onboardingReplayTourSubtitle =>
      'অ্যাপের বৈশিষ্ট্য ও গোপনীয়তার প্রতিশ্রুতি আবার দেখুন';

  @override
  String get onboardingBack => 'পেছনে';

  @override
  String get navTracker => 'ট্র্যাকার';

  @override
  String get prayerSunset => 'সূর্যাস্ত';

  @override
  String get statusNotPrayed => 'আদায় করা হয়নি';

  @override
  String get statusUpcoming => 'আসন্ন';

  @override
  String get statusNotYet => 'এখনও হয়নি';

  @override
  String get todaysPrayers => 'আজকের সালাত';

  @override
  String startsAt(String time) {
    return 'শুরু $time';
  }

  @override
  String periodRange(String start, String end) {
    return 'ওয়াক্ত: $start – $end';
  }

  @override
  String get locating => 'অবস্থান শনাক্ত হচ্ছে...';

  @override
  String get drawerNavigation => 'ন্যাভিগেশন';

  @override
  String get drawerOpenSourcePrivacy => 'ওপেন সোর্স ও গোপনীয়তা';

  @override
  String get drawerQuickActions => 'দ্রুত কাজ';

  @override
  String get prayerAndReflection => 'সালাত ও আত্মশুদ্ধি';

  @override
  String get settingsNotifications => 'নোটিফিকেশন ও আযান';

  @override
  String get settingsCalculationFiqh => 'হিসাব পদ্ধতি ও ফিকহ';

  @override
  String get settingsBattery => 'ব্যাটারি অপ্টিমাইজেশন';

  @override
  String get settingsAppearance => 'থিম ও হ্যাপটিক্স';

  @override
  String get settingsGuideOnboarding => 'গাইড ও অনবোর্ডিং';

  @override
  String get settingsAboutPrivacy => 'সম্পর্কে ও গোপনীয়তা';

  @override
  String get settingsAdhanAudio => 'আযান অডিও';

  @override
  String get settingsAdhanVoice => 'মুয়াযযিনের কণ্ঠ';

  @override
  String get settingsDailyReflection => 'প্রতিদিনের আত্মশুদ্ধি';

  @override
  String get settingsDailyReflectionSubtitle =>
      'সকালের আয়াত ও সহীহ হাদিস নোটিফিকেশন';

  @override
  String get settingsCalculationMethod => 'সালাতের হিসাব পদ্ধতি';

  @override
  String get settingsJuristicMethod => 'আসর ফিকহ পদ্ধতি (মাযহাব)';

  @override
  String get settingsHighLatitude => 'উচ্চ অক্ষাংশ নিয়ম';

  @override
  String get settingsHijriAdjustment => 'হিজরি তারিখ সমন্বয়';

  @override
  String get settingsBatteryHeader => 'ব্যাকগ্রাউন্ড কার্যক্ষমতা';

  @override
  String get settingsBatteryDesc =>
      'নির্ধারিত সময়ে আযান ও ফজর অ্যালার্ম নিশ্চিত করতে সালাহ কম্প্যানিয়নকে ব্যাটারি অপ্টিমাইজেশন থেকে মুক্ত রাখুন।';

  @override
  String get settingsBatteryExempt => 'ছাড়প্রাপ্ত';

  @override
  String get settingsBatteryNotExempt =>
      'ব্যাটারি অপ্টিমাইজেশন: সক্রিয় (সমাধানে ট্যাপ করুন)';

  @override
  String get settingsCheckBattery => 'ব্যাটারি অবস্থা পরীক্ষা করুন';

  @override
  String get settingsTheme => 'থিম মোড';

  @override
  String get settingsHaptics => 'হ্যাপটিক ভাইব্রেশন';

  @override
  String get settingsHapticsSubtitle => 'ট্যাপ ও ইভেন্টে স্পর্শকাতর কম্পন';

  @override
  String get settingsPrivacyPolicy => 'গোপনীয়তা নীতি';

  @override
  String get settingsOpenSource => '১০০% ওপেন সোর্স (GitHub)';

  @override
  String get settingsTerms => 'ব্যবহারের শর্তাবলী';

  @override
  String get settingsCalculationDocs => 'হিসাব পদ্ধতি ও প্রশ্নোত্তর';

  @override
  String get settingsCalculationDocsSubtitle =>
      'সালাতের সময় ও সৌর কোণের নির্ভুল হিসাব জানুন';

  @override
  String get sunnahMuakkadah => 'সুন্নাতে মুয়াক্কাদাহ';

  @override
  String get sunnahGhairMuakkadah => 'সুন্নাতে গায়রে মুয়াক্কাদাহ';

  @override
  String get sunnahWajibWitr => 'সুন্নাত ও ওয়াজিব বিতর';

  @override
  String get sunnahVoluntary => 'নফল সালাত';

  @override
  String get categoryAll => 'সকল';

  @override
  String get categoryHadith => 'হাদিস';

  @override
  String get categoryAyah => 'কুরআনের আয়াত';

  @override
  String get categoryDua => 'দুয়া ও যিকির';

  @override
  String get categoryMorning => 'সকাল';

  @override
  String get categoryEvening => 'সন্ধ্যা';

  @override
  String get categoryAfterPrayer => 'নামাযের পর';

  @override
  String get categoryForgiveness => 'তওবা ও ক্ষমা';

  @override
  String get categoryProtection => 'নিরাপত্তা ও আশ্রয়';

  @override
  String get categoryDaily => 'দৈনন্দিন';

  @override
  String get categoryTravel => 'সফর';

  @override
  String get noSavedItems => 'এখনও কোনো সংরক্ষিত আইটেম নেই';

  @override
  String get noSavedItemsSubtitle =>
      'যেকোনো হাদিস বা আয়াত সংরক্ষণ করতে বুকমার্ক বাটনে ট্যাপ করুন।';

  @override
  String get searchPlaceholder => 'দুয়া, অর্থ বা হাদিসের সূত্র খুঁজুন...';

  @override
  String get sunnahPrayerHeader => 'সুন্নাত সালাত';

  @override
  String get sunnahFajrDesc => 'ফরজের পূর্বে ২ রাকাত সুন্নাতে মুয়াক্কাদাহ';

  @override
  String get sunnahDhuhrDesc => 'ফরজের পূর্বে ৪ রাকাত ও পরে ২ রাকাত সুন্নাত';

  @override
  String get sunnahAsrDesc =>
      'ফরজের পূর্বে ৪ রাকাত সুন্নাতে গায়রে মুয়াক্কাদাহ';

  @override
  String get sunnahMaghribDesc => 'ফরজের পরে ২ রাকাত সুন্নাতে মুয়াক্কাদাহ';

  @override
  String get sunnahIshaDesc => 'ফরজের পরে ২ রাকাত সুন্নাত + ৩ রাকাত বিতর';

  @override
  String get forbiddenNaflHeader => 'নফল নামাযের নিষিদ্ধ সময়';

  @override
  String get forbiddenNaflBody =>
      'সূর্যোদয় (~২০ মিনিট), দ্বিপ্রহরের খাড়া সূর্য (~১০ মিনিট) এবং সূর্যাস্তের সময় (~২০ মিনিট) নফল নামায পড়া নিষিদ্ধ। তবে কাযা নামায আদায় করা যাবে। (সহীহ মুসলিম ৮৩১)';

  @override
  String get forbiddenNaflSunriseHeader =>
      'নফল নামাযের নিষিদ্ধ সময় • সূর্যোদয়';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'সূর্য উদিত হচ্ছে ($startTime – $endTime)। সূর্য সম্পূর্ণ উদিত না হওয়া পর্যন্ত নফল নামায নিষিদ্ধ। (সহীহ মুসলিম ৮৩১)';
  }

  @override
  String get forbiddenNaflZawalHeader =>
      'নফল নামাযের নিষিদ্ধ সময় • যাওয়াল (দ্বিপ্রহর)';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'সূর্য ঠিক মাথার উপরে ($startTime – $endTime)। এই সময়ে নফল নামায পড়া নিষিদ্ধ। (সহীহ মুসলিম ৮৩১)';
  }

  @override
  String get forbiddenNaflSunsetHeader =>
      'নফল নামাযের নিষিদ্ধ সময় • সূর্যাস্ত';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'সূর্য অস্ত যাচ্ছে ($startTime – $endTime)। সূর্যাস্ত সম্পন্ন না হওয়া পর্যন্ত নফল নামায নিষিদ্ধ। (সহীহ মুসলিম ৮৩১)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return '$prayer নামাযের ওয়াক্ত এখনও শুরু হয়নি ($time)';
  }

  @override
  String get timeStart => 'শুরু';

  @override
  String get timeEnd => 'শেষ';

  @override
  String get onboardingShowcasePrayerTitle =>
      'নির্ভুল নামাজের ওয়াক্ত ও সময়সূচী';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'আন্তর্জাতিকভাবে স্বীকৃত ইসলামিক পদ্ধতিতে ১০০% অফলাইনে নিখুঁত ওয়াক্ত গণনা।';

  @override
  String get onboardingShowcaseQiblaTitle => 'সঠিক কিবলা কম্পাস';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'উন্নত জাইরোস্কোপিক সেন্সরের মাধ্যমে পৃথিবীর যেকোনো প্রান্ত থেকে কাবার সঠিক দিকনির্দেশনা।';

  @override
  String get onboardingShowcaseTasbihTitle => 'ডিজিটাল তাসবিহ ও জিকির';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'হ্যাপটিক ভাইব্রেশন ও স্বয়ংক্রিয় গণনাসহ প্রাণবন্ত ডিজিটাল তাসবিহ কাউন্টার।';

  @override
  String get onboardingShowcaseReflectionTitle => 'দৈনিক আয়াত, হাদিস ও দোয়া';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'বিশুদ্ধ ইসলামিক ফাউন্ডেশন অনুবাদসহ সহীহ হাদিস, কোরআনের আয়াত ও প্রয়োজনীয় মাসনূন দোয়া।';

  @override
  String get settingsPrayerNotifications => 'নামাজের নোটিফিকেশন';

  @override
  String get settingsAdhanReciterTone => 'মুয়াজ্জিন ও আজানের সুর';

  @override
  String get settingsDailyReminderTime => 'প্রতিফলনের নোটিফিকেশন';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$countটি লাইভ উইজেট';
  }

  @override
  String get settingsFiqhAsr => 'ফিকহ (আসর ওয়াক্ত)';

  @override
  String get settingsFiqhStandardTitle => 'শাফেঈ / সাধারণ (ডিফল্ট)';

  @override
  String get settingsFiqhStandardDesc => 'শাফেঈ, মালেকী ও হাম্বলী (১ গুণ ছায়া)';

  @override
  String get settingsFiqhStandardSub =>
      'ছায়ার দৈর্ঘ্য = বস্তুর সমান (১ গুণ)। শাফেঈ, মালেকী, হাম্বলী ও অধিকাংশ বৈশ্বিক পদ্ধতি।';

  @override
  String get settingsFiqhHanafiTitle => 'হানাফী';

  @override
  String get settingsFiqhHanafiDesc => 'হানাফী মাযহাব (২ গুণ ছায়া)';

  @override
  String get settingsFiqhHanafiSub =>
      'ছায়ার দৈর্ঘ্য = বস্তুর দ্বিগুণ (২ গুণ)। ইমাম আবু হানিফা (রহ.)-এর হানাফী ফিকহ অনুযায়ী।';

  @override
  String get settingsPreAdhanReminder => 'আজানের পূর্ব সতর্কবার্তা';

  @override
  String get settingsBatteryRestricted => 'সীমাবদ্ধ';

  @override
  String get settingsBatteryExemptDesc =>
      'ছাড়প্রাপ্ত — আজানের সতর্কবার্তা সময়মতো বাজবে';

  @override
  String get settingsBatteryNotExemptDesc =>
      'সীমাবদ্ধ — আজানের এলার্মে বিলম্ব হতে পারে';

  @override
  String get settingsCheckBatteryNow => 'অবস্থা যাচাই করুন';

  @override
  String get settingsCheckBatterySubtitle =>
      'ব্যাকগ্রাউন্ডে সক্রিয় থাকার অনুমতি যাচাই করুন';

  @override
  String get settingsWarnBattery => 'পুনরায় অপ্টিমাইজড হলে সতর্ক করুন';

  @override
  String get settingsWarnBatterySubtitle =>
      'অপারেটিং সিস্টেম ব্যাটারি সেভার চালু করলে সতর্কবার্তা';

  @override
  String get settingsOpenSourceFootnote =>
      '১০০% ফ্রি ও ওপেন সোর্স • বিজ্ঞাপনমুক্ত • ডেটা সংগ্রহহীন';

  @override
  String get settingsAsrCalculationTitle => 'আসর গণনার পদ্ধতি (ফিকহ)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'আসর নামাজের ওয়াক্ত শুরুর ফিকহি মাযহাব নির্বাচন করুন।';

  @override
  String get adhanVoiceMakkah => 'মক্কা (আলী মোল্লা)';

  @override
  String get adhanVoiceMadinah => 'মদিনা (আব্দুল মজিদ)';

  @override
  String get adhanVoiceAlAqsa => 'আল-আকসা (ইয়াসির আল-দোসারি)';

  @override
  String get adhanVoiceSoft => 'ঐতিহ্যবাহী কোমল সুর';

  @override
  String get calcMethodUmmAlQura => 'উম্ম আল-কুরা (সৌদি আরব)';

  @override
  String get calcMethodMwl => 'মুসলিম ওয়ার্ল্ড লিগ';

  @override
  String get calcMethodEgyptian => 'মিশরীয় জেনারেল অথরিটি';

  @override
  String get calcMethodIsna => 'ইসনা (উত্তর আমেরিকা)';

  @override
  String get calcMethodKarachi => 'করাচি (পাকিস্তান/ভারত)';

  @override
  String get calcMethodDubai => 'দুবাই (সংযুক্ত আরব আমিরাত)';

  @override
  String get calcMethodDiyanet => 'দিয়ানাত (তুরস্ক)';

  @override
  String get calcMethodSingapore => 'মুইস (সিঙ্গাপুর)';

  @override
  String get learnSalahProphetQuoteTitle => 'নবীজি ﷺ যেভাবে সালাত আদায় করেছেন';

  @override
  String get learnSalahAuthenticBadge => 'সহিহ সুন্নাহ নির্দেশিকা';

  @override
  String get learnSalahSearchPlaceholder =>
      'ভঙ্গি, ধাপ বা হাদিসের প্রমাণ অনুসন্ধান করুন...';

  @override
  String get learnSalahLearningModules => 'শিক্ষণীয় বিষয়সমূহ';

  @override
  String get learnSalahStepByStepTitle => 'ধাপে ধাপে সালাত নির্দেশিকা';

  @override
  String get learnSalahStepByStepSubtitle =>
      'চিত্র ও প্রমাণসহ ১০টি ধারাবাহিক ধাপ';

  @override
  String get learnSalahPillarsTitle => 'সালাতের ১৪টি রুকন (ফরজ)';

  @override
  String get learnSalahPillarsSubtitle => 'সালাতের অপরিহার্য মূল ভিত্তি';

  @override
  String get learnSalahObligationsTitle => 'সালাতের ৮টি ওয়াজিব';

  @override
  String get learnSalahObligationsSubtitle =>
      'বাধ্যতামূলক কাজ যা সাহু সিজদা দ্বারা পূরণ করা যায়';

  @override
  String get learnSalahSunanTitle => 'সালাতের সুন্নতসমূহ';

  @override
  String get learnSalahSunanSubtitle =>
      'নবীজি ﷺ-এর মৌখিক ও ব্যবহারিক সুন্নতসমূহ';

  @override
  String get learnSalahInvalidatorsTitle => 'সালাত ভঙ্গের কারণসমূহ';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'যেসব কারণে সালাত বাতিল বা ভেঙে যায়';

  @override
  String get learnSalahForbiddenTimesTitle => 'সালাতের নিষিদ্ধ সময়সমূহ';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'যে সময়গুলোতে নফল সালাত আদায় নিষিদ্ধ';

  @override
  String get madhabShafi => 'শাফেঈ';

  @override
  String get madhabHanafi => 'হানাফী';

  @override
  String get eventIslamicNewYear => 'হিজরি নববর্ষ';

  @override
  String get eventTasua => 'তাশূআ';

  @override
  String get eventAshura => 'পবিত্র আশুরা';

  @override
  String get eventMawlid => 'ঈদে মিলাদুন্নবী';

  @override
  String get eventIsraMiraj => 'শবে মেরাজ';

  @override
  String get eventMidShaban => 'শবে বরাত (মধ্য শাবান)';

  @override
  String get eventRamadanStart => 'পবিত্র রমজানের প্রথম দিন';

  @override
  String get eventBattleOfBadr => 'ঐতিহাসিক বদর দিবস';

  @override
  String get eventLaylatAlQadr => 'লাইলাতুল কদর';

  @override
  String get eventEidAlFitr => 'ঈদুল ফিতর';

  @override
  String get eventShawwalSixFasting => 'শাওয়ালের ছয় রোজা';

  @override
  String get eventDhuAlHijjahStart => 'জিলহজ্জ মাসের সূচনা';

  @override
  String get eventDayOfArafah => 'পবিত্র আরাফাহ দিবস';

  @override
  String get eventEidAlAdha => 'ঈদুল আজহা';

  @override
  String get eventDaysOfTashreeq => 'আইয়ামে তাশরিক';

  @override
  String get qiblaHeadingTrue => 'প্রকৃত অভিমুখ';

  @override
  String get qiblaBearingLabel => 'কিবলা কোণ';

  @override
  String get qiblaRetryLocation => 'লোকেশন পুনরায় চেষ্টা করুন';

  @override
  String get qiblaCalibClearInterference => 'চৌম্বকীয় বাধা দূর করুন';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'ধাতব টেবিল, কম্পিউটার বা চুম্বকযুক্ত কভার থেকে দূরে থাকুন।';

  @override
  String get qiblaCalibHoldFlat => 'ডিভাইসটি সমান্তরাল রাখুন';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'সঠিক নির্ভুলতার জন্য ফোনটি ভূমির সমান্তরালে সমতল রাখুন।';

  @override
  String get qiblaCalibFigure8 => '৮ আকারে ফোন ঘুরান';

  @override
  String get qiblaCalibFigure8Desc =>
      'কম্পাস ক্যালিব্রেট করতে বাতাসে ফোনটি ৮ আকারে সাবলীলভাবে ঘুরান।';

  @override
  String get stepPrevious => 'পূর্ববর্তী';

  @override
  String get stepNext => 'পরবর্তী ধাপ';

  @override
  String get stepFinishGuide => 'সম্পন্ন করুন';

  @override
  String get widgetAddAnother => 'আরেকটি যোগ করুন';

  @override
  String get widgetOpenSettings => 'সেটিংস খুলুন';

  @override
  String get widgetGoToHome => 'হোমে ফিরে যান';

  @override
  String get trackerWeeklyRate => 'সাপ্তাহিক গড়';

  @override
  String get trackerMonthlyRate => 'মাসিক গড়';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total সালাত';
  }

  @override
  String get tasbihHadithTitle => 'আঙুলে তাসবীহ গণনার ফজিলত বিষয়ক হাদীস';

  @override
  String get tasbihHadithText =>
      '“তোমরা তাসবীহ, তাহলীল ও তাকদীস পাঠকে আবশ্যক করে নাও এবং আঙুলের কড়ে গণনা করো; কেননা কিয়ামতের দিন আঙুলগুলোকে জিজ্ঞাসাবাদ করা হবে এবং তারা কথা বলবে।”';

  @override
  String get tasbihHadithReference => '— সুনান আবি দাউদ ১৪৯৬';

  @override
  String get dhikrSubhanAllah => 'সুবহানাল্লাহ';

  @override
  String get dhikrAlhamdulillah => 'আলহামদুলিল্লাহ';

  @override
  String get dhikrAllahuAkbar => 'আল্লাহু আকবার';

  @override
  String get dhikrAstaghfirullah => 'আস্তাগফিরুল্লাহ';

  @override
  String get dhikrLaIlahaIllallah => 'লা ইলাহা ইল্লাল্লাহ';

  @override
  String get dhikrSubhanAllahTranslation =>
      'আল্লাহ সকল প্রকার ত্রুটি ও দোষ থেকে সম্পূর্ণ পবিত্র';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'সকল প্রশংসা ও কৃতজ্ঞতা একমাত্র আল্লাহর প্রাপ্য';

  @override
  String get dhikrAllahuAkbarTranslation =>
      'আল্লাহ সর্বশ্রেষ্ঠ, সবচেয়ে মহান ও প্রতাপশালী';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'আমি আল্লাহর নিকট আমার গুনাহের জন্য ক্ষমা প্রার্থনা করছি';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'একমাত্র আল্লাহ ছাড়া আর কোনো সত্য উপাস্য নেই';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'পরবর্তী: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'কাস্টম';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'কাস্টম ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'কাস্টম লক্ষ্য নির্ধারণ করুন';

  @override
  String get tasbihTargetHint => 'কাঙ্ক্ষিত সংখ্যাটি লিখুন (যেমন: ৫০)';

  @override
  String get tasbihCancel => 'বাতিল';

  @override
  String get tasbihSetTarget => 'লক্ষ্য সেট করুন';

  @override
  String tasbihLap(String lap) {
    return 'চক্র $lap';
  }
}
