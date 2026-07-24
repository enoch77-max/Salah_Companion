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

  const HijriStrip({
    super.key,
    this.dateTime,
    this.hijriOffset = 0,
    this.locationName = 'Riyadh, Saudi Arabia',
    this.isTimezoneMismatched = false,
    this.onTimezoneMismatchTap,
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
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: colors.dividerStrong,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Hijri Date with Crescent Moon Icon
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.dark_mode_outlined,
                    size: 20,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    hijriString,
                    key: const ValueKey('hijri_date_text'),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),

              // Location Subtitle Badge
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: colors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    locationName,
                    key: const ValueKey('location_name_text'),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ],
          ),

          // Timezone Mismatch Banner Badge
          if (isTimezoneMismatched) ...[
            const SizedBox(height: 10),
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 14,
                      color: colors.primaryText,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Using GPS location — device timezone differs',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colors.primaryText,
                              fontWeight: FontWeight.w500,
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
