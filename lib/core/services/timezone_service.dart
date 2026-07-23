/// Service for detecting device clock/timezone mismatch vs GPS location timezone.
class TimezoneService {
  /// Standard non-blocking warning message returned when device timezone differs from location.
  static const String timezoneMismatchWarning =
      "Using GPS location — device timezone differs";

  /// Compares the device's clock timezone offset against the location's expected timezone offset.
  ///
  /// [deviceTime]: Current DateTime on device (uses `deviceTime.timeZoneOffset`).
  /// [longitude]: Geographic longitude of location (estimates offset as `longitude / 15.0`).
  /// [locationOffset]: Optional explicit timezone offset for the location.
  ///
  /// Returns `"Using GPS location — device timezone differs"` if a mismatch (> 60 minutes) is detected.
  /// Returns `null` if device timezone matches location timezone within 1 hour.
  static String? getMismatchWarning({
    required DateTime deviceTime,
    double? longitude,
    Duration? locationOffset,
  }) {
    Duration targetOffset;
    if (locationOffset != null) {
      targetOffset = locationOffset;
    } else if (longitude != null) {
      final estimatedHours = (longitude / 15.0).round();
      targetOffset = Duration(hours: estimatedHours);
    } else {
      return null;
    }

    final deviceOffset = deviceTime.timeZoneOffset;
    final diffInMinutes =
        (deviceOffset.inMinutes - targetOffset.inMinutes).abs();

    if (diffInMinutes > 60) {
      return timezoneMismatchWarning;
    }

    return null;
  }

  /// Returns `true` if a timezone mismatch exists between the device and location.
  static bool isMismatched({
    required DateTime deviceTime,
    double? longitude,
    Duration? locationOffset,
  }) {
    return getMismatchWarning(
          deviceTime: deviceTime,
          longitude: longitude,
          locationOffset: locationOffset,
        ) !=
        null;
  }
}
