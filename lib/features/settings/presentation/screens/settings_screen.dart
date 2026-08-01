import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/services/app_haptics.dart';
import '../../../../core/services/app_info_service.dart';
import '../../../../core/services/battery_service.dart';
import '../../../../core/services/notification_service.dart';
import '../../../battery_protection/presentation/sheets/battery_optimization_sheet.dart';
import '../../../home/presentation/widgets/widget_preview_sheet.dart';
import '../../../legal/presentation/screens/calculation_docs_screen.dart';
import '../../../legal/presentation/screens/privacy_policy_screen.dart';
import '../../../legal/presentation/screens/terms_screen.dart';
import '../../../reflection/data/repositories/daily_content_repository.dart';

class SettingsScreen extends StatefulWidget {
  final BatteryService? batteryService;
  final String? detectedCountry;
  final String? initialCalculationMethod;
  final String? initialMadhab;
  final String? initialAdhanVoice;
  final bool? initialPrayerNotificationsEnabled;
  final bool? initialAdhanAudioEnabled;
  final bool? initialPreAdhanReminder;
  final bool? initialHapticFeedback;
  final bool? initialBatteryExempt;
  final bool? initialWarnBatteryOpt;
  final bool? initialDailyReflectionEnabled;
  final TimeOfDay? initialDailyReflectionTime;
  final Map<String, bool>? initialPrayerNotifications;
  final Function(String method)? onCalculationMethodChanged;
  final Function(String madhab)? onMadhabChanged;
  final Function(String voice)? onAdhanVoiceChanged;
  final Function(bool enabled)? onPrayerNotificationsToggled;
  final Function(bool enabled)? onAdhanAudioToggled;
  final Function(bool enabled)? onPreAdhanReminderToggled;
  final Function(bool enabled)? onHapticFeedbackToggled;
  final Function(bool enabled)? onDailyReflectionToggled;
  final Function(TimeOfDay time)? onDailyReflectionTimeChanged;
  final Function(String prayer, bool enabled)? onPrayerNotificationToggled;
  final VoidCallback? onReplayWalkthrough;

  const SettingsScreen({
    super.key,
    this.batteryService,
    this.detectedCountry,
    this.initialCalculationMethod,
    this.initialMadhab,
    this.initialAdhanVoice,
    this.initialPrayerNotificationsEnabled,
    this.initialAdhanAudioEnabled,
    this.initialPreAdhanReminder,
    this.initialHapticFeedback,
    this.initialBatteryExempt,
    this.initialWarnBatteryOpt,
    this.initialDailyReflectionEnabled,
    this.initialDailyReflectionTime,
    this.initialPrayerNotifications,
    this.onCalculationMethodChanged,
    this.onMadhabChanged,
    this.onAdhanVoiceChanged,
    this.onPrayerNotificationsToggled,
    this.onAdhanAudioToggled,
    this.onPreAdhanReminderToggled,
    this.onHapticFeedbackToggled,
    this.onDailyReflectionToggled,
    this.onDailyReflectionTimeChanged,
    this.onPrayerNotificationToggled,
    this.onReplayWalkthrough,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with WidgetsBindingObserver {
  late String _calculationMethod;
  late String _madhab;
  late String _adhanVoice;

  late bool _prayerNotificationsEnabled;
  late bool _adhanAudioEnabled;
  late bool _preAdhanReminder;
  late bool _hapticFeedback;

  bool _isCheckingBattery = false;
  bool _isBatteryExempt = false;
  bool _warnBatteryOpt = true;

  late bool _dailyReflectionEnabled;
  late TimeOfDay _dailyReflectionTime;

  final List<String> _calculationMethods = [
    'Umm Al-Qura (Saudi Arabia)',
    'Muslim World League',
    'Egyptian General Authority',
    'ISNA (North America)',
    'Karachi (Pakistan/India)',
    'Dubai (UAE)',
    'Diyanet (Turkey)',
    'Singapore',
  ];

  final List<String> _adhanVoices = [
    'Makkah (Ali Mulla)',
    'Madinah (Abdul Majeed)',
    'Al-Aqsa (Yasser Al-Dossari)',
    'Traditional Soft Tone',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _calculationMethod = widget.initialCalculationMethod ?? 'Umm Al-Qura (Saudi Arabia)';
    _madhab = widget.initialMadhab ?? 'Shafi / Standard';
    _adhanVoice = widget.initialAdhanVoice ?? 'Makkah (Ali Mulla)';

    _prayerNotificationsEnabled = widget.initialPrayerNotificationsEnabled ?? true;
    _adhanAudioEnabled = widget.initialAdhanAudioEnabled ?? true;
    _preAdhanReminder = widget.initialPreAdhanReminder ?? true;
    _hapticFeedback = widget.initialHapticFeedback ?? true;

    _isBatteryExempt = widget.initialBatteryExempt ?? false;
    _warnBatteryOpt = widget.initialWarnBatteryOpt ?? true;
    _dailyReflectionEnabled = widget.initialDailyReflectionEnabled ?? true;
    _dailyReflectionTime = widget.initialDailyReflectionTime ?? const TimeOfDay(hour: 6, minute: 15);

    _loadSavedSettings();
    _fetchBatteryStatus();
  }

  Future<void> _loadSavedSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _calculationMethod = prefs.getString('calc_method') ?? _calculationMethod;
      _madhab = prefs.getString('calc_madhab') ?? _madhab;
      _adhanVoice = prefs.getString('adhan_voice') ?? _adhanVoice;

      _prayerNotificationsEnabled = prefs.getBool('notif_enabled_prayer') ?? _prayerNotificationsEnabled;
      _adhanAudioEnabled = prefs.getBool('notif_enabled_adhan') ?? _adhanAudioEnabled;
      _preAdhanReminder = prefs.getBool('pre_adhan_reminder') ?? _preAdhanReminder;
      _hapticFeedback = prefs.getBool('haptic_feedback_enabled') ?? _hapticFeedback;

      _dailyReflectionEnabled = prefs.getBool('notif_enabled_daily_reflection') ?? _dailyReflectionEnabled;

      final hour = prefs.getInt('daily_reflection_hour');
      final minute = prefs.getInt('daily_reflection_minute');
      if (hour != null && minute != null) {
        _dailyReflectionTime = TimeOfDay(hour: hour, minute: minute);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _fetchBatteryStatus();
    }
  }

  Future<void> _fetchBatteryStatus() async {
    if (mounted) setState(() => _isCheckingBattery = true);
    try {
      if (widget.batteryService != null) {
        final exempt = await widget.batteryService!.checkBatteryOptimizationStatus();
        final state = await widget.batteryService!.getBatteryState();
        if (mounted) {
          setState(() {
            _isBatteryExempt = exempt;
            if (state != null) {
              _warnBatteryOpt = !state.nagDisabled;
            }
            _isCheckingBattery = false;
          });
        }
      } else {
        const channel = MethodChannel('com.salahcompanion/battery');
        final isExempt = await channel
                .invokeMethod<bool>('isIgnoringBatteryOptimizations')
                .timeout(const Duration(milliseconds: 500), onTimeout: () => false) ??
            false;
        if (mounted) {
          setState(() {
            _isBatteryExempt = isExempt;
            _isCheckingBattery = false;
          });
        }
      }
    } catch (_) {
      if (mounted) setState(() => _isCheckingBattery = false);
    }
  }

  Future<void> _checkBatteryNow() async {
    setState(() => _isCheckingBattery = true);
    final service = widget.batteryService ?? BatteryService(db: AppDatabase.instance());
    final exempt = await service.checkBatteryOptimizationStatus();
    final mfg = await service.getManufacturer();

    if (mounted) {
      setState(() {
        _isBatteryExempt = exempt;
        _isCheckingBattery = false;
      });
    }

    if (!exempt && mounted) {
      await BatteryOptimizationSheet.show(
        context,
        manufacturer: mfg,
        batteryService: service,
        onFixPressed: () async {
          await service.openBatteryOptimizationSettings();
        },
        onRemindLaterPressed: () async {
          await service.recordPromptShown();
        },
        onDontAskAgainPressed: () async {
          await service.setNagDisabled(true);
          if (mounted) setState(() => _warnBatteryOpt = false);
        },
      );
      final updatedExempt = await service.checkBatteryOptimizationStatus();
      if (mounted) {
        setState(() {
          _isBatteryExempt = updatedExempt;
        });
      }
    } else if (exempt && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Battery Optimization Status: Exempt (Adhan alerts will fire reliably)'),
        ),
      );
    }
  }

  Future<void> _selectReflectionTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _dailyReflectionTime,
    );
    if (picked != null) {
      setState(() {
        _dailyReflectionTime = picked;
      });
      widget.onDailyReflectionTimeChanged?.call(picked);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('daily_reflection_hour', picked.hour);
      await prefs.setInt('daily_reflection_minute', picked.minute);

      // Reschedule reflection notification with new time immediately
      try {
        final repo = DailyContentRepository(AppDatabase.instance());
        final todayReflection = await repo.resolveTodayContent(
          installationSeed: 'salah_companion_seed_1',
          today: DateTime.now(),
        );
        final now = DateTime.now();
        var targetTime = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
        if (targetTime.isBefore(now)) {
          targetTime = targetTime.add(const Duration(days: 1));
        }
        await NotificationService().scheduleDailyReflectionNotification(
          content: todayReflection,
          scheduledTime: targetTime,
          enabled: _dailyReflectionEnabled,
        );
      } catch (_) {}
    }
  }

  void _showAdhanVoicePicker() async {
    final colors = context.appColors;
    final player = AudioPlayer();
    String? playingVoice;

    await showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            player.playerStateStream.listen((state) {
              if (state.processingState == ProcessingState.completed) {
                setModalState(() => playingVoice = null);
              }
            });

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Adhan Reciter & Tone',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    ..._adhanVoices.map((voice) {
                      final isSelected = voice == _adhanVoice;
                      final isPlayingThis = playingVoice == voice;

                      return ListTile(
                        leading: isSelected
                            ? Icon(Icons.check_rounded, color: colors.primary)
                            : const SizedBox(width: 24, height: 24),
                        title: Text(
                          voice,
                          style: TextStyle(
                            color: isSelected ? colors.primary : colors.textPrimary,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            isPlayingThis ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                            size: 30,
                          ),
                          color: colors.primary,
                          onPressed: () async {
                            if (isPlayingThis) {
                              await player.stop();
                              setModalState(() => playingVoice = null);
                              return;
                            }

                            String sampleAsset = 'assets/audio/adhan_makkah.mp3';
                            if (voice.contains('Madinah')) {
                              sampleAsset = 'assets/audio/adhan_madinah.mp3';
                            } else if (voice.contains('Al-Aqsa')) {
                              sampleAsset = 'assets/audio/adhan_alaqsa.mp3';
                            } else if (voice.contains('Soft') || voice.contains('Egyptian')) {
                              sampleAsset = 'assets/audio/adhan_egyptian.mp3';
                            }

                            try {
                              setModalState(() => playingVoice = voice);
                              await player.stop();
                              await player.setAsset(sampleAsset);
                              await player.play();
                            } catch (e) {
                              setModalState(() => playingVoice = null);
                            }
                          },
                        ),
                        onTap: () async {
                          setState(() => _adhanVoice = voice);
                          widget.onAdhanVoiceChanged?.call(voice);
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('adhan_voice', voice);
                          await player.stop();
                          await player.dispose();
                          if (context.mounted) Navigator.pop(context);
                        },
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    try {
      await player.stop();
      await player.dispose();
    } catch (_) {}
  }

  void _showCalculationMethodPicker() {
    final colors = context.appColors;

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Calculation Method',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  ..._calculationMethods.map((method) {
                    final isSelected = method == _calculationMethod;
                    return ListTile(
                      leading: isSelected
                          ? Icon(Icons.check_rounded, color: colors.primary)
                          : const SizedBox(width: 24, height: 24),
                      title: Text(
                        method,
                        style: TextStyle(
                          color: isSelected ? colors.primary : colors.textPrimary,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      onTap: () async {
                        setState(() => _calculationMethod = method);
                        widget.onCalculationMethodChanged?.call(method);
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('calc_method', method);
                        if (context.mounted) Navigator.pop(context);
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _updatePrayerNotificationsMaster(bool val) async {
    if (_hapticFeedback) HapticFeedback.selectionClick();
    setState(() => _prayerNotificationsEnabled = val);
    widget.onPrayerNotificationsToggled?.call(val);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_enabled_prayer', val);
  }

  Future<void> _updateAdhanAudioMaster(bool val) async {
    if (_hapticFeedback) HapticFeedback.selectionClick();
    setState(() => _adhanAudioEnabled = val);
    widget.onAdhanAudioToggled?.call(val);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_enabled_adhan', val);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Settings',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 32,
                      letterSpacing: -0.2,
                    ),
              ),
              const SizedBox(height: 20),

              // SECTION 1: NOTIFICATIONS (Positioned at VERY TOP as requested)
              _SectionHeader(title: 'NOTIFICATIONS'),
              const SizedBox(height: 8),
              _IOSGroupedCard(
                children: [
                  _IOSGroupedTile(
                    key: const ValueKey('prayer_notifications_master_tile'),
                    icon: Icons.notifications_active_rounded,
                    iconColor: const Color(0xFF10B981), // Emerald Green
                    title: 'Prayer Notifications',
                    trailing: Switch.adaptive(
                      key: const ValueKey('prayer_notifications_master_switch'),
                      value: _prayerNotificationsEnabled,
                      activeTrackColor: colors.primary,
                      inactiveTrackColor: colors.textTertiary.withValues(alpha: 0.3),
                      inactiveThumbColor: colors.textSecondary,
                      onChanged: _updatePrayerNotificationsMaster,
                    ),
                  ),
                  const _IOSDivider(),
                  _IOSGroupedTile(
                    key: const ValueKey('adhan_audio_master_tile'),
                    icon: Icons.volume_up_rounded,
                    iconColor: const Color(0xFF6366F1), // Indigo
                    title: 'Adhan Audio',
                    trailing: Switch.adaptive(
                      key: const ValueKey('adhan_audio_master_switch'),
                      value: _adhanAudioEnabled,
                      activeTrackColor: colors.primary,
                      inactiveTrackColor: colors.textTertiary.withValues(alpha: 0.3),
                      inactiveThumbColor: colors.textSecondary,
                      onChanged: _updateAdhanAudioMaster,
                    ),
                  ),
                  const _IOSDivider(),
                  _IOSGroupedTile(
                    key: const ValueKey('adhan_voice_tile'),
                    icon: Icons.record_voice_over_rounded,
                    iconColor: const Color(0xFFF59E0B), // Warm Amber
                    title: 'Adhan Voice',
                    valueText: _adhanVoice,
                    onTap: _showAdhanVoicePicker,
                  ),
                  const _IOSDivider(),
                  _IOSGroupedTile(
                    key: const ValueKey('daily_reflection_tile'),
                    icon: Icons.auto_stories_rounded,
                    iconColor: const Color(0xFF8B5CF6), // Royal Purple
                    title: 'Daily Reflection',
                    trailing: Switch.adaptive(
                      key: const ValueKey('daily_reflection_switch'),
                      value: _dailyReflectionEnabled,
                      activeTrackColor: colors.primary,
                      inactiveTrackColor: colors.textTertiary.withValues(alpha: 0.3),
                      inactiveThumbColor: colors.textSecondary,
                      onChanged: (val) async {
                        if (_hapticFeedback) HapticFeedback.selectionClick();
                        setState(() => _dailyReflectionEnabled = val);
                        widget.onDailyReflectionToggled?.call(val);
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('notif_enabled_daily_reflection', val);
                      },
                    ),
                  ),
                  if (_dailyReflectionEnabled) ...[
                    const _IOSDivider(),
                    _IOSGroupedTile(
                      key: const ValueKey('daily_reflection_time_tile'),
                      icon: Icons.access_time_rounded,
                      iconColor: const Color(0xFF0EA5E9), // Ocean Blue
                      title: 'Reflection Notification Time',
                      valueText: _dailyReflectionTime.format(context),
                      onTap: _selectReflectionTime,
                    ),
                  ],
                  const _IOSDivider(),
                  _IOSGroupedTile(
                    key: const ValueKey('home_widgets_tile'),
                    icon: Icons.widgets_rounded,
                    iconColor: const Color(0xFF10B981), // Emerald Green
                    title: 'Home Screen Widgets',
                    valueText: '3 Live Widgets',
                    onTap: () {
                      WidgetPreviewSheet.show(context);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // SECTION 2: CALCULATION & MADHAB
              _SectionHeader(title: 'CALCULATION & MADHAB'),
              const SizedBox(height: 8),
              _IOSGroupedCard(
                children: [
                  _IOSGroupedTile(
                    key: const ValueKey('calculation_method_tile'),
                    icon: Icons.calculate_rounded,
                    iconColor: const Color(0xFF8B5CF6), // Vibrant Purple
                    title: 'Calculation Method',
                    valueText: _calculationMethod.contains('(')
                        ? _calculationMethod.split('(').first.trim()
                        : _calculationMethod,
                    onTap: _showCalculationMethodPicker,
                  ),
                  const _IOSDivider(),
                  _IOSGroupedTile(
                    key: const ValueKey('madhab_tile'),
                    icon: Icons.balance_rounded,
                    iconColor: const Color(0xFFF59E0B), // Warm Amber
                    title: 'Madhab (Asr Timing)',
                    valueText: _madhab,
                    onTap: () async {
                      if (_hapticFeedback) HapticFeedback.selectionClick();
                      final next = _madhab.contains('Shafi') ? 'Hanafi' : 'Shafi / Standard';
                      setState(() => _madhab = next);
                      widget.onMadhabChanged?.call(next);
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('calc_madhab', next);
                    },
                  ),
                  const _IOSDivider(),
                  _IOSGroupedTile(
                    key: const ValueKey('pre_adhan_reminder_tile'),
                    icon: Icons.alarm_rounded,
                    iconColor: const Color(0xFF0EA5E9), // Vibrant Blue
                    title: 'Pre-Adhan Reminder',
                    trailing: Switch.adaptive(
                      value: _preAdhanReminder,
                      activeTrackColor: colors.primary,
                      inactiveTrackColor: colors.textTertiary.withValues(alpha: 0.3),
                      inactiveThumbColor: colors.textSecondary,
                      onChanged: (val) {
                        if (_hapticFeedback) HapticFeedback.selectionClick();
                        setState(() => _preAdhanReminder = val);
                        widget.onPreAdhanReminderToggled?.call(val);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // SECTION 3: BATTERY OPTIMIZATION
              _SectionHeader(title: 'BATTERY OPTIMIZATION'),
              const SizedBox(height: 8),
              _IOSGroupedCard(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: _isCheckingBattery ? null : _checkBatteryNow,
                          borderRadius: BorderRadius.circular(12),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: (_isBatteryExempt ? colors.success : colors.missed).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  _isBatteryExempt ? Icons.battery_full_rounded : Icons.battery_alert_rounded,
                                  color: _isBatteryExempt ? colors.success : colors.missed,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Battery Status',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            color: colors.textPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      _isBatteryExempt
                                          ? 'Exempt — Adhan alerts will fire reliably'
                                          : 'Not exempt — alerts may be delayed',
                                      key: const ValueKey('battery_status_text'),
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: _isBatteryExempt ? colors.successText : colors.missedText,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: colors.textTertiary,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            key: const ValueKey('check_battery_button'),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: colors.dividerStrong),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            icon: _isCheckingBattery
                                ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: colors.primary),
                                  )
                                : const Icon(Icons.sync_rounded, size: 18),
                            label: const Text('Check battery optimization status now'),
                            onPressed: _isCheckingBattery ? null : _checkBatteryNow,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SwitchListTile.adaptive(
                          key: const ValueKey('warn_battery_switch'),
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Warn me if battery optimization turns back on',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: colors.textPrimary,
                                ),
                          ),
                          activeTrackColor: colors.primary,
                      inactiveTrackColor: colors.textTertiary.withValues(alpha: 0.3),
                      inactiveThumbColor: colors.textSecondary,
                          value: _warnBatteryOpt,
                          onChanged: (val) {
                            if (_hapticFeedback) HapticFeedback.selectionClick();
                            setState(() => _warnBatteryOpt = val);
                            widget.batteryService?.setNagDisabled(!val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // SECTION 4: APPEARANCE & HAPTICS
              _SectionHeader(title: 'APPEARANCE & HAPTICS'),
              const SizedBox(height: 8),
              _IOSGroupedCard(
                children: [
                  _IOSGroupedTile(
                    key: const ValueKey('haptic_feedback_tile'),
                    icon: Icons.vibration_rounded,
                    iconColor: const Color(0xFF475569), // Slate Grey
                    title: 'Haptic Feedback',
                    trailing: Switch.adaptive(
                      value: _hapticFeedback,
                      activeTrackColor: colors.primary,
                      inactiveTrackColor: colors.textTertiary.withValues(alpha: 0.3),
                      inactiveThumbColor: colors.textSecondary,
                      onChanged: (val) async {
                        AppHaptics.setEnabled(val);
                        if (val) AppHaptics.selection();
                        setState(() => _hapticFeedback = val);
                        widget.onHapticFeedbackToggled?.call(val);
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('haptic_feedback_enabled', val);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // SECTION 5: ABOUT & PRIVACY
              _SectionHeader(title: 'ABOUT & PRIVACY'),
              const SizedBox(height: 8),
              _IOSGroupedCard(
                children: [
                  _IOSGroupedTile(
                    key: const ValueKey('privacy_policy_tile'),
                    icon: Icons.shield_rounded,
                    iconColor: const Color(0xFF10B981), // Emerald Green
                    title: 'Privacy Policy',
                    onTap: () {
                      if (_hapticFeedback) HapticFeedback.selectionClick();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),
                  const _IOSDivider(),
                  _IOSGroupedTile(
                    key: const ValueKey('terms_tile'),
                    icon: Icons.description_rounded,
                    iconColor: const Color(0xFF0EA5E9), // Ocean Blue
                    title: 'Terms & Conditions',
                    onTap: () {
                      if (_hapticFeedback) HapticFeedback.selectionClick();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TermsScreen(),
                        ),
                      );
                    },
                  ),
                  const _IOSDivider(),
                  _IOSGroupedTile(
                    key: const ValueKey('calculation_docs_tile'),
                    icon: Icons.help_outline_rounded,
                    iconColor: const Color(0xFF8B5CF6), // Purple
                    title: 'Calculation Accuracy & FAQ',
                    onTap: () {
                      if (_hapticFeedback) HapticFeedback.selectionClick();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CalculationDocsScreen(),
                        ),
                      );
                    },
                  ),
                  const _IOSDivider(),
                  _IOSGroupedTile(
                    key: const ValueKey('replay_walkthrough_tile'),
                    icon: Icons.auto_awesome_rounded,
                    iconColor: const Color(0xFFF59E0B), // Warm Amber
                    title: 'Replay App Walkthrough',
                    onTap: () {
                      if (_hapticFeedback) HapticFeedback.selectionClick();
                      Navigator.of(context).pop();
                      widget.onReplayWalkthrough?.call();
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    Text(
                      '100% Free & Open Source • Zero Ads • No Data Collection',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colors.textTertiary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppInfoService.settingsVersionText,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: colors.textTertiary.withValues(alpha: 0.7),
                          ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colors.textTertiary,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

/// Apple iOS-Inspired Grouped Inset Container Card
class _IOSGroupedCard extends StatelessWidget {
  final List<Widget> children;

  const _IOSGroupedCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Material(
      color: colors.surface,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: colors.divider, width: 1.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

/// Apple iOS-Inspired Grouped List Tile with Squircle Icon Badge
class _IOSGroupedTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? valueText;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _IOSGroupedTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.valueText,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            // Rounded Squircle Icon Badge
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 14),

            // Title
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
              ),
            ),

            // Trailing Value or Switch
            if (valueText != null) ...[
              Text(
                valueText!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.textSecondary,
                      fontSize: 14,
                    ),
              ),
              const SizedBox(width: 6),
            ],

            if (trailing case final Widget t) t,

            if (onTap != null && trailing == null) ...[
              Icon(
                Icons.chevron_right_rounded,
                color: colors.textTertiary,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _IOSDivider extends StatelessWidget {
  const _IOSDivider();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Divider(
      height: 1,
      thickness: 0.8,
      indent: 64,
      endIndent: 0,
      color: colors.divider,
    );
  }
}
