// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

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
  String get remaining => 'restant';

  @override
  String get statusPrayed => 'Prayed';

  @override
  String get statusMissed => 'Missed';

  @override
  String get statusPending => 'Pending';

  @override
  String get qiblaCompassTitle => 'Boussole de la Qibla';

  @override
  String get qiblaCalibrate => 'Étalonner';

  @override
  String get qiblaFacingKaaba => 'Alignement parfait avec la Kaaba';

  @override
  String get tasbihTitle => 'Tasbih Numérique';

  @override
  String get tasbihReset => 'Réinitialiser';

  @override
  String get tasbihAutoNext => 'Suivant Auto';

  @override
  String get tasbihBestOnFingers => 'Compter sur les doigts est une Sunnah';

  @override
  String get guidanceCategory => 'GUIDANCE';

  @override
  String get learnSalah => 'Apprendre la Prière';

  @override
  String get learnSalahSubtitle =>
      'Apprendre la prière selon la Sunnah authentique';

  @override
  String get savedItems => 'Enregistrés';

  @override
  String get savedItemsSubtitle => 'Hadiths, Versets & Invocations';

  @override
  String get prayerTracker => 'Suivi des Prières';

  @override
  String get prayerTrackerSubtitle => 'Consulter vos statistiques de prière';

  @override
  String get widgetsTitle => 'Widgets';

  @override
  String get widgetsSubtitle => 'Ajouter des widgets à l\'écran d\'accueil';

  @override
  String get openSourcePrivacy => 'Open Source & Confidentialité';

  @override
  String get openSourcePrivacySubtitle =>
      '100% hors ligne, sans suivi & non commercial';

  @override
  String get themeMode => 'MODE DU THÈME';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String notificationPrayerTitle(String prayer) {
    return 'Prière de $prayer';
  }

  @override
  String notificationPrayerStartBody(String prayer) {
    return 'L\'heure de la prière de $prayer est entrée. Préparez-vous à la prière.';
  }

  @override
  String notificationEarlyReminderTitle(String prayer) {
    return 'Rappel de Début de Temps — $prayer';
  }

  @override
  String notificationEarlyReminderBody(String prayer) {
    return '15 minutes se sont écoulées depuis le début de $prayer. Avez-vous prié ?';
  }

  @override
  String notificationUrgentWarningTitle(String prayer) {
    return 'Urgent — Plus que 30 min pour $prayer';
  }

  @override
  String notificationUrgentWarningBody(String prayer) {
    return 'Il ne reste que 30 minutes avant la fin du temps de la prière de $prayer.';
  }

  @override
  String get notificationDailyReflectionTitle => 'Méditation Quotidienne';

  @override
  String get notificationTestTitle => 'Alerte Salah Companion';

  @override
  String get notificationTestBody =>
      'Les notifications et le son de l\'Adhan ont été configurés avec succès.';

  @override
  String get onboardingChooseLanguage => 'Choisissez Votre Langue';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'Sélectionnez votre langue pour les horaires de prière et les rappels.';

  @override
  String get onboardingWelcomeTitle => 'Bienvenue sur Salah Companion';

  @override
  String get onboardingWelcomeBody =>
      'Votre compagnon serein et précis pour les horaires de prière, la Qibla et la Sunnah authentique.';

  @override
  String get onboardingSwipeTitle =>
      'Glissez depuis le bord gauche pour le menu';

  @override
  String get onboardingSwipeBody =>
      'Glissez depuis le bord gauche de l\'écran pour accéder à vos enregistrements et statistiques.';

  @override
  String get onboardingSunnahTitle => 'Sunnah Authentique & Guidance';

  @override
  String get onboardingSunnahBody =>
      'Accédez aux versets quotidiens, hadiths authentiques, invocations et guide de la prière prophétique.';

  @override
  String get onboardingCustomizationTitle => 'Qibla, Tasbih & Paramètres';

  @override
  String get onboardingCustomizationBody =>
      'Boussole de la Qibla, tasbih numérique et méthodes de calcul personnalisées.';

  @override
  String onboardingStepOf(int current, int total) {
    return '$current SUR $total';
  }

  @override
  String get onboardingSkip => 'Passer';

  @override
  String get onboardingNext => 'Suivant';

  @override
  String get onboardingGetStarted => 'Commencer';

  @override
  String get systemDefault => 'Langue du système';

  @override
  String get moreLanguages => 'Autres langues';

  @override
  String get searchLanguagePlaceholder => 'Rechercher une langue...';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageSubtitle => 'Changer la langue de l\'application';

  @override
  String get onboardingTrustTitle => 'Notre engagement sacré envers vous';

  @override
  String get onboardingTrustSubtitle =>
      'Conçu uniquement pour l\'amour d\'Allah — sans publicité, sans suivi, 100% privé.';

  @override
  String get onboardingTrustOfflineTitle =>
      '100% Hors-ligne et Sur l\'Appareil';

  @override
  String get onboardingTrustOfflineDesc =>
      'Votre position et vos prières ne quittent jamais votre téléphone. Tous les calculs solaires sont effectués localement.';

  @override
  String get onboardingTrustNoAdsTitle => 'Aucune Publicité. Jamais.';

  @override
  String get onboardingTrustNoAdsDesc =>
      'Aucune bannière commerciale ni fenêtre pop-up pour préserver votre recueillement.';

  @override
  String get onboardingTrustNoTrackingTitle => 'Zéro Traçage et Données';

  @override
  String get onboardingTrustNoTrackingDesc =>
      'Aucun traceur Firebase, aucune collecte de données personnelles.';

  @override
  String get onboardingTrustFreeTitle => 'Gratuit pour Toujours pour la Oummah';

  @override
  String get onboardingTrustFreeDesc =>
      'Offert comme aumône continue (Sadaqah Jariyah). Sans aucun abonnement.';

  @override
  String get onboardingFeaturesTitle => 'Fonctionnalités Clés';

  @override
  String get onboardingFeaturesSubtitle =>
      'Horaires de prière précis, Sunnah authentique et outils spirituels apaisants.';

  @override
  String get onboardingFeaturePrayerTitle => 'Précision Astronomique';

  @override
  String get onboardingFeaturePrayerDesc =>
      'Calculs solaires exacts selon les angles officiels et rappels des prières surérogatoires.';

  @override
  String get onboardingFeatureQiblaTitle =>
      'Boussole de la Qibla en Temps Réel';

  @override
  String get onboardingFeatureQiblaDesc =>
      'Indicateur directionnel vers la Sainte Kaaba avec retour haptique à l\'alignement.';

  @override
  String get onboardingFeatureTasbihTitle => 'Tasbih Numérique Haptique';

  @override
  String get onboardingFeatureTasbihDesc =>
      'Sensation tactile naturelle avec invocations prophétiques authentiques.';

  @override
  String get onboardingFeatureSunnahTitle =>
      'Sunnah Authentique et Invocations';

  @override
  String get onboardingFeatureSunnahDesc =>
      'Méditations coraniques quotidiennes et hadiths authentiques d\'al-Boukhari et Mouslim.';

  @override
  String get onboardingFeatureQiblaAligned => 'Aligné sur la Qibla • La Mecque';

  @override
  String get onboardingFeatureTapToCount =>
      'Touchez n\'importe où ou glissez pour compter';

  @override
  String get onboardingPermissionsTitle => 'Configuration Facile';

  @override
  String get onboardingPermissionsSubtitle =>
      'Activez les autorisations pour le calcul exact des heures et les alertes d\'Adhan.';

  @override
  String get onboardingPermLocationTitle => 'Position Géographique';

  @override
  String get onboardingPermLocationDesc =>
      'Utilisée strictement sur votre appareil pour calculer les heures de prière.';

  @override
  String get onboardingPermNotifTitle => 'Notifications de l\'Adhan et Prières';

  @override
  String get onboardingPermNotifDesc =>
      'Délivre l\'appel à la prière à l\'heure exacte et des rappels bienveillants.';

  @override
  String get onboardingPermBatteryTitle =>
      'Fonctionnement Fiable en Arrière-plan';

  @override
  String get onboardingPermBatteryDesc =>
      'Empêche l\'optimisation de batterie d\'Android d\'interrompre l\'Adhan du Fajr.';

  @override
  String get onboardingPermGrant => 'Autoriser';

  @override
  String get onboardingPermGranted => 'Autorisé';

  @override
  String get onboardingPermEnableLater =>
      'Configurer plus tard dans Paramètres';

  @override
  String get onboardingDedicationVerse =>
      '« La prière demeure, pour les croyants, une prescription à des moments déterminés. »';

  @override
  String get onboardingDedicationReference => 'Sourate An-Nisa (4:103)';

  @override
  String get onboardingBeginJourney => 'Bismillah • Commencer';

  @override
  String get onboardingReplayTour => 'Revoir la Visite Guidée';

  @override
  String get onboardingReplayTourSubtitle =>
      'Redécouvrez les fonctionnalités et nos engagements de confidentialité';

  @override
  String get onboardingBack => 'Retour';

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
  String get settingsBatteryExempt => 'Exempté';

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
  String get categoryAll => 'Tout';

  @override
  String get categoryHadith => 'Hadiths';

  @override
  String get categoryAyah => 'Versets';

  @override
  String get categoryDua => 'Invocations';

  @override
  String get categoryMorning => 'Matin';

  @override
  String get categoryEvening => 'Soir';

  @override
  String get categoryAfterPrayer => 'Après la Prière';

  @override
  String get categoryForgiveness => 'Pardon';

  @override
  String get categoryProtection => 'Protection';

  @override
  String get categoryDaily => 'Quotidien';

  @override
  String get categoryTravel => 'Voyage';

  @override
  String get noSavedItems => 'Aucun élément enregistré';

  @override
  String get noSavedItemsSubtitle =>
      'Appuyez sur l\'icône de signet pour enregistrer du contenu ici.';

  @override
  String get searchPlaceholder =>
      'Rechercher des duas, traductions ou sources...';

  @override
  String get sunnahPrayerHeader => 'PRIÈRE SUNNAH';

  @override
  String get sunnahFajrDesc => '2 Rak\'ahs Sunnah avant la prière obligatoire';

  @override
  String get sunnahDhuhrDesc => '4 Rak\'ahs avant et 2 après';

  @override
  String get sunnahAsrDesc => '4 Rak\'ahs Sunnah avant';

  @override
  String get sunnahMaghribDesc => '2 Rak\'ahs Sunnah après';

  @override
  String get sunnahIshaDesc => '2 Rak\'ahs après + 3 Witr';

  @override
  String get forbiddenNaflHeader =>
      'HEURES INTERDITES POUR LES PRIÈRES SURÉROGATOIRES';

  @override
  String get forbiddenNaflBody =>
      'Les prières surérogatoires (Nafl) sont interdites au lever du soleil (~20 min), au zénith (~10 min avant Dhuhr) et au coucher (~20 min avant Maghrib). Le rattrapage des prières obligatoires reste valide. (Sahih Muslim 831)';

  @override
  String get forbiddenNaflSunriseHeader => 'TEMPS INTERDIT • LEVER DU SOLEIL';

  @override
  String forbiddenNaflSunriseBody(String startTime, String endTime) {
    return 'Le soleil se lève ($startTime – $endTime). Les prières surérogatoires sont interdites jusqu\'à son élévation complète. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflZawalHeader => 'TEMPS INTERDIT • ZÉNITH';

  @override
  String forbiddenNaflZawalBody(String startTime, String endTime) {
    return 'Le soleil est au zénith ($startTime – $endTime). Prières surérogatoires interdites à midi. (Sahih Muslim 831)';
  }

  @override
  String get forbiddenNaflSunsetHeader => 'TEMPS INTERDIT • COUCHER DU SOLEIL';

  @override
  String forbiddenNaflSunsetBody(String startTime, String endTime) {
    return 'Le soleil se couche ($startTime – $endTime). Prières surérogatoires interdites jusqu\'au coucher complet. (Sahih Muslim 831)';
  }

  @override
  String prayerNotStartedYet(String prayer, String time) {
    return 'L\'heure de la prière de $prayer n\'a pas encore commencé ($time)';
  }

  @override
  String get timeStart => 'Début';

  @override
  String get timeEnd => 'Fin';

  @override
  String get onboardingShowcasePrayerTitle =>
      'Horaires de Prière d\'une Grande Précision';

  @override
  String get onboardingShowcasePrayerSubtitle =>
      'Calculs astronomiques précis 100% hors-ligne selon les méthodes islamiques mondiales.';

  @override
  String get onboardingShowcaseQiblaTitle => 'Boussole Qibla en Temps Réel';

  @override
  String get onboardingShowcaseQiblaSubtitle =>
      'Trouvez la direction exacte de la Kaaba partout dans le monde grâce au gyroscope.';

  @override
  String get onboardingShowcaseTasbihTitle => 'Tasbih Numérique Tactile';

  @override
  String get onboardingShowcaseTasbihSubtitle =>
      'Compteur de dhikr immersif avec retour haptique et progression automatique.';

  @override
  String get onboardingShowcaseReflectionTitle =>
      'Méditations Quotidiennes, Hadiths & Invocations';

  @override
  String get onboardingShowcaseReflectionSubtitle =>
      'Versets coraniques vérifiés, hadiths authentiques et invocations quotidiennes essentielles.';

  @override
  String get settingsPrayerNotifications => 'Notifications de Prière';

  @override
  String get settingsAdhanReciterTone => 'Muezzin & Tonalité de l\'Adhan';

  @override
  String get settingsDailyReminderTime => 'Notification du Rappel Quotidien';

  @override
  String settingsLiveWidgetsCount(int count) {
    return '$count Widgets Actifs';
  }

  @override
  String get settingsFiqhAsr => 'Fiqh (Calcul de l\'Asr)';

  @override
  String get settingsFiqhStandardTitle => 'Chafi\'i / Standard (Par défaut)';

  @override
  String get settingsFiqhStandardDesc =>
      'Chafi\'i, Maliki & Hanbali (1x Ombre)';

  @override
  String get settingsFiqhStandardSub =>
      'Longueur de l\'ombre = 1x la hauteur. Suivi par Chafi\'i, Maliki, Hanbali et la majorité.';

  @override
  String get settingsFiqhHanafiTitle => 'Hanafi';

  @override
  String get settingsFiqhHanafiDesc => 'École Hanafite (2x Ombre)';

  @override
  String get settingsFiqhHanafiSub =>
      'Longueur de l\'ombre = 2x la hauteur. Suivi par l\'école juridique Hanafite.';

  @override
  String get settingsPreAdhanReminder => 'Rappel Avant l\'Adhan';

  @override
  String get settingsBatteryRestricted => 'Restreint';

  @override
  String get settingsBatteryExemptDesc =>
      'Exempté — Les alertes d\'Adhan sonneront ponctuellement';

  @override
  String get settingsBatteryNotExemptDesc =>
      'Non exempté — Les alertes peuvent être retardées';

  @override
  String get settingsCheckBatteryNow => 'Vérifier le Statut Maintenant';

  @override
  String get settingsCheckBatterySubtitle =>
      'Vérifier les autorisations d\'exécution en arrière-plan';

  @override
  String get settingsWarnBattery => 'Avertir si Ré-optimisé';

  @override
  String get settingsWarnBatterySubtitle =>
      'Alerter si le système réactive l\'économiseur de batterie';

  @override
  String get settingsOpenSourceFootnote =>
      '100% Gratuit et Open Source • Sans Publicité • Zéro Collecte';

  @override
  String get settingsAsrCalculationTitle =>
      'Méthode de Calcul de l\'Asr (Fiqh)';

  @override
  String get settingsAsrCalculationSubtitle =>
      'Sélectionnez l\'école juridique pour le calcul de l\'heure de l\'Asr.';

  @override
  String get adhanVoiceMakkah => 'La Mecque (Ali Mulla)';

  @override
  String get adhanVoiceMadinah => 'Médine (Abdul Majeed)';

  @override
  String get adhanVoiceAlAqsa => 'Al-Aqsa (Yasser Al-Dossari)';

  @override
  String get adhanVoiceSoft => 'Tonalité Douce Traditionnelle';

  @override
  String get calcMethodUmmAlQura => 'Oumm Al-Qura (Arabie Saoudite)';

  @override
  String get calcMethodMwl => 'Ligue Islamique Mondiale (MWL)';

  @override
  String get calcMethodEgyptian => 'Autorité Générale Égyptienne';

  @override
  String get calcMethodIsna => 'ISNA (Amérique du Nord)';

  @override
  String get calcMethodKarachi =>
      'Université des Sciences Islamiques de Karachi';

  @override
  String get calcMethodDubai => 'Affaires Islamiques de Dubaï';

  @override
  String get calcMethodDiyanet => 'Diyanet (Turquie)';

  @override
  String get calcMethodSingapore => 'MUIS (Singapour)';

  @override
  String get learnSalahProphetQuoteTitle => 'Priez comme vous m\'avez vu prier';

  @override
  String get learnSalahAuthenticBadge => 'GUIDE AUTHENTIQUE DE LA SUNNAH';

  @override
  String get learnSalahSearchPlaceholder =>
      'Rechercher une posture, étape ou preuve de Hadith...';

  @override
  String get learnSalahLearningModules => 'MODULES D\'APPRENTISSAGE';

  @override
  String get learnSalahStepByStepTitle => 'Guide Prophétique Étape par Étape';

  @override
  String get learnSalahStepByStepSubtitle =>
      '10 Étapes séquentielles avec postures 2D et preuves';

  @override
  String get learnSalahPillarsTitle => 'Les 14 Piliers de la Prière (Arkan)';

  @override
  String get learnSalahPillarsSubtitle =>
      'Fondations essentielles et obligatoires de la prière';

  @override
  String get learnSalahObligationsTitle =>
      'Les 8 Obligations de la Prière (Wajibate)';

  @override
  String get learnSalahObligationsSubtitle =>
      'Actes obligatoires compensés par le Sujud as-Sahw';

  @override
  String get learnSalahSunanTitle => 'Pratiques Sunnah (Sunan)';

  @override
  String get learnSalahSunanSubtitle =>
      'Sunnahs verbales et gestuelles du Prophète ﷺ';

  @override
  String get learnSalahInvalidatorsTitle =>
      'Actes Invalidant la Prière (Mubtilaat)';

  @override
  String get learnSalahInvalidatorsSubtitle =>
      'Choses qui annulent la prière et obligent à la refaire';

  @override
  String get learnSalahForbiddenTimesTitle =>
      'Heures d\'Interdiction de la Prière';

  @override
  String get learnSalahForbiddenTimesSubtitle =>
      'Moments où la prière surérogatoire est strictement interdite';

  @override
  String get madhabShafi => 'Chafi\'i';

  @override
  String get madhabHanafi => 'Hanafi';

  @override
  String get eventIslamicNewYear => 'Nouvel An Hégirien';

  @override
  String get eventTasua => 'Jour de Tasu\'a';

  @override
  String get eventAshura => 'Jour d\'Achoura';

  @override
  String get eventMawlid => 'Mawlid an-Nabi ﷺ';

  @override
  String get eventIsraMiraj => 'Al-Isra et Al-Mi\'raj';

  @override
  String get eventMidShaban => 'Mi-Cha\'ban';

  @override
  String get eventRamadanStart => 'Premier jour de Ramadan';

  @override
  String get eventBattleOfBadr => 'Bataille de Badr';

  @override
  String get eventLaylatAlQadr => 'Nuit du Destin (Laylat al-Qadr)';

  @override
  String get eventEidAlFitr => 'Aïd al-Fitr';

  @override
  String get eventShawwalSixFasting => 'Jeûne des 6 jours de Chawwal';

  @override
  String get eventDhuAlHijjahStart => 'Début du mois de Dhou al-Hijja';

  @override
  String get eventDayOfArafah => 'Jour d\'Arafat';

  @override
  String get eventEidAlAdha => 'Aïd al-Adha';

  @override
  String get eventDaysOfTashreeq => 'Jours de Tachriq';

  @override
  String get qiblaHeadingTrue => 'DIRECTION RÉELLE';

  @override
  String get qiblaBearingLabel => 'ORIENTATION QIBLA';

  @override
  String get qiblaRetryLocation => 'Réessayer la localisation';

  @override
  String get qiblaCalibClearInterference =>
      'Éviter les interférences magnétiques';

  @override
  String get qiblaCalibClearInterferenceDesc =>
      'Éloignez-vous des objets métalliques, ordinateurs ou coques aimantées.';

  @override
  String get qiblaCalibHoldFlat => 'Tenir l\'appareil bien à plat';

  @override
  String get qiblaCalibHoldFlatDesc =>
      'Gardez votre téléphone à plat horizontalement pour une précision maximale.';

  @override
  String get qiblaCalibFigure8 => 'Effectuer un mouvement en 8';

  @override
  String get qiblaCalibFigure8Desc =>
      'Déplacez doucement votre téléphone en formant un 8 dans les airs pour calibrer.';

  @override
  String get stepPrevious => 'Précédent';

  @override
  String get stepNext => 'Étape suivante';

  @override
  String get stepFinishGuide => 'Terminer le guide';

  @override
  String get widgetAddAnother => 'Ajouter un autre';

  @override
  String get widgetOpenSettings => 'Ouvrir les paramètres';

  @override
  String get widgetGoToHome => 'Aller à l\'accueil';

  @override
  String get trackerWeeklyRate => 'Taux hebdomadaire';

  @override
  String get trackerMonthlyRate => 'Taux mensuel';

  @override
  String trackerPrayersRatio(String prayed, String total) {
    return '$prayed / $total Prières';
  }

  @override
  String get tasbihHadithTitle =>
      'HADITH SUR L\'ÉVOCATION SUR LE BOUT DES DOIGTS';

  @override
  String get tasbihHadithText =>
      '« Attachez-vous à glorifier Allah, proclamer Son unicité et exalter Sa sainteté, et comptez sur le bout de vos doigts, car ils seront interrogés au Jour de la Résurrection et amenés à parler. »';

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
      'Gloire et pureté à Allah au-dessus de tout défaut';

  @override
  String get dhikrAlhamdulillahTranslation =>
      'Louange et gratitude parfaites appartiennent à Allah seul';

  @override
  String get dhikrAllahuAkbarTranslation =>
      'Allah est le Plus Grand, au-dessus de toute chose';

  @override
  String get dhikrAstaghfirullahTranslation =>
      'Je demande pardon à Allah pour tous mes péchés';

  @override
  String get dhikrLaIlahaIllallahTranslation =>
      'Nulle divinité ne mérite d\'être adorée sauf Allah';

  @override
  String tasbihNextDhikr(String dhikr) {
    return 'Suivant : $dhikr';
  }

  @override
  String get tasbihCustomTarget => 'Personnalisé';

  @override
  String tasbihCustomTargetCount(String count) {
    return 'Personnalisé ($count)';
  }

  @override
  String get tasbihSetCustomTarget => 'Définir un objectif personnalisé';

  @override
  String get tasbihTargetHint => 'Entrez le nombre cible (ex. 50)';

  @override
  String get tasbihCancel => 'Annuler';

  @override
  String get tasbihSetTarget => 'Définir';

  @override
  String tasbihLap(String lap) {
    return 'Tour $lap';
  }
}
