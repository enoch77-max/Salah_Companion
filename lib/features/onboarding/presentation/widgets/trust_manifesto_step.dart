import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Interactive Trust Manifesto step for Salah Companion onboarding.
/// Highlights our radical 100% privacy, zero-tracking, zero-ad, and non-commercial pledge
/// cleanly in the user's chosen language with no misleading expand arrows.
class TrustManifestoStep extends StatefulWidget {
  const TrustManifestoStep({super.key});

  @override
  State<TrustManifestoStep> createState() => _TrustManifestoStepState();
}

class _TrustManifestoStepState extends State<TrustManifestoStep>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);

    final pledges = [
      _TrustPledgeItem(
        icon: Icons.offline_bolt_rounded,
        accentColor: colors.primary,
        title: l10n?.onboardingTrustOfflineTitle ?? '100% On-Device & Private',
        description: l10n?.onboardingTrustOfflineDesc ??
            'Your location and prayer records never leave your phone. All astronomical solar math is calculated locally with zero network calls.',
      ),
      _TrustPledgeItem(
        icon: Icons.block_rounded,
        accentColor: const Color(0xFFE5A93C),
        title: l10n?.onboardingTrustNoAdsTitle ?? 'No Advertisements. Ever.',
        description: l10n?.onboardingTrustNoAdsDesc ??
            'Zero banners, zero commercial popups, and zero distractions between you and your Creator.',
      ),
      _TrustPledgeItem(
        icon: Icons.security_rounded,
        accentColor: const Color(0xFF4A90E2),
        title: l10n?.onboardingTrustNoTrackingTitle ?? 'Zero Analytics & Tracking',
        description: l10n?.onboardingTrustNoTrackingDesc ??
            'No Firebase tracking, no user profiling, no data collection, and no background telemetry.',
      ),
      _TrustPledgeItem(
        icon: Icons.favorite_rounded,
        accentColor: const Color(0xFF50C878),
        title: l10n?.onboardingTrustFreeTitle ?? 'Free Forever for the Ummah',
        description: l10n?.onboardingTrustFreeDesc ??
            'Built as a pure Sadaqah Jariyah. No paywalls, no subscriptions, no monetization.',
      ),
    ];

    return Column(
      key: const ValueKey('trust_manifesto_step'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top Emerald Gradient Shield Icon (Shadowless, Lighter Variant)
        Center(
          child: AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
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
                    Color(0xFF34D399), // Light Mint Emerald
                    Color(0xFF10B981), // Fresh Emerald Green
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.verified_user_rounded,
                color: Colors.white,
                size: 38,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Static "Al-Amānah" Chip
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: colors.primarySoft,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colors.primary.withValues(alpha: 0.35),
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'الْأَمَانَةُ',
                  style: TextStyle(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    fontFamily: 'Scheherazade',
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'AL-AMĀNAH',
                  style: TextStyle(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Static Localized Title in User's Chosen Language
        Text(
          l10n?.onboardingTrustTitle ?? 'Our Sacred Trust to You',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),

        // Subtitle
        Text(
          l10n?.onboardingTrustSubtitle ??
              'Built purely for the sake of Allah — zero ads, zero tracking, 100% private.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.textSecondary,
            fontSize: 13,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 18),

        // Pledge Cards List (Clean, Static, No Misleading Expand Arrow)
        ...List.generate(pledges.length, (index) {
          final pledge = pledges[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              key: ValueKey('trust_card_$index'),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colors.divider,
                  width: 1.0,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: pledge.accentColor.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      pledge.icon,
                      color: pledge.accentColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pledge.title,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pledge.description,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 12,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _TrustPledgeItem {
  final IconData icon;
  final Color accentColor;
  final String title;
  final String description;

  const _TrustPledgeItem({
    required this.icon,
    required this.accentColor,
    required this.title,
    required this.description,
  });
}
