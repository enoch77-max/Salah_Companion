import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/app_haptics.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Full-bleed Multi-Slide Visual Feature Showcase for Salah Companion Onboarding.
/// Presents authentic high-fidelity native Flutter visual mockups for Prayer Times,
/// Qibla Compass, Digital Tasbih, and Daily Reflections & Duas.
class VisualFeatureShowcaseStep extends StatefulWidget {
  const VisualFeatureShowcaseStep({super.key});

  @override
  State<VisualFeatureShowcaseStep> createState() => _VisualFeatureShowcaseStepState();
}

class _VisualFeatureShowcaseStepState extends State<VisualFeatureShowcaseStep> {
  final PageController _slideController = PageController();
  int _activeSlide = 0;

  // Interactive Tasbih count
  int _tasbihCount = 28;
  final bool _isQiblaAligned = true;

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _onSlideTabTapped(int index) {
    if (_activeSlide != index) {
      AppHaptics.selection();
      setState(() => _activeSlide = index);
      _slideController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);

    return Column(
      key: const ValueKey('visual_feature_showcase_step'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Interactive Feature Tab Bar
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.divider),
          ),
          child: Row(
            children: [
              _buildFeatureTab(0, Icons.schedule_rounded, l10n?.navHome ?? 'Prayer', const [Color(0xFFFBBF24), Color(0xFFF59E0B)], colors),
              _buildFeatureTab(1, Icons.explore_rounded, l10n?.navQibla ?? 'Qibla', const [Color(0xFF38BDF8), Color(0xFF0EA5E9)], colors),
              _buildFeatureTab(2, Icons.touch_app_rounded, l10n?.navTasbih ?? 'Tasbih', const [Color(0xFF34D399), Color(0xFF10B981)], colors),
              _buildFeatureTab(3, Icons.auto_stories_rounded, l10n?.categoryHadith ?? 'Reflect', const [Color(0xFFA78BFA), Color(0xFF8B5CF6)], colors),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // 2. Carousel of Full-Fidelity Visual Feature Slides
        SizedBox(
          height: 380,
          child: PageView(
            controller: _slideController,
            onPageChanged: (page) => setState(() => _activeSlide = page),
            physics: const BouncingScrollPhysics(),
            children: [
              _buildPrayerShowcaseSlide(colors, l10n),
              _buildQiblaShowcaseSlide(colors, l10n),
              _buildTasbihShowcaseSlide(colors, l10n),
              _buildReflectionShowcaseSlide(colors, l10n),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // 3. Carousel Slide Indicator Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            final isCurrent = index == _activeSlide;
            return GestureDetector(
              onTap: () => _onSlideTabTapped(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 6,
                width: isCurrent ? 24 : 6,
                decoration: BoxDecoration(
                  color: isCurrent ? colors.primary : colors.dividerStrong,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildFeatureTab(
    int index,
    IconData icon,
    String label,
    List<Color> gradientColors,
    AppCustomColors colors,
  ) {
    final isSelected = _activeSlide == index;
    return Expanded(
      child: GestureDetector(
        key: ValueKey('showcase_tab_$index'),
        behavior: HitTestBehavior.opaque,
        onTap: () => _onSlideTabTapped(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isSelected ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 14,
                color: isSelected ? Colors.white : colors.textSecondary,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : colors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── SLIDE 1: PRAYER TIMES & COUNTDOWN HERO ──────────────────────────────────
  Widget _buildPrayerShowcaseSlide(AppCustomColors colors, AppLocalizations? l10n) {
    return Container(
      key: const ValueKey('showcase_prayer_slide'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n?.onboardingShowcasePrayerTitle ?? 'Astronomical Precision Prayer Times',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n?.onboardingShowcasePrayerSubtitle ??
                'Exact prayer calculations computed 100% offline using trusted global calculation methods.',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 11.5,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 14),

          // Visual Mockup Card: Live Countdown Hero
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFF59E0B).withValues(alpha: 0.12),
                  const Color(0xFFD97706).withValues(alpha: 0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.wb_sunny_rounded, color: Color(0xFFF59E0B), size: 14),
                          const SizedBox(width: 6),
                          Text(
                            l10n?.prayerAsr ?? 'Asr',
                            style: const TextStyle(
                              color: Color(0xFFF59E0B),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '03:45 PM',
                      style: AppTypography.timerStyle(
                        color: colors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '- 00:42:18',
                  style: AppTypography.timerStyle(
                    color: const Color(0xFFF59E0B),
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Remaining until Maghrib',
                  style: TextStyle(
                    color: colors.textTertiary,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                // Period Capsule
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colors.divider),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${l10n?.timeStart ?? 'Start'} 03:45 PM',
                        style: TextStyle(fontSize: 10, color: colors.textSecondary, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      Text('•', style: TextStyle(color: colors.textTertiary, fontSize: 10)),
                      const SizedBox(width: 8),
                      Text(
                        '${l10n?.timeEnd ?? 'End'} 06:18 PM',
                        style: TextStyle(fontSize: 10, color: colors.textPrimary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Sunnah Highlights Capsule
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colors.surfaceHover,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.menu_book_rounded, color: Color(0xFFF59E0B), size: 14),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n?.sunnahAsrDesc ?? "4 Raka'at Sunnah Before (Ghair Mu'akkadah)",
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── SLIDE 2: TRUE-NORTH QIBLA COMPASS ────────────────────────────────────────
  Widget _buildQiblaShowcaseSlide(AppCustomColors colors, AppLocalizations? l10n) {
    return Container(
      key: const ValueKey('showcase_qibla_slide'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF0EA5E9).withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n?.onboardingShowcaseQiblaTitle ?? 'Instant True-North Qibla',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n?.onboardingShowcaseQiblaSubtitle ??
                'Find the exact direction of the Kaaba anywhere on Earth with smooth gyroscopic guidance.',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 11.5,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),

          // Status Badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: colors.successSoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.success.withValues(alpha: 0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_rounded, size: 14, color: colors.success),
                  const SizedBox(width: 6),
                  const Text(
                    '294° NW • Makkah Al-Mukarramah',
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontWeight: FontWeight.bold,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Visual Compass Graphic
          Center(
            child: SizedBox(
              width: 170,
              height: 170,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size(170, 170),
                    painter: _ShowcaseCompassDialPainter(colors: colors),
                  ),
                  CustomPaint(
                    size: const Size(170, 170),
                    painter: _ShowcaseQiblaNeedlePainter(
                      angleDegrees: 0,
                      isAligned: _isQiblaAligned,
                      colors: colors,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── SLIDE 3: TACTILE DIGITAL TASBIH ──────────────────────────────────────────
  Widget _buildTasbihShowcaseSlide(AppCustomColors colors, AppLocalizations? l10n) {
    return GestureDetector(
      key: const ValueKey('showcase_tasbih_slide'),
      onTap: () {
        AppHaptics.light();
        setState(() {
          _tasbihCount = (_tasbihCount + 1) > 33 ? 1 : _tasbihCount + 1;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.35)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n?.onboardingShowcaseTasbihTitle ?? 'Tactile Digital Tasbih',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n?.onboardingShowcaseTasbihSubtitle ??
                  'Immersive dhikr counter with physical haptic vibrations and seamless auto-progression.',
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 11.5,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 14),

            // Arabic Calligraphy Card
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.25)),
              ),
              child: const Column(
                children: [
                  Text(
                    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'Scheherazade',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'SubhanAllah wa Bihamdihi',
                    style: TextStyle(
                      color: Color(0xFF059669),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Tactile Counter Display
            Center(
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF10B981).withValues(alpha: 0.2),
                      const Color(0xFF10B981).withValues(alpha: 0.02),
                    ],
                  ),
                  border: Border.all(color: const Color(0xFF10B981), width: 2),
                ),
                child: Center(
                  child: Text(
                    '$_tasbihCount',
                    style: AppTypography.timerStyle(
                      color: colors.textPrimary,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
            Text(
              'Target 33 • Tap anywhere to count',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.textTertiary,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── SLIDE 4: DAILY REFLECTIONS & DUAS ────────────────────────────────────────
  Widget _buildReflectionShowcaseSlide(AppCustomColors colors, AppLocalizations? l10n) {
    return Container(
      key: const ValueKey('showcase_reflection_slide'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF8B5CF6).withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n?.onboardingShowcaseReflectionTitle ?? 'Daily Spiritual Reflections & Duas',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n?.onboardingShowcaseReflectionSubtitle ??
                'Carefully verified Quranic verses, authentic Sahih Hadiths, and essential daily supplications.',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 11.5,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 14),

          // Daily Reflection Card Mockup
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF8B5CF6).withValues(alpha: 0.12),
                  const Color(0xFF6D28D9).withValues(alpha: 0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF8B5CF6).withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.verified_rounded, color: Color(0xFF8B5CF6), size: 12),
                          SizedBox(width: 4),
                          Text(
                            'Sahih al-Bukhari • 5058',
                            style: TextStyle(color: Color(0xFF8B5CF6), fontSize: 10.5, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.bookmark_added_rounded, color: Color(0xFF8B5CF6), size: 16),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  '“خَيْرُكُمْ مَنْ تَعَلَّمَ الْقُرْآنَ وَعَلَّمَهُ”',
                  style: TextStyle(
                    color: Color(0xFF8B5CF6),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Scheherazade',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '“The best among you are those who learn the Quran and teach it.”',
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 11.5,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Daily Duas Feature Strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colors.surfaceHover,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.favorite_rounded, color: Color(0xFF8B5CF6), size: 14),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Morning & Evening Hisn al-Muslim Duas with audio recitations',
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── COMPASS PAINTERS FOR SHOWCASE SLIDE ──────────────────────────────────────
class _ShowcaseCompassDialPainter extends CustomPainter {
  final AppCustomColors colors;

  const _ShowcaseCompassDialPainter({required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background circle
    final bgPaint = Paint()
      ..color = colors.elevatedBackground
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, bgPaint);

    // Rim border
    final rimPaint = Paint()
      ..color = colors.dividerStrong
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius - 2, rimPaint);

    // Cardinal Points
    const cardinals = ['N', 'E', 'S', 'W'];
    for (int i = 0; i < 4; i++) {
      final angle = (i * 90) * math.pi / 180 - math.pi / 2;
      final offset = Offset(
        center.dx + (radius - 16) * math.cos(angle),
        center.dy + (radius - 16) * math.sin(angle),
      );
      final textPainter = TextPainter(
        text: TextSpan(
          text: cardinals[i],
          style: TextStyle(
            color: i == 0 ? const Color(0xFFEF4444) : colors.textTertiary,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, offset - Offset(textPainter.width / 2, textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ShowcaseQiblaNeedlePainter extends CustomPainter {
  final double angleDegrees;
  final bool isAligned;
  final AppCustomColors colors;

  const _ShowcaseQiblaNeedlePainter({
    required this.angleDegrees,
    required this.isAligned,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angleDegrees * math.pi / 180);

    // Emerald Aligned Kaaba Needle
    final needlePaint = Paint()
      ..color = isAligned ? const Color(0xFF10B981) : colors.primary
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, -(radius - 24))
      ..lineTo(7, 0)
      ..lineTo(-7, 0)
      ..close();
    canvas.drawPath(path, needlePaint);

    // Kaaba gold box indicator at tip
    final goldBoxPaint = Paint()
      ..color = const Color(0xFFF59E0B)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(0, -(radius - 26)), width: 10, height: 10),
        const Radius.circular(2),
      ),
      goldBoxPaint,
    );

    // Center pivot
    final pivotPaint = Paint()
      ..color = colors.surface
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 6, pivotPaint);

    final pivotBorder = Paint()
      ..color = colors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(Offset.zero, 6, pivotBorder);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ShowcaseQiblaNeedlePainter oldDelegate) =>
      oldDelegate.angleDegrees != angleDegrees || oldDelegate.isAligned != isAligned;
}
