import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Spiritual Dedication step for Salah Companion onboarding.
/// Concludes onboarding with a serene Quranic verse and imperial gold illuminated styling.
class SpiritualDedicationStep extends StatefulWidget {
  const SpiritualDedicationStep({super.key});

  @override
  State<SpiritualDedicationStep> createState() =>
      _SpiritualDedicationStepState();
}

class _SpiritualDedicationStepState extends State<SpiritualDedicationStep>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);

    return Column(
      key: const ValueKey('spiritual_dedication_step'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Light Gold Emblem (Shadowless, Lighter Variant)
        Center(
          child: AnimatedBuilder(
            animation: _glowAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _glowAnimation.value,
                child: child,
              );
            },
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFDE047), // Soft Light Gold
                    Color(0xFFFBBF24), // Luminous Warm Gold
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.mosque_rounded,
                color: Colors.white,
                size: 38,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Spiritual Arabic Verse Card
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              const Text(
                '﴿ إِنَّ الصَّلَاةَ كَانَتْ عَلَى الْمُؤْمِنِينَ كِتَابًا مَّوْقُوتًا ﴾',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Color(0xFFF59E0B),
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  fontFamily: 'Scheherazade',
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                l10n?.onboardingDedicationVerse ??
                    '“Indeed, prayer has been decreed upon the believers a decree of specified times.”',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l10n?.onboardingDedicationReference ??
                    'Surah An-Nisa (4:103)',
                style: TextStyle(
                  color: colors.textTertiary,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Three core reassurance pills with rich colorful leading badges
        _buildReassurancePill(
          icon: Icons.check_circle_rounded,
          iconGradient: const [Color(0xFF10B981), Color(0xFF059669)],
          text: '100% Free & No Ads — Sadaqah Jariyah',
          colors: colors,
        ),
        const SizedBox(height: 8),
        _buildReassurancePill(
          icon: Icons.lock_rounded,
          iconGradient: const [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
          text: 'Private & Offline — Zero Telemetry',
          colors: colors,
        ),
        const SizedBox(height: 8),
        _buildReassurancePill(
          icon: Icons.auto_awesome_rounded,
          iconGradient: const [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
          text: 'Authentic Sunnah & Precision Astrometry',
          colors: colors,
        ),
      ],
    );
  }

  Widget _buildReassurancePill({
    required IconData icon,
    required List<Color> iconGradient,
    required String text,
    required AppCustomColors colors,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.divider),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: iconGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: colors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
