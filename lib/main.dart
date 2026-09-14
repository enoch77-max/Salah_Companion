import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/theme/app_theme.dart';
import 'core/constants/app_provenance.dart';
import 'core/services/app_haptics.dart';
import 'core/services/app_info_service.dart';
import 'core/services/app_preloader.dart';
import 'core/services/location_service.dart';
import 'core/services/notification_service.dart';
import 'features/battery_protection/presentation/widgets/battery_protection_listener.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'l10n/generated/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = true;
  AppPreloader.prewarm();
  await AppInfoService.init();
  assert(AppProvenance.verifyProvenance(), 'Invalid binary provenance signature');

  FlutterError.onError = (FlutterErrorDetails details) {
    final stack = details.stack.toString();
    final exception = details.exceptionAsString();
    if (stack.contains('package:google_fonts') ||
        exception.contains('google_fonts') ||
        exception.contains('Failed to load font') ||
        exception.contains('FontAssetNotFound') ||
        exception.contains('AssetNotFoundException') ||
        exception.contains('Unable to load asset') ||
        exception.contains('No file or variants found for asset')) {
      return;
    }
    FlutterError.presentError(details);
  };

  ThemeMode initialThemeMode = ThemeMode.dark;
  Locale? initialLocale;
  bool hasCompletedOnboarding = false;
  try {
    final prefs = await SharedPreferences.getInstance();
    LocationService.cachedLocationSync(prefs);
    await AppHaptics.init(prefs);
    hasCompletedOnboarding = prefs.getBool('has_completed_onboarding') ?? false;
    final savedMode = prefs.getString('theme_mode');
    if (savedMode == 'light') {
      initialThemeMode = ThemeMode.light;
    } else if (savedMode == 'system') {
      initialThemeMode = ThemeMode.system;
    } else if (savedMode == 'dark') {
      initialThemeMode = ThemeMode.dark;
    }

    final savedLangCode = prefs.getString('selected_language_code');
    if (savedLangCode != null && savedLangCode.isNotEmpty) {
      initialLocale = Locale(savedLangCode);
    }
  } catch (_) {}

  final notificationService = NotificationService();
  try {
    await notificationService.initialize();
    await notificationService.requestPermissions();
  } catch (_) {}

  runApp(SalahCompanionApp(
    notificationService: notificationService,
    initialThemeMode: initialThemeMode,
    initialLocale: initialLocale,
    hasCompletedOnboarding: hasCompletedOnboarding,
  ));
}

class SalahCompanionApp extends StatefulWidget {
  final NotificationService? notificationService;
  final ThemeMode initialThemeMode;
  final Locale? initialLocale;
  final bool hasCompletedOnboarding;

  const SalahCompanionApp({
    super.key,
    this.notificationService,
    this.initialThemeMode = ThemeMode.dark,
    this.initialLocale,
    this.hasCompletedOnboarding = false,
  });

  @override
  State<SalahCompanionApp> createState() => _SalahCompanionAppState();
}

class _SalahCompanionAppState extends State<SalahCompanionApp> {
  late ThemeMode _themeMode;
  Locale? _locale;
  late bool _hasCompletedOnboarding;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
    _locale = widget.initialLocale;
    _hasCompletedOnboarding = widget.hasCompletedOnboarding;
  }

  void _setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    setState(() {
      _themeMode = mode;
    });
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('theme_mode', mode.name);
    });
  }

  void _setLocale(Locale locale) {
    if (_locale == locale) return;
    setState(() {
      _locale = locale;
    });
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('selected_language_code', locale.languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salah Companion',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      themeAnimationDuration: Duration.zero,
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: _hasCompletedOnboarding
          ? BatteryProtectionListener(
              checkOnInit: true,
              child: HomeScreen(
                currentThemeMode: _themeMode,
                onThemeModeChanged: _setThemeMode,
                currentLocale: _locale,
                onLocaleChanged: _setLocale,
                notificationService: widget.notificationService,
              ),
            )
          : OnboardingScreen(
              onFinish: () => setState(() => _hasCompletedOnboarding = true),
              onLocaleChanged: _setLocale,
            ),
    );
  }
}
