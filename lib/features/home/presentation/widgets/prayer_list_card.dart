import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/services/app_haptics.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../animation/card_expand_route.dart';
import 'friday_hadith_guide_popup.dart';

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

  /// Optional override for testing dynamic forbidden nafl card
  final DateTime? nowOverride;

  /// Service managing local notifications
  final NotificationService? notificationService;

  /// Optional override for Friday Jumu'ah mode.
  final bool? isFriday;

  const PrayerListCard({
    super.key,
    this.prayers,
    this.onStatusChanged,
    this.sunriseDateTime,
    this.dhuhrDateTime,
    this.maghribDateTime,
    this.nowOverride,
    this.notificationService,
    this.isFriday,
  });

  static const List<PrayerItem> defaultPrayers = [
    PrayerItem(name: 'Fajr', time: '04:45 AM', status: PrayerStatus.prayed),
    PrayerItem(name: 'Sunrise', time: '06:05 AM', isSunrise: true),
    PrayerItem(
      name: 'Dhuhr',
      time: '12:15 PM',
      status: PrayerStatus.pending,
      isNext: true,
    ),
    PrayerItem(
      name: 'Asr',
      time: '03:30 PM',
      status: PrayerStatus.pending,
      isFuture: true,
    ),
    PrayerItem(
      name: 'Maghrib',
      time: '06:20 PM',
      status: PrayerStatus.pending,
      isFuture: true,
    ),
    PrayerItem(
      name: 'Isha',
      time: '07:50 PM',
      status: PrayerStatus.pending,
      isFuture: true,
    ),
  ];

  @override
  State<PrayerListCard> createState() => _PrayerListCardState();
}

class _PrayerListCardState extends State<PrayerListCard> {
  late List<PrayerItem> _items;
  bool _isFridayMosqueMode = true;

  @override
  void initState() {
    super.initState();
    _items = widget.prayers != null
        ? List.from(widget.prayers!)
        : List.from(PrayerListCard.defaultPrayers);
    _loadFridayLocationPreference();
  }

  Future<void> _loadFridayLocationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('friday_prayer_location');
    if (saved != null && mounted) {
      setState(() {
        _isFridayMosqueMode = (saved != 'home');
      });
    }
  }

  Future<void> _setFridayLocation(bool isMosque) async {
    AppHaptics.selection();
    setState(() {
      _isFridayMosqueMode = isMosque;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('friday_prayer_location', isMosque ? 'mosque' : 'home');
  }

  bool get _effectiveIsFriday {
    if (widget.isFriday != null) return widget.isFriday!;
    if (widget.nowOverride != null) {
      return widget.nowOverride!.weekday == DateTime.friday;
    }
    if (widget.dhuhrDateTime != null) {
      return widget.dhuhrDateTime!.weekday == DateTime.friday;
    }
    if (widget.sunriseDateTime != null) {
      return widget.sunriseDateTime!.weekday == DateTime.friday;
    }
    if (widget.maghribDateTime != null) {
      return widget.maghribDateTime!.weekday == DateTime.friday;
    }
    return false;
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
      final l10n = AppLocalizations.of(context);
      final isFridayDhuhr =
          _effectiveIsFriday && item.name.toLowerCase() == 'dhuhr';
      final localizedName = isFridayDhuhr
          ? (_isFridayMosqueMode
              ? (l10n?.fridayJumuahTitle ?? "Jumu'ah")
              : (l10n?.prayerDhuhr ?? 'Dhuhr'))
          : _localizePrayerName(context, item.name);
      final message =
          l10n?.prayerNotStartedYet(localizedName, item.time) ??
          '$localizedName prayer time has not started yet (${item.time})';
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: colors.cardBorder, width: 0.8),
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
              AppLocalizations.of(context)?.todaysPrayers ?? "TODAY'S PRAYERS",
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
              final displayItems = _items
                  .where((item) => !item.isSunrise && item.name != 'Sunrise')
                  .toList();
              final hasCurrentUnprayed = displayItems.any(
                (i) => i.isCurrent && i.status != PrayerStatus.prayed,
              );
              return ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                itemCount: displayItems.length,
                separatorBuilder: (context, index) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final item = displayItems[index];
                  final realIndex = _items.indexWhere(
                    (i) => i.name == item.name,
                  );
                  return _PrayerRowItem(
                    key: ValueKey('prayer_row_${item.name}'),
                    item: item,
                    hasCurrentUnprayed: hasCurrentUnprayed,
                    isFriday: _effectiveIsFriday,
                    isFridayMosqueMode: _isFridayMosqueMode,
                    onFridayLocationChanged: _setFridayLocation,
                    onToggle: () =>
                        _handleToggle(realIndex >= 0 ? realIndex : index),
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
              nowOverride: widget.nowOverride,
              notificationService: widget.notificationService,
            ),
        ],
      ),
    );
  }
}

String _localizePrayerName(BuildContext context, String rawName) {
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

class _SunnahInfo {
  final String label;
  final String importance;

  const _SunnahInfo({required this.label, required this.importance});
}

class _PrayerRowItem extends StatefulWidget {
  final PrayerItem item;
  final bool hasCurrentUnprayed;
  final VoidCallback onToggle;
  final bool isFriday;
  final bool isFridayMosqueMode;
  final ValueChanged<bool>? onFridayLocationChanged;

  const _PrayerRowItem({
    super.key,
    required this.item,
    this.hasCurrentUnprayed = false,
    required this.onToggle,
    this.isFriday = false,
    this.isFridayMosqueMode = true,
    this.onFridayLocationChanged,
  });

  @override
  State<_PrayerRowItem> createState() => _PrayerRowItemState();
}

_SunnahInfo _getSunnahInfo(BuildContext context, String prayerName) {
  final l10n = AppLocalizations.of(context);
  switch (prayerName.toLowerCase()) {
    case 'fajr':
      return _SunnahInfo(
        label: l10n?.sunnahFajrDesc ?? "2 Raka'at Sunnah Before (Emphasized)",
        importance: l10n?.sunnahMuakkadah ?? "Sunnah Mu'akkadah",
      );
    case 'dhuhr':
      return _SunnahInfo(
        label: l10n?.sunnahDhuhrDesc ?? "4 Raka'at Before & 2 After",
        importance: l10n?.sunnahMuakkadah ?? "Sunnah Mu'akkadah",
      );
    case 'asr':
      return _SunnahInfo(
        label: l10n?.sunnahAsrDesc ?? "4 Raka'at Sunnah Before",
        importance: l10n?.sunnahGhairMuakkadah ?? "Sunnah Ghair Mu'akkadah",
      );
    case 'maghrib':
      return _SunnahInfo(
        label: l10n?.sunnahMaghribDesc ?? "2 Raka'at Sunnah After",
        importance: l10n?.sunnahMuakkadah ?? "Sunnah Mu'akkadah",
      );
    case 'isha':
      return _SunnahInfo(
        label: l10n?.sunnahIshaDesc ?? "2 Raka'at After + 3 Witr",
        importance: l10n?.sunnahWajibWitr ?? "Sunnah & Wajib Witr",
      );
    default:
      return _SunnahInfo(
        label: l10n?.sunnahPrayerHeader ?? "Sunnah Prayer",
        importance: l10n?.sunnahVoluntary ?? "Voluntary Prayer",
      );
  }
}

class _PrayerRowItemState extends State<_PrayerRowItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final GlobalKey _fridaySunnahCardKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
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

  IconData _getPrayerIcon(
    String name,
    bool isSunrise, [
    bool isFriday = false,
    bool isMosqueMode = true,
  ]) {
    if (isSunrise) return Icons.wb_sunny_rounded;
    switch (name.toLowerCase()) {
      case 'fajr':
        return Icons.wb_twilight_rounded;
      case 'dhuhr':
        if (isFriday && isMosqueMode) {
          return Icons.mosque_rounded;
        }
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
    final l10n = AppLocalizations.of(context);
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
        statusLabel = l10n?.statusPrayed ?? 'Prayed';
        break;
      case PrayerStatus.missed:
        badgeBg = colors.missedSoft;
        badgeText = colors.missedText;
        statusIcon = Icons.cancel_rounded;
        statusLabel = l10n?.statusMissed ?? 'Missed';
        break;
      case PrayerStatus.pending:
        if (item.isCurrent) {
          badgeBg = colors.primarySoft;
          badgeText = colors.primaryText;
          statusIcon = Icons.radio_button_unchecked_rounded;
          statusLabel = l10n?.statusNotPrayed ?? 'Not Prayed';
        } else if (item.isNext) {
          badgeBg = colors.primary.withValues(alpha: 0.12);
          badgeText = colors.primary;
          statusIcon = Icons.circle_outlined;
          statusLabel = l10n?.statusUpcoming ?? 'Upcoming';
        } else if (item.isFuture) {
          badgeBg = colors.surface;
          badgeText = colors.textTertiary;
          statusIcon = Icons.circle_outlined;
          statusLabel = l10n?.statusNotYet ?? 'Not yet';
        } else {
          badgeBg = colors.surface;
          badgeText = colors.textSecondary;
          statusIcon = Icons.circle_outlined;
          statusLabel = l10n?.statusPending ?? 'Pending';
        }
        break;
    }

    final squircleColor = _getSquircleBadgeColor(item.name, item.isSunrise);
    final isPrayed = item.status == PrayerStatus.prayed;
    final isSelected = item.isCurrent
        ? !isPrayed
        : (item.isNext && !widget.hasCurrentUnprayed && !isPrayed);
    final sunnahInfo = _getSunnahInfo(context, item.name);
    final isFridayDhuhr =
        widget.isFriday && item.name.toLowerCase() == 'dhuhr';

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<BoxShadow>? selectedShadows = isSelected
        ? (isDark
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.40),
                    blurRadius: 6,
                    spreadRadius: 0,
                    offset: Offset.zero,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.32),
                    blurRadius: 16,
                    spreadRadius: 2,
                    offset: Offset.zero,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.22),
                    blurRadius: 32,
                    spreadRadius: 4,
                    offset: Offset.zero,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 54,
                    spreadRadius: 6,
                    offset: Offset.zero,
                  ),
                  BoxShadow(
                    color: const Color(0xFFD4A574).withValues(alpha: 0.18),
                    blurRadius: 14,
                    spreadRadius: 0,
                    offset: Offset.zero,
                  ),
                ]
              : [
                  BoxShadow(
                    color: const Color(0xFF78716C).withValues(alpha: 0.16),
                    blurRadius: 6,
                    spreadRadius: 0,
                    offset: Offset.zero,
                  ),
                  BoxShadow(
                    color: const Color(0xFF78716C).withValues(alpha: 0.14),
                    blurRadius: 16,
                    spreadRadius: 2,
                    offset: Offset.zero,
                  ),
                  BoxShadow(
                    color: const Color(0xFF78716C).withValues(alpha: 0.09),
                    blurRadius: 32,
                    spreadRadius: 4,
                    offset: Offset.zero,
                  ),
                  BoxShadow(
                    color: const Color(0xFF78716C).withValues(alpha: 0.05),
                    blurRadius: 54,
                    spreadRadius: 6,
                    offset: Offset.zero,
                  ),
                  BoxShadow(
                    color: const Color(0xFF0F766E).withValues(alpha: 0.10),
                    blurRadius: 14,
                    spreadRadius: 0,
                    offset: Offset.zero,
                  ),
                ])
        : null;

    final double cardOpacity;
    if (isSelected) {
      cardOpacity = 1.0;
    } else if (isPrayed) {
      cardOpacity = 0.45;
    } else if (item.isNext) {
      cardOpacity = 0.85;
    } else {
      cardOpacity = 0.70;
    }

    final effectiveCardColor = isSelected
        ? (isDark ? colors.surfaceHover : colors.surface)
        : (isPrayed
            ? Color.alphaBlend(
                colors.surface.withValues(alpha: 0.35),
                colors.elevatedBackground,
              )
            : colors.surface);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          margin: EdgeInsets.symmetric(horizontal: isSelected ? 0.0 : 8.0),
          decoration: ShapeDecoration(
            color: effectiveCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected
                    ? (isDark
                          ? const Color(0xFFD4A574)
                          : const Color(0xFF0F766E))
                    : (isPrayed
                          ? Colors.transparent
                          : (item.isNext
                                ? (isDark
                                      ? const Color(
                                          0xFFF59E0B,
                                        ).withValues(alpha: 0.35)
                                      : const Color(
                                          0xFFB45309,
                                        ).withValues(alpha: 0.35))
                                : colors.cardBorder)),
                width: 0.8,
              ),
            ),
            shadows: selectedShadows,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 14.0 : 11.0,
            vertical: isSelected ? 10.0 : 7.0,
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            opacity: cardOpacity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                // Squircle Icon Badge
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  width: isSelected ? 40 : 34,
                  height: isSelected ? 40 : 34,
                  decoration: BoxDecoration(
                    color: isPrayed
                        ? Color.alphaBlend(
                            colors.success.withValues(alpha: 0.20),
                            effectiveCardColor,
                          )
                        : squircleColor,
                    borderRadius: BorderRadius.circular(isSelected ? 13 : 11),
                    boxShadow: isSelected && !isPrayed
                        ? [
                            BoxShadow(
                              color: squircleColor.withValues(alpha: 0.35),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child:
                      Icon(
                            isPrayed
                                ? Icons.check_rounded
                                : _getPrayerIcon(
                                    item.name,
                                    item.isSunrise,
                                    widget.isFriday,
                                    widget.isFridayMosqueMode,
                                  ),
                            key: ValueKey(
                              'icon_${item.name}_${item.status.name}',
                            ),
                            size: isSelected ? 20 : 17,
                            color: isPrayed ? colors.successText : Colors.white,
                          )
                          .animate(
                            key: ValueKey(
                              'anim_icon_${item.name}_${item.status.name}',
                            ),
                          )
                          .scale(
                            begin: const Offset(0.5, 0.5),
                            end: const Offset(1.0, 1.0),
                            duration: 220.ms,
                            curve: Curves.elasticOut,
                          )
                          .fade(duration: 150.ms),
                ),
                SizedBox(width: isSelected ? 12 : 10),

                // Middle Column: Salah Name & Start/End Time Subtitle
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isFridayDhuhr
                                  ? (widget.isFridayMosqueMode
                                      ? (l10n?.fridayJumuahTitle ?? "Jumu'ah")
                                      : (l10n?.prayerDhuhr ?? 'Dhuhr'))
                                  : _localizePrayerName(context, item.name),
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: isPrayed
                                        ? colors.textSecondary
                                        : colors.textPrimary,
                                    fontWeight: isSelected
                                        ? FontWeight.w800
                                        : (isPrayed
                                              ? FontWeight.w500
                                              : FontWeight.w700),
                                    fontSize: isSelected ? 17.5 : 15.0,
                                    letterSpacing: -0.2,
                                  ),
                            ),
                            if (isSelected && !isPrayed) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 1.5,
                                ),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(
                                          0xFFD4A574,
                                        ).withValues(alpha: 0.18)
                                      : const Color(
                                          0xFF0F766E,
                                        ).withValues(alpha: 0.10),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: isDark
                                        ? const Color(
                                            0xFFD4A574,
                                          ).withValues(alpha: 0.45)
                                        : const Color(
                                            0xFF0F766E,
                                          ).withValues(alpha: 0.35),
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (item.isCurrent) ...[
                                      Container(
                                        width: 4,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? const Color(0xFFD4A574)
                                              : const Color(0xFF0F766E),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 3.5),
                                    ],
                                    Text(
                                      item.isCurrent
                                          ? (l10n?.badgeCurrent ?? 'CURRENT')
                                          : (l10n?.badgeNext ?? 'NEXT'),
                                      style: TextStyle(
                                        fontSize: 8.5,
                                        fontWeight: FontWeight.w800,
                                        color: isDark
                                            ? const Color(0xFFE8C9A0)
                                            : const Color(0xFF0F766E),
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 3),
                      _TimeCapsulePill(
                        startTime: item.time,
                        endTime: item.endTime,
                        isSunrise: item.isSunrise,
                      ),
                    ],
                  ),
                ),

                SizedBox(width: isSelected ? 12 : 10),

                // Right: Status Toggle Pill Button
                if (!item.isSunrise)
                  Semantics(
                    button: true,
                    label: '${item.name} status: $statusLabel',
                    child: InkWell(
                      key: ValueKey('toggle_button_${item.name}'),
                      onTap: widget.onToggle,
                      borderRadius: BorderRadius.circular(isSelected ? 11 : 10),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOutCubic,
                        decoration: ShapeDecoration(
                          color: isPrayed
                              ? Color.alphaBlend(
                                  colors.surface.withValues(alpha: 0.4),
                                  effectiveCardColor,
                                )
                              : badgeBg,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              isSelected ? 11 : 10,
                            ),
                            side: BorderSide(
                              color: isPrayed
                                  ? Colors.transparent
                                  : (isSelected
                                        ? colors.primary.withValues(alpha: 0.4)
                                        : colors.cardBorder),
                              width: 0.8,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isSelected ? 11.0 : 9.0,
                          vertical: isSelected ? 6.0 : 5.0,
                        ),
                        child:
                            FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    key: ValueKey(
                                      'status_row_${item.name}_${item.status.name}',
                                    ),
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        statusIcon,
                                        size: isSelected ? 12 : 11,
                                        color: isPrayed
                                            ? colors.textSecondary
                                            : badgeText,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        statusLabel,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: isPrayed
                                                  ? colors.textSecondary
                                                  : badgeText,
                                              fontWeight: FontWeight.w700,
                                              fontSize: isSelected
                                                  ? 11.5
                                                  : 10.5,
                                            ),
                                      ),
                                    ],
                                  ),
                                )
                                .animate(
                                  key: ValueKey(
                                    'anim_status_row_${item.name}_${item.status.name}',
                                  ),
                                )
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      l10n?.shuruqBadge ?? 'Shuruq',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colors.textTertiary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            if (isSelected && !item.isSunrise) ...[
              const SizedBox(height: 7.0),
              if (isFridayDhuhr) ...[
                _buildFridayLocationSelector(context, colors, l10n, isDark),
                const SizedBox(height: 6.0),
                _buildCompactFridaySunnahCard(context, colors, l10n, isDark),
              ] else ...[
                _buildStandardSunnahStrip(context, colors, sunnahInfo, isDark),
              ],
            ],
          ],
        ),
      ),
    ),
  ),
);
  }

  Widget _buildStandardSunnahStrip(
    BuildContext context,
    AppCustomColors colors,
    _SunnahInfo sunnahInfo,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 4.5,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFFD4A574).withValues(alpha: 0.14)
            : const Color(0xFF0F766E).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark
              ? const Color(0xFFD4A574).withValues(alpha: 0.35)
              : const Color(0xFF0F766E).withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_rounded,
            size: 13,
            color: isDark ? const Color(0xFFE8C9A0) : const Color(0xFF0F766E),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              sunnahInfo.label,
              softWrap: true,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? const Color(0xFFE8C9A0)
                    : const Color(0xFF0F766E),
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFridayLocationSelector(
    BuildContext context,
    AppCustomColors colors,
    AppLocalizations? l10n,
    bool isDark,
  ) {
    final isMosque = widget.isFridayMosqueMode;
    final activeBg = isDark
        ? const Color(0xFFD4A574).withValues(alpha: 0.22)
        : const Color(0xFFCCFBF1);
    final activeBorder = isDark
        ? const Color(0xFFD4A574).withValues(alpha: 0.45)
        : const Color(0xFF0F766E).withValues(alpha: 0.28);
    final activeColor =
        isDark ? const Color(0xFFE8C9A0) : const Color(0xFF0F766E);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.place_outlined,
                size: 13.5,
                color: colors.textSecondary,
              ),
              const SizedBox(width: 4.5),
              Text(
                l10n?.fridayLocationLabel ?? 'Location',
                softWrap: true,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: colors.textSecondary,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          // Clean low-profile segmented pill control
          Container(
            width: 196,
            height: 28,
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: isDark
                  ? colors.surface.withValues(alpha: 0.45)
                  : colors.surfaceHover.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Stack(
              children: [
                // Sliding capsule indicator
                Positioned.fill(
                  child: AnimatedAlign(
                    alignment: isMosque
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      heightFactor: 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: activeBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: activeBorder,
                            width: 0.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isDark
                                  ? const Color(0xFFD4A574)
                                      .withValues(alpha: 0.14)
                                  : const Color(0xFF0F766E)
                                      .withValues(alpha: 0.10),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Segmented options
                Row(
                  children: [
                    // Mosque option
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          HapticFeedback.selectionClick();
                          if (!isMosque) {
                            widget.onFridayLocationChanged?.call(true);
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.mosque_rounded,
                                  size: 12.0,
                                  color: isMosque
                                      ? activeColor
                                      : colors.textTertiary,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: AnimatedDefaultTextStyle(
                                      duration:
                                          const Duration(milliseconds: 220),
                                      curve: Curves.easeOutCubic,
                                      style: TextStyle(
                                        fontSize: 10.5,
                                        fontWeight: isMosque
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: isMosque
                                            ? activeColor
                                            : colors.textTertiary,
                                      ),
                                      child: Text(
                                        l10n?.fridayAtMosque ?? 'At Mosque',
                                        maxLines: 1,
                                        softWrap: false,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Home option
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          HapticFeedback.selectionClick();
                          if (isMosque) {
                            widget.onFridayLocationChanged?.call(false);
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.home_rounded,
                                  size: 12.0,
                                  color: !isMosque
                                      ? activeColor
                                      : colors.textTertiary,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: AnimatedDefaultTextStyle(
                                      duration:
                                          const Duration(milliseconds: 220),
                                      curve: Curves.easeOutCubic,
                                      style: TextStyle(
                                        fontSize: 10.5,
                                        fontWeight: !isMosque
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: !isMosque
                                            ? activeColor
                                            : colors.textTertiary,
                                      ),
                                      child: Text(
                                        l10n?.fridayAtHome ?? 'At Home',
                                        maxLines: 1,
                                        softWrap: false,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactFridaySunnahCard(
    BuildContext context,
    AppCustomColors colors,
    AppLocalizations? l10n,
    bool isDark,
  ) {
    final isMosque = widget.isFridayMosqueMode;
    final beforeDesc = isMosque
        ? (l10n?.fridayMosqueBeforeDesc ??
            'Tahiyyat al-Masjid & general voluntary prayers until Khutbah begins.')
        : (l10n?.fridayHomeBeforeDesc ??
            '4 Sunnah Rak\'ahs before Dhuhr (for those praying Dhuhr at home).');
    final afterDesc = isMosque
        ? (l10n?.fridayMosqueAfterDesc ??
            '4 Sunnah Rak\'ahs (at mosque) or 2 Sunnah Rak\'ahs (if prayed at home).')
        : (l10n?.fridayHomeAfterDesc ??
            '2 Sunnah Rak\'ahs after Dhuhr (for those praying Dhuhr at home).');

    final cardBg = isDark
        ? const Color(0xFFD4A574).withValues(alpha: 0.12)
        : const Color(0xFF0F766E).withValues(alpha: 0.07);
    final cardBorder = isDark
        ? const Color(0xFFD4A574).withValues(alpha: 0.32)
        : const Color(0xFF0F766E).withValues(alpha: 0.22);
    final accentColor =
        isDark ? const Color(0xFFE8C9A0) : const Color(0xFF0F766E);

    return Container(
      key: _fridaySunnahCardKey,
      child: InkWell(
        onTap: () => _showHadithGuidePopup(context),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.5),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cardBorder, width: 1.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Row: Icon + Title
              Row(
                children: [
                  Icon(
                    Icons.menu_book_rounded,
                    size: 13,
                    color: accentColor,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      l10n?.fridaySunnahRulingsTitle ?? "Jumu'ah Sunnah Rulings",
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: accentColor,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              _buildFridaySunnahBody(
                context,
                colors,
                l10n,
                isDark,
                accentColor,
                beforeDesc,
                afterDesc,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFridaySunnahBody(
    BuildContext context,
    AppCustomColors colors,
    AppLocalizations? l10n,
    bool isDark,
    Color accentColor,
    String beforeDesc,
    String afterDesc,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Row 1: BEFORE
        _buildSunnahDescRow(
          badgeText: l10n?.fridayBeforeLabel ?? 'Before',
          description: beforeDesc,
          isDark: isDark,
          accentColor: accentColor,
          colors: colors,
        ),
        const SizedBox(height: 5.0),

        // Row 2: AFTER
        _buildSunnahDescRow(
          badgeText: l10n?.fridayAfterLabel ?? 'After',
          description: afterDesc,
          isDark: isDark,
          accentColor: accentColor,
          colors: colors,
        ),
        const SizedBox(height: 6.0),

        // Hairline subtle divider
        Container(
          height: 0.5,
          color: isDark
              ? Colors.white.withValues(alpha: 0.10)
              : colors.divider.withValues(alpha: 0.5),
        ),
        const SizedBox(height: 4.5),

        // Centered bottom prompt: "Tap to view authentic rulings and hadith references"
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                l10n?.fridayClickToReadFull ??
                    'Tap to view authentic rulings and hadith references',
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                  letterSpacing: 0.1,
                ),
              ),
            ),
            const SizedBox(width: 3),
            Icon(
              Icons.arrow_forward_rounded,
              size: 10,
              color: accentColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSunnahDescRow({
    required String badgeText,
    required String description,
    required bool isDark,
    required Color accentColor,
    required AppCustomColors colors,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.5),
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFFD4A574).withValues(alpha: 0.20)
                : const Color(0xFF0F766E).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isDark
                  ? const Color(0xFFD4A574).withValues(alpha: 0.40)
                  : const Color(0xFF0F766E).withValues(alpha: 0.30),
              width: 0.8,
            ),
          ),
          child: Text(
            badgeText,
            style: TextStyle(
              fontSize: 8.5,
              fontWeight: FontWeight.w800,
              color: accentColor,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            description,
            softWrap: true,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              color: colors.textPrimary,
              height: 1.25,
            ),
          ),
        ),
      ],
    );
  }

  void _showHadithGuidePopup(BuildContext context) {
    AppHaptics.selection();
    final renderBox =
        _fridaySunnahCardKey.currentContext?.findRenderObject() as RenderBox?;
    final originRect = renderBox != null
        ? renderBox.localToGlobal(Offset.zero) & renderBox.size
        : null;

    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final accentColor =
        isDark ? const Color(0xFFE8C9A0) : const Color(0xFF0F766E);

    final isMosque = widget.isFridayMosqueMode;
    final beforeDesc = isMosque
        ? (l10n?.fridayMosqueBeforeDesc ??
            'Tahiyyat al-Masjid & general voluntary prayers until Khutbah begins.')
        : (l10n?.fridayHomeBeforeDesc ??
            '4 Sunnah Rak\'ahs before Dhuhr (for those praying Dhuhr at home).');
    final afterDesc = isMosque
        ? (l10n?.fridayMosqueAfterDesc ??
            '4 Sunnah Rak\'ahs (at mosque) or 2 Sunnah Rak\'ahs (if prayed at home).')
        : (l10n?.fridayHomeAfterDesc ??
            '2 Sunnah Rak\'ahs after Dhuhr (for those praying Dhuhr at home).');

    Navigator.of(context).push<void>(
      CardExpandRoute<void>(
        originRect: originRect,
        targetHeight: 560.0,
        startRadius: 10.0,
        headerConfig: SharedHeaderConfig(
          icon: Icons.menu_book_rounded,
          startTitle: l10n?.fridaySunnahRulingsTitle ?? "Jumu'ah Sunnah Rulings",
          endTitle: l10n?.fridayHadithGuideSheetTitle ??
              "Sunnah Prayers of Jumu'ah: Hadith Guide",
          endSubtitle: 'Authentic Sunnah Rulings • Bukhari & Muslim',
          startIconSize: 13.0,
          startIconBoxSize: 26.0,
          endIconSize: 18.0,
          endIconBoxSize: 36.0,
          startFontSize: 11.5,
          endFontSize: 15.0,
          startPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.5),
          endPadding:
              const EdgeInsets.only(left: 18.0, right: 14.0, top: 14.0, bottom: 8.0),
          accentColor: accentColor,
          startTextColor: accentColor,
          endTextColor: colors.textPrimary,
        ),
        originCardBody: _buildFridaySunnahBody(
          context,
          colors,
          l10n,
          isDark,
          accentColor,
          beforeDesc,
          afterDesc,
        ),
        builder: (popupContext, animation) => FridayHadithGuidePopup(
          animation: animation,
        ),
      ),
    );
  }
}

/// Dynamic event-driven note at the bottom of Today's Prayers card highlighting
/// forbidden times for Nafl (voluntary) prayers.
/// Appears 10m before prohibition, shows live pulsing red warning during prohibition,
/// shows brief 1-minute notice upon completion, and disappears completely (0px footprint) thereafter.
class _ForbiddenNaflNote extends StatefulWidget {
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime maghrib;
  final DateTime? nowOverride;
  final NotificationService? notificationService;

  const _ForbiddenNaflNote({
    required this.sunrise,
    required this.dhuhr,
    required this.maghrib,
    this.nowOverride,
    this.notificationService,
  });

  @override
  State<_ForbiddenNaflNote> createState() => _ForbiddenNaflNoteState();
}

enum _ForbiddenWindowType { sunrise, zawal, sunset }

enum _ForbiddenWindowPhase { upcoming, active, concluded }

class _ForbiddenWindowInfo {
  final _ForbiddenWindowType type;
  final _ForbiddenWindowPhase phase;
  final DateTime appear;
  final DateTime start;
  final DateTime end;
  final DateTime disappear;

  const _ForbiddenWindowInfo({
    required this.type,
    required this.phase,
    required this.appear,
    required this.start,
    required this.end,
    required this.disappear,
  });
}

class _ForbiddenNaflNoteState extends State<_ForbiddenNaflNote>
    with WidgetsBindingObserver {
  Timer? _eventTimer;
  _ForbiddenWindowType? _lastNotifiedWindowType;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scheduleNextEvent();
    _checkAndTriggerActiveNotification();
  }

  @override
  void didUpdateWidget(covariant _ForbiddenNaflNote oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sunrise != widget.sunrise ||
        oldWidget.dhuhr != widget.dhuhr ||
        oldWidget.maghrib != widget.maghrib ||
        oldWidget.nowOverride != widget.nowOverride ||
        oldWidget.notificationService != widget.notificationService) {
      if (oldWidget.nowOverride != widget.nowOverride) {
        _lastNotifiedWindowType = null;
      }
      _scheduleNextEvent();
      _checkAndTriggerActiveNotification();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (mounted) {
        setState(() {});
        _scheduleNextEvent();
        _checkAndTriggerActiveNotification();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _eventTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkAndTriggerActiveNotification() async {
    final activeWindow = _resolveActiveWindow();
    if (activeWindow != null &&
        activeWindow.phase == _ForbiddenWindowPhase.active) {
      if (_lastNotifiedWindowType != activeWindow.type) {
        _lastNotifiedWindowType = activeWindow.type;
        final prefs = await SharedPreferences.getInstance();
        final enabled = prefs.getBool('notif_enabled_forbidden_times') ?? true;
        if (enabled) {
          final service = widget.notificationService ?? NotificationService();
          AppLocalizations? localizations;
          if (mounted) {
            try {
              localizations = AppLocalizations.of(context);
            } catch (_) {}
          }
          await service.scheduleForbiddenTimesNotifications(
            sunrise: widget.sunrise,
            dhuhr: widget.dhuhr,
            maghrib: widget.maghrib,
            enabled: true,
            nowOverride: widget.nowOverride,
            localizations: localizations,
          );
        }
      }
    } else {
      _lastNotifiedWindowType = null;
    }
  }

  DateTime get _currentTime => widget.nowOverride ?? DateTime.now();

  String _formatTime(DateTime dt) {
    final hour = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
    final minute = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:$minute $ampm';
  }

  List<_ForbiddenWindowInfo> _getWindows() {
    final sunriseStart = widget.sunrise;
    final sunriseEnd = widget.sunrise.add(const Duration(minutes: 20));

    final zawalStart = widget.dhuhr.subtract(const Duration(minutes: 10));
    final zawalEnd = widget.dhuhr;

    final sunsetStart = widget.maghrib.subtract(const Duration(minutes: 20));
    final sunsetEnd = widget.maghrib;

    return [
      _createWindowInfo(_ForbiddenWindowType.sunrise, sunriseStart, sunriseEnd),
      _createWindowInfo(_ForbiddenWindowType.zawal, zawalStart, zawalEnd),
      _createWindowInfo(_ForbiddenWindowType.sunset, sunsetStart, sunsetEnd),
    ];
  }

  _ForbiddenWindowInfo _createWindowInfo(
    _ForbiddenWindowType type,
    DateTime start,
    DateTime end,
  ) {
    final appear = start.subtract(const Duration(minutes: 10));
    final disappear = end.add(const Duration(minutes: 1));
    final now = _currentTime;

    _ForbiddenWindowPhase phase;
    if (!now.isBefore(appear) && now.isBefore(start)) {
      phase = _ForbiddenWindowPhase.upcoming;
    } else if (!now.isBefore(start) && now.isBefore(end)) {
      phase = _ForbiddenWindowPhase.active;
    } else {
      phase = _ForbiddenWindowPhase.concluded;
    }

    return _ForbiddenWindowInfo(
      type: type,
      phase: phase,
      appear: appear,
      start: start,
      end: end,
      disappear: disappear,
    );
  }

  _ForbiddenWindowInfo? _resolveActiveWindow() {
    final now = _currentTime;
    for (final window in _getWindows()) {
      if (!now.isBefore(window.appear) && now.isBefore(window.disappear)) {
        return window;
      }
    }
    return null;
  }

  void _scheduleNextEvent() {
    _eventTimer?.cancel();
    if (widget.nowOverride != null) return;

    final now = _currentTime;
    final windows = _getWindows();

    final allTransitions = <DateTime>[];
    for (final w in windows) {
      allTransitions.addAll([w.appear, w.start, w.end, w.disappear]);
    }

    // Include tomorrow's sunrise appear transition in case all today's windows passed
    final tomorrowSunriseAppear = widget.sunrise
        .add(const Duration(days: 1))
        .subtract(const Duration(minutes: 10));
    allTransitions.add(tomorrowSunriseAppear);

    final futureTransitions =
        allTransitions.where((t) => t.isAfter(now)).toList()..sort();

    if (futureTransitions.isNotEmpty) {
      final nextTransition = futureTransitions.first;
      // Add a 50ms buffer to guarantee the clock is strictly at or past the milestone
      final delay =
          nextTransition.difference(now) + const Duration(milliseconds: 50);
      _eventTimer = Timer(delay, () {
        if (mounted) {
          setState(() {});
          _scheduleNextEvent();
          _checkAndTriggerActiveNotification();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeWindow = _resolveActiveWindow();
    if (activeWindow == null) {
      return const SizedBox.shrink();
    }

    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);

    String headerText;
    String bodyText;
    Color accentColor;
    IconData iconData;
    bool shouldPulse = false;

    switch (activeWindow.phase) {
      case _ForbiddenWindowPhase.active:
        accentColor = colors.missed;
        iconData = Icons.do_not_disturb_on_rounded;
        shouldPulse = true;
        switch (activeWindow.type) {
          case _ForbiddenWindowType.sunrise:
            headerText =
                l10n?.forbiddenNaflSunriseHeader ??
                'FORBIDDEN NAFL TIME • SUNRISE';
            bodyText =
                l10n?.forbiddenNaflSunriseBody(
                  _formatTime(activeWindow.start),
                  _formatTime(activeWindow.end),
                ) ??
                'Sun is rising (${_formatTime(activeWindow.start)} – ${_formatTime(activeWindow.end)}). Voluntary (Nafl) prayers are prohibited until the sun is fully risen. (Sahih Muslim 831)';
            break;
          case _ForbiddenWindowType.zawal:
            headerText =
                l10n?.forbiddenNaflZawalHeader ??
                'FORBIDDEN NAFL TIME • ZENITH (ZAWAL)';
            bodyText =
                l10n?.forbiddenNaflZawalBody(
                  _formatTime(activeWindow.start),
                  _formatTime(activeWindow.end),
                ) ??
                'Sun is at its zenith (${_formatTime(activeWindow.start)} – ${_formatTime(activeWindow.end)}). Nafl prayers are prohibited during this midday peak. (Sahih Muslim 831)';
            break;
          case _ForbiddenWindowType.sunset:
            headerText =
                l10n?.forbiddenNaflSunsetHeader ??
                'FORBIDDEN NAFL TIME • SUNSET';
            bodyText =
                l10n?.forbiddenNaflSunsetBody(
                  _formatTime(activeWindow.start),
                  _formatTime(activeWindow.end),
                ) ??
                'Sun is setting (${_formatTime(activeWindow.start)} – ${_formatTime(activeWindow.end)}). Nafl prayers are prohibited until sunset is complete. (Sahih Muslim 831)';
            break;
        }
        break;

      case _ForbiddenWindowPhase.upcoming:
        accentColor = const Color(0xFFF59E0B); // Amber warning
        iconData = Icons.hourglass_top_rounded;
        shouldPulse = false;
        switch (activeWindow.type) {
          case _ForbiddenWindowType.sunrise:
            headerText =
                l10n?.forbiddenNaflUpcomingSunriseHeader ??
                'UPCOMING FORBIDDEN TIME • SUNRISE';
            bodyText =
                l10n?.forbiddenNaflUpcomingSunriseBody(
                  _formatTime(activeWindow.start),
                ) ??
                'Voluntary (Nafl) prayers become prohibited at ${_formatTime(activeWindow.start)} as the sun rises. Conclude voluntary prayers before this time.';
            break;
          case _ForbiddenWindowType.zawal:
            headerText =
                l10n?.forbiddenNaflUpcomingZawalHeader ??
                'UPCOMING FORBIDDEN TIME • ZENITH (ZAWAL)';
            bodyText =
                l10n?.forbiddenNaflUpcomingZawalBody(
                  _formatTime(activeWindow.start),
                ) ??
                'Voluntary (Nafl) prayers become prohibited at ${_formatTime(activeWindow.start)} during solar zenith. Conclude voluntary prayers before this time.';
            break;
          case _ForbiddenWindowType.sunset:
            headerText =
                l10n?.forbiddenNaflUpcomingSunsetHeader ??
                'UPCOMING FORBIDDEN TIME • SUNSET';
            bodyText =
                l10n?.forbiddenNaflUpcomingSunsetBody(
                  _formatTime(activeWindow.start),
                ) ??
                'Voluntary (Nafl) prayers become prohibited at ${_formatTime(activeWindow.start)} before sunset. Conclude voluntary prayers before this time.';
            break;
        }
        break;

      case _ForbiddenWindowPhase.concluded:
        accentColor = colors.success;
        iconData = Icons.check_circle_outline_rounded;
        shouldPulse = false;
        headerText =
            l10n?.forbiddenNaflConcludedHeader ?? 'FORBIDDEN TIME CONCLUDED';
        bodyText =
            l10n?.forbiddenNaflConcludedBody ??
            'The prohibited window has ended. Voluntary (Nafl) prayers are now permissible.';
        break;
    }

    Widget noteIcon = Icon(iconData, size: 16, color: accentColor);

    if (shouldPulse) {
      noteIcon = noteIcon
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .fade(
            begin: 0.4,
            end: 1.0,
            duration: const Duration(milliseconds: 800),
          );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: ShapeDecoration(
          color: accentColor.withValues(alpha: 0.12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: accentColor.withValues(alpha: 0.4),
              width: 0.8,
            ),
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.only(top: 2.0), child: noteIcon),
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
                      color: accentColor,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasEndTime = !isSunrise && endTime != null && endTime!.isNotEmpty;

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5),
        decoration: BoxDecoration(
          color: isDark ? colors.surfaceHover : const Color(0xFFFCF2EB),
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(
            color: isDark ? colors.cardBorder : const Color(0xFFEAE1DA),
            width: 0.8,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${AppLocalizations.of(context)?.timeStart ?? 'Start'} ',
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w500,
                color: isDark ? colors.textTertiary : const Color(0xFF53433A),
              ),
            ),
            Text(
              startTime,
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
                color: isDark ? colors.textPrimary : const Color(0xFF1F1B17),
              ),
            ),
            if (hasEndTime) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.5),
                child: Container(
                  width: 1,
                  height: 8.0,
                  color: isDark
                      ? colors.dividerStrong.withValues(alpha: 0.45)
                      : colors.dividerStrong,
                ),
              ),
              Text(
                '${AppLocalizations.of(context)?.timeEnd ?? 'End'} ',
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                  color: isDark ? colors.textTertiary : const Color(0xFF53433A),
                ),
              ),
              Text(
                endTime!,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  color: isDark ? colors.textPrimary : const Color(0xFF1F1B17),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
