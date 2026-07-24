import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../core/services/battery_service.dart';

class SettingsScreen extends StatefulWidget {
  final BatteryService? batteryService;
  final String? detectedCountry;
  final String? initialCalculationMethod;
  final String? initialMadhab;
  final bool? initialBatteryExempt;
  final bool? initialWarnBatteryOpt;
  final bool? initialDailyReflectionEnabled;
  final TimeOfDay? initialDailyReflectionTime;
  final Map<String, bool>? initialPrayerNotifications;
  final Function(String method)? onCalculationMethodChanged;
  final Function(String madhab)? onMadhabChanged;
  final Function(bool enabled)? onDailyReflectionToggled;
  final Function(TimeOfDay time)? onDailyReflectionTimeChanged;
  final Function(String prayer, bool enabled)? onPrayerNotificationToggled;

  const SettingsScreen({
    super.key,
    this.batteryService,
    this.detectedCountry,
    this.initialCalculationMethod,
    this.initialMadhab,
    this.initialBatteryExempt,
    this.initialWarnBatteryOpt,
    this.initialDailyReflectionEnabled,
    this.initialDailyReflectionTime,
    this.initialPrayerNotifications,
    this.onCalculationMethodChanged,
    this.onMadhabChanged,
    this.onDailyReflectionToggled,
    this.onDailyReflectionTimeChanged,
    this.onPrayerNotificationToggled,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _calculationMethod;
  late String _madhab;

  bool _isCheckingBattery = false;
  bool _isBatteryExempt = false;
  bool _warnBatteryOpt = true;

  late bool _dailyReflectionEnabled;
  late TimeOfDay _dailyReflectionTime;

  late Map<String, bool> _prayerNotifications;

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

  @override
  void initState() {
    super.initState();
    _calculationMethod = widget.initialCalculationMethod ?? 'Umm Al-Qura (Saudi Arabia)';
    _madhab = widget.initialMadhab ?? 'Shafi / Standard';
    _isBatteryExempt = widget.initialBatteryExempt ?? false;
    _warnBatteryOpt = widget.initialWarnBatteryOpt ?? true;
    _dailyReflectionEnabled = widget.initialDailyReflectionEnabled ?? true;
    _dailyReflectionTime = widget.initialDailyReflectionTime ?? const TimeOfDay(hour: 6, minute: 15);

    _prayerNotifications = widget.initialPrayerNotifications != null
        ? Map.from(widget.initialPrayerNotifications!)
        : {
            'Fajr': true,
            'Dhuhr': true,
            'Asr': true,
            'Maghrib': true,
            'Isha': true,
          };

    _fetchBatteryStatus();
  }

  Future<void> _fetchBatteryStatus() async {
    if (widget.batteryService != null) {
      setState(() => _isCheckingBattery = true);
      try {
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
      } catch (_) {
        if (mounted) setState(() => _isCheckingBattery = false);
      }
    }
  }

  Future<void> _checkBatteryNow() async {
    setState(() => _isCheckingBattery = true);
    if (widget.batteryService != null) {
      final exempt = await widget.batteryService!.checkBatteryOptimizationStatus();
      if (mounted) {
        setState(() {
          _isBatteryExempt = exempt;
          _isCheckingBattery = false;
        });
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        setState(() {
          _isBatteryExempt = true;
          _isCheckingBattery = false;
        });
      }
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isBatteryExempt
                ? 'Battery Optimization Status: Exempt'
                : 'Battery Optimization Status: Not Exempt (Alerts may be delayed)',
          ),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final country = widget.detectedCountry ?? 'Saudi Arabia';

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Calculation & Fiqh Section
            _SectionHeader(title: 'CALCULATION & FIQH'),
            const SizedBox(height: 8),
            Material(
              color: colors.surface,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: colors.divider, width: 1.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded, size: 16, color: colors.primary),
                        const SizedBox(width: 6),
                        Text(
                          'Detected Country: $country',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: colors.primaryText,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Calculation Method',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      key: const ValueKey('calculation_method_dropdown'),
                      initialValue: _calculationMethod,
                      dropdownColor: colors.surface,
                      style: TextStyle(color: colors.textPrimary, fontSize: 14),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colors.elevatedBackground,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: colors.divider),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: colors.divider),
                        ),
                      ),
                      items: _calculationMethods.map((method) {
                        return DropdownMenuItem<String>(
                          value: method,
                          child: Text(method),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _calculationMethod = val);
                          widget.onCalculationMethodChanged?.call(val);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Madhab (Asr Timing)',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _ChoiceTile(
                            title: 'Shafi / Standard',
                            subtitle: 'Standard shadow factor 1x',
                            isSelected: _madhab.contains('Shafi'),
                            onTap: () {
                              setState(() => _madhab = 'Shafi / Standard');
                              widget.onMadhabChanged?.call('Shafi');
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _ChoiceTile(
                            title: 'Hanafi',
                            subtitle: 'Later shadow factor 2x',
                            isSelected: _madhab.contains('Hanafi'),
                            onTap: () {
                              setState(() => _madhab = 'Hanafi');
                              widget.onMadhabChanged?.call('Hanafi');
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 2. Battery Optimization Controls (PRD 4.5)
            _SectionHeader(title: 'BATTERY OPTIMIZATION (PRD 4.5)'),
            const SizedBox(height: 8),
            Material(
              color: colors.surface,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: colors.divider, width: 1.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _isBatteryExempt ? Icons.battery_full_rounded : Icons.battery_alert_rounded,
                          color: _isBatteryExempt ? colors.success : colors.missed,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
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
                              const SizedBox(height: 2),
                              Text(
                                _isBatteryExempt
                                    ? 'Exempt'
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
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        key: const ValueKey('check_battery_button'),
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
                    SwitchListTile(
                      key: const ValueKey('warn_battery_switch'),
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Warn me if battery optimization turns back on',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.textPrimary,
                            ),
                      ),
                      subtitle: Text(
                        'Displays prompt if Android resets app background restriction',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.textSecondary,
                            ),
                      ),
                      value: _warnBatteryOpt,
                      activeThumbColor: colors.primary,
                      onChanged: (val) {
                        setState(() => _warnBatteryOpt = val);
                        widget.batteryService?.setNagDisabled(!val);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 3. Daily Reflection Notification (PRD 6.7)
            _SectionHeader(title: 'DAILY REFLECTION NOTIFICATION (PRD 6.7)'),
            const SizedBox(height: 8),
            Material(
              color: colors.surface,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: colors.divider, width: 1.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SwitchListTile(
                      key: const ValueKey('daily_reflection_switch'),
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Daily Reflection',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        'Receive daily inspiration verse or Hadith',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.textSecondary,
                            ),
                      ),
                      value: _dailyReflectionEnabled,
                      activeThumbColor: colors.primary,
                      onChanged: (val) {
                        setState(() => _dailyReflectionEnabled = val);
                        widget.onDailyReflectionToggled?.call(val);
                      },
                    ),
                    if (_dailyReflectionEnabled) ...[
                      Divider(color: colors.divider),
                      ListTile(
                        key: const ValueKey('daily_reflection_time_tile'),
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Notification Time',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: colors.textPrimary,
                              ),
                        ),
                        subtitle: Text(
                          'Default: 30 mins post-Fajr',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colors.textSecondary,
                              ),
                        ),
                        trailing: TextButton.icon(
                          icon: Icon(Icons.access_time_rounded, size: 16, color: colors.primary),
                          label: Text(
                            _dailyReflectionTime.format(context),
                            style: TextStyle(
                              color: colors.primaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _selectReflectionTime,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 4. Per-Prayer Notifications
            _SectionHeader(title: 'PRAYER NOTIFICATIONS'),
            const SizedBox(height: 8),
            Material(
              color: colors.surface,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: colors.divider, width: 1.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'].map((prayer) {
                    final enabled = _prayerNotifications[prayer] ?? true;
                    return Column(
                      children: [
                        SwitchListTile(
                          key: ValueKey('prayer_switch_$prayer'),
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            prayer,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          subtitle: Text(
                            enabled ? 'Notification & Adhan enabled' : 'Muted',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: enabled ? colors.successText : colors.textTertiary,
                                ),
                          ),
                          value: enabled,
                          activeThumbColor: colors.primary,
                          onChanged: (val) {
                            setState(() {
                              _prayerNotifications[prayer] = val;
                            });
                            widget.onPrayerNotificationToggled?.call(prayer, val);
                          },
                        ),
                        if (prayer != 'Isha') Divider(color: colors.divider),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
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
    return Text(
      title,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colors.textSecondary,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChoiceTile({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: ShapeDecoration(
          color: isSelected ? colors.primarySoft : colors.elevatedBackground,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(
              color: isSelected ? colors.primary : colors.divider,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isSelected ? colors.primaryText : colors.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.textTertiary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
