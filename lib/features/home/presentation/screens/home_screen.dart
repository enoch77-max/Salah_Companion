import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../reflection/domain/models/daily_content.dart';
import '../widgets/daily_reflection_card.dart';
import '../widgets/hijri_strip.dart';
import '../widgets/prayer_countdown_hero.dart';
import '../widgets/prayer_list_card.dart';

/// Home Dashboard Screen integrating countdown hero, hijri strip,
/// prayer list card, daily reflection card, and frosted-glass navigation bar.
class HomeScreen extends StatefulWidget {
  final String nextPrayerName;
  final Duration? remainingDuration;
  final double countdownProgress;
  final bool animateHero;
  final String locationName;
  final bool isTimezoneMismatched;
  final List<PrayerItem>? prayers;
  final DailyContentItem? reflectionItem;

  const HomeScreen({
    super.key,
    this.nextPrayerName = 'Dhuhr',
    this.remainingDuration = const Duration(hours: 1, minutes: 24, seconds: 5),
    this.countdownProgress = 0.75,
    this.animateHero = true,
    this.locationName = 'Riyadh, Saudi Arabia',
    this.isTimezoneMismatched = false,
    this.prayers,
    this.reflectionItem,
  });

  static const DailyContentItem defaultReflection = DailyContentItem(
    id: 'daily_reflection_home_1',
    type: DailyContentType.hadith,
    reference: 'Sahih al-Bukhari 50',
    sourceWeight: 1.0,
    grade: 'Sahih',
    gradedBy: 'Al-Bukhari',
    arabicText: 'مَنْ كَانَ يُؤْمِنُ بِاللَّهِ وَالْيَوْمِ الآخِرِ فَلْيَقُلْ خَيْرًا أَوْ لِيَصْمُتْ',
    translationText: 'Whoever believes in Allah and the Last Day should speak good or remain silent.',
    translationSource: 'Bukhari',
  );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;
  bool _isReflectionFavorited = false;

  void _handleToggleFavorite() {
    setState(() {
      _isReflectionFavorited = !_isReflectionFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final reflection = widget.reflectionItem ?? HomeScreen.defaultReflection;

    return Scaffold(
      backgroundColor: colors.background,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Scrollable Content Viewport with BouncingScrollPhysics
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: 110.0, // Space for frosted glass nav bar
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Hijri & Location Strip
                  HijriStrip(
                    locationName: widget.locationName,
                    isTimezoneMismatched: widget.isTimezoneMismatched,
                  ),
                  const SizedBox(height: 16),

                  // 2. Countdown Hero
                  PrayerCountdownHero(
                    nextPrayerName: widget.nextPrayerName,
                    remainingDuration: widget.remainingDuration,
                    progress: widget.countdownProgress,
                    animate: widget.animateHero,
                  ),
                  const SizedBox(height: 16),

                  // 3. Prayer List Card (5 Daily + Sunrise)
                  PrayerListCard(
                    prayers: widget.prayers,
                  ),
                  const SizedBox(height: 16),

                  // 4. Daily Reflection Card
                  DailyReflectionCard(
                    content: reflection,
                    isFavorited: _isReflectionFavorited,
                    onToggleFavorite: _handleToggleFavorite,
                  ),
                ],
              ),
            ),

            // Frosted-Glass Bottom Navigation Bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _FrostedGlassBottomNavBar(
                selectedIndex: _selectedNavIndex,
                onItemSelected: (index) {
                  setState(() {
                    _selectedNavIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FrostedGlassBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const _FrostedGlassBottomNavBar({
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final navItems = const [
      _NavItemData(icon: Icons.home_rounded, label: 'Home'),
      _NavItemData(icon: Icons.explore_rounded, label: 'Qibla'),
      _NavItemData(icon: Icons.calendar_month_rounded, label: 'Tracker'),
      _NavItemData(icon: Icons.auto_awesome_rounded, label: 'Reflection'),
      _NavItemData(icon: Icons.settings_rounded, label: 'Settings'),
    ];

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface.withValues(alpha: 0.75),
            border: Border(
              top: BorderSide(
                color: colors.dividerStrong,
                width: 1.0,
              ),
            ),
          ),
          padding: EdgeInsets.only(
            top: 10,
            bottom: MediaQuery.paddingOf(context).bottom + 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(navItems.length, (index) {
              final item = navItems[index];
              final isSelected = selectedIndex == index;
              return InkWell(
                key: ValueKey('nav_item_$index'),
                onTap: () => onItemSelected(index),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        color: isSelected ? colors.primary : colors.textTertiary,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: isSelected ? colors.primary : colors.textTertiary,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;

  const _NavItemData({
    required this.icon,
    required this.label,
  });
}
