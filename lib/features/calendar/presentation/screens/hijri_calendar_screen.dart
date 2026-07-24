import 'package:flutter/material.dart';
import 'package:hijri_calendar/hijri_calendar.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';

class IslamicOccasion {
  final int month; // 1-indexed (1 = Muharram)
  final int day;
  final String title;
  final String arabicTitle;
  final String description;

  const IslamicOccasion({
    required this.month,
    required this.day,
    required this.title,
    required this.arabicTitle,
    required this.description,
  });
}

class HijriCalendarScreen extends StatefulWidget {
  final int initialOffset;

  const HijriCalendarScreen({
    super.key,
    this.initialOffset = 0,
  });

  static const List<IslamicOccasion> occasions = [
    IslamicOccasion(
      month: 1,
      day: 1,
      title: 'Islamic New Year',
      arabicTitle: 'رأس السنة الهجرية',
      description: 'First day of Muharram, marking the beginning of the Hijri year.',
    ),
    IslamicOccasion(
      month: 1,
      day: 10,
      title: 'Day of Ashura',
      arabicTitle: 'يوم عاشوراء',
      description: 'The 10th of Muharram, a day of fasting and remembrance.',
    ),
    IslamicOccasion(
      month: 3,
      day: 12,
      title: 'Mawlid an-Nabi',
      arabicTitle: 'مولد النبي',
      description: 'Observance of the birth of Prophet Muhammad (ﷺ).',
    ),
    IslamicOccasion(
      month: 7,
      day: 27,
      title: 'Isra and Mi\'raj',
      arabicTitle: 'الإسراء والمعراج',
      description: 'The miraculous night journey and ascension of the Prophet (ﷺ).',
    ),
    IslamicOccasion(
      month: 8,
      day: 15,
      title: 'Mid-Sha\'ban',
      arabicTitle: 'نصف شعبان',
      description: 'Night of forgiveness and preparation for Ramadan.',
    ),
    IslamicOccasion(
      month: 9,
      day: 1,
      title: 'First Day of Ramadan',
      arabicTitle: 'أول يوم رمضان',
      description: 'Start of the holy month of fasting.',
    ),
    IslamicOccasion(
      month: 9,
      day: 27,
      title: 'Laylat al-Qadr',
      arabicTitle: 'ليلة القدر',
      description: 'The Night of Power, better than a thousand months.',
    ),
    IslamicOccasion(
      month: 10,
      day: 1,
      title: 'Eid al-Fitr',
      arabicTitle: 'عيد الفطر',
      description: 'Festival marking the end of Ramadan.',
    ),
    IslamicOccasion(
      month: 12,
      day: 9,
      title: 'Day of Arafah',
      arabicTitle: 'يوم عرفة',
      description: 'The pinnacle day of Hajj pilgrimage.',
    ),
    IslamicOccasion(
      month: 12,
      day: 10,
      title: 'Eid al-Adha',
      arabicTitle: 'عيد الأضحى',
      description: 'Festival of Sacrifice.',
    ),
  ];

  @override
  State<HijriCalendarScreen> createState() => _HijriCalendarScreenState();
}

class _HijriCalendarScreenState extends State<HijriCalendarScreen> {
  late int _offset;
  late DateTime _selectedBaseDate;
  late HijriCalendarConfig _currentHijri;

  @override
  void initState() {
    super.initState();
    HijriCalendarConfig.setLocal('en');
    _offset = widget.initialOffset;
    _selectedBaseDate = DateTime.now();
    _updateHijriDate();
  }

  void _updateHijriDate() {
    final adjusted = _selectedBaseDate.add(Duration(days: _offset));
    _currentHijri = HijriCalendarConfig.fromGregorian(adjusted);
  }

  void _setOffset(int newOffset) {
    setState(() {
      _offset = newOffset;
      _updateHijriDate();
    });
  }

  void _changeMonth(int increment) {
    setState(() {
      _selectedBaseDate = _selectedBaseDate.add(Duration(days: increment * 30));
      _updateHijriDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final todayHijri = HijriCalendarConfig.fromGregorian(DateTime.now().add(Duration(days: _offset)));
    final daysInMonth = _currentHijri.getDaysInMonth(_currentHijri.hYear, _currentHijri.hMonth);
    final monthName = _currentHijri.getLongMonthName();
    final year = _currentHijri.hYear;

    final currentMonthOccasions = HijriCalendarScreen.occasions
        .where((o) => o.month == _currentHijri.hMonth)
        .toList();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Hijri Calendar',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Moon Sighting Offset Selector Card
            Container(
              decoration: ShapeDecoration(
                color: colors.elevatedBackground,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: colors.dividerStrong, width: 1.0),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MOON-SIGHTING ADJUSTMENT',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colors.textSecondary,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        _offset == 0
                            ? 'Default (0d)'
                            : '${_offset > 0 ? '+' : ''}$_offset day${_offset.abs() > 1 ? 's' : ''}',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: colors.primaryText,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [-2, -1, 0, 1, 2].map((offsetValue) {
                      final isSelected = _offset == offsetValue;
                      final label = offsetValue == 0
                          ? '0'
                          : offsetValue > 0
                              ? '+$offsetValue'
                              : '$offsetValue';
                      return ChoiceChip(
                        key: ValueKey('offset_chip_$offsetValue'),
                        label: Text(label),
                        selected: isSelected,
                        selectedColor: colors.primarySoft,
                        backgroundColor: colors.surface,
                        labelStyle: TextStyle(
                          color: isSelected ? colors.primaryText : colors.textSecondary,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                        side: BorderSide(
                          color: isSelected ? colors.primary : colors.divider,
                        ),
                        onSelected: (selected) {
                          if (selected) _setOffset(offsetValue);
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Calendar Month Header & Navigation Card
            Container(
              decoration: ShapeDecoration(
                color: colors.surface,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: colors.divider, width: 1.0),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        key: const ValueKey('prev_month_button'),
                        icon: Icon(Icons.chevron_left_rounded, color: colors.textPrimary),
                        onPressed: () => _changeMonth(-1),
                      ),
                      Column(
                        children: [
                          Text(
                            '$monthName $year AH',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      IconButton(
                        key: const ValueKey('next_month_button'),
                        icon: Icon(Icons.chevron_right_rounded, color: colors.textPrimary),
                        onPressed: () => _changeMonth(1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Calendar Grid of Days (1..29 or 30)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: daysInMonth,
                    itemBuilder: (context, index) {
                      final dayNum = index + 1;
                      final isToday = dayNum == todayHijri.hDay &&
                          _currentHijri.hMonth == todayHijri.hMonth &&
                          _currentHijri.hYear == todayHijri.hYear;

                      final hasOccasion = HijriCalendarScreen.occasions.any(
                        (o) => o.month == _currentHijri.hMonth && o.day == dayNum,
                      );

                      return Container(
                        decoration: ShapeDecoration(
                          color: isToday
                              ? colors.primary
                              : hasOccasion
                                  ? colors.primarySoft
                                  : colors.surfaceHover,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: isToday
                                  ? colors.primary
                                  : hasOccasion
                                      ? colors.primary
                                      : colors.divider,
                              width: isToday || hasOccasion ? 1.5 : 1.0,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$dayNum',
                                style: AppTypography.timerStyle(
                                  fontSize: 16,
                                  color: isToday
                                      ? colors.background
                                      : hasOccasion
                                          ? colors.primaryText
                                          : colors.textPrimary,
                                  fontWeight: isToday || hasOccasion
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                              ),
                              if (hasOccasion)
                                Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: isToday ? colors.background : colors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Islamic Occasions List
            Text(
              'KEY ISLAMIC OCCASIONS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.textSecondary,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),

            if (currentMonthOccasions.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Occasions in $monthName:',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: colors.primaryText,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],

            ...HijriCalendarScreen.occasions.map((occasion) {
              final isCurrentMonth = occasion.month == _currentHijri.hMonth;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  decoration: ShapeDecoration(
                    color: isCurrentMonth ? colors.primarySoft : colors.surface,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(
                        color: isCurrentMonth ? colors.primary : colors.divider,
                        width: isCurrentMonth ? 1.5 : 1.0,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: ShapeDecoration(
                          color: isCurrentMonth ? colors.primary : colors.surfaceHover,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${occasion.day}',
                            style: AppTypography.timerStyle(
                              fontSize: 18,
                              color: isCurrentMonth ? colors.background : colors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    occasion.title,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          color: colors.textPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                Text(
                                  occasion.arabicTitle,
                                  style: AppTypography.uiArabicStyle(
                                    fontSize: 14,
                                    color: colors.primaryText,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              occasion.description,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: colors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
