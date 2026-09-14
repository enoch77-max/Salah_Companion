// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class AppLocalizationsAz extends AppLocalizations {
  AppLocalizationsAz([String locale = 'az']) : super(locale);

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
  String get remaining => 'qalan vaxt';

  @override
  String get statusPrayed => 'Prayed';

  @override
  String get statusMissed => 'Missed';

  @override
  String get statusPending => 'Pending';

  @override
  String get qiblaCompassTitle => 'Qiblə Kompası';

  @override
  String get qiblaCalibrate => 'Kalibrlə';

  @override
  String get qiblaFacingKaaba => 'Kəbəyə doğru tam istiqamət';

  @override
  String get tasbihTitle => 'Rəqəmsal Təsbeh';

  @override
  String get tasbihReset => 'Sıfırla';

  @override
  String get tasbihAutoNext => 'Avto Keçid';

  @override
  String get tasbihBestOnFingers => 'Təsbehi barmaqlarla çəkmək sünnətdir';

  @override
  String get guidanceCategory => 'RƏHBƏRLİK';

  @override
  String get learnSalah => 'Namaz Təlimi';

  @override
  String get learnSalahSubtitle => 'Səhih sünnə və hədislərlə namaz qaydaları';

  @override
  String get savedItems => 'Saxlanılanlar';

  @override
  String get savedItemsSubtitle => 'Hədislər, Ayələr və Dualar';

  @override
  String get prayerTracker => 'Namaz İzləyicisi';

  @override
  String get prayerTrackerSubtitle => 'Namaz statistikasına baxın';

  @override
  String get widgetsTitle => 'Vidcetlər';

  @override
  String get widgetsSubtitle => 'Əsas ekrana vidcet əlavə edin';

  @override
  String get openSourcePrivacy => 'Açıq Mənbə və Məxfilik';

  @override
  String get openSourcePrivacySubtitle =>
      '100% oflayn, izlənməsiz və qeyri-kommersiya';

  @override
  String get themeMode => 'MÖVZU REJİMİ';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'İşıqlı';

  @override
  String get themeDark => 'Qaranlıq';

  @override
  String notificationPrayerTitle(String prayer) {
    return '$prayer Namazı';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return '$prayer namazının vaxtı daxil oldu. Namaza hazırlaşın.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'İlk Vaxt Xatırlatması — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return '$prayer vaxtından 15 dəqiqə keçdi. Namazınızı qıldınızmı?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'Təcili — $prayer Namazına 30 Dəqiqə Qaldı';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return '$prayer namazının vaxtının çıxmasına cəmi 30 dəqiqə qaldı.';
  }

  @override
  String get notificationDailyReflectionTitle => 'Günün Təfəkkürü';

  @override
  String get notificationTestTitle => 'Salah Companion Bildirişi';

  @override
  String get notificationTestBody =>
      'Bildirişlər və azan səsi uğurla tənzimləndi.';

  @override
  String get onboardingChooseLanguage => 'Dilinizi Seçin';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'Namaz vaxtları və rəhbərlik üçün istədiyiniz dili seçin.';

  @override
  String get onboardingWelcomeTitle => 'Salah Companion-a Xoş Gəlmisiniz';

  @override
  String get onboardingWelcomeBody =>
      'Dəqiq namaz vaxtları, qiblə istiqaməti və səhih sünnət üçün etibarlı yoldaşınız.';

  @override
  String get onboardingSwipeTitle => 'Menyu Üçün Sol Kənardan Sürüşdürün';

  @override
  String get onboardingSwipeBody =>
      'Yadda saxlanılanlara və statistikaya baxmaq üçün ekranın sol kənarından sürüşdürün.';

  @override
  String get onboardingSunnahTitle => 'Səhih Sünnə və Bələdçilik';

  @override
  String get onboardingSunnahBody =>
      'Gündəlik Quran ayələri, səhih hədislər, dualar və namaz qılınma qaydaları.';

  @override
  String get onboardingCustomizationTitle => 'Qiblə, Təsbeh və Tənzimləmələr';

  @override
  String get onboardingCustomizationBody =>
      'Qiblə kompası, rəqəmsal təsbeh və hesablama üsullarını fərdiləşdirin.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$total DƏN $current';
  }

  @override
  String get onboardingSkip => 'Keç';

  @override
  String get onboardingNext => 'Növbəti';

  @override
  String get onboardingGetStarted => 'Başla';

  @override
  String get systemDefault => 'Sistem Dili';

  @override
  String get moreLanguages => 'Digər Dillər';

  @override
  String get searchLanguagePlaceholder => 'Dil axtarın...';

  @override
  String get settingsTitle => 'Tənzimləmələr';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLanguageSubtitle => 'Tətbiq dilini dəyişdirin';

  @override
  String get onboardingTrustTitle => 'Sizə olan müqəddəs əmanətimiz';

  @override
  String get onboardingTrustSubtitle =>
      'Yalnız Allah rizası üçün hazırlandı — reklamsız, izlənməsiz, 100% məxfi.';

  @override
  String get onboardingTrustOfflineTitle => '100% Cihazda və Oflayn';

  @override
  String get onboardingTrustOfflineDesc =>
      'Məkanınız və namaz qeydləriniz heç vaxt telefonunuzdan kənara çıxmır.';

  @override
  String get onboardingTrustNoAdsTitle => 'Heç Vaxt Reklam Yoxdur';

  @override
  String get onboardingTrustNoAdsDesc =>
      'İbadətinizə mane olacaq heç bir kommersiya reklamı və bildirişi yoxdur.';

  @override
  String get onboardingTrustNoTrackingTitle =>
      'Sıfır İzləmə və Məlumat Toplama';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'Firebase izləməsi yoxdur, şəxsi məlumatlar toplanmır.';

  @override
  String get onboardingTrustFreeTitle => 'Ümmət üçün daima pulsuz';

  @override
  String get onboardingTrustFreeDesc =>
      'Sədəqeyi-cariyə olaraq hazırlanmışdır. Abunəlik tələb olunmur.';

  @override
  String get onboardingFeaturesTitle => 'Əsas Xüsusiyyətlər';

  @override
  String get onboardingFeaturesSubtitle =>
      'Dəqiq namaz vaxtları, səhih sünnə və ibadət vasitələri.';

  @override
  String get onboardingFeaturePrayerTitle => 'Astronomik Dəqiqlik';

  @override
  String get onboardingFeaturePrayerDesc =>
      'Günəşin bucağına əsasən dəqiq vaxtlar və sünnət namazı xatırlatmaları.';

  @override
  String get onboardingFeatureQiblaTitle => 'Qiblə Kompası';

  @override
  String get onboardingFeatureQiblaDesc =>
      'Müqəddəs Kəbə istiqamətini dəqiq göstərir və qibləyə çatanda vibrasiya verir.';

  @override
  String get onboardingFeatureTasbihTitle => 'Haptik Rəqəmsal Təsbeh';

  @override
  String get onboardingFeatureTasbihDesc =>
      'Barmaq toxunuşu hissi verən vibrasiya və məsur zikrlər.';

  @override
  String get onboardingFeatureSunnahTitle => 'Səhih Sünnə və Dualar';

  @override
  String get onboardingFeatureSunnahDesc =>
      'Səhih Buxari və Müslim mənbəli hədislər və gündəlik Quran ayələri.';

  @override
  String get onboardingFeatureQiblaAligned => 'Qibləyə Yönəldi • Məkkə';

  @override
  String get onboardingFeatureTapToCount =>
      'Saymaq üçün ekrana toxunun və ya sürüşdürün';

  @override
  String get onboardingPermissionsTitle => 'Asan Quraşdırma';

  @override
  String get onboardingPermissionsSubtitle =>
      'Namaz vaxtlarının dəqiq hesablanması və azan bildirişləri üçün icazə verin.';

  @override
  String get onboardingPermLocationTitle => 'Dəqiq Məkan';

  @override
  String get onboardingPermLocationDesc =>
      'Yalnız cihazınızda yerli namaz vaxtlarını hesablamaq üçün istifadə edilir.';

  @override
  String get onboardingPermNotifTitle => 'Azan və Namaz Bildirişləri';

  @override
  String get onboardingPermNotifDesc =>
      'Azanı vaxtında oxuyur və sünnət namazlarını xatırladır.';

  @override
  String get onboardingPermBatteryTitle => 'Etibarlı Arxa Plan İşi';

  @override
  String get onboardingPermBatteryDesc =>
      'Android batareya optimallaşdırmasının Sübh azanını dayandırmasına mane olur.';

  @override
  String get onboardingPermGrant => 'İcazə Ver';

  @override
  String get onboardingPermGranted => 'İcazə Verildi';

  @override
  String get onboardingPermEnableLater => 'Tənzimləmələrdən Sonra Aktiv Et';

  @override
  String get onboardingDedicationVerse =>
      '«Həqiqətən, namaz möminlərə müəyyən olunmuş vaxtlarda vacib edilmişdir.»';

  @override
  String get onboardingDedicationReference => 'Nisa surəsi (103)';

  @override
  String get onboardingBeginJourney => 'Bismillah • Başlayın';

  @override
  String get onboardingReplayTour => 'Tanıtım Turunu Yenidən Başlat';

  @override
  String get onboardingReplayTourSubtitle =>
      'Tətbiqin xüsusiyyətlərini və məxfilik prinsiplərini yenidən nəzərdən keçirin';

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
  String get settingsBatteryExempt => 'İstisna Edilib';

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
  String get sunnahPrayerHeader => 'SÜNNƏT NAMAZI';

  @override
  String get sunnahFajrDesc => 'Fərzdən əvvəl 2 rükət sünnət';

  @override
  String get sunnahDhuhrDesc => 'Fərzdən əvvəl 4, sonra 2 rükət sünnət';

  @override
  String get sunnahAsrDesc => 'Fərzdən əvvəl 4 rükət sünnət';

  @override
  String get sunnahMaghribDesc => 'Fərzdən sonra 2 rükət sünnət';

  @override
  String get sunnahIshaDesc => 'Fərzdən sonra 2 rükət sünnət + 3 rükət Vitr';

  @override
  String get forbiddenNaflHeader => 'NƏFİL NAMAZLARI ÜÇÜN QADAĞAN VAXTLAR';

  @override
  String get forbiddenNaflBody =>
      'Günəş çıxanda (~20 dəq), günorta zaval vaxtı (~10 dəq) və günəş batanda (~20 dəq) nəfil namaz qılmaq qadağandır. Qəza namazları qılına bilər. (Səhih Müslüm 831)';

  @override
  String get forbiddenNaflSunriseHeader => 'QADAĞAN VAXT • GÜNƏŞ ÇIXIŞI';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'Günəş çıxır ($startTime – $endTime). Günəş tam yüksələnə qədər nəfil namaz qadağandır. (Səhih Müslüm 831)';
  }

  @override
  String get forbiddenNaflZawalHeader => 'QADAĞAN VAXT • ZAVAL';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'Günəş tam təpədədir ($startTime – $endTime). Bu vaxt nəfil namaz qadağandır. (Səhih Müslüm 831)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'QADAĞAN VAXT • GÜNƏŞ BATIŞI';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'Günəş batır ($startTime – $endTime). Batış tamamlanana qədər nəfil namaz qadağandır. (Səhih Müslüm 831)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return '$prayer namazının vaxtı hələ girməyib ($time)';
  }

  @override
  String get timeStart => 'Başlanğıc';

  @override
  String get timeEnd => 'Son';

  @override
  String get onboardingShowcasePrayerTitle => 'Dəqiq Namaz Vaxtları';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'Beynəlxalq etibarlı metodlarla 100% oflayn dəqiq namaz vaxtlarının hesablanması.';

  @override
  String get onboardingShowcaseQiblaTitle => 'Dəqiq Qiblə Kompası';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'Dünyanın istənilən yerindən Kəbənin dəqiq istiqamətini asanlıqla tapın.';

  @override
  String get onboardingShowcaseTasbihTitle => 'Toxunma Hissli Rəqəmsal Təsbeh';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'Titrəyişli bildiriş və avtomatik keçidli ağıllı zikr sayğacı.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'Gündəlik Ayələr, Hədislər və Dualar';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'Səhih hədislər, Qurani-Kərim ayələri və vacib gündəlik dualar.';

  @override
  String get settingsPrayerNotifications => 'Namaz Bildirişləri';

  @override
  String get settingsAdhanReciterTone => 'Müəzzin və Azan Səsi';

  @override
  String get settingsDailyReminderTime => 'Gündəlik Təfəkkür Bildirişi';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count Canlı Vidcet';
  }

  @override
  String get settingsFiqhAsr => 'Fiqh (Əsr Vaxtı)';

  @override
  String get settingsFiqhStandardTitle => 'Şafii / Standart (Susmaya görə)';

  @override
  String get settingsFiqhStandardDesc => 'Şafii, Maliki və Hənbəli (1x Kölgə)';

  @override
  String get settingsFiqhStandardSub =>
      'Kölgə uzunluğu = cismin boyu (1 qat). Şafii, Maliki, Hənbəli və əksəriyyət.';

  @override
  String get settingsFiqhHanafiTitle => 'Hənəfi';

  @override
  String get settingsFiqhHanafiDesc => 'Hənəfi Məzhəbi (2x Kölgə)';

  @override
  String get settingsFiqhHanafiSub =>
      'Kölgə uzunluğu = cismin boyunun 2 qatı. Hənəfi məzhəbinə görə.';

  @override
  String get settingsPreAdhanReminder => 'Azandan Əvvəlki Xatırlatma';

  @override
  String get settingsBatteryRestricted => 'Məhdudlaşdırılıb';

  @override
  String get settingsBatteryExemptDesc =>
      'İstisna edilib — Azan bildirişləri vaxtında səslənəcək';

  @override
  String get settingsBatteryNotExemptDesc =>
      'İstisna edilməyib — Bildirişlərdə gecikmələr ola bilər';

  @override
  String get settingsCheckBatteryNow => 'Statusu İndi Yoxlayın';

  @override
  String get settingsCheckBatterySubtitle =>
      'Arxa fon işləmə icazələrini təsdiq edin';

  @override
  String get settingsWarnBattery => 'Yenidən Məhdudlaşdırılsa Xəbərdarlıq Et';

  @override
  String get settingsWarnBatterySubtitle =>
      'Sistem batareyaya qənaət rejimini açarsa bildirin';

  @override
  String get settingsOpenSourceFootnote =>
      '100% Pulsuz və Açıq Mənbə • Reklamsız • Məlumat Toplanmır';

  @override
  String get settingsAsrCalculationTitle => 'Əsr Hesablama Metodu (Fiqh)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'Əsr namazı vaxtı hesabı üçün məzhəb seçin.';

  @override
  String get adhanVoiceMakkah => 'Məkkə (Əli Mulla)';

  @override
  String get adhanVoiceMadinah => 'Mədinə (Əbdülməcid)';

  @override
  String get adhanVoiceAlAqsa => 'Əl-Əqsa (Yaser Əl-Dosari)';

  @override
  String get adhanVoiceSoft => 'Ənənəvi Zərif Ton';

  @override
  String get calcMethodUmmAlQura => 'Ümmül-Qura (Səudiyyə Ərəbistanı)';

  @override
  String get calcMethodMwl => 'Dünya İslam Liqası (MWL)';

  @override
  String get calcMethodEgyptian => 'Misir Baş Tədqiqat İdarəsi';

  @override
  String get calcMethodIsna => 'ISNA (Şimali Amerika)';

  @override
  String get calcMethodKarachi => 'Karaçi İslam Elmləri Universiteti';

  @override
  String get calcMethodDubai => 'Dubay İslam İşləri Departamenti';

  @override
  String get calcMethodDiyanet => 'Diyanət (Türkiyə)';

  @override
  String get calcMethodSingapore => 'MUIS (Sinqapur)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'Məni necə namaz qılan gördünüzsə, elə namaz qılın';

  @override
  String get learnSalahAuthenticBadge => 'SƏHİH SÜNNƏ BƏLƏDÇİSİ';

  @override
  String get learnSalahSearchPlaceholder =>
      'Duruş, addım və ya hədis dəlili axtarın...';

  @override
  String get learnSalahLearningModules => 'ÖYRƏNMƏ MODULLARI';

  @override
  String get learnSalahStepByStepTitle => 'Addım-addım Namaz Bələdçisi';

  @override
  String get learnSalahStepByStepSubtitle =>
      'İllüstrasiyalar və dəlillərlə 10 ardıcıl addım';

  @override
  String get learnSalahPillarsTitle => 'Namazın 14 Rükünü (Fərzləri)';

  @override
  String get learnSalahPillarsSubtitle =>
      'Namazın əsla tərk edilməyən əsas təməlləri';

  @override
  String get learnSalahObligationsTitle => 'Namazın 8 Vacibi';

  @override
  String get learnSalahObligationsSubtitle =>
      'Səhv səcdəsi ilə düzəldilən vacib əməllər';

  @override
  String get learnSalahSunanTitle => 'Namazın Sünnələri';

  @override
  String get learnSalahSunanSubtitle =>
      'Peyğəmbərimiz ﷺ-in qövli və feili sünnələri';

  @override
  String get learnSalahInvalidatorsTitle => 'Namazı Pozan Hallar';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'Namazı batil edən və yenidən qılmağı tələb edən amillər';

  @override
  String get learnSalahForbiddenTimesTitle => 'Namaz Qılınması Qadağan Vaxtlar';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'Nafilə namazların qılınmasının qadağan olduğu vaxtlar';

  @override
  String get madhabShafi => 'Şafii';

  @override
  String get madhabHanafi => 'Hənəfi';

  @override
  String get eventIslamicNewYear => 'Hicri Yeni İl';

  @override
  String get eventTasua => 'Tasu\'a Günü';

  @override
  String get eventAshura => 'Aşura Günü';

  @override
  String get eventMawlid => 'Mövlud Qəndili ﷺ';

  @override
  String get eventIsraMiraj => 'İsra və Merac Gecəsi';

  @override
  String get eventMidShaban => 'Bəraət Gecəsi';

  @override
  String get eventRamadanStart => 'Ramazan Ayının İlk Günü';

  @override
  String get eventBattleOfBadr => 'Bədr Döyüşü';

  @override
  String get eventLaylatAlQadr => 'Qədr Gecəsi';

  @override
  String get eventEidAlFitr => 'Ramazan Bayramı';

  @override
  String get eventShawwalSixFasting => 'Şəvval Ayının 6 Günlük Orucu';

  @override
  String get eventDhuAlHijjahStart => 'Zilhiccə Ayının Başlanğıcı';

  @override
  String get eventDayOfArafah => 'Ərəfə Günü';

  @override
  String get eventEidAlAdha => 'Qurban Bayramı';

  @override
  String get eventDaysOfTashreeq => 'Təşriq Günləri';

  @override
  String get qiblaHeadingTrue => 'HƏQİQİ İSTİQAMƏT';

  @override
  String get qiblaBearingLabel => 'QİBLƏ BUCAĞI';

  @override
  String get qiblaRetryLocation => 'Məkanı yenidən yoxlayın';

  @override
  String get qiblaCalibClearInterference => 'Maqnit maneələrindən uzaq durun';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'Metal masalardan, kompüterlərdən və ya maqnitli çexollardan uzaqlaşın.';

  @override
  String get qiblaCalibHoldFlat => 'Cihazı düz üfüqi tutun';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'Maksimum dəqiqlik üçün telefonunuzu yerə paralel tutun.';

  @override
  String get qiblaCalibFigure8 => '8 fiquru çəkin';

  @override
  String get qiblaCalibFigure8Desc =>
      'Kompasın tənzimlənməsi üçün telefonu havada 8 rəqəmi şəklində hərəkət etdirin.';

  @override
  String get stepPrevious => 'Əvvəlki';

  @override
  String get stepNext => 'Növbəti addım';

  @override
  String get stepFinishGuide => 'Bələdçini bitir';

  @override
  String get widgetAddAnother => 'Başqasını əlavə et';

  @override
  String get widgetOpenSettings => 'Tənzimləmələri aç';

  @override
  String get widgetGoToHome => 'Əsas səhifəyə qayıt';

  @override
  String get trackerWeeklyRate => 'Həftəlik nisbət';

  @override
  String get trackerMonthlyRate => 'Aylıq nisbət';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total Namaz';
  }

  @override
  String get tasbihHadithTitle => 'BARMAQLARLA TƏSBEH SAYMAQ HAQQINDA HƏDİS';

  @override
  String get tasbihHadithText =>
      '“Təsbihi, təhlili və təqdisi tərk etməyin və barmaq uclarınızla sayın; çünki Qiyamət günü barmaqlar sorğu-suala çəkiləcək və dillənəcəklər.”';

  @override
  String get tasbihHadithReference => '— Sünən Əbu Davud 1496';

  @override
  String get dhikrSubhanAllah => 'Sübhanallah';

  @override
  String get dhikrAlhamdulillah => 'Əlhəmdulillah';

  @override
  String get dhikrAllahuAkbar => 'Allahu Əkbər';

  @override
  String get dhikrAstaghfirullah => 'Əstəğfürullah';

  @override
  String get dhikrLaIlahaIllallah => 'Lə iləhə illəllah';

  @override
  String get dhikrSubhanAllahTranslation =>
      'Allah bütün nöqsan və kəsirlərdən uzaqdır';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'Bütün həmd və təriflər yalnız Allaha məxsusdur';

  @override
  String get dhikrAllahuAkbarTranslation =>
      'Allah hər şeydən ucadır və böyükdür';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'Allahdan günahlarımın bağışlanmasını diləyirəm';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'Allahdan başqa ibadətə layiq haqq məbud yoxdur';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'Növbəti: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'Xüsusi';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'Xüsusi ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'Fərdi hədəf təyin edin';

  @override
  String get tasbihTargetHint => 'Hədəf sayını daxil edin (məs. 50)';

  @override
  String get tasbihCancel => 'İmtina';

  @override
  String get tasbihSetTarget => 'Hədəfi təyin et';

  @override
  String tasbihLap(String lap) {
    return 'Dövrə $lap';
  }
}
