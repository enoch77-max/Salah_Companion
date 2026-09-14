import 'dart:async';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/services/app_haptics.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/services/widget_service.dart';
import '../../../../core/utils/calculation_method_mapper.dart';
import '../../../../core/utils/location_formatter.dart';
import '../../../calendar/presentation/screens/hijri_calendar_screen.dart';
import '../../../duas/presentation/screens/duas_screen.dart';
import '../../../qibla/presentation/screens/qibla_screen.dart';
import '../../../reflection/data/repositories/daily_content_repository.dart';
import '../../../reflection/domain/models/daily_content.dart';
import '../../../settings/presentation/screens/settings_screen.dart';
import '../../../tasbih/presentation/screens/tasbih_screen.dart';
import '../../domain/prayer_times_calculator.dart';
import '../widgets/daily_reflection_card.dart';
import '../widgets/hijri_strip.dart';
import '../widgets/prayer_countdown_hero.dart';
import '../widgets/prayer_list_card.dart';
import '../widgets/prayer_streak_sheet.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../widgets/app_navigation_drawer.dart';
import '../widgets/frosted_glass_bottom_nav_bar.dart';

/// Home Dashboard Screen integrating top app bar with 3-line drawer menu,
/// 6-item frosted-glass navigation bar matching design spec (Home, Tracker, Qibla, Tasbih, Duas, Calendar),
/// countdown hero, hijri strip, prayer list card, and daily reflection card.
class HomeScreen extends StatefulWidget {
  final String nextPrayerName;
  final Duration? remainingDuration;
  final double countdownProgress;
  final bool animateHero;
  final String locationName;
  final bool isTimezoneMismatched;
  final List<PrayerItem>? prayers;
  final DailyContentItem? reflectionItem;
  final ThemeMode currentThemeMode;
  final ValueChanged<ThemeMode>? onThemeModeChanged;
  final NotificationService? notificationService;
  final Locale? currentLocale;
  final ValueChanged<Locale>? onLocaleChanged;

  const HomeScreen({
    super.key,
    this.nextPrayerName = 'Dhuhr',
    this.remainingDuration = const Duration(hours: 1, minutes: 24, seconds: 5),
    this.countdownProgress = 0.75,
    this.animateHero = true,
    this.locationName = 'Locating...',
    this.isTimezoneMismatched = false,
    this.prayers,
    this.reflectionItem,
    this.currentThemeMode = ThemeMode.dark,
    this.onThemeModeChanged,
    this.notificationService,
    this.currentLocale,
    this.onLocaleChanged,
  });

  static final defaultReflection = DailyContentItem(
    id: 'hadith_bukhari_50',
    type: DailyContentType.hadith,
    arabicText: 'مَنْ صَامَ رَمَضَانَ إِيمَانًا وَاحْتِسَابًا غُفِرَ لَهُ مَا تَقَدَّمَ مِنْ ذَنْبِهِ',
    translationText:
        'Whoever fasts during the month of Ramadan out of sincere faith and hoping for a reward from Allah will have all his previous sins forgiven.',
    translationSource: 'Sahih al-Bukhari 38',
    reference: 'Sahih al-Bukhari 38',
    grade: 'Sahih',
    gradedBy: 'Sahih al-Bukhari',
    sourceWeight: 1.5,
    tags: const ['ramadan'],
  );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedNavIndex = 0;
  bool _isReflectionFavorited = false;
  late String _currentLocationName;
  int _hijriOffset = 0;
  Timer? _periodicRefreshTimer;
  StreamSubscription<LocationData>? _locationSubscription;
  bool _isLocationFallback = false;
  String? _locationStatusMessage;

  // Dynamic Hero State
  String _heroHeaderLabel = 'UPCOMING PRAYER';
  String _nextPrayerName = 'Dhuhr';
  String? _heroPeriodText;
  String? _sunriseTimeStr;
  String? _sunsetTimeStr;
  DateTime? _nextPrayerTime;
  DateTime? _heroPeriodStartTime;
  DateTime? _heroPeriodEndTime;
  Duration? _remainingDuration;
  double _countdownProgress = 0.75;
  bool _isDrain = false;

  // Dynamic Prayer List & Content State
  List<PrayerItem> _prayers = [];
  Map<String, DateTime> _calculatedTimesMap = {};
  DateTime? _currentCalcDate;
  String? _lastLoadedDateStr;
  DailyContentItem? _reflectionItem;
  bool _isDatabaseHydrated = false;

  @override
  void initState() {
    super.initState();
    _currentLocationName = widget.locationName;
    _nextPrayerName = widget.nextPrayerName;
    _remainingDuration = widget.remainingDuration;
    _countdownProgress = widget.countdownProgress;
    _reflectionItem = widget.reflectionItem;

    if (LocationService.savedLocation != null) {
      _applyLocationAndCalculateSync(LocationService.savedLocation!);
    }

    _initLocationAndPrayers();

    _periodicRefreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _reEvaluateCurrentPrayerState();
    });
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentLocale != widget.currentLocale) {
      _reEvaluateCurrentPrayerState();
    }
  }

  @override
  void dispose() {
    _periodicRefreshTimer?.cancel();
    _locationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _reEvaluateCurrentPrayerState() async {
    if (!mounted) return;

    final now = DateTime.now();
    final loc = LocationService.savedLocation ?? LocationService.defaultFallbackLocation;

    if (_calculatedTimesMap.isEmpty || _currentCalcDate == null) {
      await _applyLocationAndCalculate(loc);
      return;
    }

    final calcParams = CalculationMethodMapper.getMethodForCountry(loc.countryCode);
    final coords = Coordinates(loc.latitude, loc.longitude);
    final calc = const PrayerTimesCalculator();
    final requiredCalcDate = calc.getIslamicCalculationDate(
      now: now,
      coordinates: coords,
      calculationParameters: calcParams,
    );

    final reqDateOnly = DateTime(requiredCalcDate.year, requiredCalcDate.month, requiredCalcDate.day);
    final curDateOnly = DateTime(_currentCalcDate!.year, _currentCalcDate!.month, _currentCalcDate!.day);

    if (reqDateOnly != curDateOnly) {
      await _applyLocationAndCalculate(loc);
      return;
    }

    final fajr = _calculatedTimesMap['Fajr'];
    final sunrise = _calculatedTimesMap['Sunrise'];
    final dhuhr = _calculatedTimesMap['Dhuhr'];
    final asr = _calculatedTimesMap['Asr'];
    final maghrib = _calculatedTimesMap['Maghrib'];
    final isha = _calculatedTimesMap['Isha'];

    if (fajr == null || sunrise == null || dhuhr == null || asr == null || maghrib == null || isha == null) {
      return;
    }

    final todayStr = _getTodayDateStr(_currentCalcDate);
    final isSameDay = _lastLoadedDateStr == todayStr;
    _lastLoadedDateStr = todayStr;

    final savedLogs = await _loadTodayPrayerLogs(todayStr);

    PrayerStatus resolveStatus(String name) {
      final dbStatus = savedLogs[name];
      if (dbStatus != null && dbStatus != PrayerStatus.pending) return dbStatus;
      if (isSameDay) {
        for (final p in _prayers) {
          if (p.name == name && p.status != PrayerStatus.pending) return p.status;
        }
      }
      return dbStatus ?? PrayerStatus.pending;
    }

    final mergedLogs = <String, PrayerStatus>{};
    for (final key in ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha']) {
      mergedLogs[key] = resolveStatus(key);
    }

    final fajrStr = _formatTime12h(fajr);
    final sunriseStr = _formatTime12h(sunrise);
    final dhuhrStr = _formatTime12h(dhuhr);
    final asrStr = _formatTime12h(asr);
    final maghribStr = _formatTime12h(maghrib);
    final ishaStr = _formatTime12h(isha);
    final tomorrowFajrStr = _formatTime12h(fajr.add(const Duration(days: 1)));

    final rawList = [
      PrayerItem(name: 'Fajr', time: fajrStr, endTime: sunriseStr, status: mergedLogs['Fajr']!),
      PrayerItem(name: 'Sunrise', time: sunriseStr, isSunrise: true),
      PrayerItem(name: 'Dhuhr', time: dhuhrStr, endTime: asrStr, status: mergedLogs['Dhuhr']!),
      PrayerItem(name: 'Asr', time: asrStr, endTime: maghribStr, status: mergedLogs['Asr']!),
      PrayerItem(name: 'Maghrib', time: maghribStr, endTime: ishaStr, status: mergedLogs['Maghrib']!),
      PrayerItem(name: 'Isha', time: ishaStr, endTime: tomorrowFajrStr, status: mergedLogs['Isha']!),
    ];

    if (!mounted) return;
    setState(() {
      _evaluateHeroAndList(
        rawPrayers: rawList,
        fajr: fajr,
        sunrise: sunrise,
        dhuhr: dhuhr,
        asr: asr,
        maghrib: maghrib,
        isha: isha,
        logs: savedLogs,
      );
    });
  }

  void _applyLocationAndCalculateSync(LocationData loc) {
    final calcParams = CalculationMethodMapper.getMethodForCountry(loc.countryCode);
    final calc = const PrayerTimesCalculator();
    final coords = Coordinates(loc.latitude, loc.longitude);
    final calcDate = _getIslamicCalculationDate(DateTime.now(), coords, calcParams);
    final prayerTimes = calc.calculatePrayerTimes(
      coordinates: coords,
      date: calcDate,
      calculationParameters: calcParams,
    );

    final cityName = LocationFormatter.format(loc);

    _currentCalcDate = DateTime(calcDate.year, calcDate.month, calcDate.day);
    _calculatedTimesMap = {
      'Fajr': prayerTimes.fajr,
      'Sunrise': prayerTimes.sunrise,
      'Dhuhr': prayerTimes.dhuhr,
      'Asr': prayerTimes.asr,
      'Maghrib': prayerTimes.maghrib,
      'Isha': prayerTimes.isha,
    };

    WidgetService().updateFromPrayerTimes(
      prayerTimes: {
        'Fajr': prayerTimes.fajr,
        'Sunrise': prayerTimes.sunrise,
        'Dhuhr': prayerTimes.dhuhr,
        'Asr': prayerTimes.asr,
        'Maghrib': prayerTimes.maghrib,
        'Isha': prayerTimes.isha,
      },
      city: cityName,
    );

    final fajrStr = _formatTime12h(prayerTimes.fajr);
    final sunriseStr = _formatTime12h(prayerTimes.sunrise);
    final dhuhrStr = _formatTime12h(prayerTimes.dhuhr);
    final asrStr = _formatTime12h(prayerTimes.asr);
    final maghribStr = _formatTime12h(prayerTimes.maghrib);
    final ishaStr = _formatTime12h(prayerTimes.isha);
    final tomorrowFajrStr = _formatTime12h(prayerTimes.fajr.add(const Duration(days: 1)));

    final rawList = [
      PrayerItem(name: 'Fajr', time: fajrStr, endTime: sunriseStr),
      PrayerItem(name: 'Sunrise', time: sunriseStr, isSunrise: true),
      PrayerItem(name: 'Dhuhr', time: dhuhrStr, endTime: asrStr),
      PrayerItem(name: 'Asr', time: asrStr, endTime: maghribStr),
      PrayerItem(name: 'Maghrib', time: maghribStr, endTime: ishaStr),
      PrayerItem(name: 'Isha', time: ishaStr, endTime: tomorrowFajrStr),
    ];

    _currentLocationName = cityName;
    _evaluateHeroAndList(
      rawPrayers: rawList,
      fajr: prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      dhuhr: prayerTimes.dhuhr,
      asr: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isha: prayerTimes.isha,
      logs: {},
    );
  }

  String _formatTime12h(DateTime dt) {
    final hour = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
    final minute = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:$minute $ampm';
  }

  DateTime _getIslamicCalculationDate([DateTime? referenceDate, Coordinates? coords, CalculationParameters? params]) {
    final now = referenceDate ?? DateTime.now();
    if (coords != null && params != null) {
      final calc = const PrayerTimesCalculator();
      return calc.getIslamicCalculationDate(
        now: now,
        coordinates: coords,
        calculationParameters: params,
      );
    } else if (now.hour < 4) {
      return DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1));
    }
    return DateTime(now.year, now.month, now.day);
  }

  String _getTodayDateStr([DateTime? calcDate]) {
    final target = calcDate ?? _currentCalcDate ?? _getIslamicCalculationDate();
    return '${target.year}-${target.month.toString().padLeft(2, '0')}-${target.day.toString().padLeft(2, '0')}';
  }

  Future<Map<String, PrayerStatus>> _loadTodayPrayerLogs(String dateStr) async {
    try {
      final db = AppDatabase.instance();
      final logs = await (db.select(db.prayerLogsTable)
            ..where((tbl) => tbl.date.equals(dateStr)))
          .get();
      final map = <String, PrayerStatus>{};
      for (final log in logs) {
        if (log.status == 'prayed') {
          map[log.prayerName] = PrayerStatus.prayed;
        } else if (log.status == 'missed') {
          map[log.prayerName] = PrayerStatus.missed;
        } else {
          map[log.prayerName] = PrayerStatus.pending;
        }
      }
      return map;
    } catch (_) {
      return {};
    }
  }

  Future<void> _savePrayerLog(String dateStr, String prayerName, PrayerStatus status) async {
    try {
      final db = AppDatabase.instance();
      final existing = await (db.select(db.prayerLogsTable)
            ..where((tbl) => (tbl.date.equals(dateStr)) & (tbl.prayerName.equals(prayerName))))
          .getSingleOrNull();

      if (existing != null) {
        await (db.update(db.prayerLogsTable)..where((tbl) => tbl.id.equals(existing.id))).write(
          PrayerLogsTableCompanion(
            status: Value(status.name),
            updatedAt: Value(DateTime.now()),
          ),
        );
      } else {
        await db.into(db.prayerLogsTable).insert(
              PrayerLogsTableCompanion.insert(
                date: dateStr,
                prayerName: prayerName,
                status: status.name,
                updatedAt: DateTime.now(),
              ),
            );
      }
    } catch (_) {}
  }

  void _evaluateHeroAndList({
    required List<PrayerItem> rawPrayers,
    required DateTime fajr,
    required DateTime sunrise,
    required DateTime dhuhr,
    required DateTime asr,
    required DateTime maghrib,
    required DateTime isha,
    required Map<String, PrayerStatus> logs,
  }) {
    final now = DateTime.now();
    final l10n = AppLocalizations.of(context);
    final upcomingLabel = l10n?.upcomingPrayer ?? 'UPCOMING PRAYER';
    final currentSalahLabel = l10n?.currentSalah ?? 'CURRENT SALAH';

    PrayerStatus statusOf(String name) => logs[name] ?? PrayerStatus.pending;

    String headerLabel = upcomingLabel;
    String heroPrayerName = 'Dhuhr';
    String? currentActivePrayerName;
    String upcomingNextPrayerName = 'Dhuhr';
    String? periodText;
    DateTime? targetTime;
    DateTime? pStart;
    DateTime? pEnd;
    final fajrStr = _formatTime12h(fajr);
    final sunriseStr = _formatTime12h(sunrise);
    final dhuhrStr = _formatTime12h(dhuhr);
    final asrStr = _formatTime12h(asr);
    final maghribStr = _formatTime12h(maghrib);
    final ishaStr = _formatTime12h(isha);
    final tomorrowFajr = fajr.add(const Duration(days: 1));
    final tomorrowFajrStr = _formatTime12h(tomorrowFajr);

    if (now.isBefore(fajr)) {
      headerLabel = upcomingLabel;
      heroPrayerName = 'Fajr';
      currentActivePrayerName = null;
      upcomingNextPrayerName = 'Fajr';
      periodText = l10n?.startsAt(fajrStr) ?? 'Starts at $fajrStr';
      targetTime = fajr;
      pStart = fajr.subtract(const Duration(hours: 6));
      pEnd = fajr;
    } else if (now.isBefore(sunrise)) {
      upcomingNextPrayerName = 'Dhuhr';
      if (statusOf('Fajr') != PrayerStatus.prayed) {
        headerLabel = currentSalahLabel;
        heroPrayerName = 'Fajr';
        currentActivePrayerName = 'Fajr';
        periodText = l10n?.periodRange(fajrStr, sunriseStr) ?? 'Period: $fajrStr – $sunriseStr';
        targetTime = sunrise;
        pStart = fajr;
        pEnd = sunrise;
      } else {
        headerLabel = upcomingLabel;
        heroPrayerName = 'Dhuhr';
        currentActivePrayerName = null;
        periodText = l10n?.startsAt(dhuhrStr) ?? 'Starts at $dhuhrStr';
        targetTime = dhuhr;
        pStart = sunrise;
        pEnd = dhuhr;
      }
    } else if (now.isBefore(dhuhr)) {
      headerLabel = upcomingLabel;
      heroPrayerName = 'Dhuhr';
      currentActivePrayerName = null;
      upcomingNextPrayerName = 'Dhuhr';
      periodText = l10n?.startsAt(dhuhrStr) ?? 'Starts at $dhuhrStr';
      targetTime = dhuhr;
      pStart = sunrise;
      pEnd = dhuhr;
    } else if (now.isBefore(asr)) {
      upcomingNextPrayerName = 'Asr';
      if (statusOf('Dhuhr') != PrayerStatus.prayed) {
        headerLabel = currentSalahLabel;
        heroPrayerName = 'Dhuhr';
        currentActivePrayerName = 'Dhuhr';
        periodText = l10n?.periodRange(dhuhrStr, asrStr) ?? 'Period: $dhuhrStr – $asrStr';
        targetTime = asr;
        pStart = dhuhr;
        pEnd = asr;
      } else {
        headerLabel = upcomingLabel;
        heroPrayerName = 'Asr';
        currentActivePrayerName = null;
        periodText = l10n?.startsAt(asrStr) ?? 'Starts at $asrStr';
        targetTime = asr;
        pStart = dhuhr;
        pEnd = asr;
      }
    } else if (now.isBefore(maghrib)) {
      upcomingNextPrayerName = 'Maghrib';
      if (statusOf('Asr') != PrayerStatus.prayed) {
        headerLabel = currentSalahLabel;
        heroPrayerName = 'Asr';
        currentActivePrayerName = 'Asr';
        periodText = l10n?.periodRange(asrStr, maghribStr) ?? 'Period: $asrStr – $maghribStr';
        targetTime = maghrib;
        pStart = asr;
        pEnd = maghrib;
      } else {
        headerLabel = upcomingLabel;
        heroPrayerName = 'Maghrib';
        currentActivePrayerName = null;
        periodText = l10n?.startsAt(maghribStr) ?? 'Starts at $maghribStr';
        targetTime = maghrib;
        pStart = asr;
        pEnd = maghrib;
      }
    } else if (now.isBefore(isha)) {
      upcomingNextPrayerName = 'Isha';
      if (statusOf('Maghrib') != PrayerStatus.prayed) {
        headerLabel = currentSalahLabel;
        heroPrayerName = 'Maghrib';
        currentActivePrayerName = 'Maghrib';
        periodText = l10n?.periodRange(maghribStr, ishaStr) ?? 'Period: $maghribStr – $ishaStr';
        targetTime = isha;
        pStart = maghrib;
        pEnd = isha;
      } else {
        headerLabel = upcomingLabel;
        heroPrayerName = 'Isha';
        currentActivePrayerName = null;
        periodText = l10n?.startsAt(ishaStr) ?? 'Starts at $ishaStr';
        targetTime = isha;
        pStart = maghrib;
        pEnd = isha;
      }
    } else {
      upcomingNextPrayerName = 'Fajr';
      if (statusOf('Isha') != PrayerStatus.prayed) {
        headerLabel = currentSalahLabel;
        heroPrayerName = 'Isha';
        currentActivePrayerName = 'Isha';
        periodText = l10n?.periodRange(ishaStr, tomorrowFajrStr) ?? 'Period: $ishaStr – $tomorrowFajrStr';
        targetTime = tomorrowFajr;
        pStart = isha;
        pEnd = tomorrowFajr;
      } else {
        final isSameDayFajr = tomorrowFajr.day == now.day;
        headerLabel = upcomingLabel;
        heroPrayerName = 'Fajr';
        currentActivePrayerName = null;
        periodText = isSameDayFajr
            ? (l10n?.startsAt(tomorrowFajrStr) ?? 'Starts at $tomorrowFajrStr')
            : 'Tomorrow at $tomorrowFajrStr';
        targetTime = tomorrowFajr;
        pStart = isha;
        pEnd = tomorrowFajr;
      }
    }

    final updatedList = rawPrayers.map((item) {
      bool isFut = false;
      DateTime? endT;
      if (item.name == 'Fajr') {
        isFut = now.isBefore(fajr);
        endT = sunrise;
      }
      if (item.name == 'Dhuhr') {
        isFut = now.isBefore(dhuhr);
        endT = asr;
      }
      if (item.name == 'Asr') {
        isFut = now.isBefore(asr);
        endT = maghrib;
      }
      if (item.name == 'Maghrib') {
        isFut = now.isBefore(maghrib);
        endT = isha;
      }
      if (item.name == 'Isha') {
        isFut = now.isBefore(isha);
        endT = tomorrowFajr;
      }

      PrayerStatus evalStatus = item.status;

      // RULE 1: Future prayer (start time not arrived yet) MUST ALWAYS be pending
      if (isFut) {
        evalStatus = PrayerStatus.pending;
      }
      // RULE 2: Past expired prayer (end time has passed) auto-evaluates to missed if user has not logged prayed/missed
      else if (_isDatabaseHydrated && !item.isSunrise && endT != null && now.isAfter(endT)) {
        if (evalStatus == PrayerStatus.pending) {
          evalStatus = PrayerStatus.missed;
        }
      }
      final isThisCurrent = item.name == currentActivePrayerName;
      final isThisNext = item.name == upcomingNextPrayerName && isFut;

      return item.copyWith(
        isCurrent: isThisCurrent,
        isNext: isThisNext,
        isFuture: isFut,
        status: evalStatus,
      );
    }).toList();

    final sunriseItem = rawPrayers.firstWhere(
      (p) => p.isSunrise || p.name == 'Sunrise',
      orElse: () => const PrayerItem(name: 'Sunrise', time: '06:05 AM', isSunrise: true),
    );

    _heroHeaderLabel = headerLabel;
    _nextPrayerName = heroPrayerName;
    _heroPeriodText = periodText;
    _sunriseTimeStr = sunriseItem.time;
    _sunsetTimeStr = _formatTime12h(maghrib);
    _nextPrayerTime = targetTime;
    _heroPeriodStartTime = pStart;
    _heroPeriodEndTime = pEnd;
    _isDrain = (headerLabel == 'CURRENT SALAH');
    _prayers = updatedList;

    final stringLogs = logs.map((k, v) => MapEntry(k, v.name));
    WidgetService().updateFromPrayerTimes(
      prayerTimes: {
        'Fajr': fajr,
        'Dhuhr': dhuhr,
        'Asr': asr,
        'Maghrib': maghrib,
        'Isha': isha,
      },
      prayerLogs: stringLogs,
      city: _currentLocationName,
    );
  }

  Future<void> _applyLocationAndCalculate(LocationData loc) async {
    final prefs = await SharedPreferences.getInstance();
    final savedMethod = prefs.getString('calc_method');
    final savedMadhab = prefs.getString('calc_madhab');

    final calcParams = CalculationMethodMapper.getMethodByName(savedMethod, loc.countryCode);
    calcParams.madhab = CalculationMethodMapper.getMadhabByName(savedMadhab);

    final calc = const PrayerTimesCalculator();
    final coords = Coordinates(loc.latitude, loc.longitude);
    final calcDate = _getIslamicCalculationDate(DateTime.now(), coords, calcParams);
    final prayerTimes = calc.calculatePrayerTimes(
      coordinates: coords,
      date: calcDate,
      calculationParameters: calcParams,
    );

    final cityName = LocationFormatter.format(loc);

    _currentCalcDate = DateTime(calcDate.year, calcDate.month, calcDate.day);
    final todayStr = _getTodayDateStr(_currentCalcDate);
    final isSameDay = _lastLoadedDateStr == todayStr;
    _lastLoadedDateStr = todayStr;

    final savedLogs = await _loadTodayPrayerLogs(todayStr);

    PrayerStatus resolveStatus(String name) {
      final dbStatus = savedLogs[name];
      if (dbStatus != null && dbStatus != PrayerStatus.pending) return dbStatus;
      if (isSameDay) {
        for (final p in _prayers) {
          if (p.name == name && p.status != PrayerStatus.pending) return p.status;
        }
      }
      return dbStatus ?? PrayerStatus.pending;
    }

    final mergedLogs = <String, PrayerStatus>{};
    for (final key in ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha']) {
      mergedLogs[key] = resolveStatus(key);
    }

    _calculatedTimesMap = {
      'Fajr': prayerTimes.fajr,
      'Sunrise': prayerTimes.sunrise,
      'Dhuhr': prayerTimes.dhuhr,
      'Asr': prayerTimes.asr,
      'Maghrib': prayerTimes.maghrib,
      'Isha': prayerTimes.isha,
    };

    final fajrStr = _formatTime12h(prayerTimes.fajr);
    final sunriseStr = _formatTime12h(prayerTimes.sunrise);
    final dhuhrStr = _formatTime12h(prayerTimes.dhuhr);
    final asrStr = _formatTime12h(prayerTimes.asr);
    final maghribStr = _formatTime12h(prayerTimes.maghrib);
    final ishaStr = _formatTime12h(prayerTimes.isha);
    final tomorrowFajrStr = _formatTime12h(prayerTimes.fajr.add(const Duration(days: 1)));

    final rawList = [
      PrayerItem(name: 'Fajr', time: fajrStr, endTime: sunriseStr, status: mergedLogs['Fajr']!),
      PrayerItem(name: 'Sunrise', time: sunriseStr, isSunrise: true),
      PrayerItem(name: 'Dhuhr', time: dhuhrStr, endTime: asrStr, status: mergedLogs['Dhuhr']!),
      PrayerItem(name: 'Asr', time: asrStr, endTime: maghribStr, status: mergedLogs['Asr']!),
      PrayerItem(name: 'Maghrib', time: maghribStr, endTime: ishaStr, status: mergedLogs['Maghrib']!),
      PrayerItem(name: 'Isha', time: ishaStr, endTime: tomorrowFajrStr, status: mergedLogs['Isha']!),
    ];

    if (!mounted) return;
    setState(() {
      _isDatabaseHydrated = true;
      _currentLocationName = cityName;
      _isLocationFallback = loc.isFallback;
      _locationStatusMessage = loc.statusMessage;
      _evaluateHeroAndList(
        rawPrayers: rawList,
        fajr: prayerTimes.fajr,
        sunrise: prayerTimes.sunrise,
        dhuhr: prayerTimes.dhuhr,
        asr: prayerTimes.asr,
        maghrib: prayerTimes.maghrib,
        isha: prayerTimes.isha,
        logs: mergedLogs,
      );
    });

    final notifService = widget.notificationService ?? NotificationService();
    final notifPrayerMaster = prefs.getBool('notif_enabled_prayer') ?? true;
    final notifAdhanMaster = prefs.getBool('notif_enabled_adhan') ?? true;
    final adhanVoice = prefs.getString('adhan_voice') ?? 'Makkah (Ali Mulla)';

    final enabledMap = <String, bool>{
      'Fajr': notifPrayerMaster,
      'Sunrise': false,
      'Dhuhr': notifPrayerMaster,
      'Asr': notifPrayerMaster,
      'Maghrib': notifPrayerMaster,
      'Isha': notifPrayerMaster,
    };
    final endTimesMap = <String, DateTime>{
      'Fajr': prayerTimes.sunrise,
      'Dhuhr': prayerTimes.asr,
      'Asr': prayerTimes.maghrib,
      'Maghrib': prayerTimes.isha,
      'Isha': prayerTimes.fajr.add(const Duration(days: 1)),
    };
    final completedPrayers = <String>{};
    savedLogs.forEach((name, status) {
      if (status == PrayerStatus.prayed || status == PrayerStatus.missed) {
        completedPrayers.add(name);
      }
    });

    await notifService.schedulePrayerNotifications(
      prayerTimes: _calculatedTimesMap,
      enabledPrayers: enabledMap,
      endTimes: endTimesMap,
      completedPrayers: completedPrayers,
      playAdhanSound: notifAdhanMaster,
      adhanVoice: adhanVoice,
    );
  }

  Future<void> _initLocationAndPrayers() async {
    final prefs = await SharedPreferences.getInstance();
    final savedOffset = prefs.getInt('hijri_offset') ?? 0;
    if (mounted) {
      setState(() {
        _hijriOffset = savedOffset;
      });
    }

    DailyContentItem? todayReflection;
    try {
      final repo = DailyContentRepository(AppDatabase.instance());
      todayReflection = await repo.resolveTodayContent(
        installationSeed: 'salah_companion_seed_1',
        today: DateTime.now(),
      );
      final isFav = await repo.isFavorited(todayReflection.id);
      if (mounted) {
        setState(() {
          _reflectionItem = todayReflection;
          _isReflectionFavorited = isFav;
        });
      }
    } catch (_) {}

    final locService = LocationService();

    // 1. Instant startup hydration from local cache or memory
    try {
      final cachedLoc = LocationService.savedLocation ?? await locService.getCachedLocation();
      if (cachedLoc != null && mounted) {
        await _applyLocationAndCalculate(cachedLoc);

        if (todayReflection != null && _calculatedTimesMap.containsKey('Fajr')) {
          final notifService = widget.notificationService ?? NotificationService();
          final prefs = await SharedPreferences.getInstance();
          final reflectionEnabled = prefs.getBool('notif_enabled_daily_reflection') ?? true;
          final fajrTime = _calculatedTimesMap['Fajr']!;
          final reflectionTime = fajrTime.add(const Duration(minutes: 30));

          await notifService.scheduleDailyReflectionNotification(
            content: todayReflection,
            scheduledTime: reflectionTime,
            enabled: reflectionEnabled,
          );
        }
      }
    } catch (_) {}

    // 2. Guaranteed Location Resolution Failsafe (never stuck at Locating...)
    try {
      final resolvedLoc = await locService.getCurrentLocation();
      if (mounted) {
        await _applyLocationAndCalculate(resolvedLoc);
      }
    } catch (_) {
      if (mounted && (_prayers.isEmpty || _currentLocationName == 'Locating...')) {
        await _applyLocationAndCalculate(LocationService.defaultFallbackLocation);
      }
    }

    // 3. Continuous Hardware GPS Precision Stream
    _locationSubscription = locService.listenToHighAccuracyUpdates().listen((freshLoc) {
      if (mounted) {
        _applyLocationAndCalculate(freshLoc);
      }
    });

    // Safety net: if still unpopulated for any unexpected reason
    if (mounted && (_prayers.isEmpty || _currentLocationName == 'Locating...')) {
      await _applyLocationAndCalculate(LocationService.defaultFallbackLocation);
    }
  }

  void _handleStatusChanged(int index, PrayerStatus newStatus) async {
    if (index < 0 || index >= _prayers.length) return;
    final item = _prayers[index];
    if (item.isSunrise) return;

    if (item.isFuture && newStatus == PrayerStatus.prayed) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.name} prayer time has not started yet (${item.time})'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    final prevPrayedCount = _prayers.where((p) => !p.isSunrise && p.status == PrayerStatus.prayed).length;

    AppHaptics.prayerStatusChanged();
    final updatedItem = item.copyWith(status: newStatus);

    final newPrayers = List<PrayerItem>.from(_prayers);
    newPrayers[index] = updatedItem;

    final newPrayedCount = newPrayers.where((p) => !p.isSunrise && p.status == PrayerStatus.prayed).length;

    final logsMap = <String, PrayerStatus>{};
    for (final p in newPrayers) {
      if (!p.isSunrise) {
        logsMap[p.name] = p.status;
      }
    }

    setState(() {
      _prayers = newPrayers;
      if (_calculatedTimesMap.containsKey('Fajr')) {
        _evaluateHeroAndList(
          rawPrayers: newPrayers,
          fajr: _calculatedTimesMap['Fajr']!,
          sunrise: _calculatedTimesMap['Sunrise']!,
          dhuhr: _calculatedTimesMap['Dhuhr']!,
          asr: _calculatedTimesMap['Asr']!,
          maghrib: _calculatedTimesMap['Maghrib']!,
          isha: _calculatedTimesMap['Isha']!,
          logs: logsMap,
        );
      }
    });

    final todayStr = _getTodayDateStr(_currentCalcDate);
    await _savePrayerLog(todayStr, item.name, newStatus);

    final notifService = widget.notificationService ?? NotificationService();
    if (newStatus == PrayerStatus.prayed || newStatus == PrayerStatus.missed) {
      await notifService.cancelPrayerReminders(item.name);
    }

    if (prevPrayedCount < 5 && newPrayedCount == 5 && mounted) {
      await PrayerStreakSheet.show(context);
    }
  }

  void _handleToggleFavorite() async {
    final item = _reflectionItem ?? widget.reflectionItem ?? HomeScreen.defaultReflection;
    try {
      final repo = DailyContentRepository(AppDatabase.instance());
      await repo.toggleFavorite(item.id);
      final isFav = await repo.isFavorited(item.id);
      if (mounted) {
        setState(() {
          _isReflectionFavorited = isFav;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isReflectionFavorited = !_isReflectionFavorited;
        });
      }
    }
  }

  void _handleRefreshReflection() async {
    try {
      final repo = DailyContentRepository(AppDatabase.instance());
      final freshItem = await repo.resolveTodayContent(
        installationSeed: 'salah_companion_seed_1',
        today: DateTime.now(),
        forceRefresh: true,
      );
      final isFav = await repo.isFavorited(freshItem.id);
      if (mounted) {
        setState(() {
          _reflectionItem = freshItem;
          _isReflectionFavorited = isFav;
        });
      }
    } catch (_) {}
  }

  Widget _buildBody(BuildContext context) {
    final reflection = _reflectionItem ?? widget.reflectionItem ?? HomeScreen.defaultReflection;

    return IndexedStack(
      index: _selectedNavIndex,
      children: [
        // Tab 0: Home Dashboard
        TickerMode(
          enabled: _selectedNavIndex == 0,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: 110.0, // Space for frosted glass nav bar
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Hijri & Location Strip
                RepaintBoundary(
                  child: HijriStrip(
                    locationName: _currentLocationName,
                    hijriOffset: _hijriOffset,
                    isTimezoneMismatched: widget.isTimezoneMismatched,
                    isLocationFallback: _isLocationFallback,
                    locationStatusMessage: _locationStatusMessage,
                    onLocationBannerTap: () async {
                      await LocationService().openLocationSettings();
                      await _initLocationAndPrayers();
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // 2. Daily Reflection Card
                RepaintBoundary(
                  child: DailyReflectionCard(
                    content: reflection,
                    isFavorited: _isReflectionFavorited,
                    onToggleFavorite: _handleToggleFavorite,
                    onRefresh: _handleRefreshReflection,
                  ),
                ),
                const SizedBox(height: 16),

                // 3. Countdown Hero Card
                RepaintBoundary(
                  child: PrayerCountdownHero(
                    headerLabel: _heroHeaderLabel,
                    nextPrayerName: _nextPrayerName,
                    periodText: _heroPeriodText,
                    sunriseTime: _sunriseTimeStr,
                    sunsetTime: _sunsetTimeStr,
                    nextPrayerTime: _nextPrayerTime,
                    periodStartTime: _heroPeriodStartTime,
                    periodEndTime: _heroPeriodEndTime,
                    remainingDuration: _nextPrayerTime == null ? _remainingDuration : null,
                    progress: _countdownProgress,
                    isDrain: _isDrain,
                    animate: widget.animateHero,
                    onTimerExpired: _reEvaluateCurrentPrayerState,
                  ),
                ),
                const SizedBox(height: 16),

                // 4. Prayer List Card
                RepaintBoundary(
                  child: PrayerListCard(
                    prayers: _prayers.isNotEmpty ? _prayers : widget.prayers,
                    onStatusChanged: _handleStatusChanged,
                    sunriseDateTime: _calculatedTimesMap['Sunrise'],
                    dhuhrDateTime: _calculatedTimesMap['Dhuhr'],
                    maghribDateTime: _calculatedTimesMap['Maghrib'],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Tab 1: Duas & Azkar
        TickerMode(
          enabled: _selectedNavIndex == 1,
          child: const DuasScreen(),
        ),

        // Tab 2: Tasbih Counter
        TickerMode(
          enabled: _selectedNavIndex == 2,
          child: const TasbihScreen(),
        ),

        // Tab 3: Qibla Finder
        TickerMode(
          enabled: _selectedNavIndex == 3,
          child: QiblaScreen(
            isActive: _selectedNavIndex == 3,
          ),
        ),

        // Tab 4: Hijri Calendar
        TickerMode(
          enabled: _selectedNavIndex == 4,
          child: HijriCalendarScreen(
            initialOffset: _hijriOffset,
            onOffsetChanged: (newOffset) {
              if (mounted) {
                setState(() {
                  _hijriOffset = newOffset;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colors.background,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          key: const ValueKey('three_line_menu_button'),
          icon: const Icon(Icons.menu_rounded),
          color: colors.textPrimary,
          tooltip: 'Menu',
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          'Salah Companion',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            key: const ValueKey('top_right_settings_button'),
            icon: const Icon(Icons.settings_rounded),
            color: colors.textPrimary,
            tooltip: 'Settings',
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                    currentThemeMode: widget.currentThemeMode,
                    onThemeModeChanged: widget.onThemeModeChanged,
                    currentLocale: widget.currentLocale,
                    onLocaleChanged: widget.onLocaleChanged,
                  ),
                ),
              );
              final loc = LocationService.savedLocation ?? LocationService.defaultFallbackLocation;
              await _applyLocationAndCalculate(loc);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: AppNavigationDrawer(
        currentThemeMode: widget.currentThemeMode,
        onThemeModeChanged: widget.onThemeModeChanged,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Active Tab Content Viewport
            Positioned.fill(
              child: _buildBody(context),
            ),

            // Frosted-Glass Bottom Navigation Bar (6 Tabs)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: FrostedGlassBottomNavBar(
                selectedIndex: _selectedNavIndex,
                onItemSelected: (index) {
                  setState(() {
                    _selectedNavIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

