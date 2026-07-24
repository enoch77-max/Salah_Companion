import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';

enum PrayerStatus {
  pending,
  prayed,
  missed;

  PrayerStatus get next {
    switch (this) {
      case PrayerStatus.pending:
        return PrayerStatus.prayed;
      case PrayerStatus.prayed:
        return PrayerStatus.missed;
      case PrayerStatus.missed:
        return PrayerStatus.pending;
    }
  }
}

class PrayerItem {
  final String name;
  final String time;
  final PrayerStatus status;
  final bool isNext;
  final bool isSunrise;

  const PrayerItem({
    required this.name,
    required this.time,
    this.status = PrayerStatus.pending,
    this.isNext = false,
    this.isSunrise = false,
  });

  PrayerItem copyWith({
    String? name,
    String? time,
    PrayerStatus? status,
    bool? isNext,
    bool? isSunrise,
  }) {
    return PrayerItem(
      name: name ?? this.name,
      time: time ?? this.time,
      status: status ?? this.status,
      isNext: isNext ?? this.isNext,
      isSunrise: isSunrise ?? this.isSunrise,
    );
  }
}

/// Card component rendering 5 daily prayers + Sunrise with interactive status toggles
/// and 18pt continuous squircle borders.
class PrayerListCard extends StatefulWidget {
  final List<PrayerItem>? prayers;
  final Function(int index, PrayerStatus newStatus)? onStatusChanged;

  const PrayerListCard({
    super.key,
    this.prayers,
    this.onStatusChanged,
  });

  static const List<PrayerItem> defaultPrayers = [
    PrayerItem(name: 'Fajr', time: '04:45 AM', status: PrayerStatus.prayed),
    PrayerItem(name: 'Sunrise', time: '06:05 AM', isSunrise: true),
    PrayerItem(name: 'Dhuhr', time: '12:15 PM', status: PrayerStatus.pending, isNext: true),
    PrayerItem(name: 'Asr', time: '03:30 PM', status: PrayerStatus.pending),
    PrayerItem(name: 'Maghrib', time: '06:20 PM', status: PrayerStatus.pending),
    PrayerItem(name: 'Isha', time: '07:50 PM', status: PrayerStatus.pending),
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
    final updatedItem = _items[index].copyWith(status: _items[index].status.next);
    setState(() {
      _items[index] = updatedItem;
    });
    widget.onStatusChanged?.call(index, updatedItem.status);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      decoration: ShapeDecoration(
        color: colors.elevatedBackground,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(22),
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
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = _items[index];
              return _PrayerRowItem(
                key: ValueKey('prayer_row_${item.name}'),
                item: item,
                onToggle: () => _handleToggle(index),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PrayerRowItem extends StatefulWidget {
  final PrayerItem item;
  final VoidCallback onToggle;

  const _PrayerRowItem({
    super.key,
    required this.item,
    required this.onToggle,
  });

  @override
  State<_PrayerRowItem> createState() => _PrayerRowItemState();
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
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
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
        badgeBg = colors.surface;
        badgeText = colors.textSecondary;
        statusIcon = Icons.circle_outlined;
        statusLabel = 'Pending';
        break;
    }

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onToggle,
        child: Container(
          decoration: ShapeDecoration(
            color: item.isNext ? colors.primarySoft : colors.surface,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: item.isNext ? colors.primary : colors.divider,
                width: item.isNext ? 1.5 : 1.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Row(
            children: [
              Icon(
                _getPrayerIcon(item.name, item.isSunrise),
                size: 20,
                color: item.isNext ? colors.primary : colors.textSecondary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: colors.textPrimary,
                        fontWeight: item.isNext ? FontWeight.w700 : FontWeight.w600,
                      ),
                ),
              ),
              Text(
                item.time,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: item.isNext ? colors.primaryText : colors.textSecondary,
                      fontWeight: item.isNext ? FontWeight.w600 : FontWeight.w400,
                    ),
              ),
              const SizedBox(width: 12),
              // Status Toggle Button / Badge
              if (!item.isSunrise)
                Semantics(
                  button: true,
                  label: '${item.name} status: $statusLabel',
                  child: InkWell(
                    key: ValueKey('toggle_button_${item.name}'),
                    onTap: widget.onToggle,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: ShapeDecoration(
                        color: badgeBg,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      child: Row(
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
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Container(
                  decoration: ShapeDecoration(
                    color: colors.surfaceHover,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Text(
                    'Shuruq',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colors.textTertiary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
