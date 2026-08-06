import 'package:flutter/material.dart';
import 'package:hijri_calendar/hijri_calendar.dart';

import '../../../../app/theme/app_theme.dart';

/// Strip Widget rendering current Hijri date, location subtitle,
/// and optional timezone mismatch banner pill.
class HijriStrip extends StatelessWidget {
  final DateTime? dateTime;
  final int hijriOffset;
  final String locationName;
  final bool isTimezoneMismatched;
  final VoidCallback? onTimezoneMismatchTap;
  final bool isLocationFallback;
  final String? locationStatusMessage;
  final VoidCallback? onLocationBannerTap;

  const HijriStrip({
    super.key,
    this.dateTime,
    this.hijriOffset = 0,
    this.locationName = 'Riyadh, Saudi Arabia',
    this.isTimezoneMismatched = false,
    this.onTimezoneMismatchTap,
    this.isLocationFallback = false,
    this.locationStatusMessage,
    this.onLocationBannerTap,
  });

  String _formatHijriDate(DateTime date, int offsetDays) {
    final adjustedDate = date.add(Duration(days: offsetDays));
    final hDate = HijriCalendarConfig.fromGregorian(adjustedDate);
    return '${hDate.hDay} ${hDate.getLongMonthName()} ${hDate.hYear} AH';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final targetDate = dateTime ?? DateTime.now();
    final hijriString = _formatHijriDate(targetDate, hijriOffset);

    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: colors.elevatedBackground,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colors.dividerStrong,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Hijri Date with Sleek Micro Icon Badge
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.dark_mode_rounded,
                    size: 16,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    hijriString,
                    key: const ValueKey('hijri_date_text'),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 13.5,
                          letterSpacing: -0.2,
                        ),
                  ),
                ],
              ),

              // Sleek Location Subtitle Badge Pill
              GestureDetector(
                onTap: isLocationFallback ? onLocationBannerTap : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: ShapeDecoration(
                    color: isLocationFallback ? colors.primarySoft : colors.surface,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: isLocationFallback
                            ? colors.primary.withValues(alpha: 0.3)
                            : colors.divider,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isLocationFallback ? Icons.location_off_rounded : Icons.location_on_rounded,
                        size: 12,
                        color: isLocationFallback ? colors.primary : colors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        locationName,
                        key: const ValueKey('location_name_text'),
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: isLocationFallback ? colors.primaryText : colors.textSecondary,
                              fontWeight: isLocationFallback ? FontWeight.w700 : FontWeight.w600,
                              fontSize: 11.5,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Location Fallback Actionable Banner Badge
          if (isLocationFallback) ...[
            const SizedBox(height: 6),
            GestureDetector(
              onTap: onLocationBannerTap,
              child: Container(
                key: const ValueKey('location_fallback_banner'),
                decoration: ShapeDecoration(
                  color: colors.primarySoft,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: colors.primaryGlow,
                      width: 1.0,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.gps_off_rounded,
                      size: 14,
                      color: colors.primaryText,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        locationStatusMessage ?? 'GPS disabled. Tap to enable location for exact times.',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colors.primaryText,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 14,
                      color: colors.primaryText,
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Timezone Mismatch Banner Badge
          if (isTimezoneMismatched) ...[
            const SizedBox(height: 6),
            GestureDetector(
              onTap: onTimezoneMismatchTap,
              child: Container(
                key: const ValueKey('timezone_mismatch_banner'),
                decoration: ShapeDecoration(
                  color: colors.primarySoft,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: colors.primaryGlow,
                      width: 1.0,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 13,
                      color: colors.primaryText,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Using GPS location — device timezone differs',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
