// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Salah Companion';

  @override
  String get navHome => 'Ana Sayfa';

  @override
  String get navDuas => 'Dualar';

  @override
  String get navTasbih => 'Tesbih';

  @override
  String get navQibla => 'Kıble';

  @override
  String get navCalendar => 'Takvim';

  @override
  String get prayerFajr => 'İmsak';

  @override
  String get prayerSunrise => 'Güneş';

  @override
  String get prayerDhuhr => 'Öğle';

  @override
  String get prayerAsr => 'İkindi';

  @override
  String get prayerMaghrib => 'Akşam';

  @override
  String get prayerIsha => 'Yatsı';

  @override
  String get upcomingPrayer => 'GELECEK VAKİT';

  @override
  String get currentSalah => 'ŞİMDİKİ VAKİT';

  @override
  String get remaining => 'kalan süre';

  @override
  String get statusPrayed => 'Kılındı';

  @override
  String get statusMissed => 'Kaçırıldı';

  @override
  String get statusPending => 'Bekliyor';

  @override
  String get qiblaCompassTitle => 'Kıble Pusulası';

  @override
  String get qiblaCalibrate => 'Kalibre Et';

  @override
  String get qiblaFacingKaaba => 'Kâbe ile tam hizalama';

  @override
  String get tasbihTitle => 'Dijital Tesbih';

  @override
  String get tasbihReset => 'Sıfırla';

  @override
  String get tasbihAutoNext => 'Otomatik Geçiş';

  @override
  String get tasbihBestOnFingers => 'Tesbihi parmaklarla çekmek sünnettir';

  @override
  String get guidanceCategory => 'REHBERLİK';

  @override
  String get learnSalah => 'Namaz Rehberi';

  @override
  String get learnSalahSubtitle => 'Sahih sünnet ve hadislerle namaz kılınışı';

  @override
  String get savedItems => 'Kaydedilenler';

  @override
  String get savedItemsSubtitle => 'Hadisler, Ayetler ve Dualar';

  @override
  String get prayerTracker => 'Namaz Takibi';

  @override
  String get prayerTrackerSubtitle => 'Namaz istatistiklerinizi görüntüleyin';

  @override
  String get widgetsTitle => 'Widgetlar';

  @override
  String get widgetsSubtitle => 'Ana ekrana widget ekleyin';

  @override
  String get openSourcePrivacy => 'Açık Kaynak ve Gizlilik';

  @override
  String get openSourcePrivacySubtitle =>
      '%100 çevrimdışı, sıfır takip ve ticari olmayan';

  @override
  String get themeMode => 'TEMA MODU';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String notificationPrayerTitle(String prayer) {
    return '$prayer Vakti';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return '$prayer namazı vakti girdi. Haydi namaza.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'İlk Vakit Hatırlatması — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return '$prayer vaktinden 15 dakika geçti. Namazınızı kıldınız mı?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'Acil — $prayer Vaktine Son 30 Dakika';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return '$prayer namazı vaktinin çıkmasına sadece 30 dakika kaldı.';
  }

  @override
  String get notificationDailyReflectionTitle => 'Günün Tefekkürü';

  @override
  String get notificationTestTitle => 'Salah Companion Bildirimi';

  @override
  String get notificationTestBody =>
      'Bildirimler ve Ezan sesi başarıyla yapılandırıldı.';

  @override
  String get onboardingChooseLanguage => 'Dilinizi Seçin';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'Namaz vakitleri ve rehberlik için tercih ettiğiniz dili seçin.';

  @override
  String get onboardingWelcomeTitle => 'Salah Companion\'a Hoş Geldiniz';

  @override
  String get onboardingWelcomeBody =>
      'Doğru namaz vakitleri, kıble yönü ve sahih sünnetler için dikkat dağıtmayan yardımcınız.';

  @override
  String get onboardingSwipeTitle => 'Menü İçin Sol Kenardan Kaydırın';

  @override
  String get onboardingSwipeBody =>
      'Kaydedilenler, takip ve temalara erişmek için ekranın sol kenarından kaydırın.';

  @override
  String get onboardingSunnahTitle => 'Sahih Sünnet ve Rehberlik';

  @override
  String get onboardingSunnahBody =>
      'Günlük ayetler, sahih hadisler, dualar ve namaz kılınış rehberine erişin.';

  @override
  String get onboardingCustomizationTitle => 'Kıble, Tesbih ve Ayarlar';

  @override
  String get onboardingCustomizationBody =>
      'Kıble pusulası, dijital tesbih ve hesaplama yöntemlerini özelleştirin.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$current / $total';
  }

  @override
  String get onboardingSkip => 'Geç';

  @override
  String get onboardingNext => 'İleri';

  @override
  String get onboardingGetStarted => 'Başlayın';

  @override
  String get systemDefault => 'Sistem Dili';

  @override
  String get moreLanguages => 'Diğer Diller';

  @override
  String get searchLanguagePlaceholder => 'Dil ara...';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLanguageSubtitle => 'Uygulama dilini değiştirin';

  @override
  String get onboardingTrustTitle => 'Size Karşı Mukaddes Sorumluluğumuz';

  @override
  String get onboardingTrustSubtitle =>
      'Yalnızca Allah rızası için geliştirildi — sıfır reklam, sıfır takip, %100 gizli.';

  @override
  String get onboardingTrustOfflineTitle =>
      '%100 Cihaz İçi & Tamamen Çevrimdışı';

  @override
  String get onboardingTrustOfflineDesc =>
      'Konumunuz ve namaz kayıtlarınız asla telefonunuzdan dışarı çıkmaz. Tüm astronomik hesaplamalar internetsiz yapılır.';

  @override
  String get onboardingTrustNoAdsTitle => 'Asla Reklam Yok';

  @override
  String get onboardingTrustNoAdsDesc =>
      'Rabbınızla aranızdaki huzuru bozacak hiçbir ticari reklam ve bildirim bulunmaz.';

  @override
  String get onboardingTrustNoTrackingTitle => 'Sıfır Analitik ve Takip';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'Firebase takibi yok, veri toplama yok, arka plan telemetrisi yok.';

  @override
  String get onboardingTrustFreeTitle => 'Ümmet İçin Daima Ücretsiz';

  @override
  String get onboardingTrustFreeDesc =>
      'Sadaka-i cariye olarak hazırlandı. Abonelik veya ücretli özellik yoktur.';

  @override
  String get onboardingFeaturesTitle => 'Uygulama Özellikleri';

  @override
  String get onboardingFeaturesSubtitle =>
      'Hassas namaz vakitleri, sahih sünnetler ve ibadet araçları.';

  @override
  String get onboardingFeaturePrayerTitle => 'Hassas Astronomik Vakitler';

  @override
  String get onboardingFeaturePrayerDesc =>
      'Güneş açılarına göre tam vakitler ve sünnet namazı hatırlatıcıları.';

  @override
  String get onboardingFeatureQiblaTitle => 'Gerçek Zamanlı Kıble Pusulası';

  @override
  String get onboardingFeatureQiblaDesc =>
      'Manyetik sensörle Kabe-i Muazzama yönü ve hedefe varınca titreşimli geri bildirim.';

  @override
  String get onboardingFeatureTasbihTitle => 'Dokunsal Dijital Tesbih';

  @override
  String get onboardingFeatureTasbihDesc =>
      'Parmak ucu hissi veren titreşimli geri bildirim ve me’sur zikirler.';

  @override
  String get onboardingFeatureSunnahTitle => 'Sahih Sünnet ve Dualar';

  @override
  String get onboardingFeatureSunnahDesc =>
      'Kaynaklı Sahih-i Buhari ve Müslim hadisleri ile günlük Kuran tefekkürleri.';

  @override
  String get onboardingFeatureQiblaAligned =>
      'Kıbleye Yönelindi • Mekke-i Mükerreme';

  @override
  String get onboardingFeatureTapToCount =>
      'Saymak için ekrana dokunun veya kaydırın';

  @override
  String get onboardingPermissionsTitle => 'Kolay Kurulum';

  @override
  String get onboardingPermissionsSubtitle =>
      'Doğru vakit hesabı ve ezan bildirimleri için gerekli izinleri sağlayın.';

  @override
  String get onboardingPermLocationTitle => 'Hassas Konum';

  @override
  String get onboardingPermLocationDesc =>
      'Yalnızca cihazınızda güneşin doğuş ve batış açılarını hesaplamak için kullanılır.';

  @override
  String get onboardingPermNotifTitle => 'Ezan ve Vakit Bildirimleri';

  @override
  String get onboardingPermNotifDesc =>
      'Vakit girdiğinde ezan okur ve sünnet hatırlatmalarını ulaştırır.';

  @override
  String get onboardingPermBatteryTitle => 'Güvenilir Arka Plan Bildirimi';

  @override
  String get onboardingPermBatteryDesc =>
      'Android pil optimizasyonunun sabah ezanı alarmlarını durdurmasını engeller.';

  @override
  String get onboardingPermGrant => 'İzin Ver';

  @override
  String get onboardingPermGranted => 'İzin Verildi';

  @override
  String get onboardingPermEnableLater => 'Ayarlardan Daha Sonra Yap';

  @override
  String get onboardingDedicationVerse =>
      '“Şüphesiz namaz, mü’minler üzerine vakitleri belirlenmiş bir farzdır.”';

  @override
  String get onboardingDedicationReference => 'Nisâ Suresi (103)';

  @override
  String get onboardingBeginJourney => 'Bismillah • Başlayın';

  @override
  String get onboardingReplayTour => 'Tanıtım Turunu Yeniden Başlat';

  @override
  String get onboardingReplayTourSubtitle =>
      'Uygulama özelliklerini ve gizlilik taahhüdünü tekrar inceleyin';

  @override
  String get onboardingBack => 'Geri';

  @override
  String get navTracker => 'Takip';

  @override
  String get prayerSunset => 'Gün Batımı';

  @override
  String get statusNotPrayed => 'Kılınmadı';

  @override
  String get statusUpcoming => 'Yaklaşan';

  @override
  String get statusNotYet => 'Vakti Gelmedi';

  @override
  String get todaysPrayers => 'GÜNÜN VAKİTLERİ';

  @override
  String startsAt(String time) {
    return 'Başlangıç: $time';
  }

  @override
  String periodRange(String start, String end) {
    return 'Vakit: $start – $end';
  }

  @override
  String get locating => 'Konum belirleniyor...';

  @override
  String get drawerNavigation => 'GEZİNME';

  @override
  String get drawerOpenSourcePrivacy => 'AÇIK KAYNAK VE GİZLİLİK';

  @override
  String get drawerQuickActions => 'HIZLI İŞLEMLER';

  @override
  String get prayerAndReflection => 'Namaz ve Tefekkür';

  @override
  String get settingsNotifications => 'BİLDİRİMLER';

  @override
  String get settingsCalculationFiqh => 'HESAPLAMA VE FIKIH';

  @override
  String get settingsBattery => 'PİL OPTİMİZASYONU';

  @override
  String get settingsAppearance => 'GÖRÜNÜM VE TİTREŞİM';

  @override
  String get settingsGuideOnboarding => 'REHBER VE TUR';

  @override
  String get settingsAboutPrivacy => 'HAKKINDA VE GİZLİLİK';

  @override
  String get settingsAdhanAudio => 'Ezan Sesi';

  @override
  String get settingsAdhanVoice => 'Müezzin Sesi';

  @override
  String get settingsDailyReflection => 'Günün Ayet ve Hadisi';

  @override
  String get settingsDailyReflectionSubtitle => 'Sabah tefekkür hatırlatıcısı';

  @override
  String get settingsCalculationMethod => 'Hesaplama Yöntemi';

  @override
  String get settingsJuristicMethod => 'İkindi Vakti Yöntemi (Mezhep)';

  @override
  String get settingsHighLatitude => 'Yüksek Enlem Kuralı';

  @override
  String get settingsHijriAdjustment => 'Hicri Takvim Ayarı';

  @override
  String get settingsBatteryHeader => 'Arka Plan Çalışması';

  @override
  String get settingsBatteryDesc =>
      'Zamanında ezan ve bildirimler için Salah Companion\'ı pil tasarrufundan muaf tutun.';

  @override
  String get settingsBatteryExempt => 'Muaf';

  @override
  String get settingsBatteryNotExempt =>
      'Pil Optimizasyonu: Kısıtlı (Düzeltmek için Dokunun)';

  @override
  String get settingsCheckBattery => 'Pil Durumunu Kontrol Et';

  @override
  String get settingsTheme => 'Tema Modu';

  @override
  String get settingsHaptics => 'Dokunsal Geri Bildirim';

  @override
  String get settingsHapticsSubtitle => 'Dokunmalarda hafif titreşim';

  @override
  String get settingsPrivacyPolicy => 'Gizlilik Politikası';

  @override
  String get settingsOpenSource => '%100 Açık Kaynak (GitHub)';

  @override
  String get settingsTerms => 'Kullanım Şartları';

  @override
  String get settingsCalculationDocs => 'Hesaplama Detayları ve SSS';

  @override
  String get settingsCalculationDocsSubtitle =>
      'Namaz vakitlerinin nasıl hesaplandığını öğrenin';

  @override
  String get sunnahMuakkadah => 'Müekkede Sünnet';

  @override
  String get sunnahGhairMuakkadah => 'Gayr-i Müekkede Sünnet';

  @override
  String get sunnahWajibWitr => 'Sünnet ve Vacip Vitir';

  @override
  String get sunnahVoluntary => 'Nafile Namaz';

  @override
  String get categoryAll => 'Tümü';

  @override
  String get categoryHadith => 'Hadisler';

  @override
  String get categoryAyah => 'Ayetler';

  @override
  String get categoryDua => 'Dualar';

  @override
  String get categoryMorning => 'Sabah';

  @override
  String get categoryEvening => 'Akşam';

  @override
  String get categoryAfterPrayer => 'Namaz Sonrası';

  @override
  String get categoryForgiveness => 'Tövbe ve İstiğfar';

  @override
  String get categoryProtection => 'Korunma';

  @override
  String get categoryDaily => 'Günlük';

  @override
  String get categoryTravel => 'Yolculuk';

  @override
  String get noSavedItems => 'Henüz kaydedilmiş içerik yok';

  @override
  String get noSavedItemsSubtitle =>
      'Herhangi bir içeriği buraya kaydetmek için yer işareti simgesine dokunun.';

  @override
  String get searchPlaceholder => 'Dua, meal veya kaynak ara...';

  @override
  String get sunnahPrayerHeader => 'SÜNNET NAMAZI';

  @override
  String get sunnahFajrDesc => 'Farzdan önce 2 rekat müekkede sünnet';

  @override
  String get sunnahDhuhrDesc => 'Farzdan önce 4, sonra 2 rekat sünnet';

  @override
  String get sunnahAsrDesc => 'Farzdan önce 4 rekat gayr-i müekkede sünnet';

  @override
  String get sunnahMaghribDesc => 'Farzdan sonra 2 rekat müekkede sünnet';

  @override
  String get sunnahIshaDesc => 'Farzdan sonra 2 rekat sünnet + 3 rekat Vitir';

  @override
  String get forbiddenNaflHeader => 'KERAHAAT VAKİTLERİ (NAFİLE KILINMAZ)';

  @override
  String get forbiddenNaflBody =>
      'Güneş doğarken (~20 dk), tam tepedeyken (~10 dk) ve batarken (~20 dk) nafile namaz kılınması mekruhtur. Kaza namazları kılınabilir. (Sahih Müslim 831)';

  @override
  String get forbiddenNaflSunriseHeader => 'KERAHAAT VAKTİ • GÜNEŞ DOĞUŞU';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'Güneş doğuyor ($startTime – $endTime). Güneş tamamen yükselene kadar nafile namaz kılınmaz. (Sahih Müslim 831)';
  }

  @override
  String get forbiddenNaflZawalHeader =>
      'KERAHAAT VAKTİ • İSTİVA (ÖĞLE ÖNCESİ)';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'Güneş tam tepede ($startTime – $endTime). Bu vakitte nafile kılınmaz. (Sahih Müslim 831)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'KERAHAAT VAKTİ • GÜNEŞ BATIŞI';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'Güneş batıyor ($startTime – $endTime). Batış tamamlanana kadar nafile kılınmaz. (Sahih Müslim 831)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return '$prayer vakti henüz girmedi ($time)';
  }

  @override
  String get timeStart => 'Başlangıç';

  @override
  String get timeEnd => 'Bitiş';

  @override
  String get onboardingShowcasePrayerTitle => 'Hassas Namaz Vakitleri';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'Diyanet ve küresel yöntemlerle %100 çevrimdışı, milimetrik vakit hesaplaması.';

  @override
  String get onboardingShowcaseQiblaTitle => 'Gerçek Kıble Pusulası';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'Gelişmiş jiroskopik sensörlerle dünyanın her yerinden Kabe\'nin yönünü bulun.';

  @override
  String get onboardingShowcaseTasbihTitle => 'Dokunsal Dijital Tesbih';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'Titreşim geri bildirimi ve otomatik geçişli akıllı zikirmatik.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'Günlük Ayet, Hadis ve Dualar';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'Sahih hadisler, Kur\'an ayetleri ve günlük okunacak faziletli dualar.';

  @override
  String get settingsPrayerNotifications => 'Namaz Bildirimleri';

  @override
  String get settingsAdhanReciterTone => 'Müezzin ve Ezan Sesi';

  @override
  String get settingsDailyReminderTime => 'Günün Ayet/Hadis Bildirimi';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count Canlı Widget';
  }

  @override
  String get settingsFiqhAsr => 'Fıkıh (İkindi Vakti)';

  @override
  String get settingsFiqhStandardTitle => 'Şafii / Cumhur (Varsayılan)';

  @override
  String get settingsFiqhStandardDesc => 'Şafii, Maliki ve Hanbeli (1x Gölge)';

  @override
  String get settingsFiqhStandardSub =>
      'Gölge uzunluğu = cismin boyu (1 katı). Şafii, Maliki, Hanbeli ve Diyanet standardı.';

  @override
  String get settingsFiqhHanafiTitle => 'Hanefi';

  @override
  String get settingsFiqhHanafiDesc => 'Hanefi Mezhebi (2x Gölge)';

  @override
  String get settingsFiqhHanafiSub =>
      'Gölge uzunluğu = cismin boyunun 2 katı. İmam-ı Azam Ebu Hanife içtihadı.';

  @override
  String get settingsPreAdhanReminder => 'Ezan Öncesi Hatırlatıcı';

  @override
  String get settingsBatteryRestricted => 'Kısıtlı';

  @override
  String get settingsBatteryExemptDesc =>
      'Muaf — Ezan bildirimleri zamanında çalar';

  @override
  String get settingsBatteryNotExemptDesc =>
      'Muaf değil — Arka planda gecikmeler olabilir';

  @override
  String get settingsCheckBatteryNow => 'Durumu Şimdi Kontrol Et';

  @override
  String get settingsCheckBatterySubtitle =>
      'Arka planda çalışma izinlerini doğrula';

  @override
  String get settingsWarnBattery => 'Yeniden Kısıtlanırsa Uyar';

  @override
  String get settingsWarnBatterySubtitle =>
      'Sistem pil tasarrufunu açarsa bildirim gönder';

  @override
  String get settingsOpenSourceFootnote =>
      '%100 Ücretsiz ve Açık Kaynak • Reklamsız • Veri Toplanmaz';

  @override
  String get settingsAsrCalculationTitle =>
      'İkindi Vakti Hesaplama Yöntemi (Fıkıh)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'İkindi namazı vakti hesabı için mezhep seçin.';

  @override
  String get adhanVoiceMakkah => 'Mekke (Ali Mulla)';

  @override
  String get adhanVoiceMadinah => 'Medine (Abdülmecid)';

  @override
  String get adhanVoiceAlAqsa => 'Mescid-i Aksa (Yaser ed-Devseri)';

  @override
  String get adhanVoiceSoft => 'Geleneksel Yumuşak Ton';

  @override
  String get calcMethodUmmAlQura => 'Ümmü\'l-Kura (Suudi Arabistan)';

  @override
  String get calcMethodMwl => 'Dünya İslam Birliği (Rabıta)';

  @override
  String get calcMethodEgyptian => 'Mısır Genel Araştırma Kurumu';

  @override
  String get calcMethodIsna => 'ISNA (Kuzey Amerika)';

  @override
  String get calcMethodKarachi => 'Karaçi İslami İlimler Üniversitesi';

  @override
  String get calcMethodDubai => 'Dubai İslam İşleri Dairesi';

  @override
  String get calcMethodDiyanet => 'Diyanet İşleri Başkanlığı (Türkiye)';

  @override
  String get calcMethodSingapore => 'MUIS (Singapur)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'Beni Nasıl Namaz Kılıyor Gördüyseniz Öyle Kılın';

  @override
  String get learnSalahAuthenticBadge => 'SAHİH SÜNNET REHBERİ';

  @override
  String get learnSalahSearchPlaceholder =>
      'Duruş, adım veya hadis delili arayın...';

  @override
  String get learnSalahLearningModules => 'ÖĞRENME MODÜLLERİ';

  @override
  String get learnSalahStepByStepTitle => 'Adım Adım Nebevi Namaz Rehberi';

  @override
  String get learnSalahStepByStepSubtitle =>
      '2D duruşlar ve delillerle 10 sıralı adım';

  @override
  String get learnSalahPillarsTitle => 'Namazın 14 Farzı ve Rükünleri';

  @override
  String get learnSalahPillarsSubtitle =>
      'Namazın asla terk edilemeyecek temel şartları';

  @override
  String get learnSalahObligationsTitle => 'Namazın 8 Vacibi';

  @override
  String get learnSalahObligationsSubtitle =>
      'Terk edildiğinde sehiv secdesi gerektiren vacipler';

  @override
  String get learnSalahSunanTitle => 'Namazın Sünnetleri';

  @override
  String get learnSalahSunanSubtitle =>
      'Peygamberimiz ﷺ\'in fiili ve kavli sünnetleri';

  @override
  String get learnSalahInvalidatorsTitle => 'Namazı Bozan Haller (Müfsitler)';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'Namazı iptal eden ve iadesini gerektiren durumlar';

  @override
  String get learnSalahForbiddenTimesTitle => 'Mekruh ve Yasak Vakitler';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'Nafile namaz kılınması yasak olan kerahet vakitleri';

  @override
  String get madhabShafi => 'Şafii';

  @override
  String get madhabHanafi => 'Hanefi';

  @override
  String get eventIslamicNewYear => 'Hicri Yılbaşı';

  @override
  String get eventTasua => 'Tasu\'a Günü';

  @override
  String get eventAshura => 'Aşure Günü';

  @override
  String get eventMawlid => 'Mevlid Kandili';

  @override
  String get eventIsraMiraj => 'Miraç Kandili';

  @override
  String get eventMidShaban => 'Berat Kandili';

  @override
  String get eventRamadanStart => 'Ramazan-ı Şerif Başlangıcı';

  @override
  String get eventBattleOfBadr => 'Bedir Zaferi';

  @override
  String get eventLaylatAlQadr => 'Kadir Gecesi';

  @override
  String get eventEidAlFitr => 'Ramazan Bayramı';

  @override
  String get eventShawwalSixFasting => 'Şevval Ayı 6 Oruçları';

  @override
  String get eventDhuAlHijjahStart => 'Zilhicce Ayı Başlangıcı';

  @override
  String get eventDayOfArafah => 'Arefe Günü';

  @override
  String get eventEidAlAdha => 'Kurban Bayramı';

  @override
  String get eventDaysOfTashreeq => 'Teşrik Günleri';

  @override
  String get qiblaHeadingTrue => 'GERÇEK YÖN';

  @override
  String get qiblaBearingLabel => 'KIBLE AÇISI';

  @override
  String get qiblaRetryLocation => 'Konumu Yeniden Dene';

  @override
  String get qiblaCalibClearInterference => 'Manyetik Parazitten Uzaklaşın';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'Metal masalardan, bilgisayarlardan veya mıknatıslı kılıflardan uzak durun.';

  @override
  String get qiblaCalibHoldFlat => 'Cihazı Düz ve Yatay Tutun';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'En yüksek hassasiyet için telefonunuzu yere paralel yatay tutun.';

  @override
  String get qiblaCalibFigure8 => '8 Şeklinde Hareket Ettirin';

  @override
  String get qiblaCalibFigure8Desc =>
      'Pusulayı kalibre etmek için telefonunuzu havada 8 çizecek şekilde hareket ettirin.';

  @override
  String get stepPrevious => 'Önceki';

  @override
  String get stepNext => 'Sonraki Adım';

  @override
  String get stepFinishGuide => 'Rehberi Bitir';

  @override
  String get widgetAddAnother => 'Başka Ekle';

  @override
  String get widgetOpenSettings => 'Ayarları Aç';

  @override
  String get widgetGoToHome => 'Ana Ekrana Dön';

  @override
  String get trackerWeeklyRate => 'Haftalık Oran';

  @override
  String get trackerMonthlyRate => 'Aylık Oran';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total Vakit';
  }

  @override
  String get tasbihHadithTitle => 'PARMAKLARLA TESBİH ÇEKMEK HAKKINDA HADİS';

  @override
  String get tasbihHadithText =>
      '“Tesbih, tehlil ve takdisi elden bırakmayın ve parmak uçlarınızla sayın; çünkü kıyamet günü parmaklar sorgulanacak ve konuşturulacaktır.”';

  @override
  String get tasbihHadithReference => '— Sünen-i Ebû Dâvûd 1496';

  @override
  String get dhikrSubhanAllah => 'Sübhanallah';

  @override
  String get dhikrAlhamdulillah => 'Elhamdülillah';

  @override
  String get dhikrAllahuAkbar => 'Allahu Ekber';

  @override
  String get dhikrAstaghfirullah => 'Estağfirullah';

  @override
  String get dhikrLaIlahaIllallah => 'Lâ ilâhe illallah';

  @override
  String get dhikrSubhanAllahTranslation =>
      'Allah her türlü eksiklik ve kusurdan münezzehtir';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'Hamd ve şükür yalnızca âlemlerin Rabbi olan Allah\'a aittir';

  @override
  String get dhikrAllahuAkbarTranslation =>
      'Allah en büyüktür, her şeyden yücedir';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'Allah\'tan bağışlanma diler, O\'na tövbe ederim';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'Allah\'tan başka ibadete lâyık hiçbir hak ilâh yoktur';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'Sonraki: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'Özel';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'Özel ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'Özel Hedef Belirle';

  @override
  String get tasbihTargetHint => 'Hedef sayıyı girin (örn. 50)';

  @override
  String get tasbihCancel => 'İptal';

  @override
  String get tasbihSetTarget => 'Hedefi Belirle';

  @override
  String tasbihLap(String lap) {
    return 'Tur $lap';
  }
}
