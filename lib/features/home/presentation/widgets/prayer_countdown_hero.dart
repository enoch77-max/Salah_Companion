import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';

/// Hero Widget showing next prayer countdown with circular progress ring
/// and animated blinking LED dot.
class PrayerCountdownHero extends StatefulWidget {
  final String nextPrayerName;
  final DateTime? nextPrayerTime;
  final DateTime? periodStartTime;
  final DateTime? periodEndTime;
  final Duration? remainingDuration;
  final double progress; // 0.0 to 1.0 fallback
  final bool isDrain; // true = emptying ring (Current Salah), false = filling ring (Upcoming)
  final bool animate;
  final String headerLabel;
  final String? periodText;
  final String? sunriseTime;
  final String? sunsetTime;
  final VoidCallback? onTap;
  final VoidCallback? onTimerExpired;

  const PrayerCountdownHero({
    super.key,
    required this.nextPrayerName,
    this.nextPrayerTime,
    this.periodStartTime,
    this.periodEndTime,
    this.remainingDuration,
    this.progress = 0.75,
    this.isDrain = false,
    this.animate = true,
    this.headerLabel = 'UPCOMING PRAYER',
    this.periodText,
    this.sunriseTime,
    this.sunsetTime,
    this.onTap,
    this.onTimerExpired,
  });

  @override
  State<PrayerCountdownHero> createState() => _PrayerCountdownHeroState();
}

class _PrayerCountdownHeroState extends State<PrayerCountdownHero>
    with SingleTickerProviderStateMixin {
  Timer? _ticker;
  late Duration _currentRemaining;
  double _dynamicProgress = 0.75;
  bool _hasFiredExpired = false;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _startTickerIfNeeded();
  }

  @override
  void didUpdateWidget(covariant PrayerCountdownHero oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.nextPrayerTime != widget.nextPrayerTime ||
        oldWidget.periodEndTime != widget.periodEndTime) {
      _hasFiredExpired = false;
    }
    if (oldWidget.remainingDuration != widget.remainingDuration ||
        oldWidget.nextPrayerTime != widget.nextPrayerTime ||
        oldWidget.periodStartTime != widget.periodStartTime ||
        oldWidget.periodEndTime != widget.periodEndTime ||
        oldWidget.isDrain != widget.isDrain ||
        oldWidget.animate != widget.animate) {
      _updateRemaining();
      _startTickerIfNeeded();
    }
  }

  void _startTickerIfNeeded() {
    _ticker?.cancel();
    _ticker = null;
    if (widget.animate) {
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) {
          setState(() {
            _updateRemaining();
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _updateRemaining() {
    final now = DateTime.now();

    final targetEnd = widget.periodEndTime ?? widget.nextPrayerTime;
    if (targetEnd != null) {
      final diff = targetEnd.difference(now);
      if (diff.isNegative || diff == Duration.zero) {
        _currentRemaining = Duration.zero;
        if (!_hasFiredExpired) {
          _hasFiredExpired = true;
          widget.onTimerExpired?.call();
        }
      } else {
        _currentRemaining = diff;
      }

      if (widget.periodStartTime != null && widget.periodEndTime != null) {
        final totalSecs = widget.periodEndTime!.difference(widget.periodStartTime!).inSeconds;
        final remSecs = widget.periodEndTime!.difference(now).inSeconds;

        if (totalSecs > 0) {
          if (widget.isDrain) {
            // Inverted for Current Salah per user request (1.0 - remSecs / totalSecs)
            _dynamicProgress = (1.0 - (remSecs / totalSecs)).clamp(0.0, 1.0);
          } else {
            // Upcoming Prayer: (remSecs / totalSecs)
            _dynamicProgress = (remSecs / totalSecs).clamp(0.0, 1.0);
          }
        } else {
          _dynamicProgress = widget.progress;
        }
      } else {
        _dynamicProgress = widget.progress;
      }
    } else if (widget.remainingDuration != null) {
      if (_ticker != null && _ticker!.isActive) {
        if (_currentRemaining > Duration.zero) {
          _currentRemaining = _currentRemaining - const Duration(seconds: 1);
        }
      } else {
        _currentRemaining = widget.remainingDuration!;
      }
      _dynamicProgress = widget.progress;
    } else {
      _currentRemaining = const Duration(hours: 1, minutes: 24, seconds: 5);
      _dynamicProgress = widget.progress;
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  LinearGradient _getBackgroundGradient(Brightness brightness) {
    final name = widget.nextPrayerName.toLowerCase();
    final isDark = brightness == Brightness.dark;

    if (name.contains('fajr')) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? const [Color(0xFF231934), Color(0xFF3B1E38), Color(0xFF14171E)]
            : const [Color(0xFFF3E8F4), Color(0xFFFCE4EC), Color(0xFFF5F2EE)],
      );
    } else if (name.contains('dhuhr')) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? const [Color(0xFF33200F), Color(0xFF4D3014), Color(0xFF14171E)]
            : const [Color(0xFFFFF3E0), Color(0xFFFFE0B2), Color(0xFFF5F2EE)],
      );
    } else if (name.contains('asr')) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? const [Color(0xFF352018), Color(0xFF4E2C1D), Color(0xFF14171E)]
            : const [Color(0xFFFBE9E7), Color(0xFFFFCCBC), Color(0xFFF5F2EE)],
      );
    } else if (name.contains('maghrib')) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? const [Color(0xFF3D1A1A), Color(0xFF572520), Color(0xFF14171E)]
            : const [Color(0xFFFDE8E8), Color(0xFFF8D7DA), Color(0xFFF5F2EE)],
      );
    } else if (name.contains('isha')) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? const [Color(0xFF111827), Color(0xFF1F2937), Color(0xFF14171E)]
            : const [Color(0xFFE2E8F0), Color(0xFFCBD5E1), Color(0xFFF5F2EE)],
      );
    } else {
      // Sunrise / default
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? const [Color(0xFF2E1C2B), Color(0xFF4A283B), Color(0xFF14171E)]
            : const [Color(0xFFFCE4EC), Color(0xFFF8BBD0), Color(0xFFF5F2EE)],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final brightness = Theme.of(context).brightness;
    final formattedTime = _formatDuration(_currentRemaining);

    final isCurrentSalah = widget.headerLabel == 'CURRENT SALAH';
    final ledColor = isCurrentSalah ? colors.currentSalahGreen : colors.primary;

    final Widget ledDot = _PulsingDot(
      color: ledColor,
      animate: widget.animate,
    );

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          gradient: _getBackgroundGradient(brightness),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: colors.dividerStrong,
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Section: Prayer Info + Sunrise Pill
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Tag + Blinking LED
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.headerLabel,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: colors.textSecondary,
                                letterSpacing: 1.1,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                        ),
                        const SizedBox(width: 6),
                        ledDot,
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.nextPrayerName,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                            letterSpacing: -0.3,
                          ),
                    ),
                    if (widget.periodText case final String pText) ...[
                      const SizedBox(height: 2),
                      Text(
                        pText,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.primaryText,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                              fontSize: 12,
                            ),
                      ),
                    ],
                    if (widget.sunriseTime != null || widget.sunsetTime != null) ...[
                      const SizedBox(height: 6),
                      IntrinsicWidth(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: colors.surface.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: colors.dividerStrong.withValues(alpha: 0.5),
                              width: 0.8,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Sunrise row
                              if (widget.sunriseTime case final String sTime)
                                _SunTimePillRow(
                                  icon: Icons.wb_sunny_rounded,
                                  iconColor: const Color(0xFFF59E0B),
                                  label: 'Sunrise',
                                  time: sTime,
                                  textSecondary: colors.textSecondary,
                                  textPrimary: colors.textPrimary,
                                ),
                              // Divider between sunrise and sunset
                              if (widget.sunriseTime != null && widget.sunsetTime != null)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 1.5),
                                  child: Container(
                                    height: 0.5,
                                    color: colors.dividerStrong.withValues(alpha: 0.4),
                                  ),
                                ),
                              // Sunset row
                              if (widget.sunsetTime case final String setTime)
                                _SunTimePillRow(
                                  icon: Icons.wb_twilight_rounded,
                                  iconColor: const Color(0xFFEF6C00),
                                  label: 'Sunset',
                                  time: setTime,
                                  textSecondary: colors.textSecondary,
                                  textPrimary: colors.textPrimary,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Right Section: Circular Progress Ring with Timer
              SizedBox(
                width: 112,
                height: 112,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(112, 112),
                      painter: _CountdownRingPainter(
                        progress: _dynamicProgress.clamp(0.0, 1.0),
                        trackColor: colors.primarySoft.withValues(alpha: 0.3),
                        progressColor: colors.primary,
                      ),
                    ),
                    _BlinkingProgressTipDot(
                      progress: _dynamicProgress.clamp(0.0, 1.0),
                      size: 112,
                      dotColor: colors.primary,
                      animate: widget.animate,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          formattedTime,
                          key: const ValueKey('hero_timer_text'),
                          style: AppTypography.timerStyle(
                            color: colors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          'remaining',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colors.textTertiary,
                                letterSpacing: 0.4,
                                fontSize: 10,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountdownRingPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;

  _CountdownRingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 7.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background track
    canvas.drawCircle(center, radius, trackPaint);

    // Draw progress arc
    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CountdownRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressColor != progressColor;
  }
}

class _BlinkingProgressTipDot extends StatelessWidget {
  final double progress;
  final double size;
  final Color dotColor;
  final bool animate;

  const _BlinkingProgressTipDot({
    required this.progress,
    required this.size,
    required this.dotColor,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    const strokeWidth = 7.0;
    final radius = (size - strokeWidth) / 2;
    final angle = -math.pi / 2 + (2 * math.pi * progress);
    final cx = size / 2 + radius * math.cos(angle);
    final cy = size / 2 + radius * math.sin(angle);

    Widget dot = Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: dotColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: dotColor.withValues(alpha: 0.8),
            blurRadius: 6,
            spreadRadius: 1.5,
          ),
        ],
      ),
    );

    if (animate) {
      dot = dot
          .animate(
            onPlay: (controller) => controller.repeat(reverse: true),
          )
          .fade(
            begin: 0.4,
            end: 1.0,
            duration: const Duration(milliseconds: 750),
          );
    }

    return Positioned(
      left: cx - 5,
      top: cy - 5,
      child: dot,
    );
  }
}

/// Reusable row for the sunrise/sunset pill capsule inside the hero widget.
class _SunTimePillRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String time;
  final Color textSecondary;
  final Color textPrimary;

  const _SunTimePillRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.time,
    required this.textSecondary,
    required this.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 8,
              ),
            ),
            const SizedBox(width: 3),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 9.5,
                  ),
            ),
          ],
        ),
        const SizedBox(width: 5),
        Text(
          time,
          style: AppTypography.timerStyle(
            color: textPrimary,
            fontSize: 9.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _PulsingDot extends StatelessWidget {
  final Color color;
  final bool animate;

  const _PulsingDot({
    required this.color,
    required this.animate,
  });

  @override
  Widget build(BuildContext context) {
    Widget dot = Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.6),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
    );

    if (animate) {
      dot = dot
          .animate(
            onPlay: (controller) => controller.repeat(reverse: true),
          )
          .fade(
            begin: 0.3,
            end: 1.0,
            duration: const Duration(milliseconds: 900),
          );
    }

    return dot;
  }
}
