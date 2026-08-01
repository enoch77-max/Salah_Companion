import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/app_theme.dart';

/// Modal bottom sheet celebrating the completion of all 5 daily prayers today.
class PrayerStreakSheet extends StatelessWidget {
  final VoidCallback? onDismiss;

  const PrayerStreakSheet({
    super.key,
    this.onDismiss,
  });

  /// Displays the 5-Prayer Streak celebration bottom sheet with haptic feedback.
  static Future<T?> show<T>(BuildContext context, {VoidCallback? onDismiss}) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.65),
      builder: (sheetContext) => PrayerStreakSheet(onDismiss: onDismiss),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textTheme = Theme.of(context).textTheme;

    const dailyPrayers = [
      {'name': 'Fajr', 'time': 'Dawn'},
      {'name': 'Dhuhr', 'time': 'Noon'},
      {'name': 'Asr', 'time': 'Afternoon'},
      {'name': 'Maghrib', 'time': 'Sunset'},
      {'name': 'Isha', 'time': 'Night'},
    ];

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
      child: Container(
        decoration: ShapeDecoration(
          color: colors.elevatedBackground.withValues(alpha: 0.95),
          shape: ContinuousRectangleBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            side: BorderSide(
              color: colors.success.withValues(alpha: 0.4),
              width: 1.2,
            ),
          ),
          shadows: [
            BoxShadow(
              color: colors.successGlow.withValues(alpha: 0.3),
              blurRadius: 30,
              spreadRadius: 4,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Drag Handle
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.dividerStrong,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // Glowing Animated Star & Checkmark Badge Icon
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: colors.successSoft,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colors.success.withValues(alpha: 0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.success.withValues(alpha: 0.35),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: colors.success,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.verified_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.3, 0.3),
                    end: const Offset(1.0, 1.0),
                    duration: 400.ms,
                    curve: Curves.elasticOut,
                  )
                  .fade(duration: 200.ms),

              const SizedBox(height: 16),

              // Title
              Text(
                'ALL 5 PRAYERS COMPLETED!',
                textAlign: TextAlign.center,
                style: textTheme.labelMedium?.copyWith(
                  color: colors.successText,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 1.4,
                ),
              ).animate().fade(delay: 150.ms, duration: 250.ms),

              const SizedBox(height: 6),

              // Subtitle
              Text(
                "Masha'Allah! You have completed all 5 daily prayers today.",
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ).animate().fade(delay: 200.ms, duration: 250.ms),

              const SizedBox(height: 20),

              // Staggered 5 Daily Prayer Chips Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(dailyPrayers.length, (index) {
                  final prayer = dailyPrayers[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: colors.success,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: colors.success.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        prayer['name']!,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .scale(
                        delay: (250 + (index * 60)).ms,
                        duration: 350.ms,
                        curve: Curves.elasticOut,
                        begin: const Offset(0.2, 0.2),
                        end: const Offset(1.0, 1.0),
                      )
                      .fade(delay: (250 + (index * 60)).ms, duration: 200.ms);
                }),
              ),

              const SizedBox(height: 22),

              // Quranic Verse Card
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: ShapeDecoration(
                  color: colors.surface.withValues(alpha: 0.6),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: colors.dividerStrong,
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'إِنَّ الصَّلَاةَ كَانَتْ عَلَى الْمُؤْمِنِينَ كِتَابًا مَّوْقُوتًا',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 17,
                        height: 1.8,
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '“Indeed, prayer has been decreed upon the believers a decree of specified times.” — Surah An-Nisa (4:103)',
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                        fontSize: 11.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ).animate().fade(delay: 550.ms, duration: 300.ms),

              const SizedBox(height: 22),

              // Primary Dismiss Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).pop();
                    onDismiss?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.success,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'ALHAMDULILLAH',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ).animate().fade(delay: 600.ms, duration: 300.ms),
            ],
          ),
        ),
      ),
    );
  }
}
