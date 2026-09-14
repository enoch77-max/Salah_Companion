import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/services/battery_service.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Contextual Permission Priming step for Salah Companion onboarding.
/// Directly interacts with real native OS permissions (Location, Notifications, Battery Optimization),
/// persists granted statuses across navigation, and auto-refreshes when returning from system settings.
class PermissionPrimingStep extends StatefulWidget {
  final NotificationService? notificationService;
  final BatteryService? batteryService;

  const PermissionPrimingStep({
    super.key,
    this.notificationService,
    this.batteryService,
  });

  @override
  State<PermissionPrimingStep> createState() => _PermissionPrimingStepState();
}

class _PermissionPrimingStepState extends State<PermissionPrimingStep>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  late final NotificationService _notificationService;
  late final BatteryService _batteryService;

  bool _locationGranted = false;
  bool _notificationGranted = false;
  bool _batteryExempt = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _notificationService = widget.notificationService ?? NotificationService();
    _batteryService = widget.batteryService ?? BatteryService(db: AppDatabase.instance());
    _checkInitialStatuses();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkInitialStatuses();
    }
  }

  Future<void> _checkInitialStatuses() async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Check Location
    try {
      final permission = await Geolocator.checkPermission();
      final isLocGranted = permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
      if (mounted) {
        setState(() => _locationGranted = isLocGranted);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _locationGranted = prefs.getBool('onboarding_location_granted') ?? false);
      }
    }

    // 2. Check Notifications
    try {
      final androidImpl = _notificationService.notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final isNotifEnabled = await androidImpl?.areNotificationsEnabled();
      final savedNotif = prefs.getBool('onboarding_notification_granted') ?? false;

      if (mounted) {
        setState(() => _notificationGranted = isNotifEnabled ?? savedNotif);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _notificationGranted = prefs.getBool('onboarding_notification_granted') ?? false);
      }
    }

    // 3. Check Battery Optimization
    try {
      final isIgnoring = await _batteryService.isIgnoringBatteryOptimizations();
      final savedBattery = prefs.getBool('onboarding_battery_granted') ?? false;
      if (mounted) {
        setState(() => _batteryExempt = isIgnoring || savedBattery);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _batteryExempt = prefs.getBool('onboarding_battery_granted') ?? false);
      }
    }
  }

  Future<void> _requestLocation() async {
    HapticFeedback.selectionClick();
    final prefs = await SharedPreferences.getInstance();
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        await prefs.setBool('onboarding_location_granted', true);
        if (mounted) {
          setState(() => _locationGranted = true);
          HapticFeedback.mediumImpact();
        }
      }
    } catch (_) {
      await prefs.setBool('onboarding_location_granted', true);
      if (mounted) setState(() => _locationGranted = true);
    }
  }

  Future<void> _requestNotification() async {
    HapticFeedback.selectionClick();
    final prefs = await SharedPreferences.getInstance();
    try {
      final granted = await _notificationService.requestPermissions();
      await prefs.setBool('onboarding_notification_granted', granted);
      if (mounted) {
        setState(() => _notificationGranted = true);
        HapticFeedback.mediumImpact();
      }
    } catch (_) {
      await prefs.setBool('onboarding_notification_granted', true);
      if (mounted) {
        setState(() => _notificationGranted = true);
        HapticFeedback.mediumImpact();
      }
    }
  }

  Future<void> _requestBattery() async {
    HapticFeedback.selectionClick();
    final prefs = await SharedPreferences.getInstance();
    try {
      await _batteryService.openBatteryOptimizationSettings();
      await prefs.setBool('onboarding_battery_granted', true);
      if (mounted) {
        setState(() => _batteryExempt = true);
        HapticFeedback.mediumImpact();
      }
    } catch (_) {
      await prefs.setBool('onboarding_battery_granted', true);
      if (mounted) {
        setState(() => _batteryExempt = true);
        HapticFeedback.mediumImpact();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;

    return Column(
      key: const ValueKey('permission_priming_step'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top Colorful Medallion (Shadowless, Lighter Variant)
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF67E8F9), // Light Electric Cyan
                  Color(0xFF38BDF8), // Bright Sky Blue
                ],
              ),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Title & Subtitle
        Text(
          l10n?.onboardingPermissionsTitle ?? 'Seamless Setup',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l10n?.onboardingPermissionsSubtitle ??
              'Enable permissions for accurate solar calculations and timely Adhan notifications.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.textSecondary,
            fontSize: 13,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 18),

        // 1. Location Permission Card
        _buildPermissionCard(
          icon: Icons.location_on_rounded,
          gradientColors: const [Color(0xFF60A5FA), Color(0xFF3B82F6)],
          title: l10n?.onboardingPermLocationTitle ?? 'Precise Location',
          description: l10n?.onboardingPermLocationDesc ??
              'Used strictly on-device to compute solar prayer times for your coordinates.',
          isGranted: _locationGranted,
          onRequest: _requestLocation,
          colors: colors,
          l10n: l10n,
          testKey: 'perm_location_btn',
        ),

        const SizedBox(height: 10),

        // 2. Notification Permission Card
        _buildPermissionCard(
          icon: Icons.notifications_active_rounded,
          gradientColors: const [Color(0xFFFBBF24), Color(0xFFF59E0B)],
          title: l10n?.onboardingPermNotifTitle ?? 'Adhan & Prayer Alerts',
          description: l10n?.onboardingPermNotifDesc ??
              'Delivers gentle Adhan calls and Sunnah reminders right on time.',
          isGranted: _notificationGranted,
          onRequest: _requestNotification,
          colors: colors,
          l10n: l10n,
          testKey: 'perm_notif_btn',
        ),

        if (isAndroid) ...[
          const SizedBox(height: 10),
          // 3. Android Battery Optimization Exemption Card
          _buildPermissionCard(
            icon: Icons.battery_charging_full_rounded,
            gradientColors: const [Color(0xFF34D399), Color(0xFF10B981)],
            title: l10n?.onboardingPermBatteryTitle ?? 'Reliable Background Alarms',
            description: l10n?.onboardingPermBatteryDesc ??
                'Prevents Android battery optimization from canceling scheduled Fajr and midnight alarms.',
            isGranted: _batteryExempt,
            onRequest: _requestBattery,
            colors: colors,
            l10n: l10n,
            testKey: 'perm_battery_btn',
          ),
        ],
      ],
    );
  }

  Widget _buildPermissionCard({
    required IconData icon,
    required List<Color> gradientColors,
    required String title,
    required String description,
    required bool isGranted,
    required VoidCallback onRequest,
    required AppCustomColors colors,
    required AppLocalizations? l10n,
    required String testKey,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isGranted ? gradientColors.first : colors.divider,
          width: isGranted ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            key: ValueKey(testKey),
            onTap: isGranted ? null : onRequest,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isGranted ? colors.primarySoft : colors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isGranted) ...[
                    Icon(Icons.check_rounded, color: colors.primary, size: 14),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    isGranted
                        ? (l10n?.onboardingPermGranted ?? 'Granted')
                        : (l10n?.onboardingPermGrant ?? 'Grant'),
                    style: TextStyle(
                      color: isGranted ? colors.primary : colors.background,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
