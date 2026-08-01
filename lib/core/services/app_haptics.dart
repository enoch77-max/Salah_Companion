import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

/// Centralized service for triggering tactile haptic feedback.
/// Uses the `vibration` package for reliable cross-device vibration
/// (Flutter's built-in HapticFeedback is imperceptible on many Android OEMs).
///
/// Ensures consistent, crisp vibration pulses for:
/// 1. Prayer Status Updates
/// 2. Tasbih Counter Clicks & Target Completions
/// 3. Qibla Compass ticks & Alignment
class AppHaptics {
  static bool _isEnabled = true;
  static bool _hasVibrator = false;
  static bool _hasAmplitudeControl = false;

  static Future<void> init([SharedPreferences? prefs]) async {
    try {
      final p = prefs ?? await SharedPreferences.getInstance();
      _isEnabled = p.getBool('haptic_feedback_enabled') ?? true;
      _hasVibrator = await Vibration.hasVibrator();
      _hasAmplitudeControl = await Vibration.hasAmplitudeControl();
    } catch (_) {
      _isEnabled = true;
      _hasVibrator = false;
    }
  }

  static bool get isEnabled => _isEnabled;

  static void setEnabled(bool value) {
    _isEnabled = value;
  }

  /// Low-level vibrate helper. Falls back to Flutter's HapticFeedback if
  /// the vibration plugin reports no vibrator hardware.
  static Future<void> _vibrate({
    required int duration,
    int amplitude = -1,
  }) async {
    if (!_isEnabled) return;
    try {
      if (_hasVibrator) {
        if (_hasAmplitudeControl && amplitude > 0) {
          await Vibration.vibrate(duration: duration, amplitude: amplitude);
        } else {
          await Vibration.vibrate(duration: duration);
        }
      } else {
        // Fallback for devices where vibration plugin can't detect hardware
        await HapticFeedback.mediumImpact();
      }
    } catch (_) {}
  }

  /// Vibrate with a pattern. Each pair in [pattern] is [pause, vibrate] in ms.
  static Future<void> _vibratePattern(List<int> pattern, {int amplitude = -1}) async {
    if (!_isEnabled) return;
    try {
      if (_hasVibrator) {
        await Vibration.vibrate(pattern: pattern, intensities: List.filled(pattern.length, amplitude > 0 ? amplitude : 128));
      } else {
        await HapticFeedback.heavyImpact();
      }
    } catch (_) {}
  }

  // ─── Public API ───────────────────────────────────────────────────

  /// Trigger crisp, ultra-subtle haptic feedback for general button taps
  static Future<void> light() async {
    await _vibrate(duration: 12, amplitude: 35);
  }

  /// Selection feedback — delicate, tactile micro-click
  static Future<void> selection() async {
    await _vibrate(duration: 10, amplitude: 25);
  }

  /// Medium feedback — smooth tactile pulse
  static Future<void> medium() async {
    await _vibrate(duration: 20, amplitude: 65);
  }

  /// Heavy feedback — gentle emphasis pulse without harsh buzzing
  static Future<void> heavy() async {
    await _vibrate(duration: 30, amplitude: 100);
  }

  /// Tactile feedback for prayer status toggle (Pending -> Prayed / Missed)
  /// Ultra-smooth double-click pulse for an enhanced, refined Apple-like feel.
  static Future<void> prayerStatusChanged() async {
    await _vibratePattern([0, 14, 25, 14], amplitude: 55);
  }

  /// Tactile feedback for every Tasbih bead tap — crisp, smooth micro-click
  static Future<void> tasbihClick() async {
    await _vibrate(duration: 14, amplitude: 45);
  }

  /// Tactile feedback when Tasbih target (33 / 100) is reached
  /// Refined triple-pulse celebration pattern
  static Future<void> tasbihTargetReached() async {
    await _vibratePattern([0, 18, 30, 18, 30, 20], amplitude: 85);
  }

  /// Tactile feedback for compass rotation movement — ultra-light tick
  static Future<void> compassTick() async {
    await _vibrate(duration: 8, amplitude: 20);
  }

  /// Tactile vibration when Qibla compass aligns with Kaaba
  /// Smooth double-buzz confirmation
  static Future<void> compassAligned() async {
    await _vibratePattern([0, 22, 35, 22], amplitude: 90);
  }
}
