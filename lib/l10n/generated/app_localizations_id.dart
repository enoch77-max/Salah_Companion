// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Salah Companion';

  @override
  String get navHome => 'Beranda';

  @override
  String get navDuas => 'Doa';

  @override
  String get navTasbih => 'Tasbih';

  @override
  String get navQibla => 'Kiblat';

  @override
  String get navCalendar => 'Kalender';

  @override
  String get prayerFajr => 'Subuh';

  @override
  String get prayerSunrise => 'Terbit';

  @override
  String get prayerDhuhr => 'Dzuhur';

  @override
  String get prayerAsr => 'Ashar';

  @override
  String get prayerMaghrib => 'Maghrib';

  @override
  String get prayerIsha => 'Isya';

  @override
  String get upcomingPrayer => 'UPCOMING PRAYER';

  @override
  String get currentSalah => 'CURRENT SALAH';

  @override
  String get remaining => 'tersisa';

  @override
  String get statusPrayed => 'Sudah Shalat';

  @override
  String get statusMissed => 'Terlewat';

  @override
  String get statusPending => 'Menunggu';

  @override
  String get qiblaCompassTitle => 'Kompas Kiblat';

  @override
  String get qiblaCalibrate => 'Kalibrasi';

  @override
  String get qiblaFacingKaaba => 'Tepat menghadap Ka\'bah';

  @override
  String get tasbihTitle => 'Tasbih Digital';

  @override
  String get tasbihReset => 'Atur Ulang';

  @override
  String get tasbihAutoNext => 'Otomatis Lanjut';

  @override
  String get tasbihBestOnFingers =>
      'Menghitung tasbih dengan jari adalah sunnah';

  @override
  String get guidanceCategory => 'BIMBINGAN';

  @override
  String get learnSalah => 'Panduan Shalat';

  @override
  String get learnSalahSubtitle =>
      'Pelajari tata cara shalat sesuai sunnah dan hadits shahih';

  @override
  String get savedItems => 'Tersimpan';

  @override
  String get savedItemsSubtitle => 'Hadits, Ayat & Doa';

  @override
  String get prayerTracker => 'Pelacak Shalat';

  @override
  String get prayerTrackerSubtitle => 'Lihat statistik shalat Anda';

  @override
  String get widgetsTitle => 'Widget';

  @override
  String get widgetsSubtitle => 'Tambahkan widget ke layar utama';

  @override
  String get openSourcePrivacy => 'Sumber Terbuka & Privasi';

  @override
  String get openSourcePrivacySubtitle =>
      '100% luring, tanpa pelacakan & non-komersial';

  @override
  String get themeMode => 'TEMA APLIKASI';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String notificationPrayerTitle(String prayer) {
    return 'Waktu Shalat $prayer';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return 'Telah masuk waktu shalat $prayer. Mari tunaikan shalat.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'Pengingat Awal Waktu — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return 'Sudah 15 menit berlalu dari waktu $prayer. Sudahkah Anda shalat?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'Penting — 30 Menit Tersisa untuk $prayer';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return 'Hanya tersisa 30 menit sebelum waktu shalat $prayer berakhir.';
  }

  @override
  String get notificationDailyReflectionTitle => 'Renungan Harian';

  @override
  String get notificationTestTitle => 'Pemberitahuan Salah Companion';

  @override
  String get notificationTestBody =>
      'Notifikasi dan audio adzan telah berhasil dikonfigurasi.';

  @override
  String get onboardingChooseLanguage => 'Pilih Bahasa Anda';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'Pilih bahasa untuk jadwal shalat, panduan, dan renungan harian.';

  @override
  String get onboardingWelcomeTitle => 'Selamat Datang di Salah Companion';

  @override
  String get onboardingWelcomeBody =>
      'Pendamping ibadah yang akurat, bebas distraksi untuk waktu shalat, kiblat, dan sunnah shahih.';

  @override
  String get onboardingSwipeTitle => 'Geser Tepi Kiri untuk Menu';

  @override
  String get onboardingSwipeBody =>
      'Geser dari tepi paling kiri layar untuk membuka item tersimpan dan pelacak shalat.';

  @override
  String get onboardingSunnahTitle => 'Sunnah Shahih & Bimbingan';

  @override
  String get onboardingSunnahBody =>
      'Akses ayat Al-Qur\'an harian, hadits shahih, doa-doa ma\'tsur, dan tata cara shalat.';

  @override
  String get onboardingCustomizationTitle => 'Kiblat, Tasbih & Pengaturan';

  @override
  String get onboardingCustomizationBody =>
      'Kompas kiblat, tasbih digital, dan penyesuaian metode hisab waktu shalat.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$current DARI $total';
  }

  @override
  String get onboardingSkip => 'Lewati';

  @override
  String get onboardingNext => 'Lanjut';

  @override
  String get onboardingGetStarted => 'Mulai';

  @override
  String get systemDefault => 'Default Sistem';

  @override
  String get moreLanguages => 'Bahasa Lainnya';

  @override
  String get searchLanguagePlaceholder => 'Cari bahasa...';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get settingsLanguageSubtitle => 'Ubah bahasa aplikasi';

  @override
  String get onboardingTrustTitle => 'Amanah Suci Kami Kepada Anda';

  @override
  String get onboardingTrustSubtitle =>
      'Dibuat murni karena Allah — tanpa iklan, tanpa pelacakan, 100% privasi terjaga.';

  @override
  String get onboardingTrustOfflineTitle =>
      '100% Di Perangkat & Sepenuhnya Privat';

  @override
  String get onboardingTrustOfflineDesc =>
      'Lokasi dan catatan ibadah Anda tidak pernah meninggalkan ponsel. Semua hisab astronomi dihitung secara lokal tanpa koneksi internet.';

  @override
  String get onboardingTrustNoAdsTitle => 'Tanpa Iklan Selamanya';

  @override
  String get onboardingTrustNoAdsDesc =>
      'Tanpa banner komersial, tanpa pop-up yang mengganggu kekhusyukan ibadah Anda.';

  @override
  String get onboardingTrustNoTrackingTitle => 'Nol Pelacakan & Analisis';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'Tanpa pelacakan Firebase, tanpa pengumpulan data pribadi, tanpa telemetri latar belakang.';

  @override
  String get onboardingTrustFreeTitle => 'Gratis Selamanya untuk Umat';

  @override
  String get onboardingTrustFreeDesc =>
      'Dihibahkan sebagai sedekah jariyah. Tanpa langganan, tanpa fitur berbayar.';

  @override
  String get onboardingFeaturesTitle => 'Jelajahi Fitur Utama';

  @override
  String get onboardingFeaturesSubtitle =>
      'Jadwal salat akurat, panduan sunnah autentik, dan sarana ibadah yang menenangkan.';

  @override
  String get onboardingFeaturePrayerTitle => 'Presisi Astronomi';

  @override
  String get onboardingFeaturePrayerDesc =>
      'Hisab matahari akurat sesuai Kemenag dan pengingat salat sunnah.';

  @override
  String get onboardingFeatureQiblaTitle => 'Kompas Kiblat Real-Time';

  @override
  String get onboardingFeatureQiblaDesc =>
      'Penunjuk arah Ka\'bah dengan stabilisasi sensor geomagnetik dan getaran haptik.';

  @override
  String get onboardingFeatureTasbihTitle => 'Tasbih Digital Haptik';

  @override
  String get onboardingFeatureTasbihDesc =>
      'Sensasi sentuhan tasbih dengan zikir-zikir ma\'tsur dari sunnah Nabi.';

  @override
  String get onboardingFeatureSunnahTitle => 'Sunnah Sahih & Doa Harian';

  @override
  String get onboardingFeatureSunnahDesc =>
      'Tadabur ayat harian dan hadis sahih lengkap dengan rujukan kitab-kitab induk.';

  @override
  String get onboardingFeatureQiblaAligned =>
      'Tepat Mengarah Kiblat • Makkah Al-Mukarramah';

  @override
  String get onboardingFeatureTapToCount =>
      'Ketuk di mana saja atau geser untuk menghitung';

  @override
  String get onboardingPermissionsTitle => 'Pengaturan Mudah';

  @override
  String get onboardingPermissionsSubtitle =>
      'Aktifkan izin untuk kalkulasi waktu salat dan notifikasi azan tepat waktu.';

  @override
  String get onboardingPermLocationTitle => 'Lokasi Akurat';

  @override
  String get onboardingPermLocationDesc =>
      'Hanya digunakan di perangkat untuk menghitung koordinat jadwal salat lokal.';

  @override
  String get onboardingPermNotifTitle => 'Notifikasi Azan & Salat';

  @override
  String get onboardingPermNotifDesc =>
      'Menyampaikan azan tepat waktu serta pengingat salat sunnah rawatib.';

  @override
  String get onboardingPermBatteryTitle => 'Alarm Latar Belakang Andal';

  @override
  String get onboardingPermBatteryDesc =>
      'Mencegah optimasi baterai Android mematikan alarm azan Subuh.';

  @override
  String get onboardingPermGrant => 'Beri Izin';

  @override
  String get onboardingPermGranted => 'Izin Diberikan';

  @override
  String get onboardingPermEnableLater => 'Atur Nanti di Pengaturan';

  @override
  String get onboardingDedicationVerse =>
      '“Sungguh, salat itu adalah kewajiban yang ditentukan waktunya atas orang-orang yang beriman.”';

  @override
  String get onboardingDedicationReference => 'Surah An-Nisa (4:103)';

  @override
  String get onboardingBeginJourney => 'Bismillah • Mulai';

  @override
  String get onboardingReplayTour => 'Putar Ulang Tur Pengenalan';

  @override
  String get onboardingReplayTourSubtitle =>
      'Lihat kembali fitur aplikasi dan komitmen privasi kami';

  @override
  String get onboardingBack => 'Kembali';

  @override
  String get navTracker => 'Tracker';

  @override
  String get prayerSunset => 'Terbenam';

  @override
  String get statusNotPrayed => 'Belum Shalat';

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
  String get categoryAfterPrayer => 'Setelah Shalat';

  @override
  String get categoryForgiveness => 'Istighfar';

  @override
  String get categoryProtection => 'Perlindungan';

  @override
  String get categoryDaily => 'Harian';

  @override
  String get categoryTravel => 'Safar';

  @override
  String get noSavedItems => 'Belum ada item tersimpan';

  @override
  String get noSavedItemsSubtitle =>
      'Ketuk ikon bookmark pada konten apa pun untuk menyimpannya di sini.';

  @override
  String get searchPlaceholder => 'Cari doa, terjemahan, atau sumber...';

  @override
  String get sunnahPrayerHeader => 'SHALAT SUNNAH';

  @override
  String get sunnahFajrDesc => '2 Rakaat Sunnah Qabliyah (Muakkadah)';

  @override
  String get sunnahDhuhrDesc => '4 Rakaat Qabliyah & 2 Rakaat Ba\'diyah';

  @override
  String get sunnahAsrDesc => '4 Rakaat Sunnah Qabliyah (Ghairu Muakkadah)';

  @override
  String get sunnahMaghribDesc => '2 Rakaat Sunnah Ba\'diyah';

  @override
  String get sunnahIshaDesc => '2 Rakaat Ba\'diyah + 3 Rakaat Witir';

  @override
  String get forbiddenNaflHeader => 'WAKTU TERLARANG SHALAT SUNNAH';

  @override
  String get forbiddenNaflBody =>
      'Shalat sunnah dilarang saat matahari terbit (~20 mnt), istiwa/tengah hari (~10 mnt sebelum Dzuhur), dan terbenam (~20 mnt sebelum Maghrib). Shalat qadha tetap sah. (Shahih Muslim 831)';

  @override
  String get forbiddenNaflSunriseHeader => 'WAKTU TERLARANG • TERBIT MATAHARI';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'Matahari sedang terbit ($startTime – $endTime). Shalat sunnah dilarang hingga matahari naik sempurna. (Shahih Muslim 831)';
  }

  @override
  String get forbiddenNaflZawalHeader =>
      'WAKTU TERLARANG • ISTIWA / TENGAH HARI';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'Matahari tepat di atas kepala ($startTime – $endTime). Shalat sunnah dilarang pada puncak siang ini. (Shahih Muslim 831)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'WAKTU TERLARANG • TERBENAM MATAHARI';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'Matahari sedang terbenam ($startTime – $endTime). Shalat sunnah dilarang hingga terbenam sempurna. (Shahih Muslim 831)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return 'Waktu shalat $prayer belum masuk ($time)';
  }

  @override
  String get timeStart => 'Mulai';

  @override
  String get timeEnd => 'Berakhir';

  @override
  String get onboardingShowcasePrayerTitle => 'Jadwal Shalat Akurat & Presisi';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'Perhitungan waktu shalat 100% offline menggunakan metode astronomi terpercaya.';

  @override
  String get onboardingShowcaseQiblaTitle => 'Kompas Kiblat Akurat';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'Temukan arah Ka\'bah dengan mudah di mana pun Anda berada di seluruh dunia.';

  @override
  String get onboardingShowcaseTasbihTitle => 'Tasbih Digital Interaktif';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'Hitung zikir dengan getaran haptik responsif dan target otomatis.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'Renungan Harian, Hadits & Doa';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'Ayat Al-Qur\'an terverifikasi, hadits shahih, dan doa-doa harian mustajab.';

  @override
  String get settingsPrayerNotifications => 'Notifikasi Shalat';

  @override
  String get settingsAdhanReciterTone => 'Muadzin & Suara Adzan';

  @override
  String get settingsDailyReminderTime => 'Waktu Notifikasi Renungan';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count Widget Aktif';
  }

  @override
  String get settingsFiqhAsr => 'Fiqih (Waktu Ashar)';

  @override
  String get settingsFiqhStandardTitle => 'Syafi\'i / Mayoritas (Standar)';

  @override
  String get settingsFiqhStandardDesc =>
      'Syafi\'i, Maliki & Hanbali (1x Bayangan)';

  @override
  String get settingsFiqhStandardSub =>
      'Panjang bayangan = tinggi benda (1x). Diikuti mazhab Syafi\'i, Maliki, Hanbali & Kemenag.';

  @override
  String get settingsFiqhHanafiTitle => 'Hanafi';

  @override
  String get settingsFiqhHanafiDesc => 'Mazhab Hanafi (2x Bayangan)';

  @override
  String get settingsFiqhHanafiSub =>
      'Panjang bayangan = 2x tinggi benda. Mengikuti ijtihad mazhab Hanafi.';

  @override
  String get settingsPreAdhanReminder => 'Pengingat Sebelum Adzan';

  @override
  String get settingsBatteryRestricted => 'Dibatasi';

  @override
  String get settingsBatteryExemptDesc =>
      'Dikecualikan — Alarm adzan akan berbunyi tepat waktu';

  @override
  String get settingsBatteryNotExemptDesc =>
      'Dibatasi — Alarm adzan mungkin tertunda di latar belakang';

  @override
  String get settingsCheckBatteryNow => 'Periksa Status Sekarang';

  @override
  String get settingsCheckBatterySubtitle =>
      'Verifikasi izin latar belakang sistem';

  @override
  String get settingsWarnBattery => 'Peringatkan jika Dibatasi Kembali';

  @override
  String get settingsWarnBatterySubtitle =>
      'Beri tahu jika penghemat baterai OS aktif kembali';

  @override
  String get settingsOpenSourceFootnote =>
      '100% Gratis & Open Source • Tanpa Iklan • Tanpa Pelacakan';

  @override
  String get settingsAsrCalculationTitle => 'Metode Perhitungan Ashar (Fiqih)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'Pilih mazhab fikih untuk waktu shalat Ashar.';

  @override
  String get adhanVoiceMakkah => 'Mekkah (Ali Mulla)';

  @override
  String get adhanVoiceMadinah => 'Madinah (Abdul Majeed)';

  @override
  String get adhanVoiceAlAqsa => 'Al-Aqsha (Yasser Al-Dossari)';

  @override
  String get adhanVoiceSoft => 'Nada Lembut Tradisional';

  @override
  String get calcMethodUmmAlQura => 'Umm Al-Qura (Arab Saudi)';

  @override
  String get calcMethodMwl => 'Liga Muslim Dunia (MWL)';

  @override
  String get calcMethodEgyptian => 'Otoritas Umum Mesir (Survey)';

  @override
  String get calcMethodIsna => 'ISNA (Amerika Utara)';

  @override
  String get calcMethodKarachi => 'Universitas Ilmu Islam Karachi';

  @override
  String get calcMethodDubai => 'Departemen Urusan Islam Dubai';

  @override
  String get calcMethodDiyanet => 'Diyanet (Turki)';

  @override
  String get calcMethodSingapore => 'MUIS (Singapura)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'Shalatlah Sebagaimana Kalian Melihatku Shalat';

  @override
  String get learnSalahAuthenticBadge => 'PANDUAN SUNNAH SHAHIH';

  @override
  String get learnSalahSearchPlaceholder =>
      'Cari gerakan, langkah, atau dalil hadits...';

  @override
  String get learnSalahLearningModules => 'MODUL PEMBELAJARAN';

  @override
  String get learnSalahStepByStepTitle =>
      'Panduan Shalat Nabi Langkah Demi Langkah';

  @override
  String get learnSalahStepByStepSubtitle =>
      '10 Langkah berurutan lengkap dengan ilustrasi & dalil';

  @override
  String get learnSalahPillarsTitle => '14 Rukun Shalat (Arkan)';

  @override
  String get learnSalahPillarsSubtitle =>
      'Fondasi utama shalat yang tidak boleh ditinggalkan';

  @override
  String get learnSalahObligationsTitle => '8 Kewajiban Shalat (Wajibat)';

  @override
  String get learnSalahObligationsSubtitle =>
      'Kewajiban shalat yang ditambal dengan Sujud Sahwi';

  @override
  String get learnSalahSunanTitle => 'Sunnah-Sunnah Shalat (Sunan)';

  @override
  String get learnSalahSunanSubtitle =>
      'Sunnah ucapan dan perbuatan Rasulullah ﷺ';

  @override
  String get learnSalahInvalidatorsTitle => 'Pembatal Shalat (Mubthilat)';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'Hal-hal yang merusak dan membatalkan shalat';

  @override
  String get learnSalahForbiddenTimesTitle => 'Waktu-Waktu Dilarang Shalat';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'Waktu di mana shalat sunnah dilarang dikerjakan';

  @override
  String get madhabShafi => 'Syafi\'i';

  @override
  String get madhabHanafi => 'Hanafi';

  @override
  String get eventIslamicNewYear => 'Tahun Baru Islam';

  @override
  String get eventTasua => 'Hari Tasu\'a';

  @override
  String get eventAshura => 'Hari Asyura';

  @override
  String get eventMawlid => 'Maulid Nabi Muhammad ﷺ';

  @override
  String get eventIsraMiraj => 'Isra Mi\'raj';

  @override
  String get eventMidShaban => 'Malam Nisfu Sya\'ban';

  @override
  String get eventRamadanStart => 'Awal Puasa Ramadhan';

  @override
  String get eventBattleOfBadr => 'Peristiwa Perang Badar';

  @override
  String get eventLaylatAlQadr => 'Malam Lailatul Qadar';

  @override
  String get eventEidAlFitr => 'Hari Raya Idul Fitri';

  @override
  String get eventShawwalSixFasting => 'Puasa 6 Hari Syawal';

  @override
  String get eventDhuAlHijjahStart => 'Awal Bulan Dzulhijjah';

  @override
  String get eventDayOfArafah => 'Hari Arafah';

  @override
  String get eventEidAlAdha => 'Hari Raya Idul Adha';

  @override
  String get eventDaysOfTashreeq => 'Hari Tasyrik';

  @override
  String get qiblaHeadingTrue => 'ARAH SEBENARNYA';

  @override
  String get qiblaBearingLabel => 'DERAJAT KIBLAT';

  @override
  String get qiblaRetryLocation => 'Coba Lagi Lokasi';

  @override
  String get qiblaCalibClearInterference => 'Hindari Gangguan Magnetik';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'Jauhi meja logam, komputer, atau casing hp bermagnet.';

  @override
  String get qiblaCalibHoldFlat => 'Pegang Perangkat Datar Horizontal';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'Jaga ponsel tetap datar sejajar tanah untuk akurasi optimal.';

  @override
  String get qiblaCalibFigure8 => 'Lakukan Gerakan Angka 8';

  @override
  String get qiblaCalibFigure8Desc =>
      'Gerakkan ponsel membentuk pola angka 8 di udara untuk kalibrasi kompas.';

  @override
  String get stepPrevious => 'Sebelumnya';

  @override
  String get stepNext => 'Langkah Berikutnya';

  @override
  String get stepFinishGuide => 'Selesaikan Panduan';

  @override
  String get widgetAddAnother => 'Tambah Lainnya';

  @override
  String get widgetOpenSettings => 'Buka Pengaturan';

  @override
  String get widgetGoToHome => 'Kembali ke Beranda';

  @override
  String get trackerWeeklyRate => 'Rata-rata Mingguan';

  @override
  String get trackerMonthlyRate => 'Rata-rata Bulanan';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total Shalat';
  }

  @override
  String get tasbihHadithTitle => 'HADITS KEUTAMAAN BERTASBIH DENGAN JARI';

  @override
  String get tasbihHadithText =>
      '“Hendaklah kalian senantiasa bertasbih, bertahlil, dan menyucikan Allah, dan hitunglah dengan ujung jari-jemari, karena sesungguhnya jari-jemari itu akan ditanya dan diminta berbicara pada Hari Kiamat.”';

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
      'Maha Suci Allah dari segala kekurangan dan cela';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'Segala puji dan syukur hanya milik Allah';

  @override
  String get dhikrAllahuAkbarTranslation =>
      'Allah Maha Besar melampaui segala sesuatu';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'Aku memohon ampunan dan tobat kepada Allah';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'Tiada sesembahan yang berhak disembah selain Allah';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'Selanjutnya: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'Kustom';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'Kustom ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'Tentukan Target Kustom';

  @override
  String get tasbihTargetHint => 'Masukkan jumlah target (mis. 50)';

  @override
  String get tasbihCancel => 'Batal';

  @override
  String get tasbihSetTarget => 'Simpan Target';

  @override
  String tasbihLap(String lap) {
    return 'Putaran $lap';
  }
}
