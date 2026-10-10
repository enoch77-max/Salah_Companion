import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/app_haptics.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../reflection/domain/models/daily_content.dart';
import 'daily_reflection_card.dart';

/// Modal pop-up dialog presenting the Daily Reflection on first daily app entry.
///
/// Features:
/// - Frosted background blur (sigma 16)
/// - Continuous squircle container with dark paper surface
/// - Large, muted watermark quotation mark integrated into the card background
/// - Top-right ✕ close button
/// - Centered DAILY REFLECTION tag, Arabic text in Amiri, Lora translation, and citation
/// - Full-width "Continue to Prayer Times" CTA button
class DailyReflectionPopup extends StatelessWidget {
  static const emeraldGreen = Color(0xFF10B981);
  static const accentGold = Color(0xFFF59E0B);

  final DailyContentItem content;
  final bool isFavorited;
  final VoidCallback onToggleFavorite;
  final VoidCallback? onRefresh;
  final VoidCallback? onShare;

  const DailyReflectionPopup({
    super.key,
    required this.content,
    required this.isFavorited,
    required this.onToggleFavorite,
    this.onRefresh,
    this.onShare,
  });

  /// Displays the Daily Reflection pop-up modal with frosted blur backdrop.
  static Future<T?> show<T>(
    BuildContext context, {
    required DailyContentItem content,
    required bool isFavorited,
    required VoidCallback onToggleFavorite,
    VoidCallback? onRefresh,
    VoidCallback? onShare,
  }) {
    AppHaptics.selection();
    return showDialog<T>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.65),
      builder: (dialogContext) => DailyReflectionPopup(
        content: content,
        isFavorited: isFavorited,
        onToggleFavorite: onToggleFavorite,
        onRefresh: onRefresh,
        onShare: onShare,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);
    final isHadith = content.type == DailyContentType.hadith;
    final langCode = Localizations.localeOf(context).languageCode;
    final localizedTranslation = content.getLocalizedTranslation(langCode);

    final TextStyle arabicTextStyle =
        (isHadith
                ? AppTypography.hadithStyle(color: colors.textPrimary)
                : AppTypography.quranicStyle(color: colors.textPrimary))
            .copyWith(height: 1.7, fontSize: 20.0);

    final TextStyle translationTextStyle = AppTypography.quoteTranslationStyle(
      color: colors.textPrimary,
    ).copyWith(height: 1.45, fontSize: 14.5);

    final shareCallback =
        onShare ?? () => DailyReflectionCard.shareContent(content, langCode);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 390),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: colors.paperBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                  side: BorderSide(
                    color: colors.cardBorder,
                    width: 0.8,
                  ),
                ),
                shadows: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 36,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Large Muted Watermark Quotation Mark (66 Opening Quotation Position)
                  Positioned(
                    top: -10,
                    left: 12,
                    child: IgnorePointer(
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.format_quote_rounded,
                          size: 64,
                          color: accentGold.withValues(alpha: 0.08),
                        ),
                      ),
                    ),
                  ),

                  // Close Button (Top-Right)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: colors.textSecondary,
                      ),
                      tooltip: 'Close',
                      splashRadius: 18,
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                      onPressed: () {
                        AppHaptics.light();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),

                  // Main Content
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Centered Eyebrow Header Tag
                        Center(
                          child: Text(
                            (l10n?.notificationDailyReflectionTitle ??
                                    'Daily Reflection')
                                .toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: accentGold,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Arabic Calligraphy (RTL)
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            content.arabicText,
                            textAlign: TextAlign.center,
                            style: arabicTextStyle,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Hairline Gradient Divider
                        Container(
                          height: 1,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                colors.divider.withValues(alpha: 0.0),
                                colors.dividerStrong,
                                colors.divider.withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Translation Text (Lora italic)
                        Text(
                          localizedTranslation,
                          textAlign: TextAlign.center,
                          style: translationTextStyle,
                        ),
                        const SizedBox(height: 12),

                        // Citation & Hadith Grade Badge
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            Text(
                              content.getLocalizedSource(langCode),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
                                    color: colors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.5,
                                  ),
                            ),
                            if (isHadith &&
                                content.grade != null &&
                                content.grade!.trim().isNotEmpty) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 2,
                                ),
                                decoration: ShapeDecoration(
                                  color: emeraldGreen.withValues(alpha: 0.12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    side: BorderSide(
                                      color: emeraldGreen.withValues(
                                        alpha: 0.3,
                                      ),
                                      width: 0.8,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.check_circle_rounded,
                                      size: 11,
                                      color: emeraldGreen,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      content.grade!.trim(),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: emeraldGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Action Buttons: Refresh, Share, Bookmark
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (onRefresh != null)
                              AnimatedRefreshButton(onRefresh: onRefresh!),
                            IconButton(
                              onPressed: shareCallback,
                              icon: Icon(
                                Icons.share_rounded,
                                size: 17,
                                color: colors.textSecondary,
                              ),
                              tooltip: 'Share',
                              splashRadius: 18,
                              constraints: const BoxConstraints(
                                minWidth: 38,
                                minHeight: 38,
                              ),
                            ),
                            AnimatedFavoriteButton(
                              isFavorited: isFavorited,
                              onToggle: () {
                                AppHaptics.selection();
                                onToggleFavorite();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Continue to Prayer Times CTA Button
                        Container(
                          width: double.infinity,
                          decoration: ShapeDecoration(
                            color: colors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                AppHaptics.light();
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      l10n?.continueToPrayerTimes ??
                                          'Continue to Prayer Times',
                                      style: TextStyle(
                                        color: colors.background,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 16,
                                      color: colors.background,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
