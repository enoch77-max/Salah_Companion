import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/theme/app_theme.dart';
import 'core/services/notification_service.dart';
import 'features/battery_protection/presentation/widgets/battery_protection_listener.dart';
import 'features/home/presentation/screens/home_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'core/services/location_service.dart';

import 'core/services/app_haptics.dart';

import 'core/services/app_info_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = true;
  await AppInfoService.init();

  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.exception.toString().contains('google_fonts') ||
        details.exception.toString().contains('Failed host lookup')) {
      // Graceful offline fallback to system fonts when disconnected from internet
      return;
    }
    FlutterError.presentError(details);
  };

  ThemeMode initialThemeMode = ThemeMode.dark;
  try {
    final prefs = await SharedPreferences.getInstance();
    LocationService.cachedLocationSync(prefs);
    await AppHaptics.init(prefs);
    final savedMode = prefs.getString('theme_mode');
    if (savedMode == 'light') {
      initialThemeMode = ThemeMode.light;
    } else if (savedMode == 'system') {
      initialThemeMode = ThemeMode.system;
    } else if (savedMode == 'dark') {
      initialThemeMode = ThemeMode.dark;
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
  ));
}

class SalahCompanionApp extends StatefulWidget {
  final NotificationService? notificationService;
  final ThemeMode initialThemeMode;

  const SalahCompanionApp({
    super.key,
    this.notificationService,
    this.initialThemeMode = ThemeMode.dark,
  });

  @override
  State<SalahCompanionApp> createState() => _SalahCompanionAppState();
}

class _SalahCompanionAppState extends State<SalahCompanionApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salah Companion',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      themeAnimationDuration: Duration.zero,
      home: BatteryProtectionListener(
        checkOnInit: true,
        child: HomeScreen(
          currentThemeMode: _themeMode,
          onThemeModeChanged: _setThemeMode,
          notificationService: widget.notificationService,
        ),
      ),
    );
  }
}
