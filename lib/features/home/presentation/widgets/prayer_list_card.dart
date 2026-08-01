import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/app_haptics.dart';

enum PrayerStatus {
  pending,
  prayed,
  missed;

  PrayerStatus get next {
    switch (this) {
      case PrayerStatus.pending:
        return PrayerStatus.prayed;
      case PrayerStatus.prayed:
        return PrayerStatus.pending;
      case PrayerStatus.missed:
        return PrayerStatus.prayed;
    }
  }
}

class PrayerItem {
  final String name;
  final String time;
  final String? endTime;
  final PrayerStatus status;
  final bool isCurrent;
  final bool isNext;
  final bool isSunrise;
  final bool isFuture;

  const PrayerItem({
    required this.name,
    required this.time,
    this.endTime,
    this.status = PrayerStatus.pending,
    this.isCurrent = false,
    this.isNext = false,
    this.isSunrise = false,
    this.isFuture = false,
  });

  PrayerItem copyWith({
    String? name,
    String? time,
    String? endTime,
    PrayerStatus? status,
    bool? isCurrent,
    bool? isNext,
    bool? isSunrise,
    bool? isFuture,
  }) {
    return PrayerItem(
      name: name ?? this.name,
      time: time ?? this.time,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      isCurrent: isCurrent ?? this.isCurrent,
      isNext: isNext ?? this.isNext,
      isSunrise: isSunrise ?? this.isSunrise,
      isFuture: isFuture ?? this.isFuture,
    );
  }
}

/// Card component rendering 5 daily prayers + Sunrise with iOS squircle icon badges,
/// interactive status toggles, haptics, and continuous squircle borders.
class PrayerListCard extends StatefulWidget {
  final List<PrayerItem>? prayers;
  final Function(int index, PrayerStatus newStatus)? onStatusChanged;
  /// Sunrise DateTime for computing the forbidden nafl window (sunrise → sunrise+20min).
  final DateTime? sunriseDateTime;
  /// Dhuhr DateTime for computing the zawal forbidden window (dhuhr-10min → dhuhr).
  final DateTime? dhuhrDateTime;
  /// Maghrib (sunset) DateTime for computing the sunset forbidden window (maghrib-20min → maghrib).
  final DateTime? maghribDateTime;

  const PrayerListCard({
    super.key,
    this.prayers,
    this.onStatusChanged,
    this.sunriseDateTime,
    this.dhuhrDateTime,
    this.maghribDateTime,
  });

  static const List<PrayerItem> defaultPrayers = [
    PrayerItem(name: 'Fajr', time: '04:45 AM', status: PrayerStatus.prayed),
    PrayerItem(name: 'Sunrise', time: '06:05 AM', isSunrise: true),
    PrayerItem(name: 'Dhuhr', time: '12:15 PM', status: PrayerStatus.pending, isNext: true),
    PrayerItem(name: 'Asr', time: '03:30 PM', status: PrayerStatus.pending, isFuture: true),
    PrayerItem(name: 'Maghrib', time: '06:20 PM', status: PrayerStatus.pending, isFuture: true),
    PrayerItem(name: 'Isha', time: '07:50 PM', status: PrayerStatus.pending, isFuture: true),
  ];

  @override
  State<PrayerListCard> createState() => _PrayerListCardState();
}

class _PrayerListCardState extends State<PrayerListCard> {
  late List<PrayerItem> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.prayers != null
        ? List.from(widget.prayers!)
        : List.from(PrayerListCard.defaultPrayers);
  }

  @override
  void didUpdateWidget(covariant PrayerListCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.prayers != null) {
      _items = List.from(widget.prayers!);
    }
  }

  void _handleToggle(int index) {
    final item = _items[index];
    if (item.isFuture) {
      AppHaptics.light();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.name} prayer time has not started yet (${item.time})'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }
    AppHaptics.prayerStatusChanged();
    final PrayerStatus newStatus;
    if (item.status == PrayerStatus.pending) {
      newStatus = PrayerStatus.prayed;
    } else if (item.status == PrayerStatus.prayed) {
      newStatus = PrayerStatus.pending;
    } else {
      newStatus = PrayerStatus.prayed;
    }

    final updatedItem = item.copyWith(status: newStatus);
    setState(() {
      _items[index] = updatedItem;
    });
    widget.onStatusChanged?.call(index, newStatus);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      decoration: ShapeDecoration(
        color: colors.elevatedBackground,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: colors.dividerStrong,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: Text(
              'TODAY\'S PRAYERS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.textSecondary,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 12),
          Builder(
            builder: (context) {
              final displayItems = _items.where((item) => !item.isSunrise && item.name != 'Sunrise').toList();
              final hasCurrentUnprayed = displayItems.any((i) => i.isCurrent && i.status != PrayerStatus.prayed);
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayItems.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = displayItems[index];
                  final realIndex = _items.indexWhere((i) => i.name == item.name);
                  return _PrayerRowItem(
                    key: ValueKey('prayer_row_${item.name}'),
                    item: item,
                    hasCurrentUnprayed: hasCurrentUnprayed,
                    onToggle: () => _handleToggle(realIndex >= 0 ? realIndex : index),
                  );
                },
              );
            },
          ),
          // Dynamic Forbidden Nafl Prayer Note
          if (widget.sunriseDateTime != null &&
              widget.dhuhrDateTime != null &&
              widget.maghribDateTime != null)
            _ForbiddenNaflNote(
              sunrise: widget.sunriseDateTime!,
              dhuhr: widget.dhuhrDateTime!,
              maghrib: widget.maghribDateTime!,
            ),
        ],
      ),
    );
  }
}

class _SunnahInfo {
  final String label;
  final String importance;

  const _SunnahInfo({
    required this.label,
    required this.importance,
  });
}

class _PrayerRowItem extends StatefulWidget {
  final PrayerItem item;
  final bool hasCurrentUnprayed;
  final VoidCallback onToggle;

  const _PrayerRowItem({
    super.key,
    required this.item,
    this.hasCurrentUnprayed = false,
    required this.onToggle,
  });

  @override
  State<_PrayerRowItem> createState() => _PrayerRowItemState();
}

_SunnahInfo _getSunnahInfo(String prayerName) {
  switch (prayerName.toLowerCase()) {
    case 'fajr':
      return const _SunnahInfo(
        label: "2 Raka'at Sunnah Before",
        importance: "Sunnah Mu'akkadah",
      );
    case 'dhuhr':
      return const _SunnahInfo(
        label: "4 Raka'at Before & 2 After",
        importance: "Sunnah Mu'akkadah",
      );
    case 'asr':
      return const _SunnahInfo(
        label: "4 Raka'at Sunnah Before",
        importance: "Sunnah Ghair Mu'akkadah",
      );
    case 'maghrib':
      return const _SunnahInfo(
        label: "2 Raka'at Sunnah After",
        importance: "Sunnah Mu'akkadah",
      );
    case 'isha':
      return const _SunnahInfo(
        label: "2 Raka'at After + 3 Witr",
        importance: "Sunnah & Wajib Witr",
      );
    default:
      return const _SunnahInfo(
        label: "Sunnah Prayer",
        importance: "Voluntary Prayer",
      );
  }
}

class _PrayerRowItemState extends State<_PrayerRowItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  IconData _getPrayerIcon(String name, bool isSunrise) {
    if (isSunrise) return Icons.wb_sunny_rounded;
    switch (name.toLowerCase()) {
      case 'fajr':
        return Icons.wb_twilight_rounded;
      case 'dhuhr':
        return Icons.wb_sunny_rounded;
      case 'asr':
        return Icons.wb_cloudy_rounded;
      case 'maghrib':
        return Icons.nights_stay_rounded;
      case 'isha':
        return Icons.bedtime_rounded;
      default:
        return Icons.access_time_rounded;
    }
  }

  Color _getSquircleBadgeColor(String name, bool isSunrise) {
    if (isSunrise) return const Color(0xFFF59E0B);
    switch (name.toLowerCase()) {
      case 'fajr':
        return const Color(0xFF6366F1);
      case 'dhuhr':
        return const Color(0xFF0284C7);
      case 'asr':
        return const Color(0xFF0D9488);
      case 'maghrib':
        return const Color(0xFFEC4899);
      case 'isha':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF64748B);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final item = widget.item;

    Color badgeBg;
    Color badgeText;
    IconData statusIcon;
    String statusLabel;

    switch (item.status) {
      case PrayerStatus.prayed:
        badgeBg = colors.successSoft;
        badgeText = colors.successText;
        statusIcon = Icons.check_circle_rounded;
        statusLabel = 'Prayed';
        break;
      case PrayerStatus.missed:
        badgeBg = colors.missedSoft;
        badgeText = colors.missedText;
        statusIcon = Icons.cancel_rounded;
        statusLabel = 'Missed';
        break;
      case PrayerStatus.pending:
        if (item.isCurrent) {
          badgeBg = colors.primarySoft;
          badgeText = colors.primaryText;
          statusIcon = Icons.radio_button_unchecked_rounded;
          statusLabel = 'Not Prayed';
        } else if (item.isNext) {
          badgeBg = colors.primary.withValues(alpha: 0.12);
          badgeText = colors.primary;
          statusIcon = Icons.circle_outlined;
          statusLabel = 'Upcoming';
        } else if (item.isFuture) {
          badgeBg = colors.surface;
          badgeText = colors.textTertiary;
          statusIcon = Icons.circle_outlined;
          statusLabel = 'Not yet';
        } else {
          badgeBg = colors.surface;
          badgeText = colors.textSecondary;
          statusIcon = Icons.circle_outlined;
          statusLabel = 'Pending';
        }
        break;
    }

    final squircleColor = _getSquircleBadgeColor(item.name, item.isSunrise);
    final isPrayed = item.status == PrayerStatus.prayed;
    final isSelected = item.isCurrent
        ? !isPrayed
        : (item.isNext && !widget.hasCurrentUnprayed && !isPrayed);
    final sunnahInfo = _getSunnahInfo(item.name);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          decoration: ShapeDecoration(
            color: isSelected
                ? (isPrayed ? colors.successSoft : colors.paperBackground)
                : (isPrayed ? colors.successSoft.withValues(alpha: 0.5) : colors.surface),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected
                    ? (isPrayed ? colors.success.withValues(alpha: 0.5) : colors.primary.withValues(alpha: 0.6))
                    : (isPrayed ? colors.success.withValues(alpha: 0.25) : colors.divider),
                width: isSelected ? 1.8 : 1.0,
              ),
            ),
            shadows: isSelected
                ? [
                    BoxShadow(
                      color: (isPrayed ? colors.success : colors.primary).withValues(alpha: 0.12),
                      blurRadius: 12,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Squircle Icon Badge
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isPrayed ? colors.success : squircleColor,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: (isPrayed ? colors.success : squircleColor).withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              )
                            ]
                          : null,
                    ),
                    child: Icon(
                      isPrayed ? Icons.check_rounded : _getPrayerIcon(item.name, item.isSunrise),
                      key: ValueKey('icon_${item.name}_${item.status.name}'),
                      size: 20,
                      color: Colors.white,
                    )
                        .animate(key: ValueKey('anim_icon_${item.name}_${item.status.name}'))
                        .scale(
                          begin: const Offset(0.5, 0.5),
                          end: const Offset(1.0, 1.0),
                          duration: 220.ms,
                          curve: Curves.elasticOut,
                        )
                        .fade(duration: 150.ms),
                  ),
                  const SizedBox(width: 14),

                  // Middle Column: Salah Name & Start/End Time Subtitle
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                item.name,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: isPrayed ? colors.successText : colors.textPrimary,
                                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                      fontSize: isSelected ? 17.5 : 16.5,
                                    ),
                              ),
                            ),
                            if (isSelected && !isPrayed) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: item.isCurrent
                                      ? colors.primary.withValues(alpha: 0.22)
                                      : colors.primary.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                  border: item.isCurrent
                                      ? Border.all(color: colors.primary.withValues(alpha: 0.4), width: 1.0)
                                      : null,
                                ),
                                child: Text(
                                  item.isCurrent ? 'CURRENT' : 'NEXT',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w800,
                                    color: colors.primary,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: _TimeCapsulePill(
                            startTime: item.time,
                            endTime: item.endTime,
                            isSunrise: item.isSunrise,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Right: Status Toggle Pill Button
                  if (!item.isSunrise)
                    Semantics(
                      button: true,
                      label: '${item.name} status: $statusLabel',
                      child: InkWell(
                        key: ValueKey('toggle_button_${item.name}'),
                        onTap: widget.onToggle,
                        borderRadius: BorderRadius.circular(14),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOutCubic,
                          decoration: ShapeDecoration(
                            color: badgeBg,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: BorderSide(
                                color: isSelected
                                    ? (isPrayed ? colors.success.withValues(alpha: 0.4) : colors.primary.withValues(alpha: 0.4))
                                    : (isPrayed ? colors.success.withValues(alpha: 0.3) : colors.dividerStrong),
                                width: 1,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          child: Row(
                            key: ValueKey('status_row_${item.name}_${item.status.name}'),
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                statusIcon,
                                size: 14,
                                color: badgeText,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                statusLabel,
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: badgeText,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          )
                              .animate(key: ValueKey('anim_status_row_${item.name}_${item.status.name}'))
                              .scale(
                                begin: const Offset(0.85, 0.85),
                                end: const Offset(1.0, 1.0),
                                duration: 200.ms,
                                curve: Curves.easeOutBack,
                              )
                              .fade(duration: 150.ms),
                        ),
                      ),
                    )
                  else
                    Container(
                      decoration: ShapeDecoration(
                        color: colors.surfaceHover,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      child: Text(
                        'Shuruq',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colors.textTertiary,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                      ),
                    ),
                ],
              ),

              // Sunnah Section (on selected prayer card)
              if (isSelected && !item.isSunrise) ...[
                const SizedBox(height: 12),
                Container(
                  decoration: ShapeDecoration(
                    color: colors.surface.withValues(alpha: 0.6),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                        color: colors.dividerStrong,
                        width: 1,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.menu_book_rounded,
                        size: 16,
                        color: colors.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SUNNAH PRAYER',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.8,
                                color: colors.textTertiary,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              sunnahInfo.label,
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: colors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Dynamic note at the bottom of Today's Prayers card highlighting forbidden times for Nafl (voluntary) prayers.
class _ForbiddenNaflNote extends StatelessWidget {
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime maghrib;

  const _ForbiddenNaflNote({
    required this.sunrise,
    required this.dhuhr,
    required this.maghrib,
  });

  String _formatTime(DateTime dt) {
    final hour = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
    final minute = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:$minute $ampm';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final now = DateTime.now();

    // Define forbidden windows
    final sunriseEnd = sunrise.add(const Duration(minutes: 20));
    final zawalStart = dhuhr.subtract(const Duration(minutes: 10));
    final sunsetStart = maghrib.subtract(const Duration(minutes: 20));

    final isSunriseForbidden = now.isAfter(sunrise) && now.isBefore(sunriseEnd);
    final isZawalForbidden = now.isAfter(zawalStart) && now.isBefore(dhuhr);
    final isSunsetForbidden = now.isAfter(sunsetStart) && now.isBefore(maghrib);
    final isCurrentlyForbidden = isSunriseForbidden || isZawalForbidden || isSunsetForbidden;

    String headerText;
    String bodyText;
    Color accentColor;
    IconData iconData;

    if (isSunriseForbidden) {
      headerText = 'FORBIDDEN NAFL TIME • SUNRISE';
      bodyText =
          'Sun is rising (${_formatTime(sunrise)} – ${_formatTime(sunriseEnd)}). Voluntary (Nafl) prayers are prohibited until the sun is fully risen. (Sahih Muslim 831)';
      accentColor = colors.missed;
      iconData = Icons.do_not_disturb_on_rounded;
    } else if (isZawalForbidden) {
      headerText = 'FORBIDDEN NAFL TIME • ZENITH (ZAWAL)';
      bodyText =
          'Sun is at its zenith (${_formatTime(zawalStart)} – ${_formatTime(dhuhr)}). Nafl prayers are prohibited during this midday peak. (Sahih Muslim 831)';
      accentColor = colors.missed;
      iconData = Icons.do_not_disturb_on_rounded;
    } else if (isSunsetForbidden) {
      headerText = 'FORBIDDEN NAFL TIME • SUNSET';
      bodyText =
          'Sun is setting (${_formatTime(sunsetStart)} – ${_formatTime(maghrib)}). Nafl prayers are prohibited until sunset is complete. (Sahih Muslim 831)';
      accentColor = colors.missed;
      iconData = Icons.do_not_disturb_on_rounded;
    } else {
      headerText = 'FORBIDDEN TIMES FOR NAFL PRAYERS';
      bodyText =
          'Voluntary (Nafl) prayers are prohibited during sunrise (~20m), solar zenith (~10m before Dhuhr), and sunset (~20m before Maghrib). Obligatory (Fard) make-ups remain valid. (Sahih Muslim 831)';
      accentColor = colors.primary;
      iconData = Icons.info_outline_rounded;
    }

    Widget noteIcon = Icon(
      iconData,
      size: 16,
      color: accentColor,
    );

    if (isCurrentlyForbidden) {
      noteIcon = noteIcon
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .fade(begin: 0.4, end: 1.0, duration: const Duration(milliseconds: 800));
    }

    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: Container(
        decoration: ShapeDecoration(
          color: isCurrentlyForbidden
              ? accentColor.withValues(alpha: 0.12)
              : colors.surface.withValues(alpha: 0.5),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isCurrentlyForbidden
                  ? accentColor.withValues(alpha: 0.4)
                  : colors.dividerStrong,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: noteIcon,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headerText,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: isCurrentlyForbidden ? accentColor : colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    bodyText,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sleek, compact single-row horizontal capsule displaying Start | End prayer times.
class _TimeCapsulePill extends StatelessWidget {
  final String startTime;
  final String? endTime;
  final bool isSunrise;

  const _TimeCapsulePill({
    required this.startTime,
    this.endTime,
    this.isSunrise = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final hasEndTime = !isSunrise && endTime != null && endTime!.isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colors.dividerStrong.withValues(alpha: 0.4),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Start ',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: colors.textTertiary,
            ),
          ),
          Text(
            startTime,
            style: AppTypography.timerStyle(
              color: colors.textPrimary,
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (hasEndTime) ...[
            const SizedBox(width: 5),
            Container(
              width: 0.8,
              height: 10,
              color: colors.dividerStrong.withValues(alpha: 0.45),
            ),
            const SizedBox(width: 5),
            Text(
              'End ',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: colors.textTertiary,
              ),
            ),
            Text(
              endTime!,
              style: AppTypography.timerStyle(
                color: colors.textSecondary,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

