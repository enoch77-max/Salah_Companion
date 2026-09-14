import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../core/presentation/widgets/dua_hands_icon.dart';
import '../../../../core/presentation/widgets/tasbih_icon.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Floating frosted-glass navigation bar matching the design spec.
class FrostedGlassBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const FrostedGlassBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<FrostedGlassBottomNavBar> createState() => _FrostedGlassBottomNavBarState();
}

class _FrostedGlassBottomNavBarState extends State<FrostedGlassBottomNavBar> {
  int? _pressedIndex;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    final navItems = [
      NavItemData(selectedIcon: Icons.home_rounded, unselectedIcon: Icons.home_outlined, label: l10n?.navHome ?? 'Home'),
      NavItemData(selectedIcon: Icons.book_rounded, unselectedIcon: Icons.book_outlined, label: l10n?.navDuas ?? 'Duas'),
      NavItemData(selectedIcon: Icons.radio_button_checked_rounded, unselectedIcon: Icons.radio_button_off_rounded, label: l10n?.navTasbih ?? 'Tasbih'),
      NavItemData(selectedIcon: Icons.explore_rounded, unselectedIcon: Icons.explore_outlined, label: l10n?.navQibla ?? 'Qibla'),
      NavItemData(selectedIcon: Icons.calendar_month_rounded, unselectedIcon: Icons.calendar_today_outlined, label: l10n?.navCalendar ?? 'Calendar'),
    ];

    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, bottomPadding > 0 ? bottomPadding + 4 : 12),
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface.withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: colors.dividerStrong,
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.14),
                blurRadius: 20,
                offset: const Offset(0, 6),
                spreadRadius: -2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                height: 58,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final availableWidth = constraints.maxWidth;
                    final itemWidth = availableWidth / navItems.length;

                    return Stack(
                      children: [
                        // ─── FLUID SLIDING SELECTION HIGHLIGHT PILL (Fully Rounded Edges) ───
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 260),
                          curve: Curves.easeOutCubic,
                          left: (widget.selectedIndex * itemWidth) + 3,
                          top: 2,
                          bottom: 2,
                          width: itemWidth - 6,
                          child: Container(
                            decoration: BoxDecoration(
                              color: colors.primarySoft,
                              borderRadius: BorderRadius.circular(23), // Fully rounded stadium pill!
                              border: Border.all(
                                color: colors.primary.withValues(alpha: 0.35),
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colors.primary.withValues(alpha: 0.12),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ─── NAV ITEMS ROW ──────────────────────────────────────────
                        Row(
                          children: List.generate(navItems.length, (index) {
                            final item = navItems[index];
                            final isSelected = widget.selectedIndex == index;
                            final isPressed = _pressedIndex == index;

                            return Expanded(
                              child: GestureDetector(
                                key: ValueKey('nav_item_$index'),
                                behavior: HitTestBehavior.opaque,
                                onTapDown: (_) {
                                  setState(() {
                                    _pressedIndex = index;
                                  });
                                  HapticFeedback.selectionClick();
                                },
                                onTapUp: (_) {
                                  setState(() {
                                    _pressedIndex = null;
                                  });
                                  widget.onItemSelected(index);
                                },
                                onTapCancel: () {
                                  setState(() {
                                    _pressedIndex = null;
                                  });
                                },
                                child: AnimatedScale(
                                  scale: isPressed ? 0.92 : 1.0,
                                  duration: const Duration(milliseconds: 120),
                                  curve: Curves.easeOutCubic,
                                  child: Container(
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AnimatedScale(
                                          scale: isSelected ? 1.10 : 1.0,
                                          duration: const Duration(milliseconds: 220),
                                          curve: Curves.easeOutBack,
                                          child: index == 1
                                              ? DuaHandsIcon(
                                                  color: isSelected ? colors.primary : colors.textTertiary,
                                                  size: 20,
                                                  isSelected: isSelected,
                                                )
                                              : index == 2
                                                  ? TasbihIcon(
                                                      color: isSelected ? colors.primary : colors.textTertiary,
                                                      size: 20,
                                                      isSelected: isSelected,
                                                    )
                                                  : Icon(
                                                      isSelected ? item.selectedIcon : item.unselectedIcon,
                                                      color: isSelected ? colors.primary : colors.textTertiary,
                                                      size: 20,
                                                    ),
                                        ),
                                        const SizedBox(height: 2),
                                        AnimatedDefaultTextStyle(
                                          duration: const Duration(milliseconds: 200),
                                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                                color: isSelected ? colors.primary : colors.textTertiary,
                                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                                fontSize: 10.5,
                                                letterSpacing: isSelected ? -0.1 : 0.0,
                                              ),
                                          child: Text(
                                            item.label,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavItemData {
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final String label;

  const NavItemData({
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
  });
}
