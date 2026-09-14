// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'Salah Companion';

  @override
  String get navHome => 'Utama';

  @override
  String get navDuas => 'Doa';

  @override
  String get navTasbih => 'Tasbih';

  @override
  String get navQibla => 'Kiblat';

  @override
  String get navCalendar => 'Kalendar';

  @override
  String get prayerFajr => 'Subuh';

  @override
  String get prayerSunrise => 'Syuruk';

  @override
  String get prayerDhuhr => 'Zohor';

  @override
  String get prayerAsr => 'Asar';

  @override
  String get prayerMaghrib => 'Maghrib';

  @override
  String get prayerIsha => 'Isyak';

  @override
  String get upcomingPrayer => 'UPCOMING PRAYER';

  @override
  String get currentSalah => 'CURRENT SALAH';

  @override
  String get remaining => 'berbaki';

  @override
  String get statusPrayed => 'Selesai Solat';

  @override
  String get statusMissed => 'Terlepas';

  @override
  String get statusPending => 'Menunggu';

  @override
  String get qiblaCompassTitle => 'Kompas Kiblat';

  @override
  String get qiblaCalibrate => 'Kalibrasi';

  @override
  String get qiblaFacingKaaba => 'Tepat menghadap Kaabah';

  @override
  String get tasbihTitle => 'Tasbih Digital';

  @override
  String get tasbihReset => 'Set Semula';

  @override
  String get tasbihAutoNext => 'Auto Seterusnya';

  @override
  String get tasbihBestOnFingers => 'Mengira dengan jari adalah sunnah';

  @override
  String get guidanceCategory => 'BIMBINGAN';

  @override
  String get learnSalah => 'Panduan Solat';

  @override
  String get learnSalahSubtitle =>
      'Pelajari sifat solat nabi berasaskan hadis sahih';

  @override
  String get savedItems => 'Disimpan';

  @override
  String get savedItemsSubtitle => 'Hadis, Ayat & Doa';

  @override
  String get prayerTracker => 'Jejak Solat';

  @override
  String get prayerTrackerSubtitle => 'Lihat statistik solat anda';

  @override
  String get widgetsTitle => 'Widget';

  @override
  String get widgetsSubtitle => 'Tambah widget ke skrin utama';

  @override
  String get openSourcePrivacy => 'Sumber Terbuka & Privasi';

  @override
  String get openSourcePrivacySubtitle =>
      '100% luar talian, sifar penjejakan & bukan komersial';

  @override
  String get themeMode => 'MOD TEMA';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Cerah';

  @override
  String get themeDark => 'Gelap';

  @override
  String notificationPrayerTitle(String prayer) {
    return 'Waktu Solat $prayer';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return 'Telah masuk waktu solat $prayer. Marilah menunaikan solat.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'Peringatan Awal Waktu — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return '15 minit telah berlalu dari waktu $prayer. Sudahkah anda solat?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'Penting — Tinggal 30 Minit untuk $prayer';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return 'Hanya tinggal 30 minit sebelum waktu solat $prayer berakhir.';
  }

  @override
  String get notificationDailyReflectionTitle => 'Tadabbur Harian';

  @override
  String get notificationTestTitle => 'Pemberitahuan Salah Companion';

  @override
  String get notificationTestBody =>
      'Notifikasi dan audio azan telah berjaya dikonfigurasi.';

  @override
  String get onboardingChooseLanguage => 'Pilih Bahasa Anda';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'Pilih bahasa pilihan anda untuk waktu solat, bimbingan dan tadabbur.';

  @override
  String get onboardingWelcomeTitle => 'Selamat Datang ke Salah Companion';

  @override
  String get onboardingWelcomeBody =>
      'Teman ibadah yang tenang dan tepat untuk waktu solat, arah kiblat dan amalan sunnah.';

  @override
  String get onboardingSwipeTitle => 'Leret Tepi Kiri untuk Menu';

  @override
  String get onboardingSwipeBody =>
      'Leret dari tepi kiri skrin untuk melihat simpanan dan rekod solat.';

  @override
  String get onboardingSunnahTitle => 'Sunnah Sahih & Bimbingan';

  @override
  String get onboardingSunnahBody =>
      'Akses ayat al-Quran harian, hadis sahih, doa ma\'thur dan sifat solat nabi.';

  @override
  String get onboardingCustomizationTitle => 'Kiblat, Tasbih & Tetapan';

  @override
  String get onboardingCustomizationBody =>
      'Kompas kiblat, tasbih digital dan pelarasan kaedah pengiraan waktu solat.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$current DARIPADA $total';
  }

  @override
  String get onboardingSkip => 'Langkau';

  @override
  String get onboardingNext => 'Seterusnya';

  @override
  String get onboardingGetStarted => 'Mula Sekarang';

  @override
  String get systemDefault => 'Tetapan Sistem';

  @override
  String get moreLanguages => 'Bahasa Lain';

  @override
  String get searchLanguagePlaceholder => 'Cari bahasa...';

  @override
  String get settingsTitle => 'Tetapan';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get settingsLanguageSubtitle => 'Tukar bahasa aplikasi';

  @override
  String get onboardingTrustTitle => 'Amanah Suci Kami Kepada Anda';

  @override
  String get onboardingTrustSubtitle =>
      'Dibina ikhlas kerana Allah — sifar iklan, sifar penjejakan, 100% peribadi.';

  @override
  String get onboardingTrustOfflineTitle => '100% Pada Peranti & Luar Talian';

  @override
  String get onboardingTrustOfflineDesc =>
      'Lokasi dan rekod solat anda tidak pernah keluar daripada telefon anda. Pengiraan waktu dilakukan sepenuhnya di dalam peranti.';

  @override
  String get onboardingTrustNoAdsTitle => 'Tiada Iklan Selamanya';

  @override
  String get onboardingTrustNoAdsDesc =>
      'Tiada iklan sepanduk, tiada tetingkap komersial yang mengganggu ibadah anda.';

  @override
  String get onboardingTrustNoTrackingTitle => 'Sifar Penjejakan & Data';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'Tiada penjejakan Firebase, tiada pengumpulan data peribadi.';

  @override
  String get onboardingTrustFreeTitle => 'Percuma Selamanya untuk Ummah';

  @override
  String get onboardingTrustFreeDesc =>
      'Sebagai amal jariah. Tiada langganan atau bayaran tersembunyi.';

  @override
  String get onboardingFeaturesTitle => 'Terokai Ciri-Ciri Utama';

  @override
  String get onboardingFeaturesSubtitle =>
      'Waktu solat tepat, panduan sunnah sahih, dan kemudahan ibadah.';

  @override
  String get onboardingFeaturePrayerTitle => 'Ketepatan Astronomi';

  @override
  String get onboardingFeaturePrayerDesc =>
      'Pengiraan waktu solat yang jitu beserta peringatan solat sunat.';

  @override
  String get onboardingFeatureQiblaTitle => 'Kompas Kiblat Tepat';

  @override
  String get onboardingFeatureQiblaDesc =>
      'Petunjuk arah Kaabah dengan getaran haptik apabila tepat menghadap kiblat.';

  @override
  String get onboardingFeatureTasbihTitle => 'Tasbih Digital Haptik';

  @override
  String get onboardingFeatureTasbihDesc =>
      'Kiraan zikir dengan getaran rasa sentuhan seperti mengira pada jari.';

  @override
  String get onboardingFeatureSunnahTitle => 'Sunnah Sahih & Doa';

  @override
  String get onboardingFeatureSunnahDesc =>
      'Ayat pilihan harian dan hadis sahih lengkap dengan rujukan yang diyakini.';

  @override
  String get onboardingFeatureQiblaAligned =>
      'Menghadap Kiblat • Makkah Al-Mukarramah';

  @override
  String get onboardingFeatureTapToCount =>
      'Ketik di mana-mana atau leret untuk mengira';

  @override
  String get onboardingPermissionsTitle => 'Persediaan Mudah';

  @override
  String get onboardingPermissionsSubtitle =>
      'Benarkan kebenaran untuk pengiraan waktu solat dan azan yang tepat.';

  @override
  String get onboardingPermLocationTitle => 'Lokasi Tepat';

  @override
  String get onboardingPermLocationDesc =>
      'Digunakan hanya pada telefon untuk mengira koordinat waktu solat.';

  @override
  String get onboardingPermNotifTitle => 'Notifikasi Azan & Solat';

  @override
  String get onboardingPermNotifDesc =>
      'Memberikan azan dan peringatan solat sunat tepat pada masanya.';

  @override
  String get onboardingPermBatteryTitle => 'Penggera Latar Belakang';

  @override
  String get onboardingPermBatteryDesc =>
      'Menghalang sistem Android daripada mematikan penggera azan Subuh.';

  @override
  String get onboardingPermGrant => 'Beri Kebenaran';

  @override
  String get onboardingPermGranted => 'Kebenaran Diberikan';

  @override
  String get onboardingPermEnableLater => 'Tetapkan Kemudian di Tetapan';

  @override
  String get onboardingDedicationVerse =>
      '“Sesungguhnya solat itu adalah satu ketetapan yang diwajibkan atas orang-orang yang beriman pada waktu-waktu tertentu.”';

  @override
  String get onboardingDedicationReference => 'Surah An-Nisa (4:103)';

  @override
  String get onboardingBeginJourney => 'Bismillah • Mulakan';

  @override
  String get onboardingReplayTour => 'Ulang Semula Pengenalan';

  @override
  String get onboardingReplayTourSubtitle =>
      'Terokai semula ciri-ciri aplikasi dan komitmen privasi';

  @override
  String get onboardingBack => 'Kembali';

  @override
  String get navTracker => 'Tracker';

  @override
  String get prayerSunset => 'Terbenam';

  @override
  String get statusNotPrayed => 'Belum Solat';

  @override
  String get statusUpcoming => 'Akan Datang';

  @override
  String get statusNotYet => 'Belum Masuk';

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
  String get settingsBatteryExempt => 'Dikecualikan';

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
  String get categoryAll => 'Semua';

  @override
  String get categoryHadith => 'Hadis';

  @override
  String get categoryAyah => 'Ayat';

  @override
  String get categoryDua => 'Doa';

  @override
  String get categoryMorning => 'Pagi';

  @override
  String get categoryEvening => 'Petang';

  @override
  String get categoryAfterPrayer => 'Selepas Solat';

  @override
  String get categoryForgiveness => 'Keampunan';

  @override
  String get categoryProtection => 'Perlindungan';

  @override
  String get categoryDaily => 'Harian';

  @override
  String get categoryTravel => 'Musafir';

  @override
  String get noSavedItems => 'Tiada item disimpan lagi';

  @override
  String get noSavedItemsSubtitle =>
      'Ketik ikon penanda buku pada mana-mana kandungan untuk simpan di sini.';

  @override
  String get searchPlaceholder => 'Cari doa, terjemahan, atau sumber...';

  @override
  String get sunnahPrayerHeader => 'SOLAT SUNAT';

  @override
  String get sunnahFajrDesc => '2 Rakaat Sunat Qabliyah (Muakkad)';

  @override
  String get sunnahDhuhrDesc => '4 Rakaat Qabliyah & 2 Rakaat Ba\'diyah';

  @override
  String get sunnahAsrDesc => '4 Rakaat Sunat Qabliyah (Ghairu Muakkad)';

  @override
  String get sunnahMaghribDesc => '2 Rakaat Sunat Ba\'diyah';

  @override
  String get sunnahIshaDesc => '2 Rakaat Ba\'diyah + 3 Rakaat Witir';

  @override
  String get forbiddenNaflHeader => 'WAKTU DIHARAMKAN SOLAT SUNAT';

  @override
  String get forbiddenNaflBody =>
      'Solat sunat dilarang ketika matahari terbit (~20 min), rembang matahari (~10 min sebelum Zohor), dan terbenam (~20 min sebelum Maghrib). Qada solat fardu tetap sah. (Sahih Muslim 831)';

  @override
  String get forbiddenNaflSunriseHeader => 'WAKTU HARAM • TERBIT MATAHARI';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'Matahari sedang terbit ($startTime – $endTime). Solat sunat dilarang hingga matahari naik setinggi tombak. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflZawalHeader => 'WAKTU HARAM • ISTIWA / TENGAH HARI';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'Matahari berada tepat di tengah langit ($startTime – $endTime). Solat sunat dilarang ketika ini. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'WAKTU HARAM • TERBENAM MATAHARI';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'Matahari sedang terbenam ($startTime – $endTime). Solat sunat dilarang hingga terbenam sepenuhnya. (Sahih Muslim 831)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return 'Waktu solat $prayer belum bermula ($time)';
  }

  @override
  String get timeStart => 'Mula';

  @override
  String get timeEnd => 'Tamat';

  @override
  String get onboardingShowcasePrayerTitle => 'Waktu Solat Tepat & Jitu';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'Pengiraan waktu solat 100% luar talian mengikut kaedah hisab rasmi dan sahih.';

  @override
  String get onboardingShowcaseQiblaTitle =>
      'Kompas Kiblat Berketepatan Tinggi';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'Ketahui arah Kaabah yang tepat di mana jua anda berada di muka bumi.';

  @override
  String get onboardingShowcaseTasbihTitle => 'Tasbih Digital Dinamik';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'Alat pengira zikir pintar dengan getaran sentuhan haptik dan peralihan automatik.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'Tadabbur Harian, Hadis & Doa';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'Koleksi ayat suci Al-Quran, hadis sahih, dan doa-doa harian mustajab.';

  @override
  String get settingsPrayerNotifications => 'Pemberitahuan Waktu Solat';

  @override
  String get settingsAdhanReciterTone => 'Muazzin & Nada Azan';

  @override
  String get settingsDailyReminderTime => 'Waktu Peringatan Tadabbur';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count Widget Langsung';
  }

  @override
  String get settingsFiqhAsr => 'Fikah (Waktu Asar)';

  @override
  String get settingsFiqhStandardTitle => 'Syafi\'i / Jumhur (Lalai)';

  @override
  String get settingsFiqhStandardDesc =>
      'Syafi\'i, Maliki & Hanbali (1x Bayang)';

  @override
  String get settingsFiqhStandardSub =>
      'Panjang bayang = tinggi objek (1x). Diikuti mazhab Syafi\'i, Maliki, Hanbali & JAKIM.';

  @override
  String get settingsFiqhHanafiTitle => 'Hanafi';

  @override
  String get settingsFiqhHanafiDesc => 'Mazhab Hanafi (2x Bayang)';

  @override
  String get settingsFiqhHanafiSub =>
      'Panjang bayang = 2x tinggi objek. Mengikut mazhab Hanafi.';

  @override
  String get settingsPreAdhanReminder => 'Peringatan Sebelum Azan';

  @override
  String get settingsBatteryRestricted => 'Disekat';

  @override
  String get settingsBatteryExemptDesc =>
      'Dikecualikan — Azan akan berbunyi tepat pada masanya';

  @override
  String get settingsBatteryNotExemptDesc =>
      'Disekat — Pemberitahuan mungkin terlewat di latar belakang';

  @override
  String get settingsCheckBatteryNow => 'Semak Status Sekarang';

  @override
  String get settingsCheckBatterySubtitle =>
      'Sahkan kebenaran latar belakang sistem';

  @override
  String get settingsWarnBattery => 'Beri Amaran Jika Disekat Semula';

  @override
  String get settingsWarnBatterySubtitle =>
      'Maklumkan jika penjimatan bateri OS diaktifkan semula';

  @override
  String get settingsOpenSourceFootnote =>
      '100% Percuma & Sumber Terbuka • Tanpa Iklan • Tanpa Pengumpulan Data';

  @override
  String get settingsAsrCalculationTitle => 'Kaedah Kiraan Asar (Fikah)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'Pilih mazhab fikah untuk menentukan waktu solat Asar.';

  @override
  String get adhanVoiceMakkah => 'Makkah (Ali Mulla)';

  @override
  String get adhanVoiceMadinah => 'Madinah (Abdul Majeed)';

  @override
  String get adhanVoiceAlAqsa => 'Al-Aqsa (Yasser Al-Dossari)';

  @override
  String get adhanVoiceSoft => 'Nada Lembut Tradisional';

  @override
  String get calcMethodUmmAlQura => 'Umm Al-Qura (Arab Saudi)';

  @override
  String get calcMethodMwl => 'Liga Dunia Islam (MWL)';

  @override
  String get calcMethodEgyptian => 'Pihak Berkuasa Am Mesir';

  @override
  String get calcMethodIsna => 'ISNA (Amerika Utara)';

  @override
  String get calcMethodKarachi => 'Universiti Sains Islam Karachi';

  @override
  String get calcMethodDubai => 'Hal Ehwal Islam Dubai';

  @override
  String get calcMethodDiyanet => 'Diyanet (Turki)';

  @override
  String get calcMethodSingapore => 'MUIS (Singapura)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'Solatlah Sebagaimana Kamu Melihat Aku Solat';

  @override
  String get learnSalahAuthenticBadge => 'PANDUAN SUNNAH SAHIH';

  @override
  String get learnSalahSearchPlaceholder =>
      'Cari posisi, langkah atau dalil hadis...';

  @override
  String get learnSalahLearningModules => 'MODUL PEMBELAJARAN';

  @override
  String get learnSalahStepByStepTitle =>
      'Panduan Solat Nabi Langkah Demi Langkah';

  @override
  String get learnSalahStepByStepSubtitle =>
      '10 Langkah berturutan dengan ilustrasi & dalil';

  @override
  String get learnSalahPillarsTitle => '14 Rukun Solat (Arkan)';

  @override
  String get learnSalahPillarsSubtitle =>
      'Rukun asas solat yang wajib disempurnakan';

  @override
  String get learnSalahObligationsTitle => '8 Wajib Solat (Wajibat)';

  @override
  String get learnSalahObligationsSubtitle =>
      'Perkara wajib yang diganti dengan Sujud Sahwi';

  @override
  String get learnSalahSunanTitle => 'Amalan Sunat Solat (Sunan)';

  @override
  String get learnSalahSunanSubtitle =>
      'Sunnah perkataan dan perbuatan Rasulullah ﷺ';

  @override
  String get learnSalahInvalidatorsTitle => 'Perkara Membatalkan Solat';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'Perkara yang membatalkan solat dan wajib diulang';

  @override
  String get learnSalahForbiddenTimesTitle => 'Waktu Diharamkan Solat';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'Waktu di mana solat sunat dilarang sama sekali';

  @override
  String get madhabShafi => 'Syafi\'i';

  @override
  String get madhabHanafi => 'Hanafi';

  @override
  String get eventIslamicNewYear => 'Awal Muharram (Tahun Baru Hijrah)';

  @override
  String get eventTasua => 'Hari Tasu\'a';

  @override
  String get eventAshura => 'Hari Asyura';

  @override
  String get eventMawlid => 'Maulidur Rasul ﷺ';

  @override
  String get eventIsraMiraj => 'Israk dan Mikraj';

  @override
  String get eventMidShaban => 'Malam Nisfu Syaaban';

  @override
  String get eventRamadanStart => 'Awal Ramadan';

  @override
  String get eventBattleOfBadr => 'Perang Badar Al-Kubra';

  @override
  String get eventLaylatAlQadr => 'Malam Lailatul Qadar';

  @override
  String get eventEidAlFitr => 'Hari Raya Aidilfitri';

  @override
  String get eventShawwalSixFasting => 'Puasa 6 Syawal';

  @override
  String get eventDhuAlHijjahStart => 'Awal Zulhijjah';

  @override
  String get eventDayOfArafah => 'Hari Arafah';

  @override
  String get eventEidAlAdha => 'Hari Raya Aidiladha';

  @override
  String get eventDaysOfTashreeq => 'Hari Tasyrik';

  @override
  String get qiblaHeadingTrue => 'ARAH SEBENAR';

  @override
  String get qiblaBearingLabel => 'DARJAH KIBLAT';

  @override
  String get qiblaRetryLocation => 'Cuba Semula Lokasi';

  @override
  String get qiblaCalibClearInterference => 'Jauhi Gangguan Magnetik';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'Jauhi meja logam, komputer atau bekas telefon bermagnet.';

  @override
  String get qiblaCalibHoldFlat => 'Pegang Telefon Mendatar';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'Pastikan telefon rata mendatar selari dengan tanah untuk ketepatan.';

  @override
  String get qiblaCalibFigure8 => 'Lakukan Gerakan Angka 8';

  @override
  String get qiblaCalibFigure8Desc =>
      'Gerakkan telefon membentuk angka 8 di udara untuk menentukur kompas.';

  @override
  String get stepPrevious => 'Sebelum';

  @override
  String get stepNext => 'Langkah Seterusnya';

  @override
  String get stepFinishGuide => 'Selesai';

  @override
  String get widgetAddAnother => 'Tambah Lagi';

  @override
  String get widgetOpenSettings => 'Buka Tetapan';

  @override
  String get widgetGoToHome => 'Ke Halaman Utama';

  @override
  String get trackerWeeklyRate => 'Kadar Mingguan';

  @override
  String get trackerMonthlyRate => 'Kadar Bulanan';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total Solat';
  }

  @override
  String get tasbihHadithTitle => 'HADIS KEUTAMAAN BERTASBIH DENGAN JARI';

  @override
  String get tasbihHadithText =>
      '“Hendaklah kamu sentiasa bertasbih, bertahlil, dan menyucikan Allah, dan hitunglah dengan ruas jari-jemari, kerana sesungguhnya jari-jemari itu akan disoal dan disuruh bercakap pada Hari Kiamat.”';

  @override
  String get tasbihHadithReference => '— Sunan Abi Dawud 1496';

  @override
  String get dhikrSubhanAllah => 'Subhanallah';

  @override
  String get dhikrAlhamdulillah => 'Alhamdulillah';

  @override
  String get dhikrAllahuAkbar => 'Allahu Akbar';

  @override
  String get dhikrAstaghfirullah => 'Astaghfirullah';

  @override
  String get dhikrLaIlahaIllallah => 'La ilaha illallah';

  @override
  String get dhikrSubhanAllahTranslation =>
      'Maha Suci Allah daripada segala kelemahan dan sifat kekurangan';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'Segala puji dan kesyukuran hanya untuk Allah';

  @override
  String get dhikrAllahuAkbarTranslation =>
      'Allah Maha Besar mengatasi segalanya';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'Aku memohon keampunan kepada Allah';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'Tiada tuhan yang berhak disembah melainkan Allah';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'Seterusnya: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'Tersuai';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'Tersuai ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'Tetapkan Sasaran Tersuai';

  @override
  String get tasbihTargetHint => 'Masukkan bilangan sasaran (cth. 50)';

  @override
  String get tasbihCancel => 'Batal';

  @override
  String get tasbihSetTarget => 'Tetapkan Sasaran';

  @override
  String tasbihLap(String lap) {
    return 'Pusingan $lap';
  }
}
