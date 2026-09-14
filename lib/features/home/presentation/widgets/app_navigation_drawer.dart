import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/services/app_info_service.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../learn_salah/presentation/screens/learn_salah_hub_screen.dart';
import '../../../reflection/data/repositories/daily_content_repository.dart';
import '../../../reflection/presentation/screens/favorites_screen.dart';
import 'open_source_sheet.dart';
import 'widget_preview_sheet.dart';

/// Custom 3-Line Navigation Drawer housing Saved Items, Settings, and Theme Toggle.
class AppNavigationDrawer extends StatelessWidget {
  final ThemeMode currentThemeMode;
  final ValueChanged<ThemeMode>? onThemeModeChanged;

  const AppNavigationDrawer({
    super.key,
    required this.currentThemeMode,
    this.onThemeModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);

    return Drawer(
      backgroundColor: colors.background,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Drawer Header Card
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: ShapeDecoration(
                          color: colors.surface,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                            side: BorderSide(color: colors.divider, width: 1.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: colors.primarySoft,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.mosque_rounded,
                                color: colors.primary,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n?.appTitle ?? 'Salah Companion',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: colors.textPrimary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                  ),
                                  const SizedBox(height: 1),
                                  Text(
                                    l10n?.prayerAndReflection ?? 'Prayer & Reflection',
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
                    ),

                    // 1. GUIDANCE Category (Learn Salah on Top of Navigation)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, bottom: 6.0, top: 4.0),
                            child: Text(
                              l10n?.guidanceCategory ?? 'GUIDANCE',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: const Color(0xFF7C3AED), // Royal Amethyst Violet
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8,
                                  ),
                            ),
                          ),
                          Material(
                            color: colors.surface,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: BorderSide(
                                color: const Color(0xFF7C3AED).withValues(alpha: 0.35),
                                width: 1.2,
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: DrawerGroupedTile(
                              tileKey: const ValueKey('drawer_learn_salah_item'),
                              icon: Icons.auto_stories_rounded,
                              iconColor: const Color(0xFF7C3AED), // Royal Amethyst Violet
                              title: l10n?.learnSalah ?? 'Learn Salah',
                              subtitle: l10n?.learnSalahSubtitle ?? 'Learn Salah with authentic Sunnah and Hadith',
                              onTap: () {
                                Navigator.pop(context); // Close drawer
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LearnSalahHubScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // 2. Navigation Grouped Inset Card (Matching SettingsScreen iOS Style)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, bottom: 6.0, top: 4.0),
                            child: Text(
                              l10n?.drawerNavigation ?? 'NAVIGATION',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: colors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8,
                                  ),
                            ),
                          ),
                          Material(
                            color: colors.surface,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: BorderSide(color: colors.divider, width: 1.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // 1. Saved Screen Option
                                DrawerGroupedTile(
                                  tileKey: const ValueKey('drawer_favorites_item'),
                                  icon: Icons.bookmark_rounded,
                                  iconColor: const Color(0xFFF59E0B), // Warm Amber Gold
                                  title: l10n?.savedItems ?? 'Saved',
                                  subtitle: l10n?.savedItemsSubtitle ?? 'Hadiths, Verses & Duas',
                                  onTap: () {
                                    Navigator.pop(context); // Close drawer
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FavoritesScreen(
                                          repository: DailyContentRepository(AppDatabase.instance()),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Divider(height: 1, thickness: 1, color: colors.divider, indent: 64),
                                // 2. Home Screen Widgets Option
                                DrawerGroupedTile(
                                  tileKey: const ValueKey('drawer_widgets_item'),
                                  icon: Icons.widgets_rounded,
                                  iconColor: const Color(0xFF06B6D4), // Electric Cyan (Modular Widgets)
                                  title: l10n?.widgetsTitle ?? 'Widgets',
                                  subtitle: l10n?.widgetsSubtitle ?? 'Add widgets to home screen',
                                  onTap: () {
                                    Navigator.pop(context); // Close drawer
                                    WidgetPreviewSheet.show(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // 3. OPEN SOURCE & PRIVACY Inset Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, bottom: 6.0, top: 4.0),
                            child: Text(
                              l10n?.drawerOpenSourcePrivacy ?? 'OPEN SOURCE & PRIVACY',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: colors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8,
                                  ),
                            ),
                          ),
                          Material(
                            color: colors.surface,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: BorderSide(color: colors.divider, width: 1.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: DrawerGroupedTile(
                              tileKey: const ValueKey('drawer_open_source_privacy_item'),
                              icon: Icons.verified_user_rounded,
                              iconColor: const Color(0xFF059669), // Trust Jade Emerald
                              title: l10n?.openSourcePrivacy ?? 'Open Source & Privacy',
                              subtitle: l10n?.openSourcePrivacySubtitle ?? '100% offline, zero tracking & Non-Commercial',
                              onTap: () {
                                Navigator.pop(context); // Close drawer
                                OpenSourceSheet.show(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 3-Option Segmented Pill Theme Switcher (Bottom of Menu)
            ThemeSegmentedControl(
              key: const ValueKey('drawer_theme_segmented_control'),
              currentThemeMode: currentThemeMode,
              onThemeModeChanged: onThemeModeChanged,
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                AppInfoService.drawerFooterText,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.textTertiary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper tile widget for iOS Grouped Inset style drawer navigation tiles.
class DrawerGroupedTile extends StatelessWidget {
  final Key? tileKey;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const DrawerGroupedTile({
    super.key,
    this.tileKey,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return InkWell(
      key: tileKey,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: colors.textTertiary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

/// 3-Option Segmented Sliding Control for Theme Mode (System / Light / Dark).
class ThemeSegmentedControl extends StatelessWidget {
  final ThemeMode currentThemeMode;
  final ValueChanged<ThemeMode>? onThemeModeChanged;

  const ThemeSegmentedControl({
    super.key,
    required this.currentThemeMode,
    this.onThemeModeChanged,
  });

  int _getSelectedIndex() {
    switch (currentThemeMode) {
      case ThemeMode.light:
        return 1;
      case ThemeMode.dark:
        return 2;
      case ThemeMode.system:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);
    final selectedIndex = _getSelectedIndex();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
            child: Text(
              l10n?.themeMode ?? 'THEME MODE',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.textSecondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
            ),
          ),
          Container(
            height: 44,
            decoration: ShapeDecoration(
              color: colors.surface,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(22),
                side: BorderSide(color: colors.divider, width: 1.0),
              ),
            ),
            padding: const EdgeInsets.all(3.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = (constraints.maxWidth - 6) / 3;
                final alignment = selectedIndex == 0
                    ? Alignment.centerLeft
                    : selectedIndex == 1
                        ? Alignment.center
                        : Alignment.centerRight;

                return Stack(
                  children: [
                    // Sliding Pill Surface Indicator
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      alignment: alignment,
                      child: Container(
                        width: itemWidth,
                        height: double.infinity,
                        decoration: ShapeDecoration(
                          color: colors.primary,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          shadows: [
                            BoxShadow(
                              color: colors.primary.withValues(alpha: 0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 3 Tappable Options: System / Light / Dark
                    Row(
                      children: [
                        _buildSegment(
                          context,
                          index: 0,
                          label: l10n?.themeSystem ?? 'System',
                          icon: Icons.brightness_auto_rounded,
                          mode: ThemeMode.system,
                          selectedIndex: selectedIndex,
                        ),
                        _buildSegment(
                          context,
                          index: 1,
                          label: l10n?.themeLight ?? 'Light',
                          icon: Icons.light_mode_rounded,
                          mode: ThemeMode.light,
                          selectedIndex: selectedIndex,
                        ),
                        _buildSegment(
                          context,
                          index: 2,
                          label: l10n?.themeDark ?? 'Dark',
                          icon: Icons.dark_mode_rounded,
                          mode: ThemeMode.dark,
                          selectedIndex: selectedIndex,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegment(
    BuildContext context, {
    required int index,
    required String label,
    required IconData icon,
    required ThemeMode mode,
    required int selectedIndex,
  }) {
    final colors = context.appColors;
    final isSelected = selectedIndex == index;
    final textColor = isSelected ? colors.background : colors.textSecondary;

    return Expanded(
      child: GestureDetector(
        key: ValueKey('theme_segment_$index'),
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.selectionClick();
          onThemeModeChanged?.call(mode);
        },
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 14,
                color: textColor,
              ),
              const SizedBox(width: 4),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  letterSpacing: 0.6,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
