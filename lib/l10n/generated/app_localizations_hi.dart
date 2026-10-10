// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'सलाह कम्पैनियन';

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
  String get prayerFajr => 'फ़ज्र';

  @override
  String get prayerSunrise => 'सूर्योदय';

  @override
  String get prayerDhuhr => 'ज़ुहर';

  @override
  String get prayerAsr => 'असर';

  @override
  String get prayerMaghrib => 'मग़रिब';

  @override
  String get prayerIsha => 'इशा';

  @override
  String get upcomingPrayer => 'अगली नमाज़';

  @override
  String get currentSalah => 'वर्तमान नमाज़';

  @override
  String get remaining => 'शेष समय';

  @override
  String get statusPrayed => 'Prayed';

  @override
  String get statusMissed => 'Missed';

  @override
  String get statusPending => 'Pending';

  @override
  String get qiblaCompassTitle => 'क़िबला कम्पास';

  @override
  String get qiblaCalibrate => 'कैलिब्रेट करें';

  @override
  String get qiblaFacingKaaba => 'काबा की सही दिशा';

  @override
  String get tasbihTitle => 'डिजिटल तस्बीह';

  @override
  String get tasbihReset => 'रीसेट';

  @override
  String get tasbihAutoNext => 'स्वचालित अगला';

  @override
  String get tasbihBestOnFingers => 'उंगलियों के पोरों पर गिनना सुन्नत है';

  @override
  String get guidanceCategory => 'मार्गदर्शन';

  @override
  String get learnSalah => 'नमाज़ सीखें';

  @override
  String get learnSalahSubtitle =>
      'सहीह सुन्नत और हदीसों के अनुसार नमाज़ का तरीक़ा';

  @override
  String get savedItems => 'सहेजे गए';

  @override
  String get savedItemsSubtitle => 'हदीसें, आयतें और दुआएं';

  @override
  String get prayerTracker => 'नमाज़ ट्रैकर';

  @override
  String get prayerTrackerSubtitle => 'अपने नमाज़ के आंकड़े देखें';

  @override
  String get widgetsTitle => 'विगेट्स';

  @override
  String get widgetsSubtitle => 'होम स्क्रीन पर विगेट जोड़ें';

  @override
  String get openSourcePrivacy => 'ओपन सोर्स और गोपनीयता';

  @override
  String get openSourcePrivacySubtitle =>
      '100% ऑफ़लाइन, बिना ट्रैकिंग और गैर-व्यावसायिक';

  @override
  String get themeMode => 'थीम मोड';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeDark => 'डार्क';

  @override
  String notificationPrayerTitle(String prayer) {
    return '$prayer की नमाज़';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return '$prayer का समय हो गया है। नमाज़ की तैयारी करें।';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'प्रारंभिक समय की याददिहानी — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return '$prayer के समय में से 15 मिनट बीत चुके हैं। क्या आपने नमाज़ अदा कर ली?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'महत्वपूर्ण — $prayer के समय में 30 मिनट शेष';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return '$prayer की नमाज़ का समय समाप्त होने में केवल 30 मिनट बचे हैं।';
  }

  @override
  String get notificationDailyReflectionTitle => 'दैनिक चिंतन';

  @override
  String get notificationTestTitle => 'सलाह कम्पैनियन अलर्ट';

  @override
  String get notificationTestBody =>
      'सूचनाएं और अज़ान की आवाज़ सफलतापूर्वक सेट हो गई हैं।';

  @override
  String get onboardingChooseLanguage => 'अपनी भाषा चुनें';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'नमाज़ के समय और मार्गदर्शन के लिए अपनी पसंदीदा भाषा चुनें।';

  @override
  String get onboardingWelcomeTitle => 'सलाह कम्पैनियन में आपका स्वागत है';

  @override
  String get onboardingWelcomeBody =>
      'नमाज़ के सही समय, क़िबला रुख और सुन्नत-ए-नबवी के लिए आपका विश्वसनीय साथी।';

  @override
  String get onboardingSwipeTitle => 'मेनू के लिए बाईं ओर से स्वाइप करें';

  @override
  String get onboardingSwipeBody =>
      'सहेजी गई सामग्री और नमाज़ के आंकड़ों तक पहुंचने के लिए स्क्रीन के बाएं किनारे से स्वाइप करें।';

  @override
  String get onboardingSunnahTitle => 'सहीह सुन्नत और मार्गदर्शन';

  @override
  String get onboardingSunnahBody =>
      'दैनिक क़ुरआनी आयतें, सहीह हदीसें, मसनून दुआएं और नमाज़ का सही तरीक़ा।';

  @override
  String get onboardingCustomizationTitle => 'क़िबला, तस्बीह और सेटिंग्स';

  @override
  String get onboardingCustomizationBody =>
      'क़िबला कम्पास, डिजिटल तस्बीह और नमाज़ के समय की गणना के तरीक़े कस्टमाइज़ करें।';

  @override
  String onboardingStepOf(int current, int total) {
    return '$total में से $current';
  }

  @override
  String get onboardingSkip => 'छोड़ें';

  @override
  String get onboardingNext => 'आगे';

  @override
  String get onboardingGetStarted => 'शुरू करें';

  @override
  String get systemDefault => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get moreLanguages => 'अन्य भाषाएं';

  @override
  String get searchLanguagePlaceholder => 'भाषा खोजें...';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsLanguageSubtitle => 'एप्लिकेशन की भाषा बदलें';

  @override
  String get onboardingTrustTitle => 'आपसे हमारी पवित्र अमानत';

  @override
  String get onboardingTrustSubtitle =>
      'केवल अल्लाह की रज़ा के लिए निर्मित — कोई विज्ञापन नहीं, कोई ट्रैकिंग नहीं, 100% निजी।';

  @override
  String get onboardingTrustOfflineTitle =>
      '100% ऑफ़लाइन और डिवाइस में सुरक्षित';

  @override
  String get onboardingTrustOfflineDesc =>
      'आपकी लोकेशन और नमाज़ का रिकॉर्ड कभी फोन से बाहर नहीं जाता। सभी गणनाएं बिना इंटरनेट के होती हैं।';

  @override
  String get onboardingTrustNoAdsTitle => 'हमेशा के लिए विज्ञापन मुक्त';

  @override
  String get onboardingTrustNoAdsDesc =>
      'कोई बैनर या पॉप-अप नहीं, आपकी इबादत में कोई बाधा नहीं।';

  @override
  String get onboardingTrustNoTrackingTitle => 'शून्य ट्रैकिंग और डेटा संग्रह';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'कोई फायरबेस ट्रैकिंग नहीं, कोई व्यक्तिगत डेटा एकत्र नहीं किया जाता।';

  @override
  String get onboardingTrustFreeTitle => 'उम्मत के लिए हमेशा मुफ्त';

  @override
  String get onboardingTrustFreeDesc =>
      'सदक़ा-ए-जारिया के रूप में प्रस्तुत। कोई शुल्क या सदस्यता नहीं।';

  @override
  String get onboardingFeaturesTitle => 'मुख्य विशेषताएं';

  @override
  String get onboardingFeaturesSubtitle =>
      'नमाज़ के सही समय, प्रामाणिक सुन्नत और इबादत के आसान साधन।';

  @override
  String get onboardingFeaturePrayerTitle => 'सटीक खगोलीय समय';

  @override
  String get onboardingFeaturePrayerDesc =>
      'सूरज के कोणों पर आधारित सही नमाज़ के समय और सुन्नत के रिमाइंडर।';

  @override
  String get onboardingFeatureQiblaTitle => 'क़िबला कंपास';

  @override
  String get onboardingFeatureQiblaDesc =>
      'पवित्र काबा की सही दिशा और क़िबला संरेखित होने पर हैप्टिक कंपन।';

  @override
  String get onboardingFeatureTasbihTitle => 'डिजिटल तस्बीह काउंटर';

  @override
  String get onboardingFeatureTasbihDesc =>
      'उंगलियों पर गिनने जैसा स्पर्श एहसास और मसनून अज़कार।';

  @override
  String get onboardingFeatureSunnahTitle => 'प्रामाणिक सुन्नत और दुआएं';

  @override
  String get onboardingFeatureSunnahDesc =>
      'सहीह बुखारी और मुस्लिम की सहीह हदीसें और दैनिक कुरानिक चिंतन।';

  @override
  String get onboardingFeatureQiblaAligned => 'क़िबला संरेखित • मक्का मुकर्रमा';

  @override
  String get onboardingFeatureTapToCount =>
      'गिनने के लिए कहीं भी टैप करें या स्वाइप करें';

  @override
  String get onboardingPermissionsTitle => 'आसान सेटअप';

  @override
  String get onboardingPermissionsSubtitle =>
      'नमाज़ के सही समय और अज़ान अलर्ट के लिए अनुमतियां प्रदान करें।';

  @override
  String get onboardingPermLocationTitle => 'सटीक लोकेशन';

  @override
  String get onboardingPermLocationDesc =>
      'केवल आपके फोन में सूर्योदय और सूर्यास्त के समय की गणना के लिए उपयोग की जाती है।';

  @override
  String get onboardingPermNotifTitle => 'अज़ान और नमाज़ अलर्ट';

  @override
  String get onboardingPermNotifDesc =>
      'समय पर अज़ान और सुन्नत नमाज़ों की याद दिलाने के लिए।';

  @override
  String get onboardingPermBatteryTitle => 'विश्वसनीय पृष्ठभूमि अलार्म';

  @override
  String get onboardingPermBatteryDesc =>
      'एंड्रॉयड बैटरी सेवर को फज्र अज़ान अलार्म रोकने से रोकता है।';

  @override
  String get onboardingPermGrant => 'अनुमति दें';

  @override
  String get onboardingPermGranted => 'अनुमति दी गई';

  @override
  String get onboardingPermEnableLater => 'बाद में सेटिंग्स में सेट करें';

  @override
  String get onboardingDedicationVerse =>
      '“बेशक नमाज़ ईमान वालों पर तयशुदा वक़्तों में फ़र्ज़ की गई है।”';

  @override
  String get onboardingDedicationReference => 'सूरह अन-निसा (4:103)';

  @override
  String get onboardingBeginJourney => 'बिस्मिल्लाह • शुरू करें';

  @override
  String get onboardingReplayTour => 'परिचय यात्रा दोबारा देखें';

  @override
  String get onboardingReplayTourSubtitle =>
      'ऐप की विशेषताओं और गोपनीयता के वादे को फिर से देखें';

  @override
  String get onboardingBack => 'पीछे';

  @override
  String get navTracker => 'Tracker';

  @override
  String get prayerSunset => 'सूर्यास्त';

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
  String get settingsBatteryExempt => 'छूट प्राप्त';

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
  String get categoryAll => 'सभी';

  @override
  String get categoryHadith => 'हदीस';

  @override
  String get categoryAyah => 'आयात';

  @override
  String get categoryDua => 'दुआएं';

  @override
  String get categoryMorning => 'सुबह';

  @override
  String get categoryEvening => 'शाम';

  @override
  String get categoryAfterPrayer => 'नमाज़ के बाद';

  @override
  String get categoryForgiveness => 'तौबा व माफ़ी';

  @override
  String get categoryProtection => 'हिफ़ाज़त';

  @override
  String get categoryDaily => 'दैनिक';

  @override
  String get categoryTravel => 'सफ़र';

  @override
  String get noSavedItems => 'अभी तक कोई सुरक्षित सामग्री नहीं है';

  @override
  String get noSavedItemsSubtitle =>
      'यहां सहेजने के लिए बुकमार्क आइकन पर टैप करें।';

  @override
  String get searchPlaceholder => 'दुआ, अनुवाद या स्रोत खोजें...';

  @override
  String get sunnahPrayerHeader => 'सुन्नत नमाज़';

  @override
  String get sunnahFajrDesc => 'फ़र्ज़ से पहले २ रकअत सुन्नत';

  @override
  String get sunnahDhuhrDesc => 'फ़र्ज़ से पहले ४ और बाद में २ रकअत';

  @override
  String get sunnahAsrDesc => 'फ़र्ज़ से पहले ४ रकअत सुन्नत';

  @override
  String get sunnahMaghribDesc => 'फ़र्ज़ के बाद २ रकअत सुन्नत';

  @override
  String get sunnahIshaDesc => 'फ़र्ज़ के बाद २ रकअत सुन्नत + ३ वित्र';

  @override
  String get forbiddenNaflHeader => 'नफ़्ल नमाज़ के मकरूह औक़ात';

  @override
  String get forbiddenNaflBody =>
      'सूर्योदय (~२० मिनट), दोपहर के ज़वाल (~१० मिनट) और सूर्यास्त (~२० मिनट) के समय नफ़्ल नमाज़ पढ़ना मना है। क़ज़ा नमाज़ पढ़ी जा सकती है। (सहीह मुस्लिम ८३१)';

  @override
  String get forbiddenNaflSunriseHeader => 'मकरूह वक़्त • सूर्योदय';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'सूरज निकल रहा है ($startTime – $endTime)। सूरज पूरी तरह निकलने तक नफ़्ल नमाज़ मना है। (सहीह मुस्लिम ८३१)';
  }

  @override
  String get forbiddenNaflZawalHeader => 'मकरूह वक़्त • ज़वाल';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'सूरज ठीक दोपहर में है ($startTime – $endTime)। इस समय नफ़्ल नमाज़ मना है। (सहीह मुस्लिम ८३१)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'मकरूह वक़्त • सूर्यास्त';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'सूरज डूब रहा है ($startTime – $endTime)। सूर्यास्त पूरा होने तक नफ़्ल नमाज़ मना है। (सहीह मुस्लिम ८३१)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return '$prayer का समय अभी शुरू नहीं हुआ है ($time)';
  }

  @override
  String get timeStart => 'शुरू';

  @override
  String get timeEnd => 'समाप्त';

  @override
  String get onboardingShowcasePrayerTitle => 'नमाज़ के सटीक और सही औक़ात';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'मान्यता प्राप्त इस्लामी तरीकों से १००% ऑफलाइन नमाज़ के समय की सही गणना।';

  @override
  String get onboardingShowcaseQiblaTitle => 'सटीक क़िबला कम्पास';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'दुनिया के किसी भी कोने से काबा शरीफ की सही दिशा आसानी से मालूम करें।';

  @override
  String get onboardingShowcaseTasbihTitle => 'डिजिटल तस्बीह और अज़कार';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'वाइब्रेशन फीडबैक और ऑटो-नेक्स्ट के साथ बेहतरीन डिजिटल तस्बीह काउंटर।';

  @override
  String get onboardingShowcaseReflectionTitle => 'दैनिक आयतें, हदीस और दुआएं';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'सटीक अनुवाद के साथ सहीह हदीसें, क़ुरआनी आयतें और ज़रूरी मसनून दुआएं।';

  @override
  String get settingsPrayerNotifications => 'नमाज़ की सूचनाएं';

  @override
  String get settingsAdhanReciterTone => 'मुअज़्ज़िन और अज़ान की आवाज़';

  @override
  String get settingsDailyReminderTime => 'दैनिक विचार की सूचना';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count लाइव विजेट';
  }

  @override
  String get settingsFiqhAsr => 'फ़िक़्ह (अस्र का समय)';

  @override
  String get settingsFiqhStandardTitle => 'शाफई / मानक (डिफ़ॉल्ट)';

  @override
  String get settingsFiqhStandardDesc => 'शाफई, मालिकी और हनबली (१ गुना साया)';

  @override
  String get settingsFiqhStandardSub =>
      'साये की लंबाई = वस्तु के बराबर (१ गुना)। शाफई, मालिकी, हनबली और अधिकांश संस्थान।';

  @override
  String get settingsFiqhHanafiTitle => 'हनफ़ी';

  @override
  String get settingsFiqhHanafiDesc => 'हनफ़ी मसलक (२ गुना साया)';

  @override
  String get settingsFiqhHanafiSub =>
      'साये की लंबाई = वस्तु से दोगुनी (२ गुना)। इमाम अबू हनीफ़ा रह. के फ़िक़्ह अनुसार।';

  @override
  String get settingsPreAdhanReminder => 'अज़ान से पहले याद दिलाना';

  @override
  String get settingsBatteryRestricted => 'प्रतिबंधित';

  @override
  String get settingsBatteryExemptDesc =>
      'छूट प्राप्त — अज़ान के अलर्ट समय पर बजेंगे';

  @override
  String get settingsBatteryNotExemptDesc =>
      'छूट नहीं — बैकग्राउंड में अलर्ट में देरी हो सकती है';

  @override
  String get settingsCheckBatteryNow => 'अभी स्थिति जांचें';

  @override
  String get settingsCheckBatterySubtitle => 'बैकग्राउंड अनुमति की पुष्टि करें';

  @override
  String get settingsWarnBattery => 'पुनः अनुकूलित होने पर चेतावनी दें';

  @override
  String get settingsWarnBatterySubtitle =>
      'यदि सिस्टम बैटरी सेवर चालू करता है तो अलर्ट करें';

  @override
  String get settingsOpenSourceFootnote =>
      '१००% मुफ़्त और ओपन सोर्स • कोई विज्ञापन नहीं • कोई डेटा संग्रह नहीं';

  @override
  String get settingsAsrCalculationTitle => 'अस्र गणना पद्धति (फ़िक़्ह)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'अस्र नमाज़ के समय के लिए फ़िक़्ही मसलक चुनें।';

  @override
  String get adhanVoiceMakkah => 'मक्का (अली मुल्ला)';

  @override
  String get adhanVoiceMadinah => 'मदीना (अब्दुल मजीद)';

  @override
  String get adhanVoiceAlAqsa => 'अल-अक़्सा (यासिर अद-दौसरी)';

  @override
  String get adhanVoiceSoft => 'पारंपरिक शांत आवाज़';

  @override
  String get calcMethodUmmAlQura => 'उम्म अल-क़ुरा (सऊदी अरब)';

  @override
  String get calcMethodMwl => 'मुस्लिम वर्ल्ड लीग (MWL)';

  @override
  String get calcMethodEgyptian => 'मिस्र सामान्य सर्वेक्षण प्राधिकरण';

  @override
  String get calcMethodIsna => 'इस्ना (उत्तरी अमेरिका)';

  @override
  String get calcMethodKarachi => 'कराची इस्लामी विज्ञान विश्वविद्यालय';

  @override
  String get calcMethodDubai => 'दुबई इस्लामी मामले विभाग';

  @override
  String get calcMethodDiyanet => 'दियानत (तुर्की)';

  @override
  String get calcMethodSingapore => 'मुइस (सिंगापुर)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'नमाज़ वैसे पढ़ो जैसे तुमने मुझे पढ़ते देखा';

  @override
  String get learnSalahAuthenticBadge => 'प्रामाणिक सुन्नत मार्गदर्शिका';

  @override
  String get learnSalahSearchPlaceholder =>
      'मुद्रा, चरण या हदीस प्रमाण खोजें...';

  @override
  String get learnSalahLearningModules => 'अध्ययन मॉड्यूल';

  @override
  String get learnSalahStepByStepTitle => 'चरण-दर-चरण नबवी नमाज़ गाइड';

  @override
  String get learnSalahStepByStepSubtitle =>
      'चित्रों और प्रमाणों के साथ १० क्रमिक चरण';

  @override
  String get learnSalahPillarsTitle => 'नमाज़ के १४ अरकान (फ़र्ज़)';

  @override
  String get learnSalahPillarsSubtitle => 'नमाज़ के अनिवार्य बुनियादी स्तंभ';

  @override
  String get learnSalahObligationsTitle => 'नमाज़ के ८ वाजिबात';

  @override
  String get learnSalahObligationsSubtitle =>
      'अनिवार्य कर्म जो सजदा सहव से पूरे किए जाते हैं';

  @override
  String get learnSalahSunanTitle => 'नमाज़ की सुन्नतें';

  @override
  String get learnSalahSunanSubtitle => 'नबी करीम ﷺ की कौली और फेली सुन्नतें';

  @override
  String get learnSalahInvalidatorsTitle => 'नमाज़ तोड़ने वाले कारण';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'वे बातें जिनसे नमाज़ टूट जाती है';

  @override
  String get learnSalahForbiddenTimesTitle => 'नमाज़ के लिए निषिद्ध समय';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'वे समय जब नफ़्ल नमाज़ पढ़ना मना है';

  @override
  String get madhabShafi => 'शाफई';

  @override
  String get madhabHanafi => 'हनफ़ी';

  @override
  String get eventIslamicNewYear => 'इस्लामी नया साल';

  @override
  String get eventTasua => 'तासुआ का दिन';

  @override
  String get eventAshura => 'आशूरा का दिन';

  @override
  String get eventMawlid => 'ईद मीलाद-उन-नबी ﷺ';

  @override
  String get eventIsraMiraj => 'शबे मेराज';

  @override
  String get eventMidShaban => 'शबे बारात (मध्य शाबान)';

  @override
  String get eventRamadanStart => 'माहे रमज़ान का पहला दिन';

  @override
  String get eventBattleOfBadr => 'जंगे बद्र';

  @override
  String get eventLaylatAlQadr => 'शबे क़द्र (लैलतुल क़द्र)';

  @override
  String get eventEidAlFitr => 'ईदुल फ़ित्र';

  @override
  String get eventShawwalSixFasting => 'शव्वाल के ६ रोज़े';

  @override
  String get eventDhuAlHijjahStart => 'ज़ुल हिज्जा का पहला दिन';

  @override
  String get eventDayOfArafah => 'अराफ़ा का दिन';

  @override
  String get eventEidAlAdha => 'ईदुल अज़हा';

  @override
  String get eventDaysOfTashreeq => 'अय्यामे तशरीक़';

  @override
  String get qiblaHeadingTrue => 'वास्तविक दिशा';

  @override
  String get qiblaBearingLabel => 'क़िबला कोण';

  @override
  String get qiblaRetryLocation => 'स्थान पुनः प्रयास करें';

  @override
  String get qiblaCalibClearInterference => 'चुंबकीय व्यवधान से दूर रहें';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'धातु की मेज़ों, कंप्यूटर या चुंबकीय कवर से दूर रहें।';

  @override
  String get qiblaCalibHoldFlat => 'फ़ोन को समतल रखें';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'सटीक दिशा के लिए फ़ोन को ज़मीन के समानांतर सीधा रखें।';

  @override
  String get qiblaCalibFigure8 => 'फ़ोन को ८ के आकार में घुमाएं';

  @override
  String get qiblaCalibFigure8Desc =>
      'कम्पास को कैलिब्रेट करने के लिए हवा में फ़ोन से ८ बनाएं।';

  @override
  String get stepPrevious => 'पिछला';

  @override
  String get stepNext => 'अगला चरण';

  @override
  String get stepFinishGuide => 'गाइड समाप्त करें';

  @override
  String get widgetAddAnother => 'एक और जोड़ें';

  @override
  String get widgetOpenSettings => 'सेटिंग्स खोलें';

  @override
  String get widgetGoToHome => 'होम पर जाएं';

  @override
  String get trackerWeeklyRate => 'साप्ताहिक दर';

  @override
  String get trackerMonthlyRate => 'मासिक दर';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total नमाज़ें';
  }

  @override
  String get tasbihHadithTitle => 'उंगलियों पर तस्बीह पढ़ने की फ़ज़ीलत पर हदीस';

  @override
  String get tasbihHadithText =>
      '“तस्बीह, तहलील और तक़दीस को लाज़िम पकड़ो और उंगलियों के पोरों पर गिनो, क्योंकि क़यामत के दिन उंगलियों से सवाल होगा और वे बोलेंगी।”';

  @override
  String get tasbihHadithReference => '— सुनन अबू दाऊद 1496';

  @override
  String get dhikrSubhanAllah => 'सुब्हानअल्लाह';

  @override
  String get dhikrAlhamdulillah => 'अलहम्दुलिल्लाह';

  @override
  String get dhikrAllahuAkbar => 'अल्लाहु अकबर';

  @override
  String get dhikrAstaghfirullah => 'अस्तग़फ़िरुल्लाह';

  @override
  String get dhikrLaIlahaIllallah => 'ला इलाहा इल्लल्लाह';

  @override
  String get dhikrSalawat => 'दुरूद शरीफ़';

  @override
  String get dhikrSubhanAllahTranslation =>
      'अल्लाह हर ऐब और कमी से बिल्कुल पाक है';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'सब तारीफ़ और शुक्र केवल अल्लाह ही के लिए है';

  @override
  String get dhikrAllahuAkbarTranslation => 'अल्लाह सबसे बड़ा और सर्वोपरि है';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'मैं अल्लाह से अपने गुनाहों की माफ़ी माँगता हूँ';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'अल्लाह के सिवा कोई सच्चा माबूद नहीं है';

  @override
  String get dhikrSalawatTranslation => 'ऐ अल्लाह! मुहम्मद पर रहमत नाज़िल फरमा';

  @override
  String get dhikrDuroodIbrahim => 'दुरूद-ए-इब्राहीमी';

  @override
  String get dhikrDuroodIbrahimTranslation =>
      'अल्लाहुम्मा सल्लि \'अला मुहम्मदिंव-व \'अला आलि मुहम्मद, कमा सल्लैता \'अला इब्राहीमा व \'अला आलि इब्राहीम, इन्नका हमीदुम मजीद। अल्लाहुम्मा बारिक \'अला मुहम्मदिंव-व \'अला आलि मुहम्मद, कमा बारक्ता \'अला इब्राहीमा व \'अला आलि इब्राहीम, इन्नका हमीदुम मजीद।';

  @override
  String get doSalawat => 'Do Salawat';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'अगला: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'कस्टम';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'कस्टम ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'कस्टम लक्ष्य निर्धारित करें';

  @override
  String get tasbihTargetHint => 'लक्ष्य संख्या दर्ज करें (उदा. 50)';

  @override
  String get tasbihCancel => 'रद्द करें';

  @override
  String get tasbihSetTarget => 'लक्ष्य तय करें';

  @override
  String tasbihLap(String lap) {
    return 'चक्र $lap';
  }

  @override
  String get forbiddenTimesNotificationTitle => 'मकरूह औक़ात की सूचनाएं';

  @override
  String get forbiddenTimesNotificationSubtitle =>
      'नफ़्ल नमाज़ के मकरूह समय का अलर्ट';

  @override
  String get forbiddenNaflUpcomingSunriseHeader =>
      'आगामी मकरूह वक़्त • सूर्योदय';

  @override
  String forbiddenNaflUpcomingSunriseBody(String time) {
    return 'सूर्योदय के समय $time पर नफ़्ल नमाज़ पढ़ना मकरूह हो जाएगा। इससे पहले अपनी नफ़्ल नमाज़ पूरी कर लें।';
  }

  @override
  String get forbiddenNaflUpcomingZawalHeader => 'आगामी मकरूह वक़्त • ज़वाल';

  @override
  String forbiddenNaflUpcomingZawalBody(String time) {
    return 'दोपहर में ज़वाल के समय $time पर नफ़्ल नमाज़ पढ़ना मकरूह हो जाएगा। इससे पहले अपनी नफ़्ल नमाज़ पूरी कर लें।';
  }

  @override
  String get forbiddenNaflUpcomingSunsetHeader =>
      'आगामी मकरूह वक़्त • सूर्यास्त';

  @override
  String forbiddenNaflUpcomingSunsetBody(String time) {
    return 'सूर्यास्त से पहले $time पर नफ़्ल नमाज़ पढ़ना मकरूह हो जाएगा। इससे पहले अपनी नफ़्ल नमाज़ पूरी कर लें।';
  }

  @override
  String get forbiddenNaflConcludedHeader => 'मकरूह वक़्त समाप्त';

  @override
  String get forbiddenNaflConcludedBody =>
      'मकरूह समय समाप्त हो चुका है। अब नफ़्ल नमाज़ पढ़ी जा सकती है।';

  @override
  String get solarTimingsTitle => 'सौर समय';

  @override
  String get daylightWindowNote =>
      'दिन के उजाले की अवधि: सूर्योदय के साथ ही फज्र समाप्त होता है। सूर्यास्त के साथ मगरिब शुरू होता है।';

  @override
  String get prayerStarts => 'शुरू';

  @override
  String get prayerStarted => 'शुरू हुआ';

  @override
  String get prayerEnds => 'समाप्त';

  @override
  String get badgeCurrent => 'वर्तमान';

  @override
  String get badgeNext => 'अगला';

  @override
  String get shuruqBadge => 'शुरूक़ (सूर्योदय)';

  @override
  String get continueToPrayerTimes => 'नमाज़ के समय पर जाएँ';

  @override
  String tomorrowAt(String time) {
    return 'कल $time बजे';
  }

  @override
  String get fridayJumuahTitle => 'जुमु\'आह';

  @override
  String get fridayLocationLabel => 'स्थान';

  @override
  String get fridayAtMosque => 'मस्जिद में';

  @override
  String get fridayAtHome => 'घर पर';

  @override
  String get fridaySunnahRulingsTitle => 'जुमा की सुन्नतें और अहकाम';

  @override
  String get fridayBeforeLabel => 'पहले';

  @override
  String get fridayAfterLabel => 'बाद में';

  @override
  String get fridayMosqueBeforeDesc =>
      'तहिय्यतुल मस्जिद और खुतबा शुरू होने तक नफ़्ल नमाज़।';

  @override
  String get fridayMosqueAfterDesc =>
      '४ रकात सुन्नत (मस्जिद में) या २ रकात सुन्नत (घर पर पढ़ने की सूरत में)।';

  @override
  String get fridayHomeBeforeDesc =>
      'ज़ुहर से पहले ४ रकात सुन्नत (घर पर ज़ुहर पढ़ने वालों के लिए)।';

  @override
  String get fridayHomeAfterDesc =>
      'ज़ुहर के बाद २ रकात सुन्नत (घर पर ज़ुहर पढ़ने वालों के लिए)।';

  @override
  String get fridayClickToReadFull =>
      'सहीह हदीसों और अहकाम की तफ़्सील देखने के लिए टैप करें';

  @override
  String get fridaySuiteHeader => 'जुमा की सुन्नतें और नेक आमाल';

  @override
  String get fridayTodayOnly => 'सिर्फ जुमा के दिन उपलब्ध';

  @override
  String get surahKahfTitle => 'सूरह अल-कहफ़';

  @override
  String get surahKahfBadge => 'दो जुमों के बीच नूर';

  @override
  String get surahKahfHadith =>
      'जो शख्स जुमा के दिन सूरह अल-कहफ़ पढ़ेगा, उसके लिए दोनों जुमों के दरमियान नूर रोशन रहेगा। (अल-बैहक़ी)';

  @override
  String get markAsRead => 'पढ़ा हुआ मार्क करें';

  @override
  String get readCompleted => 'मुकम्मल';

  @override
  String get salawatTitle => 'नबी करीम ﷺ पर कसरत से दुरूद';

  @override
  String get salawatBadge => 'सलाम पेश किया जाता है';

  @override
  String get salawatHadith =>
      'जुमा के दिन मुझ पर कसरत से दुरूद भेजो, क्योंकि तुम्हारा दुरूद मुझ पर पेश किया जाता है। (अबू दाऊद)';

  @override
  String get salawatCountLabel => 'आज पढ़े गए दुरूद';

  @override
  String get salawatTapBtn => 'दुरूद शरीफ़ पढ़ें (+१)';

  @override
  String get fridayEtiquettesTitle => 'जुमा की सुन्नतें और आदाब';

  @override
  String get fridayEtiquettesRef => 'जुमा की मोतबर सुन्नतें';

  @override
  String get fridayGhusl => 'नमाज़ से पहले ग़ुस्ल करना';

  @override
  String get fridaySiwak => 'मिस्वाक का इस्तेमाल और खुशबू लगाना';

  @override
  String get fridayCleanClothes => 'साफ-सुथरे और बेहतरीन कपड़े पहनना';

  @override
  String get fridayEarlyMosque => 'खुतबा सुनने के लिए जल्दी मस्जिद पहुंचना';

  @override
  String get istijabahTitle => 'क़बूलियत की घड़ी (साअतुल इस्तिजाबा)';

  @override
  String get istijabahBadge => 'दुआ क़बूल होती है';

  @override
  String get istijabahHadith =>
      'जुमा के दिन एक ऐसी घड़ी है जिसमें कोई मुसलमान बंदा अल्लाह से भलाई की दुआ मांगे तो वह उसे अता करता है — इसे अस्र के बाद अंतिम घड़ी में तलाश करो। (अबू दाऊद, अन-नसाई)';

  @override
  String get fridayHadithGuideSheetTitle =>
      'जुमा की सुन्नतों की रहनुमाई: हदीस की रोशनी में';

  @override
  String get fridayHadithBeforeCardTitle => 'जुमु\'आह / ज़ुहर की नमाज़ से पहले';

  @override
  String get fridayHadithBeforeCardDesc =>
      'मस्जिद में: दाखिल होते ही २ रकात तहिय्यतुल मस्जिद और इमाम के मिंबर पर जाने तक नफ़्ल नमाज़। घर पर (ज़ुहर): ज़ुहर से पहले ४ रकात सुन्नते मुअक्कदा।';

  @override
  String get fridayHadithAfterMosqueTitle => 'जुमा के बाद मस्जिद में (४ रकात)';

  @override
  String get fridayHadithAfterMosqueDesc =>
      'हज़रत अबू हुरैरा (र.अ.) से रिवायत है कि रसूलुल्लाह ﷺ ने फरमाया: \'जब तुम में से कोई जुमा पढ़ चुके तो उसके बाद चार रकात पढ़े।\' (सहीह मुस्लिम ८८१)';

  @override
  String get fridayHadithAfterHomeTitle => 'जुमा के बाद घर पर (२ रकात)';

  @override
  String get fridayHadithAfterHomeDesc =>
      'हज़रत इब्ने उमर (र.अ.) से रिवायत है: \'नबी करीम ﷺ जुमा के बाद नमाज़ नहीं पढ़ते थे जब तक कि घर न लौट आते, फिर घर आकर दो रकात पढ़ते थे।\' (सहीह अल-बुख़ारी ९३७, सहीह मुस्लिम ८८२)';

  @override
  String get closeGuideBtn => 'गाइड बंद करें';
}
