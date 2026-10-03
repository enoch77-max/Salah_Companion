import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../l10n/generated/app_localizations.dart';

String _localizeHeroPrayerName(BuildContext context, String rawName) {
  final l10n = AppLocalizations.of(context);
  switch (rawName.toLowerCase()) {
    case 'fajr':
      return l10n?.prayerFajr ?? 'Fajr';
    case 'sunrise':
      return l10n?.prayerSunrise ?? 'Sunrise';
    case 'dhuhr':
      return l10n?.prayerDhuhr ?? 'Dhuhr';
    case 'asr':
      return l10n?.prayerAsr ?? 'Asr';
    case 'maghrib':
      return l10n?.prayerMaghrib ?? 'Maghrib';
    case 'isha':
      return l10n?.prayerIsha ?? 'Isha';
    case 'sunset':
      return l10n?.prayerSunset ?? 'Sunset';
    default:
      return rawName;
  }
}

/// Hero Widget showing next prayer countdown with circular progress ring
/// and animated blinking LED dot.
class PrayerCountdownHero extends StatefulWidget {
  final String nextPrayerName;
  final DateTime? nextPrayerTime;
  final DateTime? periodStartTime;
  final DateTime? periodEndTime;
  final String? startTimeStr;
  final String? endTimeStr;
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
    this.startTimeStr,
    this.endTimeStr,
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
        oldWidget.startTimeStr != widget.startTimeStr ||
        oldWidget.endTimeStr != widget.endTimeStr ||
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

  static final RegExp _extractTimesRegex = RegExp(
    r'(\d{1,2}:\d{2})\s*([AaPp][Mm])?',
  );

  ({String digits, String ampm}) _resolveStartTime() {
    if (widget.startTimeStr != null && widget.startTimeStr!.isNotEmpty) {
      return _splitTime(widget.startTimeStr!);
    }
    if (widget.periodStartTime != null) {
      return _splitTime(_formatDateTime12h(widget.periodStartTime!));
    }
    if (widget.periodText != null) {
      final matches = _extractTimesRegex.allMatches(widget.periodText!).toList();
      if (matches.isNotEmpty) {
        final m = matches.first;
        final digits = m.group(1) ?? '04:58';
        final ampm = (m.group(2) ?? '').toUpperCase();
        return (digits: digits, ampm: ampm.isNotEmpty ? ampm : 'AM');
      }
    }
    return (digits: '04:58', ampm: 'AM');
  }

  ({String digits, String ampm}) _resolveEndTime() {
    if (widget.endTimeStr != null && widget.endTimeStr!.isNotEmpty) {
      return _splitTime(widget.endTimeStr!);
    }
    if (widget.periodEndTime != null) {
      return _splitTime(_formatDateTime12h(widget.periodEndTime!));
    }
    if (widget.periodText != null) {
      final matches = _extractTimesRegex.allMatches(widget.periodText!).toList();
      if (matches.length >= 2) {
        final m = matches[1];
        final digits = m.group(1) ?? '06:12';
        final ampm = (m.group(2) ?? '').toUpperCase();
        return (digits: digits, ampm: ampm.isNotEmpty ? ampm : 'AM');
      }
    }
    if (widget.nextPrayerName.toLowerCase().contains('fajr') && widget.sunriseTime != null) {
      return _splitTime(widget.sunriseTime!);
    }
    return (digits: '06:12', ampm: 'AM');
  }

  static ({String digits, String ampm}) _splitTime(String raw) {
    final clean = raw.replaceAll(RegExp(r'[^\d:APMapm\s]'), '').trim();
    final parts = clean.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return (digits: parts[0], ampm: parts[1].toUpperCase());
    }
    final match = RegExp(r'^(\d{1,2}:\d{2})\s*([AaPp][Mm])?').firstMatch(clean);
    if (match != null) {
      return (
        digits: match.group(1) ?? clean,
        ampm: (match.group(2) ?? '').toUpperCase(),
      );
    }
    return (digits: clean, ampm: '');
  }

  static String _formatDateTime12h(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:$minute $ampm';
  }

  bool get _isNextSolarSunset {
    final name = widget.nextPrayerName.toLowerCase();
    return name.contains('dhuhr') || name.contains('asr');
  }

  Widget _buildAnimatedTimeRow({
    required String tag,
    required Key tagKey,
    required String digits,
    required String ampm,
    required bool isBig,
    required Color accentColor,
    required dynamic colors,
  }) {
    const duration = Duration(milliseconds: 400);
    const curve = Curves.easeInOutCubic;

    final tagStyle = GoogleFonts.inter(
      fontSize: isBig ? 10.0 : 12.5,
      fontWeight: isBig ? FontWeight.w700 : FontWeight.w600,
      letterSpacing: isBig ? 0.6 : 0.0,
      color: colors.textSecondary as Color,
      height: 1.1,
    );

    final digitsStyle = GoogleFonts.inter(
      fontSize: isBig ? 28.0 : 13.5,
      fontWeight: isBig ? FontWeight.w800 : FontWeight.w700,
      letterSpacing: isBig ? -0.4 : 0.0,
      color: isBig ? (colors.textPrimary as Color) : (colors.textSecondary as Color),
      fontFeatures: const [FontFeature.tabularFigures()],
      height: 1.1,
    );

    final ampmStyle = GoogleFonts.inter(
      fontSize: isBig ? 12.5 : 10.0,
      fontWeight: isBig ? FontWeight.w700 : FontWeight.w600,
      color: isBig ? accentColor : (colors.textSecondary as Color),
      height: 1.1,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedDefaultTextStyle(
          duration: duration,
          curve: curve,
          style: tagStyle,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Text(
              tag,
              key: tagKey,
            ),
          ),
        ),
        AnimatedContainer(
          duration: duration,
          curve: curve,
          width: isBig ? 6.0 : 5.0,
        ),
        AnimatedDefaultTextStyle(
          duration: duration,
          curve: curve,
          style: digitsStyle,
          child: Text(digits),
        ),
        if (ampm.isNotEmpty) ...[
          const SizedBox(width: 3.0),
          AnimatedDefaultTextStyle(
            duration: duration,
            curve: curve,
            style: ampmStyle,
            child: Text(ampm),
          ),
        ],
      ],
    );
  }

  void _showSolarModal(BuildContext context, dynamic colors, bool isDark) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? const [Color(0xFF1C1E28), Color(0xFF10121A)]
                  : [colors.surface as Color, colors.elevatedBackground as Color],
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.16)
                  : (colors.dividerStrong as Color),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.6 : 0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomPaint(
                        size: const Size(18, 18),
                        painter: _SunriseIconPainter(),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Solar Timings',
                        style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                              color: colors.textPrimary as Color,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(ctx).pop(),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : (colors.surfaceHover as Color),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: colors.textSecondary as Color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.04)
                            : (colors.surface as Color),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : (colors.dividerStrong as Color),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomPaint(
                                size: const Size(16, 16),
                                painter: _SunriseIconPainter(),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Sunrise',
                                style: Theme.of(ctx).textTheme.labelSmall?.copyWith(
                                      color: colors.textSecondary as Color,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      letterSpacing: 0.5,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.sunriseTime ?? '06:12 AM',
                            style: AppTypography.timerStyle(
                              color: colors.textPrimary as Color,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.04)
                            : (colors.surface as Color),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : (colors.dividerStrong as Color),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomPaint(
                                size: const Size(16, 16),
                                painter: _SunsetIconPainter(),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Sunset',
                                style: Theme.of(ctx).textTheme.labelSmall?.copyWith(
                                      color: colors.textSecondary as Color,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      letterSpacing: 0.5,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.sunsetTime ?? '06:18 PM',
                            style: AppTypography.timerStyle(
                              color: colors.textPrimary as Color,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: (colors.primary as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: (colors.primary as Color).withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  'Daylight Window: Fajr ends promptly at sunrise. Maghrib begins at sunset.',
                  style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary as Color,
                        fontSize: 11,
                        height: 1.4,
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final formattedTime = _formatDuration(_currentRemaining);

    final isCurrentSalah = widget.headerLabel == 'CURRENT SALAH';
    final accentColor = colors.primary;

    final startTime = _resolveStartTime();
    final endTime = _resolveEndTime();

    final isSolarSunset = _isNextSolarSunset;
    final solarTime = isSolarSunset ? widget.sunsetTime : widget.sunriseTime;
    final solarLabel = isSolarSunset ? 'Sunset' : 'Sunrise';

    return Semantics(
      container: true,
      label: '${widget.headerLabel}: ${widget.nextPrayerName}, Starts ${startTime.digits} ${startTime.ampm}, Ends ${endTime.digits} ${endTime.ampm}, $formattedTime remaining',
      hint: widget.onTap != null ? 'Double tap to open prayer streak' : null,
      child: GestureDetector(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Centered Header Tag with LED dot and balancing spacer
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.06)
                          : colors.dividerStrong,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5.5),
                    Text(
                      widget.headerLabel,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: colors.textSecondary,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                    ),
                    const SizedBox(width: 6),
                    _PulsingDot(
                      color: accentColor,
                      animate: widget.animate,
                    ),
                  ],
                ),
              ),

              // 2. Card Body (Left Info + Right Ring)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left Section: Prayer Info + Solution 2 Time Box + Solar Capsule
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Grand 34px Serif Title
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _localizeHeroPrayerName(context, widget.nextPrayerName),
                              style: GoogleFonts.newsreader(
                                fontSize: 34,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.2,
                                color: colors.textPrimary,
                                height: 1.1,
                                textStyle: const TextStyle(fontFamily: 'serif'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Solution 2 Box: Rock-solid fixed height eliminates layout shifts & screen shake
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: accentColor,
                                    width: 2.5,
                                  ),
                                ),
                              ),
                              child: SizedBox(
                                height: 52.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Top Row: Always Start Time
                                    _buildAnimatedTimeRow(
                                      tag: isCurrentSalah ? 'Started' : 'Starts',
                                      tagKey: ValueKey('tag_start_${isCurrentSalah ? "started" : "starts"}'),
                                      digits: startTime.digits,
                                      ampm: startTime.ampm,
                                      isBig: !isCurrentSalah,
                                      accentColor: accentColor,
                                      colors: colors,
                                    ),
                                    // Bottom Row: Always End Time
                                    _buildAnimatedTimeRow(
                                      tag: 'Ends',
                                      tagKey: const ValueKey('tag_end_ends'),
                                      digits: endTime.digits,
                                      ampm: endTime.ampm,
                                      isBig: isCurrentSalah,
                                      accentColor: accentColor,
                                      colors: colors,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Dynamic Solar Capsule (Plan B)
                          if (solarTime != null) ...[
                            const SizedBox(height: 8),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () => _showSolarModal(context, colors, isDark),
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  height: 24,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.white.withValues(alpha: 0.06)
                                        : colors.surface.withValues(alpha: 0.65),
                                    borderRadius: BorderRadius.circular(9999),
                                    border: Border.all(
                                      color: isDark
                                          ? Colors.white.withValues(alpha: 0.12)
                                          : colors.dividerStrong,
                                      width: 0.8,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CustomPaint(
                                        size: const Size(17, 17),
                                        painter: isSolarSunset
                                            ? _SunsetIconPainter()
                                            : _SunriseIconPainter(),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        solarLabel,
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                              color: colors.textSecondary,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.5,
                                              height: 1.0,
                                            ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        solarTime,
                                        style: AppTypography.timerStyle(
                                          color: colors.textPrimary,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ).copyWith(height: 1.0),
                                      ),
                                      const SizedBox(width: 1),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        size: 14,
                                        color: colors.textTertiary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(width: 14),

                    // Right Section: Circular Progress Ring with Timer
                    SizedBox(
                      width: 104,
                      height: 104,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(104, 104),
                            painter: _CountdownRingPainter(
                              progress: _dynamicProgress.clamp(0.0, 1.0),
                              trackColor: accentColor.withValues(alpha: isDark ? 0.15 : 0.12),
                              progressColor: accentColor,
                            ),
                          ),
                          _BlinkingProgressTipDot(
                            progress: _dynamicProgress.clamp(0.0, 1.0),
                            size: 104,
                            dotColor: accentColor,
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
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'remaining',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: colors.textSecondary,
                                      letterSpacing: 0.5,
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
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

class _SunriseIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;

    final rayPaint = Paint()
      ..color = const Color(0xFFF59E0B)
      ..strokeWidth = 2.2 * scale
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // 5 Morning rays
    canvas.drawLine(Offset(12 * scale, 2 * scale), Offset(12 * scale, 5 * scale), rayPaint);
    canvas.drawLine(Offset(4.9 * scale, 4.9 * scale), Offset(7.1 * scale, 7.1 * scale), rayPaint);
    canvas.drawLine(Offset(19.1 * scale, 4.9 * scale), Offset(16.9 * scale, 7.1 * scale), rayPaint);
    canvas.drawLine(Offset(2 * scale, 12 * scale), Offset(4.5 * scale, 12 * scale), rayPaint);
    canvas.drawLine(Offset(22 * scale, 12 * scale), Offset(19.5 * scale, 12 * scale), rayPaint);

    // Rising Sun dome
    final sunPath = Path()
      ..addArc(
        Rect.fromCircle(center: Offset(12 * scale, 16 * scale), radius: 6 * scale),
        math.pi,
        math.pi,
      )
      ..close();

    final sunFill = Paint()
      ..color = const Color(0xFFFBBF24)
      ..style = PaintingStyle.fill;
    final sunStroke = Paint()
      ..color = const Color(0xFFF59E0B)
      ..strokeWidth = 1.5 * scale
      ..style = PaintingStyle.stroke;

    canvas.drawPath(sunPath, sunFill);
    canvas.drawPath(sunPath, sunStroke);

    // Horizon line
    final horizonPaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..strokeWidth = 2.0 * scale
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(2 * scale, 17 * scale), Offset(22 * scale, 17 * scale), horizonPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SunsetIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;

    final rayPaint = Paint()
      ..color = const Color(0xFFEA580C)
      ..strokeWidth = 2.0 * scale
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Setting sun rays
    canvas.drawLine(Offset(12 * scale, 4 * scale), Offset(12 * scale, 6.5 * scale), rayPaint);
    canvas.drawLine(Offset(6 * scale, 6.5 * scale), Offset(8 * scale, 8.5 * scale), rayPaint);
    canvas.drawLine(Offset(18 * scale, 6.5 * scale), Offset(16 * scale, 8.5 * scale), rayPaint);

    // Setting Sun dome
    final sunPath = Path()
      ..addArc(
        Rect.fromCircle(center: Offset(12 * scale, 15 * scale), radius: 5 * scale),
        math.pi,
        math.pi,
      )
      ..close();

    final sunFill = Paint()
      ..color = const Color(0xFFF97316)
      ..style = PaintingStyle.fill;
    final sunStroke = Paint()
      ..color = const Color(0xFFEA580C)
      ..strokeWidth = 1.5 * scale
      ..style = PaintingStyle.stroke;

    canvas.drawPath(sunPath, sunFill);
    canvas.drawPath(sunPath, sunStroke);

    // Horizon line
    final horizonPaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..strokeWidth = 2.0 * scale
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(2 * scale, 16 * scale), Offset(22 * scale, 16 * scale), horizonPaint);

    // Water dusk reflection ripple lines
    final ripple1Paint = Paint()
      ..color = const Color(0xFFEA580C)
      ..strokeWidth = 2.0 * scale
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(7 * scale, 19 * scale), Offset(17 * scale, 19 * scale), ripple1Paint);

    final ripple2Paint = Paint()
      ..color = const Color(0xFFEA580C).withValues(alpha: 0.8)
      ..strokeWidth = 1.8 * scale
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(9.5 * scale, 21.5 * scale), Offset(14.5 * scale, 21.5 * scale), ripple2Paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
      width: 5.5,
      height: 5.5,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.5),
            blurRadius: 3,
            spreadRadius: 0.5,
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
