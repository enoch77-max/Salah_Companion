import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Interactive Feature Showcase step for Salah Companion onboarding.
/// Provides live, interactive micro-demos (Prayer Card, Authentic Qibla Dial, and Tactile Tasbih)
/// with matching authentic in-app graphics and snappy interactions.
class InteractiveFeatureDemoStep extends StatefulWidget {
  const InteractiveFeatureDemoStep({super.key});

  @override
  State<InteractiveFeatureDemoStep> createState() =>
      _InteractiveFeatureDemoStepState();
}

class _InteractiveFeatureDemoStepState extends State<InteractiveFeatureDemoStep> {
  int _activeFeatureIndex = 0;

  // Qibla interactive state
  double _qiblaAngle = 45.0; // in degrees
  bool _isQiblaAligned = false;

  // Tasbih interactive state
  int _tasbihCount = 0;
  final List<String> _dhikrList = [
    'سُبْحَانَ اللَّهِ',
    'الْحَمْدُ لِلَّهِ',
    'اللَّهُ أَكْبَرُ',
    'لَا إِلٰهَ إِلَّا اللَّهُ',
  ];
  int _dhikrIndex = 0;

  // Prayer card mode
  int _soundModeIndex = 0; // 0: Adhan, 1: Chime, 2: Silent

  void _onQiblaPanUpdate(DragUpdateDetails details, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final touchPosition = details.localPosition;
    final dx = touchPosition.dx - center.dx;
    final dy = touchPosition.dy - center.dy;

    double angle = math.atan2(dy, dx) * 180 / math.pi + 90;
    if (angle < 0) angle += 360;

    final wasAligned = _isQiblaAligned;
    final isAligned = angle <= 8 || angle >= 352;

    if (isAligned && !wasAligned) {
      HapticFeedback.heavyImpact();
    } else {
      HapticFeedback.selectionClick();
    }

    setState(() {
      _qiblaAngle = angle;
      _isQiblaAligned = isAligned;
    });
  }

  void _incrementTasbih() {
    HapticFeedback.mediumImpact();
    setState(() {
      _tasbihCount++;
      if (_tasbihCount % 33 == 0) {
        _dhikrIndex = (_dhikrIndex + 1) % _dhikrList.length;
        HapticFeedback.vibrate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);

    return Column(
      key: const ValueKey('interactive_feature_demo_step'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top Features Medallion (Shadowless, Lighter Variant)
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF818CF8), // Light Indigo
                  Color(0xFF6366F1), // Vibrant Indigo
                ],
              ),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.widgets_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Title & Subtitle
        Text(
          l10n?.onboardingFeaturesTitle ?? 'Explore Core Features',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l10n?.onboardingFeaturesSubtitle ??
              'Experience precision prayer times, authentic Sunnah, and mindful worship tools.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.textSecondary,
            fontSize: 13,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 18),

        // Feature Selector Segmented Tabs (Snappy, Balanced & Auto-Scaled)
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.divider),
          ),
          child: Row(
            children: [
              _buildTabPill(0, Icons.schedule_rounded, l10n?.navHome ?? 'Prayer', colors,
                  const [Color(0xFFFBBF24), Color(0xFFF59E0B)]),
              _buildTabPill(1, Icons.explore_rounded, l10n?.navQibla ?? 'Qibla', colors,
                  const [Color(0xFF38BDF8), Color(0xFF0EA5E9)]),
              _buildTabPill(2, Icons.touch_app_rounded, l10n?.navTasbih ?? 'Tasbih', colors,
                  const [Color(0xFF34D399), Color(0xFF10B981)]),
              _buildTabPill(3, Icons.menu_book_rounded, l10n?.navDuas ?? 'Sunnah', colors,
                  const [Color(0xFFA78BFA), Color(0xFF8B5CF6)]),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Active Interactive Demo Card
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 140),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: _buildActiveDemoCard(colors, l10n),
        ),
      ],
    );
  }

  Widget _buildTabPill(
    int index,
    IconData icon,
    String label,
    AppCustomColors colors,
    List<Color> gradientColors,
  ) {
    final isSelected = _activeFeatureIndex == index;
    return Expanded(
      child: GestureDetector(
        key: ValueKey('demo_tab_$index'),
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (_activeFeatureIndex != index) {
            HapticFeedback.selectionClick();
            setState(() => _activeFeatureIndex = index);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 4),
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
                size: 15,
                color: isSelected ? Colors.white : colors.textSecondary,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    maxLines: 1,
                    style: TextStyle(
                      color: isSelected ? Colors.white : colors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 12,
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

  Widget _buildActiveDemoCard(AppCustomColors colors, AppLocalizations? l10n) {
    switch (_activeFeatureIndex) {
      case 0:
        return _buildPrayerDemo(colors, l10n);
      case 1:
        return _buildQiblaDemo(colors, l10n);
      case 2:
        return _buildTasbihDemo(colors, l10n);
      case 3:
      default:
        return _buildSunnahDemo(colors, l10n);
    }
  }

  Widget _buildPrayerDemo(AppCustomColors colors, AppLocalizations? l10n) {
    final soundModes = ['Adhan Voice', 'Gentle Chime', 'Silent'];

    return Container(
      key: const ValueKey('prayer_demo_view'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.sunny, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n?.prayerAsr ?? 'Asr',
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Text(
                            '03:45 PM • 42 mins left',
                            style: TextStyle(
                              color: Color(0xFFF59E0B),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
                ),
                child: const Text(
                  'Solar 18.0° MWL',
                  style: TextStyle(
                    color: Color(0xFFF59E0B),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Divider(height: 1, color: colors.divider),
          const SizedBox(height: 12),
          Text(
            'Interactive Alert Mode (Tap to test):',
            style: TextStyle(
              color: colors.textTertiary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(3, (idx) {
              final isSel = _soundModeIndex == idx;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _soundModeIndex = idx);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: idx < 2 ? 6 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSel ? const Color(0xFFF59E0B).withValues(alpha: 0.15) : colors.elevatedBackground,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSel ? const Color(0xFFF59E0B) : colors.divider,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        soundModes[idx],
                        style: TextStyle(
                          color: isSel ? const Color(0xFFF59E0B) : colors.textSecondary,
                          fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildQiblaDemo(AppCustomColors colors, AppLocalizations? l10n) {
    return LayoutBuilder(builder: (context, constraints) {
      final dialSize = math.min(constraints.maxWidth - 32, 210.0);

      return Container(
        key: const ValueKey('qibla_demo_view'),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _isQiblaAligned ? colors.success : colors.divider,
            width: _isQiblaAligned ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          children: [
            // Status Header Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _isQiblaAligned
                    ? colors.successSoft
                    : colors.primarySoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isQiblaAligned
                      ? colors.success.withValues(alpha: 0.4)
                      : colors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isQiblaAligned ? Icons.check_circle_rounded : Icons.explore_rounded,
                    size: 14,
                    color: _isQiblaAligned ? colors.success : colors.primary,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      _isQiblaAligned
                          ? (l10n?.onboardingFeatureQiblaAligned ?? 'Qibla Aligned • Makkah Al-Mukarramah')
                          : 'Aim needle North (Heading: ${_qiblaAngle.round()}°)',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: _isQiblaAligned ? colors.successText : colors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Authentic App Qibla Dial with Drag Controller
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanUpdate: (d) => _onQiblaPanUpdate(d, Size(dialSize, dialSize)),
              child: SizedBox(
                width: dialSize,
                height: dialSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Authentic 360° Compass Dial (Ticks, N, E, S, W & Kaaba dot)
                    CustomPaint(
                      size: Size(dialSize, dialSize),
                      painter: _DemoCompassDialPainter(
                        qiblaBearing: 0.0,
                        colors: colors,
                      ),
                    ),

                    // Authentic Qibla Needle
                    CustomPaint(
                      size: Size(dialSize, dialSize),
                      painter: _DemoQiblaNeedlePainter(
                        angleDegrees: _qiblaAngle,
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
    });
  }

  Widget _buildTasbihDemo(AppCustomColors colors, AppLocalizations? l10n) {
    return GestureDetector(
      key: const ValueKey('tasbih_demo_view'),
      onTap: _incrementTasbih,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.35)),
        ),
        child: Column(
          children: [
            Text(
              _dhikrList[_dhikrIndex],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF10B981),
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Scheherazade',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$_tasbihCount / 33',
              style: TextStyle(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 32,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n?.onboardingFeatureTapToCount ?? 'Tap anywhere or drag to count',
              style: TextStyle(
                color: colors.textTertiary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSunnahDemo(AppCustomColors colors, AppLocalizations? l10n) {
    return Container(
      key: const ValueKey('sunnah_demo_view'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF8B5CF6).withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.verified_rounded, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 8),
              const Text(
                'Sahih al-Bukhari • Hadith 5058',
                style: TextStyle(
                  color: Color(0xFF8B5CF6),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '“خَيْرُكُمْ مَنْ تَعَلَّمَ الْقُرْآنَ وَعَلَّمَهُ”',
            style: TextStyle(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '“The best among you are those who learn the Quran and teach it.”',
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 12,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

/// Authentic Compass Dial Painter matching QiblaScreen exactly
class _DemoCompassDialPainter extends CustomPainter {
  final double qiblaBearing;
  final AppCustomColors colors;

  const _DemoCompassDialPainter({
    required this.qiblaBearing,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    // 1. Outer rim background fill
    final bgPaint = Paint()
      ..color = colors.elevatedBackground
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius - 2, bgPaint);

    final borderPaint = Paint()
      ..color = colors.dividerStrong
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius - 2, borderPaint);

    // 2. Ticks & Cardinal Directions
    final tickPaint = Paint()..strokeCap = StrokeCap.round;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i < 360; i += 10) {
      final angleRad = (i - 90) * math.pi / 180;
      final isCardinal = i % 90 == 0;
      final isMajor = i % 30 == 0;

      final tickLength = isCardinal ? 10.0 : (isMajor ? 7.0 : 4.0);
      final strokeWidth = isCardinal ? 2.0 : (isMajor ? 1.4 : 0.8);

      tickPaint.color = isCardinal
          ? (i == 0 ? colors.missed : colors.textPrimary)
          : (isMajor ? colors.textSecondary : colors.textTertiary.withValues(alpha: 0.4));
      tickPaint.strokeWidth = strokeWidth;

      final outerPt = Offset(
        center.dx + (radius - 8) * math.cos(angleRad),
        center.dy + (radius - 8) * math.sin(angleRad),
      );
      final innerPt = Offset(
        center.dx + (radius - 8 - tickLength) * math.cos(angleRad),
        center.dy + (radius - 8 - tickLength) * math.sin(angleRad),
      );

      canvas.drawLine(innerPt, outerPt, tickPaint);

      // Cardinal Letters (N, E, S, W)
      if (isCardinal) {
        String label;
        Color labelColor;
        switch (i) {
          case 0:
            label = 'N';
            labelColor = colors.missed;
            break;
          case 90:
            label = 'E';
            labelColor = colors.textPrimary;
            break;
          case 180:
            label = 'S';
            labelColor = colors.textPrimary;
            break;
          case 270:
            label = 'W';
            labelColor = colors.textPrimary;
            break;
          default:
            label = '';
            labelColor = colors.textPrimary;
        }

        textPainter.text = TextSpan(
          text: label,
          style: TextStyle(
            color: labelColor,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        );
        textPainter.layout();

        final labelRadius = radius - 24;
        final labelPt = Offset(
          center.dx + labelRadius * math.cos(angleRad) - textPainter.width / 2,
          center.dy + labelRadius * math.sin(angleRad) - textPainter.height / 2,
        );
        textPainter.paint(canvas, labelPt);
      }
    }

    // 3. Kaaba Marker on Outer Rim at 0° (North/Qibla target)
    final qiblaRad = (qiblaBearing - 90) * math.pi / 180;
    final qiblaMarkerRadius = radius - 8;
    final qiblaCenter = Offset(
      center.dx + qiblaMarkerRadius * math.cos(qiblaRad),
      center.dy + qiblaMarkerRadius * math.sin(qiblaRad),
    );

    final qiblaMarkerPaint = Paint()
      ..color = colors.primary
      ..style = PaintingStyle.fill;
    canvas.drawCircle(qiblaCenter, 4.5, qiblaMarkerPaint);

    final qiblaInnerPaint = Paint()
      ..color = colors.surface
      ..style = PaintingStyle.fill;
    canvas.drawCircle(qiblaCenter, 2.0, qiblaInnerPaint);
  }

  @override
  bool shouldRepaint(covariant _DemoCompassDialPainter oldDelegate) => false;
}

/// Authentic Qibla Needle Painter matching QiblaScreen
class _DemoQiblaNeedlePainter extends CustomPainter {
  final double angleDegrees;
  final bool isAligned;
  final AppCustomColors colors;

  const _DemoQiblaNeedlePainter({
    required this.angleDegrees,
    required this.isAligned,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final needleLength = radius * 0.70;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate((angleDegrees - 90) * math.pi / 180);

    final mainColor = isAligned ? colors.success : const Color(0xFFF59E0B);

    // 1. Qibla Pointer Needle Head
    final needlePath = Path();
    needlePath.moveTo(needleLength, 0);
    needlePath.lineTo(needleLength - 20, -7);
    needlePath.lineTo(needleLength - 14, 0);
    needlePath.lineTo(needleLength - 20, 7);
    needlePath.close();

    final needlePaint = Paint()
      ..color = mainColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(needlePath, needlePaint);

    // Stem Line
    final stemPaint = Paint()
      ..color = mainColor
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset.zero, Offset(needleLength - 14, 0), stemPaint);

    // Opposite Tail
    final tailPath = Path();
    tailPath.moveTo(-18, 0);
    tailPath.lineTo(-8, -4);
    tailPath.lineTo(-8, 4);
    tailPath.close();

    final tailPaint = Paint()
      ..color = colors.textTertiary
      ..style = PaintingStyle.fill;
    canvas.drawPath(tailPath, tailPaint);

    // Center Pivot Cap
    final capOuterPaint = Paint()
      ..color = mainColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 7.0, capOuterPaint);

    final capInnerPaint = Paint()
      ..color = colors.surface
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 3.5, capInnerPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _DemoQiblaNeedlePainter oldDelegate) {
    return oldDelegate.angleDegrees != angleDegrees ||
        oldDelegate.isAligned != isAligned ||
        oldDelegate.colors != colors;
  }
}
