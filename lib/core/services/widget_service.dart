import 'dart:io';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Representation of next prayer calculation result.
class NextPrayerData {
  final String name;
  final DateTime time;

  const NextPrayerData({
    required this.name,
    required this.time,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NextPrayerData &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          time == other.time;

  @override
  int get hashCode => name.hashCode ^ time.hashCode;
}

/// Service responsible for calculating next prayer data, persisting to
/// [SharedPreferences] (FlutterSharedPreferences), and notifying the native
/// Android widget provider.
class WidgetService {
  static const String keyNextPrayerName = 'widget_next_prayer_name';
  static const String keyNextPrayerTime = 'widget_next_prayer_time';
  static const String keyCity = 'widget_city';

  static const MethodChannel _channel =
      MethodChannel('com.salahcompanion/widget');

  final SharedPreferences? prefs;
  final MethodChannel? _methodChannel;
  final bool? _isAndroidOverride;

  WidgetService({
    this.prefs,
    MethodChannel? channel,
    bool? isAndroid,
  })  : _methodChannel = channel ?? _channel,
        _isAndroidOverride = isAndroid;

  bool get _isAndroid {
    if (_isAndroidOverride != null) {
      return _isAndroidOverride;
    }
    try {
      return Platform.isAndroid;
    } catch (_) {
      return false;
    }
  }

  /// Determines the next prayer from a map of prayer names to scheduled [DateTime].
  ///
  /// Evaluates entries in chronological order. If all prayers for the given day
  /// have passed, it returns next day's Fajr if provided in [nextDayFajr], or
  /// adds 1 day to today's Fajr as fallback.
  NextPrayerData determineNextPrayer(
    Map<String, DateTime> prayerTimes, {
    DateTime? now,
    DateTime? nextDayFajr,
  }) {
    final reference = now ?? DateTime.now();

    final entries = prayerTimes.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    for (final entry in entries) {
      if (entry.value.isAfter(reference)) {
        return NextPrayerData(name: entry.key, time: entry.value);
      }
    }

    if (nextDayFajr != null) {
      return NextPrayerData(name: 'Fajr', time: nextDayFajr);
    }

    if (entries.isNotEmpty) {
      final fajrEntry = entries.firstWhere(
        (e) => e.key == 'Fajr',
        orElse: () => entries.first,
      );
      return NextPrayerData(
        name: fajrEntry.key,
        time: fajrEntry.value.add(const Duration(days: 1)),
      );
    }

    return NextPrayerData(name: 'Fajr', time: reference);
  }

  /// Formats a [DateTime] into a 12-hour formatted string (e.g., "06:45 PM").
  String formatPrayerTime(DateTime time) {
    final rawHour = time.hour;
    final hour = rawHour == 0 ? 12 : (rawHour > 12 ? rawHour - 12 : rawHour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = rawHour >= 12 ? 'PM' : 'AM';
    final formattedHour = hour.toString().padLeft(2, '0');
    return '$formattedHour:$minute $period';
  }

  /// Updates widget payload in [SharedPreferences] and notifies native Android widget.
  Future<void> updateWidgetData({
    required String nextPrayerName,
    required DateTime nextPrayerTime,
    String city = '',
  }) async {
    final formattedTime = formatPrayerTime(nextPrayerTime);
    final effectivePrefs = prefs ?? await SharedPreferences.getInstance();

    await effectivePrefs.setString(keyNextPrayerName, nextPrayerName);
    await effectivePrefs.setString(keyNextPrayerTime, formattedTime);
    await effectivePrefs.setString(keyCity, city);

    await notifyNativeWidget();
  }

  /// Calculates next prayer from [prayerTimes] map and updates widget payload.
  Future<void> updateFromPrayerTimes({
    required Map<String, DateTime> prayerTimes,
    DateTime? now,
    DateTime? nextDayFajr,
    String city = '',
  }) async {
    final nextPrayer = determineNextPrayer(
      prayerTimes,
      now: now,
      nextDayFajr: nextDayFajr,
    );
    await updateWidgetData(
      nextPrayerName: nextPrayer.name,
      nextPrayerTime: nextPrayer.time,
      city: city,
    );
  }

  /// Notifies the native Android widget provider to trigger a refresh.
  Future<void> notifyNativeWidget() async {
    try {
      if (_isAndroid) {
        await _methodChannel?.invokeMethod('updateWidget');
      }
    } catch (_) {
      // Safe fallback when method channel is missing or running in unit tests
    }
  }
}
