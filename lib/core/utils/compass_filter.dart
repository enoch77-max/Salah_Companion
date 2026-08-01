/// Exponential Moving Average (EMA) Low-Pass Filter for Compass Headings.
///
/// Dampens high-frequency sensor noise, suppresses micro-jitter, handles
/// 360°/0° angular wrap-around seamlessly, and limits sudden spike anomalies.
class CompassFilter {
  final double alpha;
  final double minDeltaThreshold;
  final double maxStepLimit;

  double? _filteredHeading;

  /// Creates a compass filter with configurable smoothing parameters.
  ///
  /// [alpha]: Smoothing factor between 0.05 (heavy damping) and 0.30 (fast response). Default is 0.15.
  /// [minDeltaThreshold]: Minimum angular change in degrees to trigger update (suppresses hover jitter). Default 0.15°.
  /// [maxStepLimit]: Maximum degrees changed per update to prevent sudden magnetic distortion jumps. Default 25.0°.
  CompassFilter({
    this.alpha = 0.35,
    this.minDeltaThreshold = 0.10,
    this.maxStepLimit = 180.0,
  })  : assert(alpha > 0.0 && alpha <= 1.0, 'alpha must be between 0 and 1'),
        assert(minDeltaThreshold >= 0.0, 'minDeltaThreshold cannot be negative'),
        assert(maxStepLimit > 0.0, 'maxStepLimit must be positive');

  /// Returns the current smoothed heading, or null if no updates received yet.
  double? get currentHeading => _filteredHeading;

  /// Resets the filter to a specific initial heading.
  void reset([double? heading]) {
    _filteredHeading = heading != null ? normalizeAngle(heading) : null;
  }

  /// Processes a raw compass heading and returns the updated smoothed heading.
  double update(double rawHeading) {
    final normalizedRaw = normalizeAngle(rawHeading);

    if (_filteredHeading == null) {
      _filteredHeading = normalizedRaw;
      return normalizedRaw;
    }

    double delta = shortestAngularDelta(normalizedRaw, _filteredHeading!);

    // 1. Micro-jitter suppression
    if (delta.abs() < minDeltaThreshold) {
      return _filteredHeading!;
    }

    // 2. Outlier spike clamping
    if (delta.abs() > maxStepLimit) {
      delta = delta.sign * maxStepLimit;
    }

    // 3. Low-Pass Exponential Moving Average filter
    double updated = _filteredHeading! + alpha * delta;
    _filteredHeading = normalizeAngle(updated);

    return _filteredHeading!;
  }

  /// Calculates the shortest angular distance from [current] to [target].
  /// Result is in range [-180.0, 180.0].
  static double shortestAngularDelta(double target, double current) {
    double diff = (target - current) % 360.0;
    if (diff > 180.0) diff -= 360.0;
    if (diff < -180.0) diff += 360.0;
    return diff;
  }

  /// Normalizes any angle into range [0.0, 360.0).
  static double normalizeAngle(double angle) {
    return (angle % 360.0 + 360.0) % 360.0;
  }
}
