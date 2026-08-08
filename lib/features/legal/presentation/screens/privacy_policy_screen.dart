import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/services/app_haptics.dart';

/// Screen displaying the Privacy Policy for Salah Companion.
/// Highlights open source commitment, zero ads, zero tracking, and local-only GPS usage.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'Privacy Policy',
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
              // Header Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shield_rounded, color: Color(0xFF10B981), size: 18),
                    const SizedBox(width: 8),
                    Text(
                      '100% Private & Open Source',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: const Color(0xFF10B981),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                'Your Privacy is Sacred',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
              ),
              const SizedBox(height: 12),

              Text(
                'Salah Companion is built with a strict privacy-first architecture. We believe a worship companion app should respect your spiritual focus without tracking, advertising, or selling user data.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colors.textSecondary,
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 24),

              // Key Commitments
              _buildPolicySection(
                context,
                icon: Icons.code_rounded,
                iconColor: const Color(0xFF8B5CF6),
                title: 'Completely Free & Open Source',
                description:
                    'Salah Companion is 100% free with no paywalls, hidden fees, or premium tiers. The codebase is fully open source for complete public auditability.',
                githubUrl: 'https://github.com/enoch77-max/Salah_Companion',
              ),
              const SizedBox(height: 16),

              _buildPolicySection(
                context,
                icon: Icons.block_rounded,
                iconColor: const Color(0xFFEF4444),
                title: 'Zero Ads & Zero Commercial Tracking',
                description:
                    'This app contains no advertisements, commercial SDKs, tracking pixels, or third-party behavioral analytics. Your focus during prayer remains uninterrupted.',
              ),
              const SizedBox(height: 16),

              _buildPolicySection(
                context,
                icon: Icons.location_on_rounded,
                iconColor: const Color(0xFF0EA5E9),
                title: 'Local-Only GPS Usage',
                description:
                    'GPS permissions are requested strictly to calculate accurate astronomical prayer times and Qibla direction for your exact location. Your geographical coordinates are processed strictly on your device and are NEVER uploaded to any cloud server or transmitted off-device.',
              ),
              const SizedBox(height: 16),

              _buildPolicySection(
                context,
                icon: Icons.sd_storage_rounded,
                iconColor: const Color(0xFFF59E0B),
                title: 'Offline Local Database',
                description:
                    'All prayer calculation preferences, logged prayers, tasbih counts, and settings are stored locally on your device in an encrypted SQLite database. You remain in complete control of your data.',
              ),
              const SizedBox(height: 16),

              _buildPolicySection(
                context,
                icon: Icons.language_rounded,
                iconColor: const Color(0xFF10B981),
                title: 'Online Hosted Privacy Policy',
                description:
                    'You can also read the official hosted web version of our privacy policy online on GitHub:',
                githubUrl: 'https://enoch77-max.github.io/Salah_Companion/docs/privacy.html',
              ),
              const SizedBox(height: 32),

              Center(
                child: Text(
                  'Salah Companion • Dedicated to the Ummah',
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

  Widget _buildPolicySection(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
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
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                              height: 1.4,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (githubUrl != null) ...[
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  AppHaptics.selection();
                  final uri = Uri.parse(githubUrl);
                  try {
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  } catch (_) {}
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
