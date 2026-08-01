import 'package:flutter/services.dart';

/// Service managing native display refresh rate capabilities (unlocking 90Hz, 120Hz, 144Hz, 165Hz).
class DisplayService {
  static const MethodChannel _channel = MethodChannel('com.salahcompanion/display');

  static final DisplayService _instance = DisplayService._internal();
  factory DisplayService() => _instance;
  DisplayService._internal();

  /// Requests the native OS to set the window display mode to maximum supported refresh rate.
  Future<void> enableHighRefreshRate() async {
    try {
      await _channel.invokeMethod('enableHighRefreshRate');
    } catch (_) {
      // Ignored on non-Android platforms or unsupported SDKs
    }
  }

  /// Returns current display refresh rate in Hz (e.g. 60.0, 90.0, 120.0, 144.0, 165.0).
  Future<double> getRefreshRate() async {
    try {
      final rate = await _channel.invokeMethod<double>('getRefreshRate');
      return rate ?? 60.0;
    } catch (_) {
      return 60.0;
    }
  }
}
