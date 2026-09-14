// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appTitle => 'Salah Companion';

  @override
  String get navHome => 'Asosiy';

  @override
  String get navDuas => 'Duolar';

  @override
  String get navTasbih => 'Tasbeh';

  @override
  String get navQibla => 'Qibla';

  @override
  String get navCalendar => 'Taqvim';

  @override
  String get prayerFajr => 'Bomdod';

  @override
  String get prayerSunrise => 'Quyosh';

  @override
  String get prayerDhuhr => 'Peshin';

  @override
  String get prayerAsr => 'Asr';

  @override
  String get prayerMaghrib => 'Shom';

  @override
  String get prayerIsha => 'Xufton';

  @override
  String get upcomingPrayer => 'UPCOMING PRAYER';

  @override
  String get currentSalah => 'CURRENT SALAH';

  @override
  String get remaining => 'qoldi';

  @override
  String get statusPrayed => 'O\'qildi';

  @override
  String get statusMissed => 'Qazo';

  @override
  String get statusPending => 'Kutilmoqda';

  @override
  String get qiblaCompassTitle => 'Qibla kompas';

  @override
  String get qiblaCalibrate => 'Kalibrlash';

  @override
  String get qiblaFacingKaaba => 'Kaʼbaga tomon aniq yoʻnalish';

  @override
  String get tasbihTitle => 'Raqamli tasbeh';

  @override
  String get tasbihReset => 'Qayta oʻrnatish';

  @override
  String get tasbihAutoNext => 'Avto oʻtish';

  @override
  String get tasbihBestOnFingers => 'Tasbehni barmoqlar bilan sanash sunnatdir';

  @override
  String get guidanceCategory => 'KOʻRSATMALAR';

  @override
  String get learnSalah => 'Namoz oʻrganish';

  @override
  String get learnSalahSubtitle =>
      'Sahih sunnat va hadislar asosida namoz oʻqish tartibi';

  @override
  String get savedItems => 'Saqlanganlar';

  @override
  String get savedItemsSubtitle => 'Hadislar, Oyatlar va Duolar';

  @override
  String get prayerTracker => 'Namoz hisobi';

  @override
  String get prayerTrackerSubtitle => 'Namoz statistikangizni koʻring';

  @override
  String get widgetsTitle => 'Vidjetlar';

  @override
  String get widgetsSubtitle => 'Asosiy ekranga vidjet qoʻshish';

  @override
  String get openSourcePrivacy => 'Ochiq kod va maxfiylik';

  @override
  String get openSourcePrivacySubtitle =>
      '100% oflayn, kuzatuvsiz va notijorat';

  @override
  String get themeMode => 'MAVZU REJIMI';

  @override
  String get themeSystem => 'Tizim';

  @override
  String get themeLight => 'Yorugʻ';

  @override
  String get themeDark => 'Tungi';

  @override
  String notificationPrayerTitle(String prayer) {
    return '$prayer namozi';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return '$prayer namozi vaqti kirdi. Namozga tayyorlaning.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'Vaqt boshidagi eslatma — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return '$prayer vaqtidan 15 daqiqa oʻtdi. Namozingizni oʻqidingizmi?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'Muhim — $prayer namozi tugashiga 30 daqiqa qoldi';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return '$prayer namozi vaqti chiqib ketishiga atigi 30 daqiqa qoldi.';
  }

  @override
  String get notificationDailyReflectionTitle => 'Kunlik ibrat';

  @override
  String get notificationTestTitle => 'Salah Companion bildirishnomasi';

  @override
  String get notificationTestBody =>
      'Bildirishnomalar va azon ovozi muvaffaqiyatli sozlandi.';

  @override
  String get onboardingChooseLanguage => 'Tilingizni tanlang';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'Namoz vaqtlari va koʻrsatmalar uchun qulay tilni tanlang.';

  @override
  String get onboardingWelcomeTitle =>
      'Salah Companion ilovasiga xush kelibsiz';

  @override
  String get onboardingWelcomeBody =>
      'Aniq namoz vaqtlari, qibla yoʻnalishi va sahih sunnatlar uchun ishonchli hamrohingiz.';

  @override
  String get onboardingSwipeTitle => 'Menyu uchun chap chetdan suring';

  @override
  String get onboardingSwipeBody =>
      'Saqlanganlar va namoz hisobiga kirish uchun ekranning chap chetidan suring.';

  @override
  String get onboardingSunnahTitle => 'Sahih Sunnat va Hidoyat';

  @override
  String get onboardingSunnahBody =>
      'Kunlik Qurʼon oyatlari, sahih hadislar, duolar va namoz oʻqish qoidalari.';

  @override
  String get onboardingCustomizationTitle => 'Qibla, Tasbeh va Sozlamalar';

  @override
  String get onboardingCustomizationBody =>
      'Qibla kompas, raqamli tasbeh va hisoblash usullarini sozlang.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$total DAN $current';
  }

  @override
  String get onboardingSkip => 'Oʻtkazib yuborish';

  @override
  String get onboardingNext => 'Keyingi';

  @override
  String get onboardingGetStarted => 'Boshlash';

  @override
  String get systemDefault => 'Tizim tili';

  @override
  String get moreLanguages => 'Boshqa tillar';

  @override
  String get searchLanguagePlaceholder => 'Tilni qidirish...';

  @override
  String get settingsTitle => 'Sozlamalar';

  @override
  String get settingsLanguage => 'Til';

  @override
  String get settingsLanguageSubtitle => 'Ilova tilini oʻzgartirish';

  @override
  String get onboardingTrustTitle => 'Sizga bo\'lgan muqaddas omonatimiz';

  @override
  String get onboardingTrustSubtitle =>
      'Faqat Alloh roziligi uchun yaratilgan — reklamasiz, kuzatuvsiz, 100% maxfiy.';

  @override
  String get onboardingTrustOfflineTitle => '100% Qurilma ichida va Oflayn';

  @override
  String get onboardingTrustOfflineDesc =>
      'Joylashuvingiz va ibodat ma\'lumotlaringiz hech qachon telefoningizdan tashqariga chiqmaydi.';

  @override
  String get onboardingTrustNoAdsTitle => 'Umuman reklama yo\'q';

  @override
  String get onboardingTrustNoAdsDesc =>
      'Ibodat halovatini buzuvchi hech qanday reklama yoki bannerlar mavjud emas.';

  @override
  String get onboardingTrustNoTrackingTitle =>
      'Kuzatuv va ma\'lumot yig\'ish yo\'q';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'Shaxsiy ma\'lumotlar yig\'ilmaydi va orqa fonda kuzatilmaydi.';

  @override
  String get onboardingTrustFreeTitle => 'Ummat uchun doimo bepul';

  @override
  String get onboardingTrustFreeDesc =>
      'Sadaqai jariya sifatida tayyorlangan. Obunalar yoki to\'lovlar yo\'q.';

  @override
  String get onboardingFeaturesTitle => 'Asosiy imkoniyatlar';

  @override
  String get onboardingFeaturesSubtitle =>
      'Aniq namoz vaqtlari, sahih sunnat va ibodat vositalari.';

  @override
  String get onboardingFeaturePrayerTitle => 'Astronomik aniqlik';

  @override
  String get onboardingFeaturePrayerDesc =>
      'Quyosh harakatiga mos aniq hisob-kitob va sunnat namozi eslatmalari.';

  @override
  String get onboardingFeatureQiblaTitle => 'Haqiqiy vaqtli Qibla kompassi';

  @override
  String get onboardingFeatureQiblaDesc =>
      'Ka\'ba yo\'nalishini aniq ko\'rsatish va to\'g\'ri kelganda tebranish signali.';

  @override
  String get onboardingFeatureTasbihTitle => 'Sezgir raqamli tasbeh';

  @override
  String get onboardingFeatureTasbihDesc =>
      'Barmoq bilan sanash hissini beruvchi tebranish va ma\'sur zikrlar.';

  @override
  String get onboardingFeatureSunnahTitle => 'Sahih sunnat va duolar';

  @override
  String get onboardingFeatureSunnahDesc =>
      'Sahih Buxoriy va Muslim to\'plamlaridan olingan sahih hadislar va kunlik oyatlar.';

  @override
  String get onboardingFeatureQiblaAligned => 'Qiblaga yo\'naltirildi • Makka';

  @override
  String get onboardingFeatureTapToCount =>
      'Sanash uchun ekranga bosing yoki suring';

  @override
  String get onboardingPermissionsTitle => 'Oson sozlash';

  @override
  String get onboardingPermissionsSubtitle =>
      'Namoz vaqtlarini aniqlash va azon bildirishnomalari uchun ruxsat bering.';

  @override
  String get onboardingPermLocationTitle => 'Aniq joylashuv';

  @override
  String get onboardingPermLocationDesc =>
      'Faqat qurilmangizda namoz vaqtlarini hisoblash uchun ishlatiladi.';

  @override
  String get onboardingPermNotifTitle => 'Azon va namoz eslatmalari';

  @override
  String get onboardingPermNotifDesc =>
      'Azonni o\'z vaqtida yetkazish va sunnat namozlarini eslatish uchun.';

  @override
  String get onboardingPermBatteryTitle => 'Orqa fonda ishonchli ishlash';

  @override
  String get onboardingPermBatteryDesc =>
      'Android batareya tejamkori bomdod azonini o\'chirib qo\'ymasligini ta\'minlaydi.';

  @override
  String get onboardingPermGrant => 'Ruxsat berish';

  @override
  String get onboardingPermGranted => 'Ruxsat berildi';

  @override
  String get onboardingPermEnableLater => 'Keyinroq sozlamalarda yoqish';

  @override
  String get onboardingDedicationVerse =>
      '«Albatta, namoz mo\'minlarga vaqtida tayinlangan farzdir.»';

  @override
  String get onboardingDedicationReference => 'Niso surasi (103)';

  @override
  String get onboardingBeginJourney => 'Bismillah • Boshlang';

  @override
  String get onboardingReplayTour => 'Tanishtiruvni qayta ko\'rish';

  @override
  String get onboardingReplayTourSubtitle =>
      'Ilova imkoniyatlari va maxfiylik kafolatlarini yana bir bor ko\'ring';

  @override
  String get onboardingBack => 'Orqaga';

  @override
  String get navTracker => 'Tracker';

  @override
  String get prayerSunset => 'Quyosh botishi';

  @override
  String get statusNotPrayed => 'O\'qilmadi';

  @override
  String get statusUpcoming => 'Kutilmoqda';

  @override
  String get statusNotYet => 'Vaqti kirmadi';

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
  String get settingsBatteryExempt => 'Istisno Qilingan';

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
  String get categoryAll => 'Barchasi';

  @override
  String get categoryHadith => 'Hadislar';

  @override
  String get categoryAyah => 'Oyatlar';

  @override
  String get categoryDua => 'Duolar';

  @override
  String get categoryMorning => 'Tong';

  @override
  String get categoryEvening => 'Kechqurun';

  @override
  String get categoryAfterPrayer => 'Namozdan so\'ng';

  @override
  String get categoryForgiveness => 'Istig\'for va tavba';

  @override
  String get categoryProtection => 'Himoya';

  @override
  String get categoryDaily => 'Kundalik';

  @override
  String get categoryTravel => 'Safar';

  @override
  String get noSavedItems => 'Hozircha saqlangan narsalar yo\'q';

  @override
  String get noSavedItemsSubtitle =>
      'Kontentni bu yerda saqlash uchun xatcho\'p belgisini bosing.';

  @override
  String get searchPlaceholder =>
      'Duolar, tarjimalar yoki manbalarni qidirish...';

  @override
  String get sunnahPrayerHeader => 'SUNNAT NAMOZI';

  @override
  String get sunnahFajrDesc => 'Farzdan oldin 2 rakat sunnati muakkada';

  @override
  String get sunnahDhuhrDesc => 'Farzdan oldin 4 rakat va keyin 2 rakat';

  @override
  String get sunnahAsrDesc => 'Farzdan oldin 4 rakat sunnat';

  @override
  String get sunnahMaghribDesc => 'Farzdan keyin 2 rakat sunnati muakkada';

  @override
  String get sunnahIshaDesc => 'Farzdan keyin 2 rakat sunnat + 3 rakat Vitr';

  @override
  String get forbiddenNaflHeader =>
      'NAFL NAMOZ O\'QISH MAKRUH BO\'LGAN VAQTLAR';

  @override
  String get forbiddenNaflBody =>
      'Quyosh chiqayotganda (~20 daqiqa), quyosh tikkaga kelganda (~10 daqiqa) va quyosh botayotganda (~20 daqiqa) nafl namoz o\'qish man etiladi. Qazo namozlarini o\'qish joiz. (Sahih Muslim 831)';

  @override
  String get forbiddenNaflSunriseHeader => 'MAKRUH VAQT • QUYOSH CHIQISHI';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'Quyosh chiqmoqda ($startTime – $endTime). Quyosh to\'liq ko\'tarilguncha nafl namoz o\'qilmaydi. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflZawalHeader => 'MAKRUH VAQT • ZAVOL (TIKKA QUYOSH)';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'Quyosh tikkaga kelgan ($startTime – $endTime). Bu vaqtda nafl namoz o\'qish makruh. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'MAKRUH VAQT • QUYOSH BOTISHI';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'Quyosh botmoqda ($startTime – $endTime). Botish to\'liq tugamaguncha nafl namoz o\'qilmaydi. (Sahih Muslim 831)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return '$prayer namozi vaqti hali kirmadi ($time)';
  }

  @override
  String get timeStart => 'Boshlanishi';

  @override
  String get timeEnd => 'Tugashi';

  @override
  String get onboardingShowcasePrayerTitle =>
      'Aniq Va To\'g\'ri Namoz Vaqtlari';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'Xalqaro ishonchli usullar asosida 100% oflayn aniq namoz vaqtlari hisobi.';

  @override
  String get onboardingShowcaseQiblaTitle => 'Haqiqiy Qibla Kompasi';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'Dunyoning istalgan nuqtasidan Ka\'baga to\'g\'ri yo\'nalishni oson toping.';

  @override
  String get onboardingShowcaseTasbihTitle => 'Qulay Raqamli Tasbeh';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'Vibratsiya signali va avtomatik o\'tish imkoniyatiga ega aqlli zikr sanagich.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'Kunlik Oyatlari, Hadislar Va Duolar';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'Ishonchli tarjimalarga ega sahih hadislar, Qur\'on oyatlari va kundalik duolar.';

  @override
  String get settingsPrayerNotifications => 'Namoz Bildirishnomalari';

  @override
  String get settingsAdhanReciterTone => 'Muazzin va Azon Tovushi';

  @override
  String get settingsDailyReminderTime => 'Kunlik Tafakkur Vaqti';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count Jonli Vidjet';
  }

  @override
  String get settingsFiqhAsr => 'Fiqh (Asr Vaqti)';

  @override
  String get settingsFiqhStandardTitle => 'Shofeiy / Standart (Standart)';

  @override
  String get settingsFiqhStandardDesc =>
      'Shofeiy, Molikiy va Hanbaliy (1x Soya)';

  @override
  String get settingsFiqhStandardSub =>
      'Soya uzunligi = jism bo\'yi (1 barobar). Shofeiy, Molikiy, Hanbaliy va ko\'pchilik.';

  @override
  String get settingsFiqhHanafiTitle => 'Hanafiy';

  @override
  String get settingsFiqhHanafiDesc => 'Hanafiy Mazhabi (2x Soya)';

  @override
  String get settingsFiqhHanafiSub =>
      'Soya uzunligi = jism bo\'yining 2 barobari. Imom Abu Hanifa mazhabi.';

  @override
  String get settingsPreAdhanReminder => 'Azondan Oldingi Eslatma';

  @override
  String get settingsBatteryRestricted => 'Cheklangan';

  @override
  String get settingsBatteryExemptDesc =>
      'Istisno qilingan — Azon xabarlari o\'z vaqtida chalinadi';

  @override
  String get settingsBatteryNotExemptDesc =>
      'Istisno qilinmagan — Orqa fonda kechikishlar bo\'lishi mumkin';

  @override
  String get settingsCheckBatteryNow => 'Holatni Hozir Tekshirish';

  @override
  String get settingsCheckBatterySubtitle =>
      'Orqa fonda ishlash ruxsatlarini tekshiring';

  @override
  String get settingsWarnBattery => 'Qayta Cheklansa Ogohlantirish';

  @override
  String get settingsWarnBatterySubtitle =>
      'Tizim quvvat tejash rejimini yoqsa xabar bering';

  @override
  String get settingsOpenSourceFootnote =>
      '100% Bepul va Ochiq Kodli • Reklamasiz • Ma\'lumot To\'planmaydi';

  @override
  String get settingsAsrCalculationTitle =>
      'Asr Vaqtini Hisoblash Usuli (Fiqh)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'Asr namozi vaqti uchun fiqhiy mazhabni tanlang.';

  @override
  String get adhanVoiceMakkah => 'Makka (Ali Mulla)';

  @override
  String get adhanVoiceMadinah => 'Madina (Abdul Majid)';

  @override
  String get adhanVoiceAlAqsa => 'Al-Aqso (Yosir Al-Davsariy)';

  @override
  String get adhanVoiceSoft => 'An\'anaviy Mayin Ohang';

  @override
  String get calcMethodUmmAlQura => 'Ummul Quro (Saudiya Arabistoni)';

  @override
  String get calcMethodMwl => 'Butunjahon Islom Ligasi (MWL)';

  @override
  String get calcMethodEgyptian => 'Misr Bosh Geodeziya Boshqarmasi';

  @override
  String get calcMethodIsna => 'ISNA (Shimoliy Amerika)';

  @override
  String get calcMethodKarachi => 'Karochi Islom Fanlari Universiteti';

  @override
  String get calcMethodDubai => 'Dubay Islom Ishlari Departamenti';

  @override
  String get calcMethodDiyanet => 'Diyonat (Turkiya)';

  @override
  String get calcMethodSingapore => 'MUIS (Singapur)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'Namozni men qanday o\'qiyotganimni ko\'rganingizdek o\'qing';

  @override
  String get learnSalahAuthenticBadge => 'SAHIH SUNNAT BO\'YICHA QO\'LLANMA';

  @override
  String get learnSalahSearchPlaceholder =>
      'Holat, qadam yoki hadis dalilini qidiring...';

  @override
  String get learnSalahLearningModules => 'O\'RGANISH BO\'LIMLARI';

  @override
  String get learnSalahStepByStepTitle =>
      'Bosqichma-bosqich Namoz Qo\'llanmasi';

  @override
  String get learnSalahStepByStepSubtitle =>
      'Rasmlar va dalillar bilan 10 ta ketma-ket qadam';

  @override
  String get learnSalahPillarsTitle => 'Namozning 14 Farzi va Rukni';

  @override
  String get learnSalahPillarsSubtitle =>
      'Namozning aslo tark etib bo\'lmaydigan asoslari';

  @override
  String get learnSalahObligationsTitle => 'Namozning 8 Vojibi';

  @override
  String get learnSalahObligationsSubtitle =>
      'Sajdai sahv bilan to\'g\'irlanadigan vojib amallar';

  @override
  String get learnSalahSunanTitle => 'Namoz Sunnatlari';

  @override
  String get learnSalahSunanSubtitle =>
      'Payg\'ambarimiz ﷺ ning so\'z va amaliy sunnatlari';

  @override
  String get learnSalahInvalidatorsTitle => 'Namozni Buzuvchi Amallar';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'Namozni botil qiluvchi va qayta o\'qishni vojib qiluvchi holatlar';

  @override
  String get learnSalahForbiddenTimesTitle =>
      'Namoz O\'qish Makruh Bo\'lgan Vaqtlar';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'Nafl namozlarni o\'qish qat\'iyan taqiqlangan vaqtlar';

  @override
  String get madhabShafi => 'Shofeiy';

  @override
  String get madhabHanafi => 'Hanafiy';

  @override
  String get eventIslamicNewYear => 'Hijriy Yangi Yil';

  @override
  String get eventTasua => 'Tosu\'o Kuni';

  @override
  String get eventAshura => 'Asho\'ro Kuni';

  @override
  String get eventMawlid => 'Mavlidi Nabaviy ﷺ';

  @override
  String get eventIsraMiraj => 'Isro va Me\'roj Kechasi';

  @override
  String get eventMidShaban => 'Baroat Kechasi (Sha\'bon O\'rtasi)';

  @override
  String get eventRamadanStart => 'Ramazonning Birinchi Kuni';

  @override
  String get eventBattleOfBadr => 'Badr Jangi';

  @override
  String get eventLaylatAlQadr => 'Qadr Kechasi';

  @override
  String get eventEidAlFitr => 'Ramazon Hayiti (Iyd al-Fitr)';

  @override
  String get eventShawwalSixFasting => 'Shavvol Oyining 6 Kunlik Ro\'zasi';

  @override
  String get eventDhuAlHijjahStart => 'Zulhijja Oyining Boshlanishi';

  @override
  String get eventDayOfArafah => 'Arafa Kuni';

  @override
  String get eventEidAlAdha => 'Qurbon Hayiti (Iyd al-Adha)';

  @override
  String get eventDaysOfTashreeq => 'Tashriq Kunlari';

  @override
  String get qiblaHeadingTrue => 'HAQIQIY YO\'NALISH';

  @override
  String get qiblaBearingLabel => 'QIBLA BURCHAGI';

  @override
  String get qiblaRetryLocation => 'Joylashuvni qayta aniqlash';

  @override
  String get qiblaCalibClearInterference => 'Magnit to\'siqlardan uzoqlashing';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'Metall stollar, kompyuterlar yoki magnitli g\'iloflardan uzoqroq turing.';

  @override
  String get qiblaCalibHoldFlat => 'Telefonni tekis gorizontal ushlang';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'Aniq yo\'nalish uchun telefoningizni yerga parallel tekis ushlang.';

  @override
  String get qiblaCalibFigure8 => '8 shaklida harakatlantiring';

  @override
  String get qiblaCalibFigure8Desc =>
      'Kompasni sozlash uchun telefoningizni havoda 8 shaklida ohista harakatlantiring.';

  @override
  String get stepPrevious => 'Oldingi';

  @override
  String get stepNext => 'Keyingi qadam';

  @override
  String get stepFinishGuide => 'Qo\'llanmani yakunlash';

  @override
  String get widgetAddAnother => 'Yana birini qo\'shish';

  @override
  String get widgetOpenSettings => 'Sozlamalarni ochish';

  @override
  String get widgetGoToHome => 'Bosh sahifaga';

  @override
  String get trackerWeeklyRate => 'Haftalik ko\'rsatkich';

  @override
  String get trackerMonthlyRate => 'Oylik ko\'rsatkich';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total Namoz';
  }

  @override
  String get tasbihHadithTitle => 'BARMOQLAR BILAN TASBEH SANASH HAQIDA HADIS';

  @override
  String get tasbihHadithText =>
      '«Tasbeh, tahlil va taqdis aytishni kanda qilmang va barmoq bo\'g\'inlari bilan sanang, chunki Qiyomat kuni barmoqlardan so\'raladi va ular so\'zlaydilar.»';

  @override
  String get tasbihHadithReference => '— Sunani Abu Dovud 1496';

  @override
  String get dhikrSubhanAllah => 'Subhanalloh';

  @override
  String get dhikrAlhamdulillah => 'Alhamdulillah';

  @override
  String get dhikrAllahuAkbar => 'Allohu Akbar';

  @override
  String get dhikrAstaghfirullah => 'Astag\'firulloh';

  @override
  String get dhikrLaIlahaIllallah => 'La ilaha illalloh';

  @override
  String get dhikrSubhanAllahTranslation =>
      'Alloh barcha ayb va nuqsonlardan mutlaqo pokdir';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'Barcha hamd va shukrlar yolg\'iz Allohgadir';

  @override
  String get dhikrAllahuAkbarTranslation =>
      'Alloh har narsadan ulug\' va buyukdir';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'Allohdan gunohlarim uchun mag\'firat so\'rayman';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'Allohdan o\'zga haqiqiy ibodatga loyiq iloh yo\'qdir';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'Keyingi: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'Boshqa';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'Boshqa ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'Maxsus maqsadni belgilash';

  @override
  String get tasbihTargetHint => 'Maqsad sonini kiriting (masalan, 50)';

  @override
  String get tasbihCancel => 'Bekor qilish';

  @override
  String get tasbihSetTarget => 'Maqsadni belgilash';

  @override
  String tasbihLap(String lap) {
    return 'Aylanish $lap';
  }
}
