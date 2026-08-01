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

  static const String reflectionChannelId = 'daily_reflection_channel';
  static const String reflectionChannelName = 'Daily Reflection';
  static const String reflectionChannelDesc = 'Daily Hadith and Ayah reflections';

  /// Maps user-facing voice names to Android raw resource file names (without extension).
  static const Map<String, String> adhanVoiceResources = {
    'Makkah (Ali Mulla)': 'adhan_makkah',
    'Madinah (Abdul Majeed)': 'adhan_madinah',
    'Al-Aqsa (Yasser Al-Dossari)': 'adhan_alaqsa',
    'Traditional Soft Tone': 'adhan_egyptian',
  };

  /// Returns the notification channel ID for a given adhan voice.
  static String adhanChannelIdForVoice(String voiceName) {
    final resource = adhanVoiceResources[voiceName] ?? 'adhan_makkah';
    return 'adhan_channel_v2_$resource';
  }

  /// Returns the display name for a given adhan voice notification channel.
  static String adhanChannelNameForVoice(String voiceName) {
    return 'Prayer Adhan — $voiceName';
  }

  static const String adhanChannelDesc = 'Notifications for daily prayer times with adhan audio';

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
      // Create a separate notification channel for each adhan voice.
      // Android locks sound & audio attributes to the channel at creation time,
      // so we delete legacy v1 channels and register v2 channels with AudioAttributeUsage.alarm
      // to prevent Android OS from cutting off full adhan audio at 30 seconds.
      for (final entry in adhanVoiceResources.entries) {
        final resource = entry.value;
        await androidImpl.deleteNotificationChannel(channelId: 'adhan_channel_$resource');

        final channelId = adhanChannelIdForVoice(entry.key);
        final channelName = adhanChannelNameForVoice(entry.key);
        await androidImpl.createNotificationChannel(
          AndroidNotificationChannel(
            channelId,
            channelName,
            description: adhanChannelDesc,
            importance: Importance.max,
            sound: RawResourceAndroidNotificationSound(resource),
            audioAttributesUsage: AudioAttributesUsage.alarm,
          ),
        );
      }
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

  /// Requests exact alarm and notification permissions for Android & iOS.
  Future<bool> requestPermissions() async {
    final androidImpl = notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl != null) {
      await androidImpl.requestNotificationsPermission();
      await androidImpl.requestExactAlarmsPermission();
    }
    final iosImpl = notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    if (iosImpl != null) {
      await iosImpl.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    return true;
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

  /// Cancels any scheduled follow-up reminders (15m post and 30m pre-end urgent) for a specific prayer.
  Future<void> cancelPrayerReminders(String prayerName) async {
    final baseId = defaultPrayerIds[prayerName] ?? prayerName.hashCode;
    await notificationsPlugin.cancel(id: baseId + 1000);
    await notificationsPlugin.cancel(id: baseId + 2000);
  }

  /// Schedules exact alarms and multi-stage reminders for all enabled daily prayers.
  Future<void> schedulePrayerNotifications({
    required Map<String, DateTime> prayerTimes,
    required Map<String, bool> enabledPrayers,
    Map<String, DateTime>? endTimes,
    Map<String, int>? customNotificationIds,
    Set<String>? completedPrayers,
    DateTime? nowOverride,
    bool playAdhanSound = true,
    String adhanVoice = 'Makkah (Ali Mulla)',
  }) async {
    final now = nowOverride ?? DateTime.now();
    final models = buildPrayerNotificationModels(
      prayerTimes: prayerTimes,
      enabledPrayers: enabledPrayers,
      customNotificationIds: customNotificationIds,
    );

    // Resolve the correct channel and sound for the selected adhan voice.
    final resourceName = adhanVoiceResources[adhanVoice] ?? 'adhan_makkah';
    final channelId = adhanChannelIdForVoice(adhanVoice);
    final channelName = adhanChannelNameForVoice(adhanVoice);

    for (final model in models) {
      if (!model.isEnabled) continue;

      final isCompleted = completedPrayers?.contains(model.prayerName) ?? false;
      if (isCompleted) {
        await notificationsPlugin.cancel(id: model.notificationId + 1000);
        await notificationsPlugin.cancel(id: model.notificationId + 2000);
      }

      var targetTime = model.scheduledTime;
      if (!targetTime.isAfter(now)) {
        targetTime = targetTime.add(const Duration(days: 1));
      }

      // 1. Start Notification (T = 0)
      final tzScheduledDate = tz.TZDateTime.from(
        targetTime,
        tz.local,
      );

      final androidDetails = AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: adhanChannelDesc,
        importance: Importance.max,
        priority: Priority.high,
        sound: playAdhanSound ? RawResourceAndroidNotificationSound(resourceName) : null,
        playSound: playAdhanSound,
        audioAttributesUsage: AudioAttributesUsage.alarm,
      );
      const iosDetails = DarwinNotificationDetails();
      final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await notificationsPlugin.zonedSchedule(
        id: model.notificationId,
        title: '${model.prayerName} Prayer',
        body: SunnahReminders.getStartMessage(model.prayerName),
        scheduledDate: tzScheduledDate,
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );

      if (!isCompleted) {
        // 2. 15-Minute Post-Start Sunnah Reminder (T + 15m)
        final post15Time = model.scheduledTime.add(const Duration(minutes: 15));
        if (post15Time.isAfter(now)) {
          final tzPost15 = tz.TZDateTime.from(post15Time, tz.local);
          const androidDetails = AndroidNotificationDetails(
            reflectionChannelId,
            reflectionChannelName,
            channelDescription: reflectionChannelDesc,
            importance: Importance.high,
            priority: Priority.high,
          );
          const notificationDetails = NotificationDetails(
            android: androidDetails,
            iOS: DarwinNotificationDetails(),
          );

          final msg = SunnahReminders.post15MinReminders[model.prayerName] ??
              '15 minutes into ${model.prayerName} time. Have you prayed yet?';

          await notificationsPlugin.zonedSchedule(
            id: model.notificationId + 1000,
            title: 'Early Prayer Reminder — ${model.prayerName}',
            body: msg,
            scheduledDate: tzPost15,
            notificationDetails: notificationDetails,
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          );
        }

        // 3. 30-Minute Pre-End Expiration Warning (TEnd - 30m)
        if (endTimes != null && endTimes.containsKey(model.prayerName)) {
          final endTime = endTimes[model.prayerName]!;
          final pre30Time = endTime.subtract(const Duration(minutes: 30));
          if (pre30Time.isAfter(now)) {
            final tzPre30 = tz.TZDateTime.from(pre30Time, tz.local);
            const androidDetails = AndroidNotificationDetails(
              reflectionChannelId,
              reflectionChannelName,
              channelDescription: reflectionChannelDesc,
              importance: Importance.max,
              priority: Priority.high,
            );
            const notificationDetails = NotificationDetails(
              android: androidDetails,
              iOS: DarwinNotificationDetails(),
            );

            final msg = SunnahReminders.pre30MinReminders[model.prayerName] ??
                'Only 30 minutes left for ${model.prayerName} prayer. Have you prayed yet?';

            await notificationsPlugin.zonedSchedule(
              id: model.notificationId + 2000,
              title: 'Urgent — 30 Mins Left for ${model.prayerName}',
              body: msg,
              scheduledDate: tzPre30,
              notificationDetails: notificationDetails,
              androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            );
          }
        }
      }
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

    var targetTime = scheduledTime;
    final now = nowOverride ?? DateTime.now();
    if (!targetTime.isAfter(now)) {
      targetTime = targetTime.add(const Duration(days: 1));
    }

    final tzScheduledDate = tz.TZDateTime.from(targetTime, tz.local);
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

  /// Displays an immediate local notification to test audio, vibration, and system permissions.
  Future<void> showInstantTestNotification({
    String title = 'Salah Companion Alert',
    String body = 'Notifications and Adhan audio are configured properly.',
    String adhanVoice = 'Makkah (Ali Mulla)',
  }) async {
    final resourceName = adhanVoiceResources[adhanVoice] ?? 'adhan_makkah';
    final channelId = adhanChannelIdForVoice(adhanVoice);
    final channelName = adhanChannelNameForVoice(adhanVoice);

    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: adhanChannelDesc,
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound(resourceName),
      playSound: true,
      audioAttributesUsage: AudioAttributesUsage.alarm,
    );
    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );

    await notificationsPlugin.show(
      id: 8888,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
    );
  }
}

/// Sunnah-inspired notification reminders library with varied messages.
abstract final class SunnahReminders {
  static const startReminders = <String, List<String>>{
    'Fajr': [
      'Prayer is better than sleep. Rise and shine for Fajr prayer.',
      'The two Sunnah rakahs of Fajr are better than the world and all in it. (Sahih Muslim)',
      'Fajr time has started. Perform your prayer to start your day under Allah’s protection.',
    ],
    'Dhuhr': [
      'Dhuhr time has started. The Prophet ﷺ loved to pray when the gates of heaven open at midday.',
      'Take a peaceful break from your daily work for Dhuhr Salah.',
      'The most beloved deed to Allah is prayer at its proper time. (Sahih al-Bukhari)',
    ],
    'Asr': [
      'Asr time has started. Preserve the middle prayer (Salat al-Wusta).',
      'Whoever prays the two cool prayers (Fajr & Asr) will enter Paradise. (Sahih al-Bukhari)',
      'Hasten to Asr prayer for divine tranquility and immense reward.',
    ],
    'Maghrib': [
      'Maghrib time has started. Hasten to Maghrib prayer following the Sunnah of the Prophet ﷺ.',
      'The sun has set. Turn to Allah in Maghrib prayer with devotion.',
      'Maghrib prayer time is here. May Allah accept your worship.',
    ],
    'Isha': [
      'Isha time has started. Whoever prays Isha in congregation, it is as if he prayed half the night. (Sahih Muslim)',
      'End your day in peaceful remembrance of Allah with Isha prayer.',
      'Perform your Isha prayer and retire in peace under Allah’s care.',
    ],
  };

  static const post15MinReminders = <String, String>{
    'Fajr': '15 minutes into Fajr time. Have you prayed yet? The Prophet ﷺ emphasized praying at the earliest time.',
    'Dhuhr': '15 minutes into Dhuhr time. Take a moment to pray Dhuhr and refresh your soul.',
    'Asr': '15 minutes into Asr time. Do not delay Asr prayer; perform it with devotion.',
    'Maghrib': '15 minutes into Maghrib time. Maghrib time passes quickly—hasten to pray.',
    'Isha': '15 minutes into Isha time. Complete your Isha prayer to rest with tranquility.',
  };

  static const pre30MinReminders = <String, String>{
    'Fajr': 'Only 30 minutes left for Fajr prayer before Sunrise. Make Wudu and pray now!',
    'Dhuhr': 'Only 30 minutes left for Dhuhr prayer before Asr. Have you prayed yet?',
    'Asr': 'Only 30 minutes left for Asr prayer before Maghrib. Perform your prayer now!',
    'Maghrib': 'Only 30 minutes left for Maghrib prayer before Isha. Have you prayed yet?',
    'Isha': 'Only 30 minutes left for Isha prayer before midnight. Complete your prayer now!',
  };

  static String getStartMessage(String prayerName) {
    final list = startReminders[prayerName];
    if (list == null || list.isEmpty) {
      return 'It is time for $prayerName prayer.';
    }
    final index = DateTime.now().day % list.length;
    return list[index];
  }
}
