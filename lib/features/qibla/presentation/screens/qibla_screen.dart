import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/app_haptics.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/utils/compass_filter.dart';
import '../../../../core/utils/geomagnetic_calculator.dart';
import '../../../home/domain/prayer_times_calculator.dart';

/// Qibla Compass Screen providing real-time high-precision compass direction
/// towards the Kaaba in Makkah with automatic True North declination correction,
/// Exponential Moving Average (EMA) smoothing, sensor accuracy warnings, and visual alignment indicators.
class QiblaScreen extends StatefulWidget {
  final LocationService? locationService;
  final PrayerTimesCalculator? calculator;
  final Stream<CompassEvent>? compassEvents;
  final LocationData? initialLocation;
  final double? initialQiblaBearing;
  final bool isActive;

  const QiblaScreen({
    super.key,
    this.locationService,
    this.calculator,
    this.compassEvents,
    this.initialLocation,
    this.initialQiblaBearing,
    this.isActive = true,
  });

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  static const _kaabaLat = 21.422487;
  static const _kaabaLng = 39.826206;

  late final LocationService _locationService;
  late final PrayerTimesCalculator _calculator;
  late final CompassFilter _compassFilter;

  LocationData? _locationData;
  double? _qiblaBearing;
  double? _distanceToMakkahKm;
  double? _magneticDeclination;
  double? _trueHeading;
  bool _isLoadingLocation = true;
  String? _locationError;

  CompassEvent? _lastCompassEvent;
  StreamSubscription<CompassEvent>? _compassSubscription;

  late AnimationController _headingController;
  late CurvedAnimation _curvedAnimation;
  double _startHeading = 0.0;
  double _targetHeading = 0.0;
  bool _wasAligned = false;
  int _lastHapticTickMs = 0;

  double? get _currentHeading => _trueHeading ?? _lastCompassEvent?.heading;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _locationService = widget.locationService ?? LocationService();
    _calculator = widget.calculator ?? const PrayerTimesCalculator();
    _compassFilter = CompassFilter(
      alpha: 0.35,
      minDeltaThreshold: 0.10,
      maxStepLimit: 180.0,
    );

    _headingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _curvedAnimation = CurvedAnimation(
      parent: _headingController,
      curve: Curves.easeOutCubic,
    );

    if (widget.initialLocation != null) {
      _applyLocationData(widget.initialLocation!, initialQiblaBearing: widget.initialQiblaBearing);
    } else {
      _fetchLocation();
    }

    if (widget.isActive) {
      _startCompassStream();
    }
  }

  @override
  void didUpdateWidget(QiblaScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _startCompassStream();
      } else {
        _stopCompassStream();
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (widget.isActive) {
        _startCompassStream();
      }
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.detached) {
      _stopCompassStream();
    }
  }

  void _applyLocationData(LocationData loc, {double? initialQiblaBearing}) {
    final bearing = initialQiblaBearing ??
        _calculator.calculateQiblaBearing(
          Coordinates(loc.latitude, loc.longitude),
        );
    final distance = Geolocator.distanceBetween(
          loc.latitude,
          loc.longitude,
          _kaabaLat,
          _kaabaLng,
        ) /
        1000.0;
    final declination = GeomagneticCalculator.calculateDeclination(
      latitude: loc.latitude,
      longitude: loc.longitude,
    );

    setState(() {
      _locationData = loc;
      _qiblaBearing = bearing;
      _distanceToMakkahKm = distance;
      _magneticDeclination = declination;
      _isLoadingLocation = false;
      _locationError = null;
    });
  }

  Future<void> _fetchLocation() async {
    // 1. Instant Cached Location Check (0ms startup, zero delay, works offline)
    final cached = LocationService.savedLocation ?? await _locationService.getCachedLocation();

    if (cached != null && mounted) {
      _applyLocationData(cached);
    }

    // 2. Fetch fresh position in background without blocking UI
    try {
      final loc = await _locationService.getCurrentLocation();
      if (!mounted) return;
      _applyLocationData(loc);
    } catch (e) {
      if (!mounted) return;
      if (_locationData != null) {
        setState(() {
          _isLoadingLocation = false;
        });
        return;
      }
      setState(() {
        _locationError = e.toString().replaceAll('LocationException: ', '');
        _isLoadingLocation = false;
      });
    }
  }

  void _startCompassStream() {
    if (_compassSubscription != null) return;
    final stream = widget.compassEvents ?? FlutterCompass.events;
    if (stream != null) {
      _compassSubscription = stream.listen(_onCompassEvent);
    }
  }

  void _stopCompassStream() {
    _compassSubscription?.cancel();
    _compassSubscription = null;
  }

  void _onCompassEvent(CompassEvent event) {
    if (!mounted || !widget.isActive) return;

    final rawHeading = event.heading;

    if (rawHeading == null) {
      if (_lastCompassEvent != null || _trueHeading != null) {
        setState(() {
          _lastCompassEvent = event;
          _trueHeading = null;
        });
      }
      return;
    }

    // 1. Fast, responsive EMA Low-Pass Filter without artificial step clamping
    final smoothedMagnetic = _compassFilter.update(rawHeading);

    // 2. Automatic True North magnetic declination correction
    final declination = _magneticDeclination ?? 0.0;
    final trueHeading = CompassFilter.normalizeAngle(smoothedMagnetic + declination);

    // 3. Smooth, continuous retargeting from live on-screen position (Apple fluid motion)
    final currentDisplayed = _startHeading + (_targetHeading - _startHeading) * _curvedAnimation.value;
    _startHeading = currentDisplayed;

    final diff = CompassFilter.shortestAngularDelta(trueHeading, currentDisplayed);
    _targetHeading = currentDisplayed + diff;

    if (_headingController.isAnimating) {
      _headingController.stop();
    }
    _headingController.forward(from: 0.0);

    // 4. Single consolidated setState per sensor event
    setState(() {
      _lastCompassEvent = event;
      _trueHeading = trueHeading;
    });

    // 5. Rotational haptics with cooldown (prevents UI thread haptic flooding during rapid turns)
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    if (diff.abs() >= 6.0 && (nowMs - _lastHapticTickMs) > 150) {
      _lastHapticTickMs = nowMs;
      AppHaptics.compassTick();
    }

    // 6. Trigger vibration on entering alignment zone (±3 degrees)
    if (_qiblaBearing != null) {
      final diffAngle = CompassFilter.shortestAngularDelta(trueHeading, _qiblaBearing!);
      final isAligned = diffAngle.abs() <= 3.0;

      if (isAligned && !_wasAligned) {
        AppHaptics.compassAligned();
      }
      _wasAligned = isAligned;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCompassStream();
    _curvedAnimation.dispose();
    _headingController.dispose();
    super.dispose();
  }

  void _showCalibrationSheet(BuildContext context) {
    final colors = context.appColors;
    final accuracy = _lastCompassEvent?.accuracy;

    String accuracyLabel;
    Color accuracyColor;
    if (accuracy == null || accuracy < 0) {
      accuracyLabel = 'Uncalibrated / Unknown';
      accuracyColor = colors.missed;
    } else if (accuracy <= 15.0) {
      accuracyLabel = 'High Accuracy (Ready)';
      accuracyColor = colors.success;
    } else {
      accuracyLabel = 'Medium Accuracy';
      accuracyColor = const Color(0xFFF59E0B);
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.of(context).padding.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.dividerStrong,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 18),

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.vibration_rounded,
                    color: colors.primary,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Compass Calibration Guide',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Sensor Accuracy Status Chip
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: accuracyColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: accuracyColor.withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: accuracyColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      accuracyLabel,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: accuracyColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Figure 8 Illustration Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.divider),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.all_inclusive_rounded,
                      size: 52,
                      color: colors.primary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Wave your phone in a Figure-8 (♾️) motion in the air 3 times',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Step-by-Step Instructions
              _buildCalibrationStepRow(
                context,
                stepNumber: '1',
                title: 'Clear Magnetic Interference',
                subtitle: 'Step away from metal desks, computers, or magnetic phone covers.',
              ),
              const SizedBox(height: 10),
              _buildCalibrationStepRow(
                context,
                stepNumber: '2',
                title: 'Hold Device Flat Horizontal',
                subtitle: 'Keep your phone flat horizontal parallel to the ground for peak precision.',
              ),
              const SizedBox(height: 10),
              _buildCalibrationStepRow(
                context,
                stepNumber: '3',
                title: 'Perform Figure-8 Sweep',
                subtitle: 'Sweep your phone smoothly along an 8-shaped loop in the air.',
              ),
              const SizedBox(height: 22),

              // Dismiss Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                  child: const Text(
                    'Got It & Calibrated',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCalibrationStepRow(
    BuildContext context, {
    required String stepNumber,
    required String title,
    required String subtitle,
  }) {
    final colors = context.appColors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: colors.primarySoft,
            shape: BoxShape.circle,
            border: Border.all(color: colors.primary.withValues(alpha: 0.3)),
          ),
          alignment: Alignment.center,
          child: Text(
            stepNumber,
            style: TextStyle(
              color: colors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                      fontSize: 11.5,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getCardinalDirection(double degrees) {
    final normalized = (degrees % 360 + 360) % 360;
    if (normalized >= 337.5 || normalized < 22.5) return 'N';
    if (normalized >= 22.5 && normalized < 67.5) return 'NE';
    if (normalized >= 67.5 && normalized < 112.5) return 'E';
    if (normalized >= 112.5 && normalized < 157.5) return 'SE';
    if (normalized >= 157.5 && normalized < 202.5) return 'S';
    if (normalized >= 202.5 && normalized < 247.5) return 'SW';
    if (normalized >= 247.5 && normalized < 292.5) return 'W';
    if (normalized >= 292.5 && normalized < 337.5) return 'NW';
    return 'N';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final currentHeading = _currentHeading;
    final accuracy = _lastCompassEvent?.accuracy;

    final bool isSensorUnavailable = currentHeading == null;
    final bool isAccuracyLow = currentHeading != null && accuracy != null && (accuracy > 15.0 || accuracy < 0);

    final double? qiblaBearing = _qiblaBearing;

    final double diffAngle = (qiblaBearing != null && currentHeading != null)
        ? CompassFilter.shortestAngularDelta(qiblaBearing, currentHeading)
        : 180.0;

    final bool isAligned = currentHeading != null && diffAngle.abs() <= 3.0;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: _isLoadingLocation
            ? Center(
                child: CircularProgressIndicator(
                  color: colors.primary,
                ),
              )
            : _locationError != null
                ? _buildErrorView(context, _locationError!)
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display Title with Calibrate action
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Qibla Compass',
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                    color: colors.textPrimary,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 32,
                                    letterSpacing: -0.2,
                                  ),
                            ),
                            InkWell(
                              onTap: () => _showCalibrationSheet(context),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: colors.primarySoft,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: colors.primary.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.vibration_rounded,
                                      size: 16,
                                      color: colors.primary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Calibrate',
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                            color: colors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Location Header Card with Automatic True North status
                        _buildLocationHeaderCard(context),
                        const SizedBox(height: 16),

                        // Sensor Warning Pill if accuracy low or sensor unavailable
                        if (isSensorUnavailable || isAccuracyLow)
                          GestureDetector(
                            onTap: () => _showCalibrationSheet(context),
                            child: _buildSensorWarningPill(
                              context,
                              isUnavailable: isSensorUnavailable,
                            ),
                          ),

                        // Numeric Metrics Tile with Tabular Figures
                        _buildNumericMetricsTile(
                          context,
                          currentHeading: currentHeading,
                          qiblaBearing: qiblaBearing,
                        ),
                        const SizedBox(height: 24),

                        // Animated Compass Dial & Qibla Pointer Needle
                        Center(
                          child: Semantics(
                            label: 'Qibla compass dial',
                            value:
                                '${_currentHeading?.round() ?? 0} degrees heading, Qibla at ${_qiblaBearing?.round() ?? 0} degrees',
                            child: RepaintBoundary(
                              child: Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colors.surface,
                                  boxShadow: [
                                    BoxShadow(
                                      color: isAligned
                                          ? colors.successGlow
                                          : colors.shadow,
                                      blurRadius: isAligned ? 28 : 16,
                                      spreadRadius: isAligned ? 4 : 0,
                                    ),
                                  ],
                                ),
                                child: AnimatedBuilder(
                                  animation: _curvedAnimation,
                                  builder: (context, child) {
                                    final currentHeadingAngle = _startHeading +
                                        (_targetHeading - _startHeading) *
                                            _curvedAnimation.value;
                                    final relativeAngle =
                                        (qiblaBearing != null && currentHeading != null)
                                            ? (qiblaBearing - currentHeadingAngle + 360) % 360
                                            : (qiblaBearing ?? 0.0);

                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // Rotating Compass Dial (N, E, S, W & Ticks)
                                        Transform.rotate(
                                          angle: -currentHeadingAngle * math.pi / 180,
                                          child: CustomPaint(
                                            size: const Size(290, 290),
                                            painter: _CompassDialPainter(
                                              qiblaBearing: qiblaBearing ?? 0.0,
                                              colors: colors,
                                              isDark: isDark,
                                            ),
                                          ),
                                        ),

                                        // Qibla Needle Pointer (Points towards Qibla direction)
                                        CustomPaint(
                                          size: const Size(290, 290),
                                          painter: _QiblaNeedlePainter(
                                            relativeQiblaAngle: relativeAngle,
                                            isAligned: isAligned,
                                            colors: colors,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Alignment Status Badge
                        _buildAlignmentBadge(context, isAligned, diffAngle),
                        const SizedBox(height: 16),

                        // Calibration Guide Button
                        Center(
                          child: TextButton.icon(
                            onPressed: () => _showCalibrationSheet(context),
                            icon: Icon(
                              Icons.vibration_rounded,
                              size: 16,
                              color: colors.textSecondary,
                            ),
                            label: Text(
                              'How to Calibrate Compass ♾️',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: colors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildLocationHeaderCard(BuildContext context) {
    final colors = context.appColors;
    final city = _locationData?.city;
    final country = _locationData?.countryName;
    final locationText = (city != null && country != null)
        ? '$city, $country'
        : (city ?? country ?? 'Current Location');

    final distanceKm = _distanceToMakkahKm;
    final declination = _magneticDeclination;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: ShapeDecoration(
        color: colors.surface,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(color: colors.divider, width: 1.0),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on_rounded,
              color: colors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        locationText,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (declination != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: colors.successSoft,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: colors.success.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          'TRUE NORTH (${declination >= 0 ? '+' : ''}${declination.toStringAsFixed(1)}°)',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: colors.successText,
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                  ],
                ),
                if (distanceKm != null)
                  Text(
                    '${distanceKm.round()} km to Makkah Al-Mukarramah',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSensorWarningPill(BuildContext context, {required bool isUnavailable}) {
    final colors = context.appColors;

    return Container(
      key: const ValueKey('sensor_warning_pill'),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: colors.missedSoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.missed.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 16,
            color: colors.missed,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              isUnavailable
                  ? 'Compass sensor unavailable'
                  : 'Compass accuracy low — wave phone in figure-8',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: colors.missedText,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumericMetricsTile(
    BuildContext context, {
    required double? currentHeading,
    required double? qiblaBearing,
  }) {
    final colors = context.appColors;

    final headingStr = currentHeading != null
        ? '${currentHeading.round()}° ${_getCardinalDirection(currentHeading)}'
        : '--';
    final bearingStr = qiblaBearing != null
        ? '${qiblaBearing.round()}° ${_getCardinalDirection(qiblaBearing)}'
        : '--';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.divider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _MetricDisplayTile(
            label: 'HEADING (TRUE)',
            value: headingStr,
            colors: colors,
          ),
          Container(
            height: 36,
            width: 1,
            color: colors.dividerStrong,
          ),
          _MetricDisplayTile(
            label: 'QIBLA BEARING',
            value: bearingStr,
            colors: colors,
          ),
        ],
      ),
    );
  }

  Widget _buildAlignmentBadge(BuildContext context, bool isAligned, double diffAngle) {
    final colors = context.appColors;
    final color = isAligned ? colors.success : colors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isAligned ? colors.successSoft : colors.primarySoft,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: color.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: isAligned
            ? [
                BoxShadow(
                  color: colors.successGlow,
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAligned ? Icons.check_circle_rounded : Icons.explore_rounded,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            isAligned
                ? 'ALIGNED WITH QIBLA'
                : 'TURN ${diffAngle.abs().round()}° ${diffAngle > 0 ? 'LEFT' : 'RIGHT'}',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isAligned ? colors.successText : colors.primaryText,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String error) {
    final colors = context.appColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off_rounded,
              size: 48,
              color: colors.missed,
            ),
            const SizedBox(height: 16),
            Text(
              'Location Access Failed',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.textSecondary,
                  ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _fetchLocation,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry Location'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricDisplayTile extends StatelessWidget {
  final String label;
  final String value;
  final AppCustomColors colors;

  const _MetricDisplayTile({
    required this.label,
    required this.value,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colors.textTertiary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.timerStyle(
            color: colors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _CompassDialPainter extends CustomPainter {
  final double qiblaBearing;
  final AppCustomColors colors;
  final bool isDark;

  _CompassDialPainter({
    required this.qiblaBearing,
    required this.colors,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    // 1. Outer rim background fill
    final bgPaint = Paint()
      ..color = colors.surface
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius - 4, bgPaint);

    final borderPaint = Paint()
      ..color = colors.dividerStrong
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, radius - 4, borderPaint);

    // 2. Ticks & Cardinal Directions
    final tickPaint = Paint()..strokeCap = StrokeCap.round;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < 360; i += 5) {
      final angleRad = (i - 90) * math.pi / 180;
      final isMajor = i % 30 == 0;
      final isCardinal = i % 90 == 0;

      final tickLength = isCardinal ? 14.0 : (isMajor ? 10.0 : 6.0);
      final strokeWidth = isCardinal ? 2.5 : (isMajor ? 1.8 : 1.0);

      tickPaint.color = isCardinal
          ? (i == 0 ? colors.missed : colors.textPrimary)
          : (isMajor ? colors.textSecondary : colors.textTertiary.withValues(alpha: 0.5));
      tickPaint.strokeWidth = strokeWidth;

      final outerPt = Offset(
        center.dx + (radius - 12) * math.cos(angleRad),
        center.dy + (radius - 12) * math.sin(angleRad),
      );
      final innerPt = Offset(
        center.dx + (radius - 12 - tickLength) * math.cos(angleRad),
        center.dy + (radius - 12 - tickLength) * math.sin(angleRad),
      );

      canvas.drawLine(innerPt, outerPt, tickPaint);

      // Cardinal direction letters
      if (isCardinal) {
        String label;
        Color labelColor;
        switch (i) {
          case 0:
            label = 'N';
            labelColor = colors.missed;
            break;
          case 90:
            label = 'E';
            labelColor = colors.textPrimary;
            break;
          case 180:
            label = 'S';
            labelColor = colors.textPrimary;
            break;
          case 270:
            label = 'W';
            labelColor = colors.textPrimary;
            break;
          default:
            label = '';
            labelColor = colors.textPrimary;
        }

        textPainter.text = TextSpan(
          text: label,
          style: TextStyle(
            color: labelColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        );
        textPainter.layout();

        final labelRadius = radius - 36;
        final labelPt = Offset(
          center.dx + labelRadius * math.cos(angleRad) - textPainter.width / 2,
          center.dy + labelRadius * math.sin(angleRad) - textPainter.height / 2,
        );
        textPainter.paint(canvas, labelPt);
      }
    }

    // 3. Qibla Marker on Outer Rim
    final qiblaRad = (qiblaBearing - 90) * math.pi / 180;
    final qiblaMarkerRadius = radius - 12;
    final qiblaCenter = Offset(
      center.dx + qiblaMarkerRadius * math.cos(qiblaRad),
      center.dy + qiblaMarkerRadius * math.sin(qiblaRad),
    );

    final qiblaMarkerPaint = Paint()
      ..color = colors.primary
      ..style = PaintingStyle.fill;
    canvas.drawCircle(qiblaCenter, 6.0, qiblaMarkerPaint);

    final qiblaInnerPaint = Paint()
      ..color = colors.surface
      ..style = PaintingStyle.fill;
    canvas.drawCircle(qiblaCenter, 2.5, qiblaInnerPaint);
  }

  @override
  bool shouldRepaint(covariant _CompassDialPainter oldDelegate) {
    return oldDelegate.qiblaBearing != qiblaBearing ||
        oldDelegate.colors != colors ||
        oldDelegate.isDark != isDark;
  }
}

class _QiblaNeedlePainter extends CustomPainter {
  final double relativeQiblaAngle;
  final bool isAligned;
  final AppCustomColors colors;

  _QiblaNeedlePainter({
    required this.relativeQiblaAngle,
    required this.isAligned,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final needleLength = radius * 0.72;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate((relativeQiblaAngle - 90) * math.pi / 180);

    final mainColor = isAligned ? colors.success : colors.primary;

    // 1. Glow Halo when aligned
    if (isAligned) {
      final glowPaint = Paint()
        ..color = colors.success.withValues(alpha: 0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16.0);
      canvas.drawCircle(Offset(needleLength * 0.8, 0), 22.0, glowPaint);
    }

    // 2. Qibla Pointer Needle Head
    final needlePath = Path();
    needlePath.moveTo(needleLength, 0);
    needlePath.lineTo(needleLength - 28, -10);
    needlePath.lineTo(needleLength - 20, 0);
    needlePath.lineTo(needleLength - 28, 10);
    needlePath.close();

    final needlePaint = Paint()
      ..color = mainColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(needlePath, needlePaint);

    // Stem Line
    final stemPaint = Paint()
      ..color = mainColor
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset.zero, Offset(needleLength - 20, 0), stemPaint);

    // Opposite Tail
    final tailPath = Path();
    tailPath.moveTo(-25, 0);
    tailPath.lineTo(-10, -6);
    tailPath.lineTo(-10, 6);
    tailPath.close();

    final tailPaint = Paint()
      ..color = colors.textTertiary
      ..style = PaintingStyle.fill;
    canvas.drawPath(tailPath, tailPaint);

    // Center Cap
    final capOuterPaint = Paint()
      ..color = mainColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 10.0, capOuterPaint);

    final capInnerPaint = Paint()
      ..color = colors.surface
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 5.0, capInnerPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _QiblaNeedlePainter oldDelegate) {
    return oldDelegate.relativeQiblaAngle != relativeQiblaAngle ||
        oldDelegate.isAligned != isAligned ||
        oldDelegate.colors != colors;
  }
}
