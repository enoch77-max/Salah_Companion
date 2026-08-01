import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/services/battery_service.dart';
import '../sheets/battery_optimization_sheet.dart';

/// Lifecycle observer widget listening for app resume events on Android,
/// checking battery optimization status, and displaying [BatteryOptimizationSheet] when needed.
class BatteryProtectionListener extends StatefulWidget {
  final Widget child;
  final BatteryService? batteryService;
  final String? manufacturer;
  final TargetPlatform? platform;
  final VoidCallback? onRequestExemption;
  final bool checkOnInit;

  const BatteryProtectionListener({
    super.key,
    required this.child,
    this.batteryService,
    this.manufacturer,
    this.platform,
    this.onRequestExemption,
    this.checkOnInit = false,
  });

  @override
  State<BatteryProtectionListener> createState() => _BatteryProtectionListenerState();
}

class _BatteryProtectionListenerState extends State<BatteryProtectionListener>
    with WidgetsBindingObserver {
  bool _isShowingPrompt = false;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.checkOnInit) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkAndShowPrompt();
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAndShowPrompt();
    }
  }

  Future<void> _checkAndShowPrompt() async {
    final currentPlatform = widget.platform ?? defaultTargetPlatform;
    if (currentPlatform != TargetPlatform.android) {
      return;
    }

    if (_isShowingPrompt || _isChecking) {
      return;
    }

    _isChecking = true;
    try {
      final service = widget.batteryService ?? BatteryService(db: AppDatabase.instance());
      await service.checkBatteryOptimizationStatus();
      final shouldShow = await service.shouldShowPrompt();

      if (shouldShow && mounted && !_isShowingPrompt) {
        _isShowingPrompt = true;
        await BatteryOptimizationSheet.show(
          context,
          manufacturer: widget.manufacturer,
          batteryService: service,
          onFixPressed: () async {
            if (widget.onRequestExemption != null) {
              widget.onRequestExemption!();
            } else {
              await service.openBatteryOptimizationSettings();
            }
          },
          onRemindLaterPressed: () async {
            await service.recordPromptShown();
          },
          onDontAskAgainPressed: () async {
            await service.setNagDisabled(true);
          },
        );
        _isShowingPrompt = false;
      }
    } finally {
      _isChecking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
