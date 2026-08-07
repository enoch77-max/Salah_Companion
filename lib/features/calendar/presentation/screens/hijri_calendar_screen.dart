import 'package:flutter/material.dart';
import 'package:hijri_calendar/hijri_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';

class IslamicOccasion {
  final int month;
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
  final ValueChanged<int>? onOffsetChanged;

  const HijriCalendarScreen({
    super.key,
    this.initialOffset = 0,
    this.onOffsetChanged,
  });

  static const List<IslamicOccasion> occasions = [
    IslamicOccasion(
      month: 1,
      day: 1,
      title: 'Islamic New Year',
      arabicTitle: 'رأس السنة الهجرية',
      description: 'First day of Muharram marking the Prophet\'s Hijrah.',
    ),
    IslamicOccasion(
      month: 1,
      day: 9,
      title: 'Tasu\'a',
      arabicTitle: 'تاسوعاء',
      description: 'Fasting on the 9th day of Muharram prior to Ashura.',
    ),
    IslamicOccasion(
      month: 1,
      day: 10,
      title: 'Day of Ashura',
      arabicTitle: 'يوم عاشوراء',
      description: 'Blessed day of fasting observing Prophet Musa\'s victory.',
    ),
    IslamicOccasion(
      month: 3,
      day: 12,
      title: 'Mawlid al-Nabi',
      arabicTitle: 'مولد النبي ﷺ',
      description: 'Observance of the birth of Prophet Muhammad (ﷺ).',
    ),
    IslamicOccasion(
      month: 7,
      day: 27,
      title: 'Isra and Mi\'raj',
      arabicTitle: 'الإسراء والمعراج',
      description: 'The miraculous Night Journey and Ascension to Heaven.',
    ),
    IslamicOccasion(
      month: 8,
      day: 15,
      title: 'Mid-Sha\'ban',
      arabicTitle: 'نصف شعبان',
      description: 'Night of worship and preparation for Ramadan.',
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
      day: 17,
      title: 'Battle of Badr',
      arabicTitle: 'غزوة بدر الكبرى',
      description: 'Commemoration of the decisive victory at Badr.',
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
      description: 'Festival of Breaking the Fast marking the end of Ramadan.',
    ),
    IslamicOccasion(
      month: 10,
      day: 2,
      title: 'Six Days of Shawwal Fasting',
      arabicTitle: 'صيام ست من شوال',
      description: 'Recommended 6 days of Sunnah fasting during Shawwal.',
    ),
    IslamicOccasion(
      month: 12,
      day: 1,
      title: 'First Day of Dhu al-Hijjah',
      arabicTitle: 'أول عشر ذي الحجة',
      description: 'Beginning of the 10 most beloved days of good deeds to Allah.',
    ),
    IslamicOccasion(
      month: 12,
      day: 9,
      title: 'Day of Arafah',
      arabicTitle: 'يوم عرفة',
      description: 'The pinnacle day of Hajj pilgrimage and recommended fasting.',
    ),
    IslamicOccasion(
      month: 12,
      day: 10,
      title: 'Eid al-Adha',
      arabicTitle: 'عيد الأضحى',
      description: 'Festival of Sacrifice honoring Ibrahim\'s devotion.',
    ),
    IslamicOccasion(
      month: 12,
      day: 11,
      title: 'Days of Tashreeq',
      arabicTitle: 'أيام التشريق',
      description: 'Days of remembrance, eating, and drinking following Eid.',
    ),
  ];

  @override
  State<HijriCalendarScreen> createState() => _HijriCalendarScreenState();
}

class _HijriCalendarScreenState extends State<HijriCalendarScreen> {
  late int _offset;
  late DateTime _selectedBaseDate;
  late HijriCalendarConfig _currentHijri;
  bool _isGregorian = false;

  static const List<String> _gregorianMonths = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void initState() {
    super.initState();
    HijriCalendarConfig.setLocal('en');
    _offset = widget.initialOffset;
    _selectedBaseDate = DateTime.now();
    _updateHijriDate();
    _loadSavedState();
  }

  Future<void> _loadSavedState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedOffset = prefs.getInt('hijri_offset');
    final savedIsGregorian = prefs.getBool('calendar_is_gregorian');
    if (mounted) {
      setState(() {
        if (savedOffset != null) _offset = savedOffset;
        if (savedIsGregorian != null) _isGregorian = savedIsGregorian;
        _updateHijriDate();
      });
    }
  }

  void _saveModePreference(bool isGregorian) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('calendar_is_gregorian', isGregorian);
  }

  void _updateHijriDate() {
    final adjusted = _selectedBaseDate.add(Duration(days: _offset));
    _currentHijri = HijriCalendarConfig.fromGregorian(adjusted);
  }

  void _setOffset(int newOffset) async {
    setState(() {
      _offset = newOffset;
      _updateHijriDate();
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('hijri_offset', newOffset);
    widget.onOffsetChanged?.call(newOffset);
  }

  void _changeMonth(int increment) {
    setState(() {
      if (_isGregorian) {
        int newYear = _selectedBaseDate.year;
        int newMonth = _selectedBaseDate.month + increment;
        if (newMonth > 12) {
          newYear += 1;
          newMonth = 1;
        } else if (newMonth < 1) {
          newYear -= 1;
          newMonth = 12;
        }
        _selectedBaseDate = DateTime(newYear, newMonth, 1);
        _updateHijriDate();
      } else {
        _selectedBaseDate = _selectedBaseDate.add(Duration(days: increment * 30));
        _updateHijriDate();
      }
    });
  }

  int _getHijriFirstWeekday() {
    try {
      final gDate = _currentHijri.hijriToGregorian(_currentHijri.hYear, _currentHijri.hMonth, 1);
      return gDate.weekday % 7;
    } catch (_) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final now = DateTime.now();

    final todayHijri = HijriCalendarConfig.fromGregorian(now.add(Duration(days: _offset)));

    // Active calendar calculations depending on mode
    final int daysInMonth;
    final int firstDayWeekday;
    final String monthDisplayTitle;
    final String monthDisplaySubtitle;

    if (_isGregorian) {
      final year = _selectedBaseDate.year;
      final month = _selectedBaseDate.month;
      daysInMonth = DateTime(year, month + 1, 0).day;
      firstDayWeekday = DateTime(year, month, 1).weekday % 7;
      monthDisplayTitle = '${_gregorianMonths[month - 1]} $year';
      monthDisplaySubtitle = 'Today: ${now.day} ${_gregorianMonths[now.month - 1]} $year';
    } else {
      daysInMonth = _currentHijri.getDaysInMonth(_currentHijri.hYear, _currentHijri.hMonth);
      firstDayWeekday = _getHijriFirstWeekday();
      monthDisplayTitle = '${_currentHijri.getLongMonthName()} ${_currentHijri.hYear} AH';
      monthDisplaySubtitle = '${_currentHijri.hDay} ${_currentHijri.getLongMonthName()}';
    }

    // Occasions for Key Islamic Occasions section
    final List<_OccasionItemDisplay> currentMonthOccasions = [];

    if (_isGregorian) {
      final year = _selectedBaseDate.year;
      final month = _selectedBaseDate.month;
      for (int d = 1; d <= daysInMonth; d++) {
        final gDate = DateTime(year, month, d);
        final hDate = HijriCalendarConfig.fromGregorian(gDate.add(Duration(days: _offset)));
        for (final occasion in HijriCalendarScreen.occasions) {
          if (occasion.month == hDate.hMonth && occasion.day == hDate.hDay) {
            currentMonthOccasions.add(_OccasionItemDisplay(
              occasion: occasion,
              gregorianDay: d,
              gregorianMonthName: _gregorianMonths[month - 1],
              hijriMonthName: hDate.getLongMonthName(),
              hijriDay: hDate.hDay,
            ));
          }
        }
      }
    } else {
      final occurrences = HijriCalendarScreen.occasions
          .where((o) => o.month == _currentHijri.hMonth)
          .toList()
        ..sort((a, b) => a.day.compareTo(b.day));
      for (final occasion in occurrences) {
        currentMonthOccasions.add(_OccasionItemDisplay(
          occasion: occasion,
          hijriMonthName: _currentHijri.getLongMonthName(),
          hijriDay: occasion.day,
        ));
      }
    }

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: RepaintBoundary(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display Title
              Text(
                _isGregorian ? 'English Calendar' : 'Hijri Calendar',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 32,
                      letterSpacing: -0.2,
                    ),
              ),
              const SizedBox(height: 16),

              // ─── APPLE-STYLE CALENDAR MODE SEGMENTED TOGGLE ──────────────────────
              Container(
                height: 46,
                padding: const EdgeInsets.all(4),
                decoration: ShapeDecoration(
                  color: colors.surface,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: colors.divider, width: 1.0),
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = (constraints.maxWidth) / 2;
                    return Stack(
                      children: [
                        // Animated sliding pill background
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOutCubic,
                          left: _isGregorian ? itemWidth : 0,
                          top: 0,
                          bottom: 0,
                          width: itemWidth,
                          child: Container(
                            decoration: ShapeDecoration(
                              color: colors.primarySoft,
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: colors.primary.withValues(alpha: 0.5), width: 1.0),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: colors.primary.withValues(alpha: 0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Toggle Buttons
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                key: const ValueKey('calendar_mode_hijri'),
                                onTap: () {
                                  if (_isGregorian) {
                                    setState(() {
                                      _isGregorian = false;
                                      _updateHijriDate();
                                    });
                                    _saveModePreference(false);
                                  }
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.nights_stay_rounded,
                                        size: 15,
                                        color: !_isGregorian ? colors.primaryText : colors.textSecondary,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Hijri Calendar',
                                        style: TextStyle(
                                          color: !_isGregorian ? colors.primaryText : colors.textSecondary,
                                          fontWeight: !_isGregorian ? FontWeight.bold : FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                key: const ValueKey('calendar_mode_gregorian'),
                                onTap: () {
                                  if (!_isGregorian) {
                                    setState(() {
                                      _isGregorian = true;
                                      _updateHijriDate();
                                    });
                                    _saveModePreference(true);
                                  }
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.calendar_month_rounded,
                                        size: 15,
                                        color: _isGregorian ? colors.primaryText : colors.textSecondary,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'English Calendar',
                                        style: TextStyle(
                                          color: _isGregorian ? colors.primaryText : colors.textSecondary,
                                          fontWeight: _isGregorian ? FontWeight.bold : FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Moon Sighting Offset Selector Card
              Container(
                decoration: ShapeDecoration(
                  color: colors.surface,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(color: colors.divider, width: 1.0),
                  ),
                ),
                padding: const EdgeInsets.all(18.0),
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
                                fontWeight: FontWeight.bold,
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
                      children: [-2, -1, 0, 1, 2].map((offsetValue) {
                        final isSelected = _offset == offsetValue;
                        final label = offsetValue == 0
                            ? '0'
                            : offsetValue > 0
                                ? '+$offsetValue'
                                : '$offsetValue';
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Semantics(
                              button: true,
                              selected: isSelected,
                              label: 'Hijri offset $label',
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  key: ValueKey('offset_chip_$offsetValue'),
                                  onTap: () => _setOffset(offsetValue),
                                  borderRadius: BorderRadius.circular(12),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    alignment: Alignment.center,
                                    decoration: ShapeDecoration(
                                      color: isSelected
                                          ? colors.primary.withValues(alpha: 0.18)
                                          : colors.elevatedBackground,
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        side: BorderSide(
                                          color: isSelected ? colors.primary : colors.divider,
                                          width: isSelected ? 1.5 : 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      label,
                                      style: TextStyle(
                                        color: isSelected ? colors.primary : colors.primaryText.withValues(alpha: 0.85),
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(color: colors.divider, width: 1.0),
                  ),
                ),
                padding: const EdgeInsets.all(20.0),
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
                              monthDisplayTitle,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: colors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                            ),
                            Text(
                              monthDisplaySubtitle,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: colors.primaryText,
                                    fontWeight: FontWeight.w600,
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
                    // Days of week header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((day) {
                        return SizedBox(
                          width: 36,
                          child: Text(
                            day,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: colors.textTertiary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    // Grid of Days
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: firstDayWeekday + daysInMonth,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        if (index < firstDayWeekday) {
                          return const SizedBox.shrink();
                        }

                        final dayNumber = index - firstDayWeekday + 1;
                        final bool isToday;
                        final bool hasOccasion;

                        if (_isGregorian) {
                          final gDate = DateTime(_selectedBaseDate.year, _selectedBaseDate.month, dayNumber);
                          isToday = gDate.year == now.year && gDate.month == now.month && dayNumber == now.day;
                          final hDate = HijriCalendarConfig.fromGregorian(gDate.add(Duration(days: _offset)));
                          hasOccasion = HijriCalendarScreen.occasions.any(
                            (o) => o.month == hDate.hMonth && o.day == hDate.hDay,
                          );
                        } else {
                          isToday = _currentHijri.hMonth == todayHijri.hMonth &&
                              _currentHijri.hYear == todayHijri.hYear &&
                              dayNumber == todayHijri.hDay;
                          hasOccasion = HijriCalendarScreen.occasions.any(
                            (o) => o.month == _currentHijri.hMonth && o.day == dayNumber,
                          );
                        }

                        return Container(
                          decoration: ShapeDecoration(
                            color: isToday
                                ? colors.primary
                                : hasOccasion
                                    ? colors.primarySoft
                                    : colors.elevatedBackground,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: BorderSide(
                                color: isToday
                                    ? colors.primary
                                    : hasOccasion
                                        ? colors.primary.withValues(alpha: 0.5)
                                        : colors.divider,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$dayNumber',
                                  style: TextStyle(
                                    color: isToday
                                        ? Colors.black
                                        : hasOccasion
                                            ? colors.primaryText
                                            : colors.textPrimary,
                                    fontWeight: isToday || hasOccasion ? FontWeight.bold : FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                                if (hasOccasion)
                                  Container(
                                    width: 4,
                                    height: 4,
                                    margin: const EdgeInsets.only(top: 2),
                                    decoration: BoxDecoration(
                                      color: isToday ? Colors.black : colors.primary,
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

              const SizedBox(height: 24),

              // Islamic Occasions Section Header
              Padding(
                padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                child: Text(
                  'KEY ISLAMIC OCCASIONS',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colors.textSecondary,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),

              currentMonthOccasions.isEmpty
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: ShapeDecoration(
                        color: colors.surface,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: colors.divider, width: 1.0),
                        ),
                      ),
                      child: Text(
                        _isGregorian
                            ? 'No major Islamic occasions in this Gregorian month.'
                            : 'No major occasions in this Hijri month.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.textSecondary,
                            ),
                      ),
                    )
                  : Container(
                      decoration: ShapeDecoration(
                        color: colors.surface,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(color: colors.divider, width: 1.0),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: currentMonthOccasions.map((item) {
                          final occasion = item.occasion;
                          final isLast = item == currentMonthOccasions.last;
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 38,
                                      height: 38,
                                      decoration: BoxDecoration(
                                        color: colors.primarySoft,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.event_seat_rounded,
                                        color: colors.primary,
                                        size: 20,
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
                                              Text(
                                                occasion.title,
                                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                      color: colors.textPrimary,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                              Text(
                                                item.dateBadge,
                                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                      color: colors.primaryText,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            item.subtitle,
                                            style: AppTypography.quranicStyle(
                                              fontSize: 16,
                                              color: colors.primary,
                                            ),
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
                              if (!isLast)
                                Divider(
                                  height: 1,
                                  thickness: 0.8,
                                  indent: 68,
                                  color: colors.divider,
                                ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
  }
}

class _OccasionItemDisplay {
  final IslamicOccasion occasion;
  final int? gregorianDay;
  final String? gregorianMonthName;
  final String hijriMonthName;
  final int hijriDay;

  const _OccasionItemDisplay({
    required this.occasion,
    this.gregorianDay,
    this.gregorianMonthName,
    required this.hijriMonthName,
    required this.hijriDay,
  });

  String get dateBadge {
    if (gregorianDay != null && gregorianMonthName != null) {
      return '$gregorianMonthName $gregorianDay';
    }
    return '$hijriDay $hijriMonthName';
  }

  String get subtitle {
    if (gregorianDay != null) {
      return '${occasion.arabicTitle} ($hijriDay $hijriMonthName)';
    }
    return occasion.arabicTitle;
  }
}
