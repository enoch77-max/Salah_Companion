import 'package:flutter/material.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/services/app_haptics.dart';

import '../../../../core/utils/url_launcher_utils.dart';

/// Screen displaying the Terms & Conditions for Salah Companion.
class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

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
          'Terms & Conditions',
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
                'Terms of Service',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'By downloading and using Salah Companion, you agree to the following terms and guidelines.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colors.textSecondary,
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 24),

              _buildTermSection(
                context,
                title: '1. Open Source & License',
                content:
                    'Salah Companion is 100% free and open source software created for the sake of Allah (Fi Sabilillah) to serve the global Muslim community. Using this application or its source code for commercial purposes, selling it, charging for access, or creating paid or proprietary derivatives is strictly prohibited. The full source code is public and open for community contributions, suggestions, and security audits.',
                githubUrl: 'https://github.com/enoch77-max/Salah_Companion',
              ),
              const SizedBox(height: 16),

              _buildTermSection(
                context,
                title: '2. Calculation Disclaimer',
                content:
                    'Prayer times are computed using standard astronomical algorithms based on your geographical coordinates. While astronomical calculations are highly precise, minor variations (1–3 minutes) may occur relative to local mosque timetables due to safety buffers (Ihtiyat), atmospheric refraction, or elevation. Users are encouraged to adjust Calculation Method and Madhab settings in the app to align with their local mosque authority.',
              ),
              const SizedBox(height: 16),

              _buildTermSection(
                context,
                title: '3. Notifications & Battery Settings',
                content:
                    'Due to manufacturer-specific Android battery optimizations (e.g. Xiaomi, Samsung, Oppo, Vivo), device operating systems may defer background alarms. Users must grant battery optimization exemptions to ensure uninterrupted Adhan audio reminders.',
              ),
              const SizedBox(height: 16),

              _buildTermSection(
                context,
                title: '4. Limitation of Liability',
                content:
                    'Salah Companion is provided "as is" without warranty of any kind. While every effort is made to maintain extreme precision, the developers assume no liability for missed prayers or timing discrepancies resulting from device battery management or hardware sensor variance.',
              ),
              const SizedBox(height: 32),

              Center(
                child: Text(
                  'Salah Companion • Open Source',
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

  Widget _buildTermSection(
    BuildContext context, {
    required String title,
    required String content,
    String? githubUrl,
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
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.textSecondary,
                    height: 1.5,
                  ),
            ),
            if (githubUrl != null) ...[
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  AppHaptics.selection();
                  await UrlLauncherUtils.openUrl(context, githubUrl);
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: colors.primarySoft,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colors.primary.withValues(alpha: 0.3),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.code_rounded, size: 18, color: colors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          githubUrl,
                          style: TextStyle(
                            color: colors.primaryText,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.open_in_new_rounded, size: 16, color: colors.primary),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
