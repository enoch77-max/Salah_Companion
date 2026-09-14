// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

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
  String get remaining => 'verbleibend';

  @override
  String get statusPrayed => 'Prayed';

  @override
  String get statusMissed => 'Missed';

  @override
  String get statusPending => 'Pending';

  @override
  String get qiblaCompassTitle => 'Qibla-Kompass';

  @override
  String get qiblaCalibrate => 'Kalibrieren';

  @override
  String get qiblaFacingKaaba => 'Perfekte Ausrichtung zur Kaaba';

  @override
  String get tasbihTitle => 'Digitaler Tasbih';

  @override
  String get tasbihReset => 'Zurücksetzen';

  @override
  String get tasbihAutoNext => 'Automatisch Weiter';

  @override
  String get tasbihBestOnFingers => 'Das Zählen an den Fingern ist Sunnah';

  @override
  String get guidanceCategory => 'LEITFADEN';

  @override
  String get learnSalah => 'Gebet lernen';

  @override
  String get learnSalahSubtitle =>
      'Gebetsanleitung gemäß authentischer Sunnah und Hadithen';

  @override
  String get savedItems => 'Gespeichert';

  @override
  String get savedItemsSubtitle => 'Hadithe, Verse & Bittgebete';

  @override
  String get prayerTracker => 'Gebetstracker';

  @override
  String get prayerTrackerSubtitle => 'Gebetsstatistiken ansehen';

  @override
  String get widgetsTitle => 'Widgets';

  @override
  String get widgetsSubtitle => 'Widgets zum Startbildschirm hinzufügen';

  @override
  String get openSourcePrivacy => 'Open Source & Datenschutz';

  @override
  String get openSourcePrivacySubtitle =>
      '100% offline, kein Tracking & nicht-kommerziell';

  @override
  String get themeMode => 'THEMEN-MODUS';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String notificationPrayerTitle(String prayer) {
    return '$prayer-Gebet';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return 'Die Zeit für das $prayer-Gebet hat begonnen. Bereite dich auf das Gebet vor.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'Frühzeitige Gebetserinnerung — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return '15 Minuten seit Beginn von $prayer vergangen. Hast du schon gebetet?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'Dringend — Noch 30 Min für $prayer';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return 'Nur noch 30 Minuten bis zum Ende der Gebetszeit für $prayer.';
  }

  @override
  String get notificationDailyReflectionTitle => 'Tägliche Betrachtung';

  @override
  String get notificationTestTitle => 'Salah Companion Benachrichtigung';

  @override
  String get notificationTestBody =>
      'Benachrichtigungen und Adhan-Audio wurden erfolgreich eingerichtet.';

  @override
  String get onboardingChooseLanguage => 'Wähle deine Sprache';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'Wähle deine bevorzugte Sprache für Gebetszeiten und Leitfäden.';

  @override
  String get onboardingWelcomeTitle => 'Willkommen bei Salah Companion';

  @override
  String get onboardingWelcomeBody =>
      'Dein verlässlicher Begleiter für präzise Gebetszeiten, Qibla-Richtung und authentische Sunnah.';

  @override
  String get onboardingSwipeTitle => 'Vom linken Rand wischen für Menü';

  @override
  String get onboardingSwipeBody =>
      'Wische vom linken Bildschirmrand, um Gespeichertes und den Gebetstracker aufzurufen.';

  @override
  String get onboardingSunnahTitle => 'Authentische Sunnah & Rechtleitung';

  @override
  String get onboardingSunnahBody =>
      'Tägliche Koranverse, authentische Hadithe, Bittgebete und prophetische Gebetsanleitung.';

  @override
  String get onboardingCustomizationTitle => 'Qibla, Tasbih & Einstellungen';

  @override
  String get onboardingCustomizationBody =>
      'Qibla-Kompass, digitaler Tasbih und Berechnungsmethoden anpassen.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$current VON $total';
  }

  @override
  String get onboardingSkip => 'Überspringen';

  @override
  String get onboardingNext => 'Weiter';

  @override
  String get onboardingGetStarted => 'Loslegen';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get moreLanguages => 'Weitere Sprachen';

  @override
  String get searchLanguagePlaceholder => 'Sprache suchen...';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageSubtitle => 'App-Sprache ändern';

  @override
  String get onboardingTrustTitle => 'Unser heiliges Versprechen an Sie';

  @override
  String get onboardingTrustSubtitle =>
      'Ausschließlich um Allahs willen entwickelt — keine Werbung, kein Tracking, 100% privat.';

  @override
  String get onboardingTrustOfflineTitle =>
      '100% Lokal auf dem Gerät & Offline';

  @override
  String get onboardingTrustOfflineDesc =>
      'Ihr Standort und Ihre Gebetsprotokolle verlassen niemals Ihr Telefon. Alle astronomischen Berechnungen erfolgen lokal.';

  @override
  String get onboardingTrustNoAdsTitle => 'Keine Werbung. Niemals.';

  @override
  String get onboardingTrustNoAdsDesc =>
      'Keine Werbebanner oder Pop-ups, damit Ihre Andacht ungestört bleibt.';

  @override
  String get onboardingTrustNoTrackingTitle =>
      'Kein Tracking oder Datensammlung';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'Kein Firebase-Tracking, keine Erfassung persönlicher Daten.';

  @override
  String get onboardingTrustFreeTitle => 'Für immer kostenlos für die Ummah';

  @override
  String get onboardingTrustFreeDesc =>
      'Als fortlaufende Wohltat (Sadaqah Jariyah) erbaut. Ohne Abonnements.';

  @override
  String get onboardingFeaturesTitle => 'Wichtige Funktionen';

  @override
  String get onboardingFeaturesSubtitle =>
      'Präzise Gebetszeiten, authentische Sunnah und achtsame gottesdienstliche Werkzeuge.';

  @override
  String get onboardingFeaturePrayerTitle => 'Astronomische Präzision';

  @override
  String get onboardingFeaturePrayerDesc =>
      'Exakte Sonnenwinkelberechnungen und Erinnerungen an Sunnah-Gebete.';

  @override
  String get onboardingFeatureQiblaTitle => 'Echtzeit-Qibla-Kompass';

  @override
  String get onboardingFeatureQiblaDesc =>
      'Richtungsweiser zur Heiligen Kaaba mit haptischem Vibrationsfeedback bei Ausrichtung.';

  @override
  String get onboardingFeatureTasbihTitle => 'Haptischer digitaler Tasbih';

  @override
  String get onboardingFeatureTasbihDesc =>
      'Fühlbare Perlenzählung mit authentischen prophetischen Bittgebeten.';

  @override
  String get onboardingFeatureSunnahTitle => 'Authentische Sunnah & Bittgebete';

  @override
  String get onboardingFeatureSunnahDesc =>
      'Tägliche Koranverse und authentische Hadithe aus al-Buhari und Muslim mit Quellenangaben.';

  @override
  String get onboardingFeatureQiblaAligned => 'Auf Qibla ausgerichtet • Mekka';

  @override
  String get onboardingFeatureTapToCount =>
      'Tippen oder wischen Sie zum Zählen';

  @override
  String get onboardingPermissionsTitle => 'Einfache Einrichtung';

  @override
  String get onboardingPermissionsSubtitle =>
      'Aktivieren Sie die Berechtigungen für genaue Gebetszeiten und rechtzeitige Adhan-Benachrichtigungen.';

  @override
  String get onboardingPermLocationTitle => 'Genauer Standort';

  @override
  String get onboardingPermLocationDesc =>
      'Wird ausschließlich auf dem Gerät zur Berechnung der Sonnenauf- und -untergangszeiten verwendet.';

  @override
  String get onboardingPermNotifTitle => 'Adhan- und Gebetsbenachrichtigungen';

  @override
  String get onboardingPermNotifDesc =>
      'Liefert den Adhan pünktlich und erinnert an freiwillige Sunnah-Gebete.';

  @override
  String get onboardingPermBatteryTitle => 'Zuverlässiger Hintergrundbetrieb';

  @override
  String get onboardingPermBatteryDesc =>
      'Verhindert, dass die Android-Batterieoptimierung den Fajr-Adhan abbricht.';

  @override
  String get onboardingPermGrant => 'Zugriff Erlauben';

  @override
  String get onboardingPermGranted => 'Erlaubt';

  @override
  String get onboardingPermEnableLater =>
      'Später in den Einstellungen anpassen';

  @override
  String get onboardingDedicationVerse =>
      '„Das Gebet ist den Gläubigen zu bestimmten Zeiten vorgeschrieben.“';

  @override
  String get onboardingDedicationReference => 'Sure An-Nisa (4:103)';

  @override
  String get onboardingBeginJourney => 'Bismillah • Loslegen';

  @override
  String get onboardingReplayTour => 'Einführungstour wiederholen';

  @override
  String get onboardingReplayTourSubtitle =>
      'Funktionen und Datenschutzversprechen erneut ansehen';

  @override
  String get onboardingBack => 'Zurück';

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
  String get settingsBatteryExempt => 'Ausgenommen';

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
  String get categoryAll => 'Alle';

  @override
  String get categoryHadith => 'Hadithe';

  @override
  String get categoryAyah => 'Verse';

  @override
  String get categoryDua => 'Bittgebete';

  @override
  String get categoryMorning => 'Morgen';

  @override
  String get categoryEvening => 'Abend';

  @override
  String get categoryAfterPrayer => 'Nach dem Gebet';

  @override
  String get categoryForgiveness => 'Vergebung';

  @override
  String get categoryProtection => 'Schutz';

  @override
  String get categoryDaily => 'Täglich';

  @override
  String get categoryTravel => 'Reise';

  @override
  String get noSavedItems => 'Noch keine gespeicherten Inhalte';

  @override
  String get noSavedItemsSubtitle =>
      'Tippe auf das Lesezeichen-Symbol, um Inhalte hier zu speichern.';

  @override
  String get searchPlaceholder =>
      'Bittgebete, Übersetzungen oder Quellen suchen...';

  @override
  String get sunnahPrayerHeader => 'SUNNAH-GEBET';

  @override
  String get sunnahFajrDesc => '2 Rakah Sunnah vor dem Pflichtgebet';

  @override
  String get sunnahDhuhrDesc => '4 Rakah vor & 2 nach dem Pflichtgebet';

  @override
  String get sunnahAsrDesc => '4 Rakah Sunnah vor dem Pflichtgebet';

  @override
  String get sunnahMaghribDesc => '2 Rakah Sunnah nach dem Pflichtgebet';

  @override
  String get sunnahIshaDesc => '2 Rakah nach dem Pflichtgebet + 3 Witr';

  @override
  String get forbiddenNaflHeader => 'VERBOTENE ZEITEN FÜR NAFL-GEBETE';

  @override
  String get forbiddenNaflBody =>
      'Freiwillige Gebete (Nafl) sind während des Sonnenaufgangs (~20 Min.), des Zenits (~10 Min. vor Dhuhr) und des Sonnenuntergangs (~20 Min. vor Maghrib) untersagt. Nachholgebete (Fard) bleiben gültig. (Sahih Muslim 831)';

  @override
  String get forbiddenNaflSunriseHeader => 'VERBOTENE ZEIT • SONNENAUFGANG';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'Die Sonne geht auf ($startTime – $endTime). Freiwillige Gebete sind verboten, bis die Sonne voll aufsteigt. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflZawalHeader => 'VERBOTENE ZEIT • ZENIT (ZAWAL)';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'Die Sonne steht im Zenit ($startTime – $endTime). Nafl-Gebete sind während dieser Mittagszeit untersagt. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'VERBOTENE ZEIT • SONNENUNTERGANG';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'Die Sonne geht unter ($startTime – $endTime). Nafl-Gebete sind verboten, bis der Sonnenuntergang abgeschlossen ist. (Sahih Muslim 831)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return 'Die Gebetszeit für $prayer hat noch nicht begonnen ($time)';
  }

  @override
  String get timeStart => 'Beginn';

  @override
  String get timeEnd => 'Ende';

  @override
  String get onboardingShowcasePrayerTitle =>
      'Astronomisch Präzise Gebetszeiten';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'Exakte Gebetszeiten-Berechnung 100% offline nach anerkannten weltweiten Methoden.';

  @override
  String get onboardingShowcaseQiblaTitle => 'Echter Qibla-Kompass';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'Finden Sie die genaue Richtung zur Kaaba weltweit mit gyroskopischer Führung.';

  @override
  String get onboardingShowcaseTasbihTitle => 'Haptischer Digitaler Tasbih';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'Intuitiver Dhikr-Zähler mit sanftem Vibrations-Feedback und automatischem Fortschritt.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'Tägliche Verse, Hadithe & Bittgebete';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'Geprüfte Koranverse, authentische Hadithe und essenzielle tägliche Duas.';

  @override
  String get settingsPrayerNotifications => 'Gebetsbenachrichtigungen';

  @override
  String get settingsAdhanReciterTone => 'Muezzin & Gebetsruf-Ton';

  @override
  String get settingsDailyReminderTime => 'Tägliche Erinnerungszeit';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count Live-Widgets';
  }

  @override
  String get settingsFiqhAsr => 'Fiqh (Asr-Berechnung)';

  @override
  String get settingsFiqhStandardTitle => 'Schafii / Standard (Standard)';

  @override
  String get settingsFiqhStandardDesc =>
      'Schafii, Maliki & Hanbali (1x Schatten)';

  @override
  String get settingsFiqhStandardSub =>
      'Schattenlänge = 1x Objekthöhe. Befolgt von Schafii, Maliki, Hanbali & Mehrheit.';

  @override
  String get settingsFiqhHanafiTitle => 'Hanafi';

  @override
  String get settingsFiqhHanafiDesc =>
      'Hanafitische Rechtsschule (2x Schatten)';

  @override
  String get settingsFiqhHanafiSub =>
      'Schattenlänge = 2x Objekthöhe. Befolgt von der hanafitischen Rechtsschule.';

  @override
  String get settingsPreAdhanReminder => 'Erinnerung vor dem Gebetsruf';

  @override
  String get settingsBatteryRestricted => 'Eingeschränkt';

  @override
  String get settingsBatteryExemptDesc =>
      'Ausgenommen — Adhan-Alarme ertönen absolut zuverlässig';

  @override
  String get settingsBatteryNotExemptDesc =>
      'Nicht ausgenommen — Alarme könnten sich verzögern';

  @override
  String get settingsCheckBatteryNow => 'Status jetzt prüfen';

  @override
  String get settingsCheckBatterySubtitle =>
      'Hintergrundberechtigungen des Systems prüfen';

  @override
  String get settingsWarnBattery => 'Warnen bei Neuoptimierung';

  @override
  String get settingsWarnBatterySubtitle =>
      'Benachrichtigen, falls das OS den Energiesparmodus aktiviert';

  @override
  String get settingsOpenSourceFootnote =>
      '100% Kostenlos & Open Source • Keine Werbung • Keine Datenerfassung';

  @override
  String get settingsAsrCalculationTitle => 'Asr-Berechnungsmethode (Fiqh)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'Wählen Sie die Rechtsschule für den Beginn des Asr-Gebets.';

  @override
  String get adhanVoiceMakkah => 'Mekka (Ali Mulla)';

  @override
  String get adhanVoiceMadinah => 'Medina (Abdul Majeed)';

  @override
  String get adhanVoiceAlAqsa => 'Al-Aqsa (Yasser Al-Dossari)';

  @override
  String get adhanVoiceSoft => 'Traditioneller Sanfter Ton';

  @override
  String get calcMethodUmmAlQura => 'Umm Al-Qura (Saudi-Arabien)';

  @override
  String get calcMethodMwl => 'Muslimische Weltliga (MWL)';

  @override
  String get calcMethodEgyptian => 'Ägyptische Vermessungsbehörde';

  @override
  String get calcMethodIsna => 'ISNA (Nordamerika)';

  @override
  String get calcMethodKarachi =>
      'Universität für Islamische Wissenschaften Karatschi';

  @override
  String get calcMethodDubai => 'Islamische Angelegenheiten Dubai';

  @override
  String get calcMethodDiyanet => 'Diyanet (Türkei)';

  @override
  String get calcMethodSingapore => 'MUIS (Singapur)';

  @override
  String get learnSalahProphetQuoteTitle =>
      'Betet so, wie ihr mich habt beten sehen';

  @override
  String get learnSalahAuthenticBadge => 'AUTHENTISCHER SUNNAH-LEITFADEN';

  @override
  String get learnSalahSearchPlaceholder =>
      'Haltung, Schritt oder Hadith-Beweis suchen...';

  @override
  String get learnSalahLearningModules => 'LERNMODULE';

  @override
  String get learnSalahStepByStepTitle => 'Schritt-für-Schritt Gebetsanleitung';

  @override
  String get learnSalahStepByStepSubtitle =>
      '10 Aufeinanderfolgende Schritte mit Illustrationen & Belegen';

  @override
  String get learnSalahPillarsTitle => 'Die 14 Säulen des Gebets (Arkan)';

  @override
  String get learnSalahPillarsSubtitle =>
      'Unverzichtbare Grundpfeiler des rituellen Gebets';

  @override
  String get learnSalahObligationsTitle =>
      'Die 8 Pflichten des Gebets (Wajibat)';

  @override
  String get learnSalahObligationsSubtitle =>
      'Pflichten, die durch Sujud as-Sahw ausgeglichen werden';

  @override
  String get learnSalahSunanTitle => 'Sunnah-Handlungen (Sunan)';

  @override
  String get learnSalahSunanSubtitle =>
      'Wort- und Tat-Sunnahs des Propheten Muhammad ﷺ';

  @override
  String get learnSalahInvalidatorsTitle => 'Gebetsungültigmacher (Mubtilaat)';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'Dinge, die das Gebet ungültig machen';

  @override
  String get learnSalahForbiddenTimesTitle => 'Verbotene Gebetszeiten';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'Zeiten, in denen freiwillige Gebete untersagt sind';

  @override
  String get madhabShafi => 'Schafii';

  @override
  String get madhabHanafi => 'Hanafi';

  @override
  String get eventIslamicNewYear => 'Islamisches Neujahr';

  @override
  String get eventTasua => 'Tasu\'a';

  @override
  String get eventAshura => 'Aschura-Tag';

  @override
  String get eventMawlid => 'Mawlid an-Nabi ﷺ';

  @override
  String get eventIsraMiraj => 'Isra und Miradsch';

  @override
  String get eventMidShaban => 'Mitte Scha\'ban';

  @override
  String get eventRamadanStart => 'Erster Ramadan-Tag';

  @override
  String get eventBattleOfBadr => 'Schlacht von Badr';

  @override
  String get eventLaylatAlQadr => 'Laylat al-Qadr';

  @override
  String get eventEidAlFitr => 'Eid al-Fitr (Zuckerfest)';

  @override
  String get eventShawwalSixFasting => '6 Tage Schawwal-Fasten';

  @override
  String get eventDhuAlHijjahStart => 'Beginn Dhul-Hiddscha';

  @override
  String get eventDayOfArafah => 'Tag von Arafah';

  @override
  String get eventEidAlAdha => 'Eid al-Adha (Opferfest)';

  @override
  String get eventDaysOfTashreeq => 'Taschriq-Tage';

  @override
  String get qiblaHeadingTrue => 'ECHTE AUSRICHTUNG';

  @override
  String get qiblaBearingLabel => 'QIBLA-PEILUNG';

  @override
  String get qiblaRetryLocation => 'Standort erneut versuchen';

  @override
  String get qiblaCalibClearInterference => 'Magnetische Störungen vermeiden';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'Halten Sie Abstand zu Metalltischen, Computern oder magnetischen Hüllen.';

  @override
  String get qiblaCalibHoldFlat => 'Gerät waagerecht halten';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'Halten Sie Ihr Telefon flach und waagerecht für höchste Genauigkeit.';

  @override
  String get qiblaCalibFigure8 => 'Achter-Bewegung ausführen';

  @override
  String get qiblaCalibFigure8Desc =>
      'Bewegen Sie Ihr Telefon gleichmäßig in einer 8er-Schleife in der Luft.';

  @override
  String get stepPrevious => 'Zurück';

  @override
  String get stepNext => 'Nächster Schritt';

  @override
  String get stepFinishGuide => 'Leitfaden abschließen';

  @override
  String get widgetAddAnother => 'Weiteres hinzufügen';

  @override
  String get widgetOpenSettings => 'Einstellungen öffnen';

  @override
  String get widgetGoToHome => 'Zum Hauptbildschirm';

  @override
  String get trackerWeeklyRate => 'Wöchentliche Quote';

  @override
  String get trackerMonthlyRate => 'Monatliche Quote';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total Gebete';
  }

  @override
  String get tasbihHadithTitle => 'HADITH ÜBER DAS LOBPREISEN AN DEN FINGERN';

  @override
  String get tasbihHadithText =>
      '„Haltet fest am Lobpreisen Allahs, Seiner Einheit und Seiner Heiligkeit, und zählt an den Fingerspitzen, denn sie werden am Tag der Auferstehung befragt und zum Sprechen gebracht.“';

  @override
  String get tasbihHadithReference => '— Sunan Abi Dawud 1496';

  @override
  String get dhikrSubhanAllah => 'SubhanAllah';

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
      'Gepriesen und erhaben sei Allah über jeden Mangel';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'Alles Lob und aller Dank gebühren einzig Allah';

  @override
  String get dhikrAllahuAkbarTranslation =>
      'Allah ist am größten, erhaben über alles';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'Ich bitte Allah um Vergebung für meine Sünden';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'Es gibt keinen wahrhaftigen Gott außer Allah';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'Weiter: $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'Benutzerdefiniert';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'Eigenes ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'Eigenes Ziel festlegen';

  @override
  String get tasbihTargetHint => 'Zielanzahl eingeben (z. B. 50)';

  @override
  String get tasbihCancel => 'Abbrechen';

  @override
  String get tasbihSetTarget => 'Ziel festlegen';

  @override
  String tasbihLap(String lap) {
    return 'Runde $lap';
  }
}
