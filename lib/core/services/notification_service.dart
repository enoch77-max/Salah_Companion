import 'dart:convert';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../features/reflection/domain/models/daily_content.dart';
import '../../l10n/generated/app_localizations.dart';

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

  static const String forbiddenChannelId = 'forbidden_times_channel';
  static const String forbiddenChannelName = 'Forbidden Nafl Times';
  static const String forbiddenChannelDesc =
      'Alerts when voluntary (Nafl) prayers are prohibited';

  static const int forbiddenSunriseNotificationId = 3001;
  static const int forbiddenZawalNotificationId = 3002;
  static const int forbiddenSunsetNotificationId = 3003;

  static const List<int> forbiddenNotificationIds = [
    forbiddenSunriseNotificationId,
    forbiddenZawalNotificationId,
    forbiddenSunsetNotificationId,
  ];

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

  static const String prayerStandardChannelId = 'prayer_standard_channel_v2';
  static const String prayerStandardChannelName = 'Prayer Notifications';
  static const String prayerStandardChannelDesc =
      'Notifications for daily prayer times with standard device notification sound';

  // Backwards-compatible aliases
  static const String prayerSilentChannelId = prayerStandardChannelId;
  static const String prayerSilentChannelName = prayerStandardChannelName;
  static const String prayerSilentChannelDesc = prayerStandardChannelDesc;

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

  /// Configures [tz.local] by matching the device's local timezone offset
  /// against available locations in [tz.timeZoneDatabase.locations].
  /// Ensures [tz.local] is never left as Etc/UTC on non-UTC devices.
  static void configureLocalTimeZone({DateTime? now}) {
    try {
      if (tz.timeZoneDatabase.locations.isEmpty) {
        tz.initializeTimeZones();
      }
      final current = now ?? DateTime.now();
      final offset = current.timeZoneOffset;

      if (offset == Duration.zero) {
        tz.setLocalLocation(tz.getLocation('Etc/UTC'));
        return;
      }

      tz.Location? fallbackMatch;
      for (final loc in tz.timeZoneDatabase.locations.values) {
        if (loc.currentTimeZone.offset == offset) {
          if (!loc.name.startsWith('Etc/')) {
            tz.setLocalLocation(loc);
            return;
          }
          fallbackMatch ??= loc;
        }
      }

      if (fallbackMatch != null) {
        tz.setLocalLocation(fallbackMatch);
      }
    } catch (_) {}
  }

  /// Initializes timezone data and configures notification settings & channels.
  Future<void> initialize() async {
    tz.initializeTimeZones();
    configureLocalTimeZone();

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
          prayerStandardChannelId,
          prayerStandardChannelName,
          description: prayerStandardChannelDesc,
          importance: Importance.high,
          playSound: true,
          enableVibration: true,
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
      await androidImpl.createNotificationChannel(
        const AndroidNotificationChannel(
          forbiddenChannelId,
          forbiddenChannelName,
          description: forbiddenChannelDesc,
          importance: Importance.max,
          enableLights: true,
          ledColor: Color(0xFFEF4444),
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

  /// Cancels all scheduled start alarms and follow-up reminders for all daily prayers.
  Future<void> cancelAllPrayerNotifications({
    Map<String, int>? customNotificationIds,
  }) async {
    for (final entry in defaultPrayerIds.entries) {
      final baseId = (customNotificationIds != null &&
              customNotificationIds.containsKey(entry.key))
          ? customNotificationIds[entry.key]!
          : entry.value;
      await notificationsPlugin.cancel(id: baseId);
      await notificationsPlugin.cancel(id: baseId + 1000);
      await notificationsPlugin.cancel(id: baseId + 2000);
    }
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
    AppLocalizations? localizations,
  }) async {
    final now = nowOverride ?? DateTime.now();
    if (tz.local.name == 'Etc/UTC' && DateTime.now().timeZoneOffset != Duration.zero) {
      configureLocalTimeZone();
    }
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
      if (!model.isEnabled) {
        await notificationsPlugin.cancel(id: model.notificationId);
        await notificationsPlugin.cancel(id: model.notificationId + 1000);
        await notificationsPlugin.cancel(id: model.notificationId + 2000);
        continue;
      }

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

      // Cancel previous start alarm before rescheduling
      await notificationsPlugin.cancel(id: model.notificationId);

      final effectiveChannelId =
          playAdhanSound ? channelId : prayerStandardChannelId;
      final effectiveChannelName =
          playAdhanSound ? channelName : prayerStandardChannelName;
      final effectiveChannelDesc =
          playAdhanSound ? adhanChannelDesc : prayerStandardChannelDesc;

      final androidDetails = AndroidNotificationDetails(
        effectiveChannelId,
        effectiveChannelName,
        channelDescription: effectiveChannelDesc,
        importance: playAdhanSound ? Importance.max : Importance.high,
        priority: Priority.high,
        sound: playAdhanSound
            ? RawResourceAndroidNotificationSound(resourceName)
            : null,
        playSound: true,
        audioAttributesUsage:
            playAdhanSound ? AudioAttributesUsage.alarm : AudioAttributesUsage.notification,
      );
      final iosDetails = const DarwinNotificationDetails(
        presentSound: true,
      );
      final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      final startTitle = localizations?.notificationPrayerTitle(model.prayerName) ??
          '${model.prayerName} Prayer';
      final startBody = localizations?.notificationPrayerStartBody(model.prayerName) ??
          SunnahReminders.getStartMessage(model.prayerName);

      await _safeZonedSchedule(
        id: model.notificationId,
        title: startTitle,
        body: startBody,
        scheduledDate: tzScheduledDate,
        notificationDetails: notificationDetails,
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

          final msg = localizations?.notificationEarlyReminderBody(model.prayerName) ??
              (SunnahReminders.post15MinReminders[model.prayerName] ??
                  '15 minutes into ${model.prayerName} time. Have you prayed yet?');
          final earlyTitle = localizations?.notificationEarlyReminderTitle(model.prayerName) ??
              'Early Prayer Reminder — ${model.prayerName}';

          await _safeZonedSchedule(
            id: model.notificationId + 1000,
            title: earlyTitle,
            body: msg,
            scheduledDate: tzPost15,
            notificationDetails: notificationDetails,
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

            final msg = localizations?.notificationUrgentWarningBody(model.prayerName) ??
                (SunnahReminders.pre30MinReminders[model.prayerName] ??
                    'Only 30 minutes left for ${model.prayerName} prayer. Have you prayed yet?');
            final urgentTitle = localizations?.notificationUrgentWarningTitle(model.prayerName) ??
                'Urgent — 30 Mins Left for ${model.prayerName}';

            await _safeZonedSchedule(
              id: model.notificationId + 2000,
              title: urgentTitle,
              body: msg,
              scheduledDate: tzPre30,
              notificationDetails: notificationDetails,
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
    if (tz.local.name == 'Etc/UTC' && DateTime.now().timeZoneOffset != Duration.zero) {
      configureLocalTimeZone();
    }
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

    await _safeZonedSchedule(
      id: notificationId,
      title: content.reference,
      body: truncatedBody,
      scheduledDate: tzScheduledDate,
      notificationDetails: notificationDetails,
      payload: payload,
    );
  }

  /// Formats time in 12-hour AM/PM format (e.g., "05:45 AM").
  static String _formatTime(DateTime dt) {
    final hour = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
    final minute = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:$minute $ampm';
  }

  /// Cancels all scheduled forbidden times notifications.
  Future<void> cancelForbiddenTimesNotifications() async {
    for (final id in forbiddenNotificationIds) {
      try {
        await notificationsPlugin.cancel(id: id);
      } catch (_) {}
    }
  }

  /// Schedules local notifications for the 3 daily forbidden (Makruh/Haram) voluntary prayer windows:
  /// 1. Sunrise (Shuruq): from [sunrise] to [sunrise] + 20 minutes
  /// 2. Solar Zenith (Zawal): from [dhuhr] - 10 minutes to [dhuhr]
  /// 3. Sunset (Pre-Maghrib): from [maghrib] - 20 minutes to [maghrib]
  ///
  /// Features live glowing warning attributes (max importance heads-up alert, red accent LED and badge `#EF4444`)
  /// and native Android [timeoutAfter] auto-dismissal configured to the remaining window duration
  /// so the OS automatically dismisses the notification once the forbidden time has passed.
  Future<void> scheduleForbiddenTimesNotifications({
    required DateTime sunrise,
    required DateTime dhuhr,
    required DateTime maghrib,
    bool enabled = true,
    DateTime? nowOverride,
    AppLocalizations? localizations,
  }) async {
    await cancelForbiddenTimesNotifications();

    if (!enabled) return;

    final now = nowOverride ?? DateTime.now();
    if (tz.local.name == 'Etc/UTC' && DateTime.now().timeZoneOffset != Duration.zero) {
      configureLocalTimeZone();
    }

    final sunriseStart = sunrise;
    final sunriseEnd = sunrise.add(const Duration(minutes: 20));

    final zawalStart = dhuhr.subtract(const Duration(minutes: 10));
    final zawalEnd = dhuhr;

    final sunsetStart = maghrib.subtract(const Duration(minutes: 20));
    final sunsetEnd = maghrib;

    final windows = [
      (
        id: forbiddenSunriseNotificationId,
        start: sunriseStart,
        end: sunriseEnd,
        title: localizations?.forbiddenNaflSunriseHeader ??
            'FORBIDDEN NAFL TIME • SUNRISE',
        generateBody: (DateTime s, DateTime e) =>
            localizations?.forbiddenNaflSunriseBody(
              _formatTime(s),
              _formatTime(e),
            ) ??
            'Sun is rising (${_formatTime(s)} – ${_formatTime(e)}). Voluntary (Nafl) prayers are prohibited until the sun is fully risen. (Sahih Muslim 831)',
      ),
      (
        id: forbiddenZawalNotificationId,
        start: zawalStart,
        end: zawalEnd,
        title: localizations?.forbiddenNaflZawalHeader ??
            'FORBIDDEN NAFL TIME • ZENITH (ZAWAL)',
        generateBody: (DateTime s, DateTime e) =>
            localizations?.forbiddenNaflZawalBody(
              _formatTime(s),
              _formatTime(e),
            ) ??
            'Sun is at its zenith (${_formatTime(s)} – ${_formatTime(e)}). Nafl prayers are prohibited during this midday peak. (Sahih Muslim 831)',
      ),
      (
        id: forbiddenSunsetNotificationId,
        start: sunsetStart,
        end: sunsetEnd,
        title: localizations?.forbiddenNaflSunsetHeader ??
            'FORBIDDEN NAFL TIME • SUNSET',
        generateBody: (DateTime s, DateTime e) =>
            localizations?.forbiddenNaflSunsetBody(
              _formatTime(s),
              _formatTime(e),
            ) ??
            'Sun is setting (${_formatTime(s)} – ${_formatTime(e)}). Nafl prayers are prohibited until sunset is complete. (Sahih Muslim 831)',
      ),
    ];

    for (final window in windows) {
      var targetStart = window.start;
      var targetEnd = window.end;

      if (!targetEnd.isAfter(now)) {
        // Forbidden window has passed today; schedule for tomorrow
        targetStart = targetStart.add(const Duration(days: 1));
        targetEnd = targetEnd.add(const Duration(days: 1));
      }

      final body = window.generateBody(targetStart, targetEnd);

      if (!now.isBefore(targetStart) && now.isBefore(targetEnd)) {
        // Currently inside the forbidden window: display immediate notification
        // with timeoutAfter matching the remaining window duration.
        final remainingMs = targetEnd.difference(now).inMilliseconds;
        if (remainingMs > 0) {
          final androidDetails = AndroidNotificationDetails(
            forbiddenChannelId,
            forbiddenChannelName,
            channelDescription: forbiddenChannelDesc,
            importance: Importance.max,
            priority: Priority.high,
            visibility: NotificationVisibility.public,
            enableLights: true,
            ledColor: const Color(0xFFEF4444),
            color: const Color(0xFFEF4444),
            timeoutAfter: remainingMs,
          );
          const iosDetails = DarwinNotificationDetails();
          final notificationDetails = NotificationDetails(
            android: androidDetails,
            iOS: iosDetails,
          );

          try {
            await notificationsPlugin.show(
              id: window.id,
              title: window.title,
              body: body,
              notificationDetails: notificationDetails,
            );
          } catch (_) {}
        }
      } else if (targetStart.isAfter(now)) {
        // Future forbidden window: schedule exact alarm with timeoutAfter set to full window duration.
        final timeoutAfterMs = targetEnd.difference(targetStart).inMilliseconds;
        final tzScheduledDate = tz.TZDateTime.from(targetStart, tz.local);

        final androidDetails = AndroidNotificationDetails(
          forbiddenChannelId,
          forbiddenChannelName,
          channelDescription: forbiddenChannelDesc,
          importance: Importance.max,
          priority: Priority.high,
          visibility: NotificationVisibility.public,
          enableLights: true,
          ledColor: const Color(0xFFEF4444),
          color: const Color(0xFFEF4444),
          timeoutAfter: timeoutAfterMs,
        );
        const iosDetails = DarwinNotificationDetails();
        final notificationDetails = NotificationDetails(
          android: androidDetails,
          iOS: iosDetails,
        );

        await _safeZonedSchedule(
          id: window.id,
          title: window.title,
          body: body,
          scheduledDate: tzScheduledDate,
          notificationDetails: notificationDetails,
        );
      }
    }
  }

  /// Helper to safely schedule notifications with exact alarm permissions,
  /// falling back gracefully to inexact alarms when exact alarms are restricted or battery saver is active.
  Future<void> _safeZonedSchedule({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    required NotificationDetails notificationDetails,
    String? payload,
  }) async {
    try {
      await notificationsPlugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: notificationDetails,
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (_) {
      try {
        await notificationsPlugin.zonedSchedule(
          id: id,
          title: title,
          body: body,
          scheduledDate: scheduledDate,
          notificationDetails: notificationDetails,
          payload: payload,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        );
      } catch (_) {}
    }
  }

  /// Displays an immediate local notification to test audio, vibration, and system permissions.
  Future<void> showInstantTestNotification({
    String title = 'Salah Companion Alert',
    String body = 'Notifications and Adhan audio are configured properly.',
    String adhanVoice = 'Makkah (Ali Mulla)',
    bool playAdhanSound = true,
  }) async {
    final resourceName = adhanVoiceResources[adhanVoice] ?? 'adhan_makkah';
    final channelId = adhanChannelIdForVoice(adhanVoice);
    final channelName = adhanChannelNameForVoice(adhanVoice);

    final effectiveChannelId =
        playAdhanSound ? channelId : prayerStandardChannelId;
    final effectiveChannelName =
        playAdhanSound ? channelName : prayerStandardChannelName;
    final effectiveChannelDesc =
        playAdhanSound ? adhanChannelDesc : prayerStandardChannelDesc;

    final androidDetails = AndroidNotificationDetails(
      effectiveChannelId,
      effectiveChannelName,
      channelDescription: effectiveChannelDesc,
      importance: playAdhanSound ? Importance.max : Importance.high,
      priority: Priority.high,
      sound: playAdhanSound
          ? RawResourceAndroidNotificationSound(resourceName)
          : null,
      playSound: true,
      audioAttributesUsage:
          playAdhanSound ? AudioAttributesUsage.alarm : AudioAttributesUsage.notification,
    );
    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(
        presentSound: true,
      ),
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
