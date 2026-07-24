import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../features/reflection/domain/models/daily_content.dart';

/// Data model representing prayer notification scheduling information.
class PrayerNotificationData {
  final String prayerName;
  final DateTime scheduledTime;
  final bool isEnabled;
  final int notificationId;

  const PrayerNotificationData({
    required this.prayerName,
    required this.scheduledTime,
    required this.isEnabled,
    required this.notificationId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrayerNotificationData &&
          runtimeType == other.runtimeType &&
          prayerName == other.prayerName &&
          scheduledTime == other.scheduledTime &&
          isEnabled == other.isEnabled &&
          notificationId == other.notificationId;

  @override
  int get hashCode =>
      prayerName.hashCode ^
      scheduledTime.hashCode ^
      isEnabled.hashCode ^
      notificationId.hashCode;
}

/// Service managing local notifications for daily prayer times and daily reflections.
class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  static const String adhanChannelId = 'adhan_channel';
  static const String adhanChannelName = 'Prayer Times & Adhan';
  static const String adhanChannelDesc = 'Notifications for daily prayer times';

  static const String reflectionChannelId = 'daily_reflection_channel';
  static const String reflectionChannelName = 'Daily Reflection';
  static const String reflectionChannelDesc = 'Daily Hadith and Ayah reflections';

  static const Map<String, int> defaultPrayerIds = {
    'Fajr': 101,
    'Sunrise': 102,
    'Dhuhr': 103,
    'Asr': 104,
    'Maghrib': 105,
    'Isha': 106,
  };

  NotificationService({
    FlutterLocalNotificationsPlugin? notificationsPlugin,
  }) : notificationsPlugin =
            notificationsPlugin ?? FlutterLocalNotificationsPlugin();

  /// Initializes timezone data and configures notification settings & channels.
  Future<void> initialize() async {
    tz.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await notificationsPlugin.initialize(settings: initSettings);

    final androidImpl = notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl != null) {
      await androidImpl.createNotificationChannel(
        const AndroidNotificationChannel(
          adhanChannelId,
          adhanChannelName,
          description: adhanChannelDesc,
          importance: Importance.max,
          sound: RawResourceAndroidNotificationSound('adhan'),
        ),
      );
      await androidImpl.createNotificationChannel(
        const AndroidNotificationChannel(
          reflectionChannelId,
          reflectionChannelName,
          description: reflectionChannelDesc,
          importance: Importance.high,
        ),
      );
    }
  }

  /// Truncates notification body text to [maxLength] characters at a clean word boundary.
  /// If [text] is longer than [maxLength], cuts at the last whitespace within [maxLength] limit
  /// and appends `"…"`. If no whitespace exists within limit, cuts at [maxLength] and appends `"…"`.
  static String truncateNotificationBody(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    final sub = text.substring(0, maxLength);
    final lastSpace = sub.lastIndexOf(RegExp(r'\s'));
    if (lastSpace > 0) {
      return '${sub.substring(0, lastSpace).trimRight()}…';
    }
    return '$sub…';
  }

  /// Formats notification payload for Hadith and Ayah items.
  static String formatNotificationPayload(DailyContentItem content) {
    return jsonEncode({
      'id': content.id,
      'type': content.type.name,
      'reference': content.reference,
    });
  }

  /// Parses notification payload back into a key-value Map.
  static Map<String, dynamic> parseNotificationPayload(String payload) {
    return jsonDecode(payload) as Map<String, dynamic>;
  }

  /// Helper to convert a Map of prayer names and scheduled times into [PrayerNotificationData] models.
  static List<PrayerNotificationData> buildPrayerNotificationModels({
    required Map<String, DateTime> prayerTimes,
    required Map<String, bool> enabledPrayers,
    Map<String, int>? customNotificationIds,
  }) {
    final list = <PrayerNotificationData>[];
    prayerTimes.forEach((prayerName, scheduledTime) {
      final isEnabled = enabledPrayers[prayerName] ??
          enabledPrayers[prayerName.toLowerCase()] ??
          enabledPrayers[prayerName.toUpperCase()] ??
          true;
      final id = (customNotificationIds != null &&
              customNotificationIds.containsKey(prayerName))
          ? customNotificationIds[prayerName]!
          : (defaultPrayerIds[prayerName] ?? prayerName.hashCode);

      list.add(PrayerNotificationData(
        prayerName: prayerName,
        scheduledTime: scheduledTime,
        isEnabled: isEnabled,
        notificationId: id,
      ));
    });
    return list;
  }

  /// Schedules exact alarms for all enabled daily prayers.
  Future<void> schedulePrayerNotifications({
    required Map<String, DateTime> prayerTimes,
    required Map<String, bool> enabledPrayers,
    Map<String, int>? customNotificationIds,
    DateTime? nowOverride,
  }) async {
    final now = nowOverride ?? DateTime.now();
    final models = buildPrayerNotificationModels(
      prayerTimes: prayerTimes,
      enabledPrayers: enabledPrayers,
      customNotificationIds: customNotificationIds,
    );

    for (final model in models) {
      if (!model.isEnabled) continue;
      if (!model.scheduledTime.isAfter(now)) continue;

      final tzScheduledDate = tz.TZDateTime.from(
        model.scheduledTime,
        tz.local,
      );

      const androidDetails = AndroidNotificationDetails(
        adhanChannelId,
        adhanChannelName,
        channelDescription: adhanChannelDesc,
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('adhan'),
      );
      const iosDetails = DarwinNotificationDetails();
      const notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await notificationsPlugin.zonedSchedule(
        id: model.notificationId,
        title: '${model.prayerName} Prayer',
        body: 'It is time for ${model.prayerName} prayer.',
        scheduledDate: tzScheduledDate,
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }

  /// Schedules an independent Daily Reflection notification (default 30 min post-Fajr).
  /// Content title = [content.reference], body = [content.translationText] truncated to 120 chars.
  Future<void> scheduleDailyReflectionNotification({
    required DailyContentItem content,
    required DateTime scheduledTime,
    bool enabled = true,
    int notificationId = 9999,
    DateTime? nowOverride,
  }) async {
    if (!enabled) {
      await notificationsPlugin.cancel(id: notificationId);
      return;
    }

    final now = nowOverride ?? DateTime.now();
    if (!scheduledTime.isAfter(now)) return;

    final tzScheduledDate = tz.TZDateTime.from(scheduledTime, tz.local);
    final truncatedBody = truncateNotificationBody(content.translationText, 120);
    final payload = formatNotificationPayload(content);

    const androidDetails = AndroidNotificationDetails(
      reflectionChannelId,
      reflectionChannelName,
      channelDescription: reflectionChannelDesc,
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await notificationsPlugin.zonedSchedule(
      id: notificationId,
      title: content.reference,
      body: truncatedBody,
      scheduledDate: tzScheduledDate,
      notificationDetails: notificationDetails,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
