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
  static const String keyHijriDate = 'widget_hijri_date';

  static const String keyFajrTime = 'widget_fajr_time';
  static const String keyDhuhrTime = 'widget_dhuhr_time';
  static const String keyAsrTime = 'widget_asr_time';
  static const String keyMaghribTime = 'widget_maghrib_time';
  static const String keyIshaTime = 'widget_isha_time';

  static const String keyFajrMillis = 'widget_fajr_millis';
  static const String keyDhuhrMillis = 'widget_dhuhr_millis';
  static const String keyAsrMillis = 'widget_asr_millis';
  static const String keyMaghribMillis = 'widget_maghrib_millis';
  static const String keyIshaMillis = 'widget_isha_millis';

  static const String keyDuaTitle = 'widget_dua_title';
  static const String keyDuaArabic = 'widget_dua_arabic';
  static const String keyDuaTranslation = 'widget_dua_translation';

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
  /// Determines the next or active unprayed prayer from a map of prayer names to scheduled [DateTime].
  NextPrayerData determineNextPrayer(
    Map<String, DateTime> prayerTimes, {
    DateTime? now,
    DateTime? nextDayFajr,
    Map<String, String>? prayerLogs,
  }) {
    final reference = now ?? DateTime.now();

    final fajr = prayerTimes['Fajr'];
    final sunrise = prayerTimes['Sunrise'];
    final dhuhr = prayerTimes['Dhuhr'];
    final asr = prayerTimes['Asr'];
    final maghrib = prayerTimes['Maghrib'];
    final isha = prayerTimes['Isha'];

    if (prayerLogs != null) {
      bool isPrayed(String name) => prayerLogs[name] == 'prayed';

      // Rule: If an active prayer period is in progress and NOT YET PRAYED, keep it active on the widget
      if (fajr != null && sunrise != null && reference.isAfter(fajr) && reference.isBefore(sunrise) && !isPrayed('Fajr')) {
        return NextPrayerData(name: 'Fajr', time: fajr);
      }
      if (dhuhr != null && asr != null && reference.isAfter(dhuhr) && reference.isBefore(asr) && !isPrayed('Dhuhr')) {
        return NextPrayerData(name: 'Dhuhr', time: dhuhr);
      }
      if (asr != null && maghrib != null && reference.isAfter(asr) && reference.isBefore(maghrib) && !isPrayed('Asr')) {
        return NextPrayerData(name: 'Asr', time: asr);
      }
      if (maghrib != null && isha != null && reference.isAfter(maghrib) && reference.isBefore(isha) && !isPrayed('Maghrib')) {
        return NextPrayerData(name: 'Maghrib', time: maghrib);
      }
      if (isha != null && reference.isAfter(isha) && !isPrayed('Isha')) {
        return NextPrayerData(name: 'Isha', time: isha);
      }
    }

    final entries = prayerTimes.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    for (final entry in entries) {
      if (entry.key != 'Sunrise' && entry.value.isAfter(reference)) {
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

  /// Formats a [DateTime] into a 24-hour / 12-hour short time string (e.g., "12:15").
  String formatShortPrayerTime(DateTime time) {
    final rawHour = time.hour;
    final hour = rawHour == 0 ? 12 : (rawHour > 12 ? rawHour - 12 : rawHour);
    final minute = time.minute.toString().padLeft(2, '0');
    return '${hour.toString().padLeft(2, '0')}:$minute';
  }

  /// Updates all widget payloads in [SharedPreferences] and notifies native Android widgets.
  Future<void> updateWidgetData({
    required String nextPrayerName,
    required DateTime nextPrayerTime,
    String city = '',
    String hijriDate = '',
    Map<String, DateTime>? allPrayerTimes,
    String? duaTitle,
    String? duaArabic,
    String? duaTranslation,
  }) async {
    final formattedTime = formatPrayerTime(nextPrayerTime);
    final effectivePrefs = prefs ?? await SharedPreferences.getInstance();

    await effectivePrefs.setString(keyNextPrayerName, nextPrayerName);
    await effectivePrefs.setString(keyNextPrayerTime, formattedTime);
    await effectivePrefs.setString(keyCity, city);
    if (hijriDate.isNotEmpty) {
      await effectivePrefs.setString(keyHijriDate, hijriDate);
    }

    if (allPrayerTimes != null) {
      if (allPrayerTimes.containsKey('Fajr')) {
        await effectivePrefs.setString(keyFajrTime, formatShortPrayerTime(allPrayerTimes['Fajr']!));
        await effectivePrefs.setInt(keyFajrMillis, allPrayerTimes['Fajr']!.millisecondsSinceEpoch);
      }
      if (allPrayerTimes.containsKey('Dhuhr')) {
        await effectivePrefs.setString(keyDhuhrTime, formatShortPrayerTime(allPrayerTimes['Dhuhr']!));
        await effectivePrefs.setInt(keyDhuhrMillis, allPrayerTimes['Dhuhr']!.millisecondsSinceEpoch);
      }
      if (allPrayerTimes.containsKey('Asr')) {
        await effectivePrefs.setString(keyAsrTime, formatShortPrayerTime(allPrayerTimes['Asr']!));
        await effectivePrefs.setInt(keyAsrMillis, allPrayerTimes['Asr']!.millisecondsSinceEpoch);
      }
      if (allPrayerTimes.containsKey('Maghrib')) {
        await effectivePrefs.setString(keyMaghribTime, formatShortPrayerTime(allPrayerTimes['Maghrib']!));
        await effectivePrefs.setInt(keyMaghribMillis, allPrayerTimes['Maghrib']!.millisecondsSinceEpoch);
      }
      if (allPrayerTimes.containsKey('Isha')) {
        await effectivePrefs.setString(keyIshaTime, formatShortPrayerTime(allPrayerTimes['Isha']!));
        await effectivePrefs.setInt(keyIshaMillis, allPrayerTimes['Isha']!.millisecondsSinceEpoch);
      }
    }

    if (duaTitle != null) await effectivePrefs.setString(keyDuaTitle, duaTitle);
    if (duaArabic != null) await effectivePrefs.setString(keyDuaArabic, duaArabic);
    if (duaTranslation != null) await effectivePrefs.setString(keyDuaTranslation, duaTranslation);

    await notifyNativeWidget();
  }

  /// Calculates next prayer from [prayerTimes] map and updates widget payload.
  Future<void> updateFromPrayerTimes({
    required Map<String, DateTime> prayerTimes,
    DateTime? now,
    DateTime? nextDayFajr,
    Map<String, String>? prayerLogs,
    String city = '',
    String hijriDate = '',
  }) async {
    final nextPrayer = determineNextPrayer(
      prayerTimes,
      now: now,
      nextDayFajr: nextDayFajr,
      prayerLogs: prayerLogs,
    );
    await updateWidgetData(
      nextPrayerName: nextPrayer.name,
      nextPrayerTime: nextPrayer.time,
      city: city,
      hijriDate: hijriDate,
      allPrayerTimes: prayerTimes,
    );
  }

  /// Notifies native Android widget providers to trigger a refresh.
  Future<void> notifyNativeWidget() async {
    try {
      if (_isAndroid) {
        await _methodChannel?.invokeMethod('updateWidget');
      }
    } catch (_) {}
  }

  /// Checks if 1-tap widget pinning is supported (Android 8.0+ / API 26+).
  Future<void> notifyWidgetUpdate() async {
    try {
      if (_isAndroid) {
        await _methodChannel?.invokeMethod('updateWidget');
      }
    } catch (_) {}
  }

  Future<bool> isPinWidgetSupported() async {
    try {
      if (_isAndroid) {
        final res = await _methodChannel?.invokeMethod<bool>('isPinWidgetSupported');
        return res ?? false;
      }
    } catch (_) {}
    return false;
  }

  /// Triggers native Android widget pin prompt for [widgetType] ("small_salah", "full_schedule", "daily_dua").
  Future<bool> requestPinWidget(String widgetType) async {
    try {
      if (_isAndroid) {
        final res = await _methodChannel?.invokeMethod<bool>('requestPinWidget', {'widgetType': widgetType});
        return res ?? false;
      }
    } catch (_) {}
    return false;
  }

  /// Opens native OEM App Permission settings for widget shortcut permissions (Xiaomi/MIUI/Oppo/Vivo).
  Future<void> openWidgetPermissionSettings() async {
    try {
      if (_isAndroid) {
        await _methodChannel?.invokeMethod('openWidgetPermissionSettings');
      }
    } catch (_) {}
  }

  /// Minimizes app to Home Screen so user can long-press and add widget.
  Future<void> goToHomeScreen() async {
    try {
      if (_isAndroid) {
        await _methodChannel?.invokeMethod('goToHomeScreen');
      }
    } catch (_) {}
  }

  /// Returns exact number of active instances of [widgetType] on user's home screen.
  Future<int> getWidgetCount(String widgetType) async {
    try {
      if (_isAndroid) {
        final res = await _methodChannel?.invokeMethod<int>('getWidgetCount', {'widgetType': widgetType});
        if (res != null) return res;
      }
    } catch (_) {}
    final isPinned = await isWidgetPinned(widgetType);
    return isPinned ? 1 : 0;
  }

  /// Checks if [widgetType] was already pinned by the user directly from Android OS AppWidgetManager.
  Future<bool> isWidgetPinned(String widgetType) async {
    try {
      if (_isAndroid) {
        final res = await _methodChannel?.invokeMethod<bool>('isWidgetPinned', {'widgetType': widgetType});
        if (res != null) return res;
      }
    } catch (_) {}
    final effectivePrefs = prefs ?? await SharedPreferences.getInstance();
    return effectivePrefs.getBool('widget_pinned_$widgetType') ?? false;
  }
}
