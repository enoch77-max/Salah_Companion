import 'package:flutter/material.dart';
import '../../../../app/theme/app_theme.dart';

/// Documentation screen detailing prayer time calculation methodology,
/// why 1-3 minute variations occur between apps/Google/mosques, and how to adjust settings.
class CalculationDocsScreen extends StatelessWidget {
  const CalculationDocsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: colors.textPrimary,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Calculation Accuracy & FAQ',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Understanding Prayer Times',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Learn how astronomical calculations work, why minor 1–3 minute differences happen between sources like Google or local mosques, and how to configure 100% accurate settings.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colors.textSecondary,
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 24),

              // FAQ Item 1: Why times differ by 1-3 mins
              _buildFaqCard(
                context,
                icon: Icons.help_outline_rounded,
                iconColor: const Color(0xFF0EA5E9),
                question: 'Why do prayer times differ by a few minutes from Google or local mosques?',
                answer:
                    'Prayer times are computed using solar elevation formulas. Variations of 1 to 3 minutes occur due to 4 factors:\n\n'
                    '1. Regional Calculation Methods: Different Islamic authorities use slightly different twilight angles for Fajr (e.g. 18.5° for Umm Al-Qura vs 18° for MWL) and Isha (e.g. 90-min fixed delay vs 17° angle).\n'
                    '2. Safety Buffers (Ihtiyat / احتياط): Local mosque timetables often add 1 to 3 safety minutes to Maghrib (to ensure sunset certainty) or Dhuhr (to ensure zenith passing).\n'
                    '3. Exact GPS vs City Center: Google search uses a single static city-center coordinate, whereas Salah Companion uses your precise GPS coordinates.\n'
                    '4. Juristic School (Madhab): Shafi/Standard calculates Asr at 1x shadow length, while Hanafi calculates Asr at 2x shadow length (~45-60 min later).',
              ),
              const SizedBox(height: 16),

              // FAQ Item 2: How to align with local mosque
              _buildFaqCard(
                context,
                icon: Icons.tune_rounded,
                iconColor: const Color(0xFF10B981),
                question: 'How do I align prayer times with my local mosque?',
                answer:
                    '1. Go to Settings in Salah Companion.\n'
                    '2. Select Calculation Method and pick your regional authority (e.g. Umm Al-Qura for Saudi Arabia, Diyanet for Turkey, MWL for Europe/Asia, ISNA for North America).\n'
                    '3. Select Madhab for Asr timing (Shafi / Standard vs Hanafi).\n'
                    '4. Ensure location permission is granted so exact coordinates are used.',
              ),
              const SizedBox(height: 16),

              // FAQ Item 3: Open Source & Data Guarantee
              _buildFaqCard(
                context,
                icon: Icons.lock_open_rounded,
                iconColor: const Color(0xFF8B5CF6),
                question: 'Is my location data private?',
                answer:
                    'Yes, 100%. Salah Companion calculates all prayer times completely offline on your device using astronomical algorithms. Your GPS position is never uploaded to any server or tracked.',
              ),
              const SizedBox(height: 32),

              Center(
                child: Text(
                  'Salah Companion • Open & Transparent',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.textTertiary,
                      ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String question,
    required String answer,
  }) {
    final colors = context.appColors;

    return Material(
      color: colors.surface,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: colors.divider, width: 1.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              answer,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.textSecondary,
                    height: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
