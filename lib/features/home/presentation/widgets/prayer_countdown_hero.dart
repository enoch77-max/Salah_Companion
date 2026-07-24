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
  final Duration? remainingDuration;
  final double progress; // 0.0 to 1.0
  final bool animate;
  final VoidCallback? onTap;

  const PrayerCountdownHero({
    super.key,
    required this.nextPrayerName,
    this.nextPrayerTime,
    this.remainingDuration,
    this.progress = 0.75,
    this.animate = true,
    this.onTap,
  });

  @override
  State<PrayerCountdownHero> createState() => _PrayerCountdownHeroState();
}

class _PrayerCountdownHeroState extends State<PrayerCountdownHero>
    with SingleTickerProviderStateMixin {
  Timer? _ticker;
  late Duration _currentRemaining;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _startTickerIfNeeded();
  }

  @override
  void didUpdateWidget(covariant PrayerCountdownHero oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.remainingDuration != widget.remainingDuration ||
        oldWidget.nextPrayerTime != widget.nextPrayerTime ||
        oldWidget.animate != widget.animate) {
      _updateRemaining();
      _startTickerIfNeeded();
    }
  }

  void _startTickerIfNeeded() {
    _ticker?.cancel();
    _ticker = null;
    if (widget.animate && widget.nextPrayerTime != null && widget.remainingDuration == null) {
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
    if (widget.remainingDuration != null) {
      _currentRemaining = widget.remainingDuration!;
    } else if (widget.nextPrayerTime != null) {
      final now = DateTime.now();
      final diff = widget.nextPrayerTime!.difference(now);
      _currentRemaining = diff.isNegative ? Duration.zero : diff;
    } else {
      _currentRemaining = const Duration(hours: 1, minutes: 24, seconds: 5);
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

    Widget ledDot = Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: colors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.6),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
    );

    if (widget.animate) {
      ledDot = ledDot
          .animate(
            onPlay: (controller) => controller.repeat(reverse: true),
          )
          .fade(
            begin: 0.3,
            end: 1.0,
            duration: const Duration(milliseconds: 900),
          );
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          gradient: _getBackgroundGradient(brightness),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: BorderSide(
              color: colors.dividerStrong,
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Next Prayer Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'UPCOMING PRAYER',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colors.textSecondary,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(width: 8),
                  // Blinking LED indicator dot
                  ledDot,
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.nextPrayerName,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 24),

              // Countdown Progress Ring with Center Timer
              SizedBox(
                width: 190,
                height: 190,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular Progress Ring Painter
                    CustomPaint(
                      size: const Size(190, 190),
                      painter: _CountdownRingPainter(
                        progress: widget.progress.clamp(0.0, 1.0),
                        trackColor: colors.primarySoft.withValues(alpha: 0.3),
                        progressColor: colors.primary,
                      ),
                    ),
                    // Blinking LED dot at progress tip
                    _BlinkingProgressTipDot(
                      progress: widget.progress.clamp(0.0, 1.0),
                      size: 190,
                      dotColor: colors.primary,
                      animate: widget.animate,
                    ),
                    // Center Tabular Timer Text
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          formattedTime,
                          key: const ValueKey('hero_timer_text'),
                          style: AppTypography.timerStyle(
                            color: colors.textPrimary,
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'remaining',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colors.textTertiary,
                                letterSpacing: 0.5,
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
    const strokeWidth = 10.0;
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
    const strokeWidth = 10.0;
    final radius = (size - strokeWidth) / 2;
    final angle = -math.pi / 2 + (2 * math.pi * progress);
    final cx = size / 2 + radius * math.cos(angle);
    final cy = size / 2 + radius * math.sin(angle);

    Widget dot = Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: dotColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: dotColor.withValues(alpha: 0.8),
            blurRadius: 8,
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
            begin: 0.4,
            end: 1.0,
            duration: const Duration(milliseconds: 750),
          );
    }

    return Positioned(
      left: cx - 7,
      top: cy - 7,
      child: dot,
    );
  }
}
