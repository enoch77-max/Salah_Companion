import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../core/constants/app_provenance.dart';
import '../../../../core/services/app_haptics.dart';

/// Modal sheet presenting Salah Companion's 100% Open Source & Zero Data Tracking guarantee.
class OpenSourceSheet extends StatelessWidget {
  static const repoUrl = AppProvenance.repositoryUrl;

  const OpenSourceSheet({super.key});

  static Future<void> show(BuildContext context) {
    AppHaptics.selection();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const OpenSourceSheet(),
    );
  }

  Future<void> _launchGitHub(BuildContext context) async {
    AppHaptics.selection();
    final uri = Uri.parse(repoUrl);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          _copyToClipboard(context);
        }
      }
    } catch (_) {
      if (context.mounted) {
        _copyToClipboard(context);
      }
    }
  }

  void _copyToClipboard(BuildContext context) {
    AppHaptics.medium();
    Clipboard.setData(const ClipboardData(text: repoUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'GitHub link copied to clipboard!',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(
          color: colors.dividerStrong,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 30,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 12, 20, bottomPadding > 0 ? bottomPadding + 12 : 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ─── DRAG HANDLE ──────────────────────────────────────────────
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.textTertiary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // ─── HEADER BADGE & TITLE ──────────────────────────────────────
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colors.primarySoft,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.primary.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      Icons.code_rounded,
                      color: colors.primary,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '100% Open Source',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Transparent & Privacy-First',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colors.textSecondary,
                                fontSize: 13,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: colors.primary.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'Non-Commercial',
                      style: TextStyle(
                        color: colors.primaryText,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ─── PRIVACY GUARANTEE CARDS (Grouped Inset Style) ───────────
              Container(
                decoration: BoxDecoration(
                  color: colors.surfaceHover.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colors.divider, width: 1.0),
                ),
                child: Column(
                  children: [
                    _PrivacyFeatureTile(
                      icon: Icons.shield_outlined,
                      iconColor: const Color(0xFF10B981),
                      title: 'Zero Data Stored or Shared',
                      description: 'No account required. We never collect, track, or sell your personal data.',
                    ),
                    Divider(height: 1, thickness: 1, color: colors.divider, indent: 52),
                    _PrivacyFeatureTile(
                      icon: Icons.signal_wifi_off_rounded,
                      iconColor: const Color(0xFF0EA5E9),
                      title: '100% Offline Capability',
                      description: 'Prayer times, Qibla calculation, and Duas work completely offline.',
                    ),
                    Divider(height: 1, thickness: 1, color: colors.divider, indent: 52),
                    _PrivacyFeatureTile(
                      icon: Icons.visibility_outlined,
                      iconColor: const Color(0xFF8B5CF6),
                      title: 'Fully Auditable Code',
                      description: 'Inspect every feature, algorithm, and line of code freely on GitHub.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ─── GITHUB LINK BOX ──────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.dividerStrong),
                ),
                child: Row(
                  children: [
                    Icon(Icons.terminal_rounded, size: 20, color: colors.textSecondary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'enoch77-max/Salah_Companion',
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 12.5,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.copy_rounded, size: 18, color: colors.primary),
                      tooltip: 'Copy Link',
                      onPressed: () => _copyToClipboard(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ─── ACTION BUTTON ────────────────────────────────────────────
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () => _launchGitHub(context),
                  icon: const Icon(Icons.open_in_new_rounded, size: 18),
                  label: const Text(
                    'View Code on GitHub',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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
}

class _PrivacyFeatureTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const _PrivacyFeatureTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 11.5,
                    height: 1.3,
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
