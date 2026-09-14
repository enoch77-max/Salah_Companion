// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bosnian (`bs`).
class AppLocalizationsBs extends AppLocalizations {
  AppLocalizationsBs([String locale = 'bs']) : super(locale);

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
  String get remaining => 'preostalo';

  @override
  String get statusPrayed => 'Prayed';

  @override
  String get statusMissed => 'Missed';

  @override
  String get statusPending => 'Pending';

  @override
  String get qiblaCompassTitle => 'Kibla kompas';

  @override
  String get qiblaCalibrate => 'Kalibracija';

  @override
  String get qiblaFacingKaaba => 'Potpuno usmjerenje prema Kabi';

  @override
  String get tasbihTitle => 'Digitalni tesbih';

  @override
  String get tasbihReset => 'Resetuj';

  @override
  String get tasbihAutoNext => 'Automatski dalje';

  @override
  String get tasbihBestOnFingers => 'Brojanje tesbiha na prste je sunnet';

  @override
  String get guidanceCategory => 'UPUTSTVA';

  @override
  String get learnSalah => 'Podučavanje namazu';

  @override
  String get learnSalahSubtitle =>
      'Naučite propise namaza prema vjerodostojnom sunnetu';

  @override
  String get savedItems => 'Sačuvano';

  @override
  String get savedItemsSubtitle => 'Hadisi, Ajeti i Dove';

  @override
  String get prayerTracker => 'Evidencija namaza';

  @override
  String get prayerTrackerSubtitle => 'Pregledajte statistiku namaza';

  @override
  String get widgetsTitle => 'Vidžeti';

  @override
  String get widgetsSubtitle => 'Dodajte vidžete na početni ekran';

  @override
  String get openSourcePrivacy => 'Otvoreni kod i privatnost';

  @override
  String get openSourcePrivacySubtitle =>
      '100% van mreže, bez praćenja i nekomercijalno';

  @override
  String get themeMode => 'REŽIM TEME';

  @override
  String get themeSystem => 'Sistemska';

  @override
  String get themeLight => 'Svijetla';

  @override
  String get themeDark => 'Tamna';

  @override
  String notificationPrayerTitle(String prayer) {
    return '$prayer namaz';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return 'Nastupilo je vrijeme za $prayer namaz. Pripremite se za namaz.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'Podsjetnik na početku vakta — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return 'Prošlo je 15 minuta od nastupa $prayer namaza. Jeste li klanjali?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'Hitno — 30 minuta do kraja $prayer namaza';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return 'Ostalo je samo 30 minuta do isteka vremena za $prayer namaz.';
  }

  @override
  String get notificationDailyReflectionTitle => 'Dnevno razmišljanje';

  @override
  String get notificationTestTitle => 'Obavijest Salah Companion';

  @override
  String get notificationTestBody =>
      'Obavještenja i zvuk ezana su uspješno podešeni.';

  @override
  String get onboardingChooseLanguage => 'Izaberite svoj jezik';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'Izaberite željeni jezik za vaktiju, uputstva i razmišljanja.';

  @override
  String get onboardingWelcomeTitle => 'Dobrodošli u Salah Companion';

  @override
  String get onboardingWelcomeBody =>
      'Vaš pouzdan saputnik za tačna namaska vremena, kiblu i vjerodostojni sunnet.';

  @override
  String get onboardingSwipeTitle => 'Prevucite s lijevog ruba za meni';

  @override
  String get onboardingSwipeBody =>
      'Prevucite s krajnje lijevog ruba ekrana za pristup sačuvanim stavkama i statistici.';

  @override
  String get onboardingSunnahTitle => 'Vjerodostojni Sunnet i Uputa';

  @override
  String get onboardingSunnahBody =>
      'Dnevni kur\'anski ajeti, vjerodostojni hadisi, dova i opis namaza poslanika ﷺ.';

  @override
  String get onboardingCustomizationTitle => 'Kibla, Tesbih i Postavke';

  @override
  String get onboardingCustomizationBody =>
      'Kibla kompas, digitalni tesbih i podešavanje metoda proračuna namaza.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$current OD $total';
  }

  @override
  String get onboardingSkip => 'Preskoči';

  @override
  String get onboardingNext => 'Dalje';

  @override
  String get onboardingGetStarted => 'Započni';

  @override
  String get systemDefault => 'Sistemski jezik';

  @override
  String get moreLanguages => 'Ostali jezici';

  @override
  String get searchLanguagePlaceholder => 'Pretraži jezik...';

  @override
  String get settingsTitle => 'Postavke';

  @override
  String get settingsLanguage => 'Jezik';

  @override
  String get settingsLanguageSubtitle => 'Promijenite jezik aplikacije';

  @override
  String get onboardingTrustTitle => 'Naš sveti emanet prema vama';

  @override
  String get onboardingTrustSubtitle =>
      'Napravljeno isključivo u ime Allaha — nula reklama, nula praćenja, 100% privatno.';

  @override
  String get onboardingTrustOfflineTitle => '100% Na Uređaju i Oflajn';

  @override
  String get onboardingTrustOfflineDesc =>
      'Vaša lokacija i zapisi namaza nikada ne napuštaju vaš telefon. Svi astronomski proračuni vrše se lokalno.';

  @override
  String get onboardingTrustNoAdsTitle => 'Bez reklama. Zauvijek.';

  @override
  String get onboardingTrustNoAdsDesc =>
      'Nema komercijalnih banera niti skočnih prozora koji bi ometali vaš ibadet.';

  @override
  String get onboardingTrustNoTrackingTitle => 'Nula analitike i praćenja';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'Bez Firebase praćenja, bez prikupljanja ličnih podataka.';

  @override
  String get onboardingTrustFreeTitle => 'Besplatno zauvijek za Ummet';

  @override
  String get onboardingTrustFreeDesc =>
      'Izgrađeno kao trajna sadaka (Sadaka Džarija). Nema pretplata niti plaćanja.';

  @override
  String get onboardingFeaturesTitle => 'Glavne Mogućnosti';

  @override
  String get onboardingFeaturesSubtitle =>
      'Tačna namaska vremena, autentični sunnet i alati za ibadet.';

  @override
  String get onboardingFeaturePrayerTitle => 'Astronomska Tačnost';

  @override
  String get onboardingFeaturePrayerDesc =>
      'Precizan proračun sunčevih uglova i podsjetnici na dobrovoljne sunnete.';

  @override
  String get onboardingFeatureQiblaTitle => 'Kibla Kompas Uživo';

  @override
  String get onboardingFeatureQiblaDesc =>
      'Precizno usmjeravanje prema Časnoj Kabi uz vibraciju pri poravnanju.';

  @override
  String get onboardingFeatureTasbihTitle => 'Haptički Digitalni Tespih';

  @override
  String get onboardingFeatureTasbihDesc =>
      'Ugodan osjećaj brojanja uz vibraciju i vjerodostojne Poslanikove zikrove.';

  @override
  String get onboardingFeatureSunnahTitle => 'Vjerodostojni Sunnet i Dove';

  @override
  String get onboardingFeatureSunnahDesc =>
      'Dnevni kur\'anski ajeti i vjerodostojni hadisi iz Buharije i Muslima s izvorima.';

  @override
  String get onboardingFeatureQiblaAligned => 'Kibla Poravnata • Mekka';

  @override
  String get onboardingFeatureTapToCount =>
      'Dodirnite bilo gdje ili prevucite za brojanje';

  @override
  String get onboardingPermissionsTitle => 'Jednostavno Podešavanje';

  @override
  String get onboardingPermissionsSubtitle =>
      'Omogućite dozvole za tačan proračun vaktije i pravovremena ezan obavještenja.';

  @override
  String get onboardingPermLocationTitle => 'Tačna Lokacija';

  @override
  String get onboardingPermLocationDesc =>
      'Koristi se isključivo na uređaju za izračunavanje izlaska i zalaska sunca.';

  @override
  String get onboardingPermNotifTitle => 'Obavijesti o Ezanu i Namazu';

  @override
  String get onboardingPermNotifDesc =>
      'Pravovremeni ezan i blagi podsjetnici za namaz.';

  @override
  String get onboardingPermBatteryTitle => 'Pouzdana Pozadinska Alarma';

  @override
  String get onboardingPermBatteryDesc =>
      'Sprečava Android optimizaciju baterije da ugasi sabahski ezan.';

  @override
  String get onboardingPermGrant => 'Dozvoli Pristup';

  @override
  String get onboardingPermGranted => 'Dozvoljeno';

  @override
  String get onboardingPermEnableLater => 'Podesi kasnije u postavkama';

  @override
  String get onboardingDedicationVerse =>
      '„Vjernicima je propisano da u određeno vrijeme namaz obavljaju.“';

  @override
  String get onboardingDedicationReference => 'Sura En-Nisa (4:103)';

  @override
  String get onboardingBeginJourney => 'Bismillah • Započni';

  @override
  String get onboardingReplayTour => 'Ponovi Uvodni Vodič';

  @override
  String get onboardingReplayTourSubtitle =>
      'Pogledajte funkcije aplikacije i garanciju privatnosti ponovo';

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
  String get settingsBatteryExempt => 'Izuzeto';

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
  String get sunnahPrayerHeader => 'SUNNET NAMAZ';

  @override
  String get sunnahFajrDesc => '2 rekata sunneta prije farza';

  @override
  String get sunnahDhuhrDesc => '4 rekata prije i 2 rekata poslije farza';

  @override
  String get sunnahAsrDesc => '4 rekata sunneta prije farza';

  @override
  String get sunnahMaghribDesc => '2 rekata sunneta poslije farza';

  @override
  String get sunnahIshaDesc => '2 rekata poslije farza + 3 rekata vitra';

  @override
  String get forbiddenNaflHeader => 'ZABRANJENA VREMENA ZA NAFILA NAMAZ';

  @override
  String get forbiddenNaflBody =>
      'Dobrovoljni (nafila) namazi su zabranjeni tokom izlaska sunca (~20 min), zenita (~10 min prije podne) i zalaska sunca (~20 min prije akšama). Naklanjavanje farzova je dozvoljeno. (Sahih Muslim 831)';

  @override
  String get forbiddenNaflSunriseHeader => 'ZABRANJENO VRIJEME • IZLAZAK SUNCA';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'Sunce izlazi ($startTime – $endTime). Nafila namazi su zabranjeni dok sunce potpuno ne odskoči. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflZawalHeader => 'ZABRANJENO VRIJEME • ZENIT (ZEVAL)';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'Sunce je u zenitu ($startTime – $endTime). Nafila namazi su zabranjeni u ovo doba dana. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'ZABRANJENO VRIJEME • ZALAZAK SUNCA';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'Sunce zalazi ($startTime – $endTime). Nafila namazi su zabranjeni dok sunce potpuno ne zađe. (Sahih Muslim 831)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return 'Vakat za $prayer još nije nastupio ($time)';
  }

  @override
  String get timeStart => 'Početak';

  @override
  String get timeEnd => 'Kraj';

  @override
  String get onboardingShowcasePrayerTitle => 'Precizna Vremena Namaza';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'Tačan proračun namaskih vremena 100% offline prema priznatim islamskim metodama.';

  @override
  String get onboardingShowcaseQiblaTitle => 'Pravi Kibla Kompas';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'Pronađite tačan pravac prema Kabi s bilo koje tačke na planeti.';

  @override
  String get onboardingShowcaseTasbihTitle => 'Taktiilni Digitalni Tesbih';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'Brojač zikra sa vibracijskim odzivom i automatskim prebacivanjem.';

  @override
  String get onboardingShowcaseReflectionTitle => 'Dnevni Ajeti, Hadisi i Dove';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'Vjerodostojni hadisi, kur\'anski ajeti i neophodne svakodnevne dove.';

  @override
  String get settingsPrayerNotifications => 'Obavijesti o Namazu';

  @override
  String get settingsAdhanReciterTone => 'Mujezin i Zvuk Ezana';

  @override
  String get settingsDailyReminderTime => 'Vrijeme Dnevnog Podsjetnika';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count Aktivna Widgeta';
  }

  @override
  String get settingsFiqhAsr => 'Fikh (Ikindijsko Vrijeme)';

  @override
  String get settingsFiqhStandardTitle => 'Šafijski / Standardni (Zadano)';

  @override
  String get settingsFiqhStandardDesc =>
      'Šafijski, Malikijski i Hanbelijski (1x Sjena)';

  @override
  String get settingsFiqhStandardSub =>
      'Dužina sjene = 1x visina predmeta. Šafijski, malikijski, hanbelijski mezheb.';

  @override
  String get settingsFiqhHanafiTitle => 'Hanefijski';

  @override
  String get settingsFiqhHanafiDesc => 'Hanefijski Mezheb (2x Sjena)';

  @override
  String get settingsFiqhHanafiSub =>
      'Dužina sjene = 2x visina predmeta. Prema hanefijskom fikhu.';

  @override
  String get settingsPreAdhanReminder => 'Podsjetnik Prije Ezana';

  @override
  String get settingsBatteryRestricted => 'Ograničeno';

  @override
  String get settingsBatteryExemptDesc =>
      'Izuzeto — Ezan će se oglasiti tačno na vrijeme';

  @override
  String get settingsBatteryNotExemptDesc =>
      'Nije izuzeto — Obavijesti mogu kasniti u pozadini';

  @override
  String get settingsCheckBatteryNow => 'Provjeri Status Sada';

  @override
  String get settingsCheckBatterySubtitle =>
      'Provjerite dozvole za rad u pozadini';

  @override
  String get settingsWarnBattery => 'Upozori ako se Ponovo Ograniči';

  @override
  String get settingsWarnBatterySubtitle =>
      'Upozori ako sistem ponovo uključi štednju baterije';

  @override
  String get settingsOpenSourceFootnote =>
      '100% Besplatno i Otvorenog Koda • Bez Reklama • Bez Prikupljanja Podataka';

  @override
  String get settingsAsrCalculationTitle => 'Metoda Proračuna Ikindije (Fikh)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'Odaberite pravnu školu za proračun vremena ikindije namaza.';

  @override
  String get adhanVoiceMakkah => 'Mekka (Ali Mulla)';

  @override
  String get adhanVoiceMadinah => 'Medina (Abdul Medžid)';

  @override
  String get adhanVoiceAlAqsa => 'Al-Aksa (Jaser Al-Dosari)';

  @override
  String get adhanVoiceSoft => 'Tradicionalni Blagi Ton';

  @override
  String get calcMethodUmmAlQura => 'Umm Al-Qura (Saudijska Arabija)';

  @override
  String get calcMethodMwl => 'Muslimanska svjetska liga (MWL)';

  @override
  String get calcMethodEgyptian => 'Egipatska geodetska uprava';

  @override
  String get calcMethodIsna => 'ISNA (Sjeverna Amerika)';

  @override
  String get calcMethodKarachi => 'Univerzitet islamskih nauka u Karačiju';

  @override
  String get calcMethodDubai => 'Islamski poslovi u Dubaiju';

  @override
  String get calcMethodDiyanet => 'Diyanet (Turska)';

  @override
  String get calcMethodSingapore => 'MUIS (Singapur)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'Klanjajte onako kako ste vidjeli mene da klanjam';

  @override
  String get learnSalahAuthenticBadge => 'VODIČ KROZ VJERODOSTOJNI SUNNET';

  @override
  String get learnSalahSearchPlaceholder =>
      'Pretražite položaj, korak ili hadiski dokaz...';

  @override
  String get learnSalahLearningModules => 'MODULI ZA UČENJE';

  @override
  String get learnSalahStepByStepTitle => 'Vodič kroz Namaz Korak po Korak';

  @override
  String get learnSalahStepByStepSubtitle =>
      '10 Sekvencijalnih koraka sa 2D položajima i dokazima';

  @override
  String get learnSalahPillarsTitle => '14 Namaskih Ruknova (Farzova)';

  @override
  String get learnSalahPillarsSubtitle => 'Neizostavni temelji namaza';

  @override
  String get learnSalahObligationsTitle => '8 Namaskih Vadžiba';

  @override
  String get learnSalahObligationsSubtitle =>
      'Vadžibi koji se nadoknađuju Sehvi-sedždom';

  @override
  String get learnSalahSunanTitle => 'Namaski Sunneti (Sunan)';

  @override
  String get learnSalahSunanSubtitle =>
      'Verbalni i praktični sunneti Poslanika ﷺ';

  @override
  String get learnSalahInvalidatorsTitle => 'Kvaritelji Namaza (Mubtilaat)';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'Stvari koje kvare namaz i nalažu ponavljanje';

  @override
  String get learnSalahForbiddenTimesTitle => 'Zabranjena Namaska Vremena';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'Vremena u kojima je dobrovoljni namaz strogo zabranjen';

  @override
  String get madhabShafi => 'Šafijski';

  @override
  String get madhabHanafi => 'Hanefijski';

  @override
  String get eventIslamicNewYear => 'Hidžretska Nova godina';

  @override
  String get eventTasua => 'Dan Tasu\'a';

  @override
  String get eventAshura => 'Dan Ašure';

  @override
  String get eventMawlid => 'Mevlud (Rođenje Poslanika ﷺ)';

  @override
  String get eventIsraMiraj => 'Lejletul-Mi\'radž';

  @override
  String get eventMidShaban => 'Lejletul-Berat (Pola Ša\'bana)';

  @override
  String get eventRamadanStart => 'Prvi dan Ramazana';

  @override
  String get eventBattleOfBadr => 'Bitka na Bedru';

  @override
  String get eventLaylatAlQadr => 'Lejletul-Kadr';

  @override
  String get eventEidAlFitr => 'Ramazanski bajram';

  @override
  String get eventShawwalSixFasting => 'Šest dana posta u Ševvalu';

  @override
  String get eventDhuAlHijjahStart => 'Početak Zul-hidždžeta';

  @override
  String get eventDayOfArafah => 'Dan Arefata';

  @override
  String get eventEidAlAdha => 'Kurban-bajram';

  @override
  String get eventDaysOfTashreeq => 'Dani Tešrika';

  @override
  String get qiblaHeadingTrue => 'PRAVI PRAVAC';

  @override
  String get qiblaBearingLabel => 'AZIMUT KIBLE';

  @override
  String get qiblaRetryLocation => 'Pokušaj ponovo lokaciju';

  @override
  String get qiblaCalibClearInterference => 'Izbjegavajte magnetske smetnje';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'Udaljite se od metalnih stolova, računara ili magnetnih maski.';

  @override
  String get qiblaCalibHoldFlat => 'Držite uređaj vodoravno';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'Držite telefon ravno i paralelno s tlom za maksimalnu preciznost.';

  @override
  String get qiblaCalibFigure8 => 'Napravite pokret u obliku broja 8';

  @override
  String get qiblaCalibFigure8Desc =>
      'Lagano pomičite telefon u zraku u obliku osmice radi kalibracije kompasa.';

  @override
  String get stepPrevious => 'Prethodno';

  @override
  String get stepNext => 'Sljedeći korak';

  @override
  String get stepFinishGuide => 'Završi vodič';

  @override
  String get widgetAddAnother => 'Dodaj još jedan';

  @override
  String get widgetOpenSettings => 'Otvori postavke';

  @override
  String get widgetGoToHome => 'Idi na početnu';

  @override
  String get trackerWeeklyRate => 'Sedmični omjer';

  @override
  String get trackerMonthlyRate => 'Mjesečni omjer';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total Namaza';
  }

  @override
  String get tasbihHadithTitle => 'HADIS O VRIJEDNOSTI TESBIHA NA PRSTE';

  @override
  String get tasbihHadithText =>
      '„Držite se slavljenja Allaha, potvrđivanja Njegove jednoće i veličanja Njegove svetosti, i brojite na jagodice prstiju, jer će prsti na Sudnjem danu biti pitani i progovorit će.“';

  @override
  String get tasbihHadithReference => '— Sunen Ebu Davud 1496';

  @override
  String get dhikrSubhanAllah => 'Subhanallah';

  @override
  String get dhikrAlhamdulillah => 'Elhamdulillah';

  @override
  String get dhikrAllahuAkbar => 'Allahu Ekber';

  @override
  String get dhikrAstaghfirullah => 'Estagfirullah';

  @override
  String get dhikrLaIlahaIllallah => 'La ilahe illallah';

  @override
  String get dhikrSubhanAllahTranslation =>
      'Slavljen neka je Allah i čist od svakog nedostatka';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'Sva hvala i zahvalnost pripada samo Allahu';

  @override
  String get dhikrAllahuAkbarTranslation => 'Allah je Najveći i iznad svega';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'Od Allaha oprost tražim za svoje grijehe';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'Nema istinskog boga dostojnog obožavanja osim Allaha';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'Sljedeći: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'Prilagođeno';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'Prilagođeno ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'Postavi prilagođeni cilj';

  @override
  String get tasbihTargetHint => 'Unesite ciljani broj (npr. 50)';

  @override
  String get tasbihCancel => 'Otkaži';

  @override
  String get tasbihSetTarget => 'Potvrdi cilj';

  @override
  String tasbihLap(String lap) {
    return 'Krug $lap';
  }
}
