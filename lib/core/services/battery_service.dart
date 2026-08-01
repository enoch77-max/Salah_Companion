import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../database/app_database.dart';

/// Service for checking Android battery optimization status, persisting state,
/// managing prompts & cooldowns, and providing OEM-specific guidance.
class BatteryService {
  static const String channelName = 'com.salahcompanion/battery';
  static const MethodChannel defaultChannel = MethodChannel(channelName);

  final AppDatabase db;
  final MethodChannel channel;
  final TargetPlatform _platform;

  BatteryService({
    required this.db,
    this.channel = defaultChannel,
    TargetPlatform? platform,
  }) : _platform = platform ?? defaultTargetPlatform;

  /// Checks if the app is currently ignoring battery optimizations via platform channel.
  /// Returns true on non-Android platforms.
  Future<bool> isIgnoringBatteryOptimizations() async {
    if (_platform != TargetPlatform.android) {
      return true;
    }
    try {
      final result =
          await channel.invokeMethod<bool>('isIgnoringBatteryOptimizations');
      return result ?? false;
    } on MissingPluginException {
      return true;
    } on PlatformException {
      return false;
    }
  }

  /// Directs the device OS to open battery optimization exemption settings.
  Future<void> openBatteryOptimizationSettings() async {
    if (_platform != TargetPlatform.android) return;
    try {
      await channel.invokeMethod('openBatteryOptimizationSettings');
    } catch (_) {
      try {
        await channel.invokeMethod('requestIgnoreBatteryOptimizations');
      } catch (_) {}
    }
  }

  /// Gets the device hardware manufacturer name from platform channel.
  Future<String> getManufacturer() async {
    if (_platform != TargetPlatform.android) return 'Apple';
    try {
      final res = await channel.invokeMethod<String>('getManufacturer');
      return res ?? 'Generic Android';
    } catch (_) {
      return 'Generic Android';
    }
  }

  /// Fetches current battery optimization status from platform channel (on Android),
  /// updates [lastKnownExempt] in the database, and returns the result.
  Future<bool> checkBatteryOptimizationStatus() async {
    final isExempt = await isIgnoringBatteryOptimizations();
    final existing = await getBatteryState();

    if (existing == null) {
      await db.into(db.batteryOptStateTable).insert(
            BatteryOptStateTableCompanion.insert(
              id: const Value(1),
              lastKnownExempt: Value(isExempt),
            ),
          );
    } else {
      await (db.update(db.batteryOptStateTable)..where((t) => t.id.equals(1)))
          .write(
        BatteryOptStateTableCompanion(
          lastKnownExempt: Value(isExempt),
        ),
      );
    }

    return isExempt;
  }

  /// Retrieves the current persisted [BatteryOptStateTableData] row (id = 1).
  Future<BatteryOptStateTableData?> getBatteryState() async {
    return (db.select(db.batteryOptStateTable)..where((t) => t.id.equals(1)))
        .getSingleOrNull();
  }

  /// Determines whether the battery optimization prompt should be shown.
  ///
  /// Returns `true` if:
  /// - [isExempt] is `false`
  /// - [nagDisabled] is `false`
  /// - [lastPromptAt] is `null` OR `now - lastPromptAt >= 24 hours`
  Future<bool> shouldShowPrompt({DateTime? now}) async {
    final state = await getBatteryState();
    final isExempt = state?.lastKnownExempt ?? false;
    final nagDisabled = state?.nagDisabled ?? false;
    final lastPromptAt = state?.lastPromptAt;

    if (isExempt) return false;
    if (nagDisabled) return false;
    if (lastPromptAt == null) return true;

    final currentTime = now ?? DateTime.now();
    return currentTime.difference(lastPromptAt) >= const Duration(hours: 24);
  }

  /// Records that the battery optimization prompt was shown at [promptTime] (defaults to current time).
  Future<void> recordPromptShown([DateTime? promptTime]) async {
    final time = promptTime ?? DateTime.now();
    final existing = await getBatteryState();

    if (existing == null) {
      await db.into(db.batteryOptStateTable).insert(
            BatteryOptStateTableCompanion.insert(
              id: const Value(1),
              lastPromptAt: Value(time),
            ),
          );
    } else {
      await (db.update(db.batteryOptStateTable)..where((t) => t.id.equals(1)))
          .write(
        BatteryOptStateTableCompanion(
          lastPromptAt: Value(time),
        ),
      );
    }
  }

  /// Updates the [nagDisabled] flag in the database.
  Future<void> setNagDisabled(bool disabled) async {
    final existing = await getBatteryState();

    if (existing == null) {
      await db.into(db.batteryOptStateTable).insert(
            BatteryOptStateTableCompanion.insert(
              id: const Value(1),
              nagDisabled: Value(disabled),
            ),
          );
    } else {
      await (db.update(db.batteryOptStateTable)..where((t) => t.id.equals(1)))
          .write(
        BatteryOptStateTableCompanion(
          nagDisabled: Value(disabled),
        ),
      );
    }
  }

  /// Returns manufacturer-specific autostart & battery optimization steps for Samsung,
  /// Xiaomi/Redmi, Huawei, Oppo, Vivo, or default guidance for other OEMs.
  String getOemGuidance(String manufacturer) {
    final m = manufacturer.toLowerCase().trim();
    if (m.contains('samsung')) {
      return "Go to Settings > Apps > Salah Companion > Battery > Select 'Unrestricted'. Also check Settings > Battery and device care > Battery > Background usage limits.";
    } else if (m.contains('xiaomi') ||
        m.contains('redmi') ||
        m.contains('poco')) {
      return "Go to Settings > Apps > Manage apps > Salah Companion > Enable 'Autostart'. Set Battery saver to 'No restrictions'.";
    } else if (m.contains('huawei') || m.contains('honor')) {
      return "Go to Settings > Apps > Apps > Salah Companion > Power usage details > App launch > Set to 'Manage manually' and enable Auto-launch, Secondary launch, and Run in background.";
    } else if (m.contains('oppo') || m.contains('realme')) {
      return "Go to Settings > App management > Salah Companion > Allow auto-startup. Under Battery usage, enable 'Allow background activity'.";
    } else if (m.contains('vivo') || m.contains('iqoo')) {
      return "Go to Settings > Battery > High background power consumption > Enable Salah Companion. Also check App manager > Autostart.";
    } else {
      return "Go to Settings > Apps > Salah Companion > Battery > Select 'Unrestricted' or disable Battery Optimization.";
    }
  }
}
