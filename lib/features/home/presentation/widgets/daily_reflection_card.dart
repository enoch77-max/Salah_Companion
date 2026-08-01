import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/app_haptics.dart';
import '../../../reflection/domain/models/daily_content.dart';

/// Premium Reflection Card Widget.
///
/// Features:
/// - Background: Surface fill with subtle elevation border
/// - Continuous squircle curvature (`ContinuousRectangleBorder(borderRadius: BorderRadius.circular(18))`)
/// - Header: Type tag badge (`HADITH` / `AYAH`), gold quotation mark, share action, and animated favorite star toggle
/// - Arabic text: Amiri font (`quranicStyle`/`hadithStyle`), RTL direction with dynamic height
/// - Hairline divider separating Arabic and English
/// - Translation text: Lora italic (`quoteTranslationStyle`), textPrimary color
/// - Footer: Reference citation + Hadith grade pill badge (`Sahih` in green pill tag with check icon)
/// - Compact (~20% tighter footprint) with fully dynamic expansion for long Hadith/Ayah
class DailyReflectionCard extends StatelessWidget {
  static const emeraldGreen = Color(0xFF10B981);

  final DailyContentItem content;
  final bool isFavorited;
  final VoidCallback onToggleFavorite;
  final VoidCallback? onShare;
  final VoidCallback? onRefresh;

  const DailyReflectionCard({
    super.key,
    required this.content,
    required this.isFavorited,
    required this.onToggleFavorite,
    this.onShare,
    this.onRefresh,
  });

  /// Helper to share a [DailyContentItem] via system share sheet using `share_plus`.
  static void shareContent(DailyContentItem content) {
    AppHaptics.light();
    final text = StringBuffer();
    if (content.arabicText.trim().isNotEmpty) {
      text.writeln(content.arabicText);
      text.writeln();
    }
    text.writeln('"${content.translationText}"');
    text.writeln();
    text.writeln('— ${content.reference}');
    if (content.grade != null && content.grade!.trim().isNotEmpty) {
      text.writeln('Grade: ${content.grade}');
    }
    text.writeln();
    text.writeln('Shared via Salah Companion');

    // ignore: deprecated_member_use
    Share.share(
      text.toString(),
      subject: '${content.type == DailyContentType.hadith ? "Hadith" : "Ayah"} Reflection — ${content.reference}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isHadith = content.type == DailyContentType.hadith;
    const accentGold = Color(0xFFF59E0B);

    final TextStyle arabicTextStyle = (isHadith
            ? AppTypography.hadithStyle(color: colors.textPrimary)
            : AppTypography.quranicStyle(color: colors.textPrimary))
        .copyWith(height: 1.7, fontSize: 18.0);

    final TextStyle translationTextStyle = AppTypography.quoteTranslationStyle(
      color: colors.textPrimary,
    ).copyWith(height: 1.45, fontSize: 14.0);

    final shareCallback = onShare ?? () => shareContent(content);

    return Container(
      decoration: ShapeDecoration(
        color: colors.paperBackground,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: colors.dividerStrong,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 6.0, 14.0, 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Row: Single Quote Icon (Left) + Action Buttons (Right)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.format_quote_rounded,
                  size: 20,
                  color: accentGold,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onRefresh != null)
                      _AnimatedRefreshButton(
                        onRefresh: onRefresh!,
                      ),
                    IconButton(
                      onPressed: shareCallback,
                      icon: Icon(
                        Icons.share_rounded,
                        size: 16,
                        color: colors.textSecondary,
                      ),
                      tooltip: 'Share',
                      splashRadius: 16,
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                    _AnimatedFavoriteButton(
                      isFavorited: isFavorited,
                      onToggle: () {
                        AppHaptics.selection();
                        onToggleFavorite();
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 2),

            // Arabic Text (RTL)
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
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
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
              content.translationText,
              textAlign: TextAlign.center,
              style: translationTextStyle,
            ),
            const SizedBox(height: 12),

            // Footer Row: Citation & Grade Badge
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 4,
              children: [
                Text(
                  content.reference,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: colors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (isHadith && content.grade != null && content.grade!.trim().isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: ShapeDecoration(
                      color: emeraldGreen.withValues(alpha: 0.12),
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(
                          color: emeraldGreen.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          size: 12,
                          color: emeraldGreen,
                        ),
                        const SizedBox(width: 4),
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
          ],
        ),
      ),
    );
  }
}

class _AnimatedFavoriteButton extends StatefulWidget {
  final bool isFavorited;
  final VoidCallback onToggle;

  const _AnimatedFavoriteButton({
    required this.isFavorited,
    required this.onToggle,
  });

  @override
  State<_AnimatedFavoriteButton> createState() => _AnimatedFavoriteButtonState();
}

class _AnimatedFavoriteButtonState extends State<_AnimatedFavoriteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final iconColor = widget.isFavorited ? colors.primary : colors.textSecondary;

    return Semantics(
      button: true,
      label: widget.isFavorited ? 'Remove from saved' : 'Save to bookmarks',
      value: widget.isFavorited ? 'Saved' : 'Not saved',
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onToggle,
        behavior: HitTestBehavior.opaque,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 44,
            minHeight: 44,
          ),
          child: Center(
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  widget.isFavorited ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                  key: const ValueKey('save_icon'),
                  color: iconColor,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedRefreshButton extends StatefulWidget {
  final VoidCallback onRefresh;

  const _AnimatedRefreshButton({
    required this.onRefresh,
  });

  @override
  State<_AnimatedRefreshButton> createState() => _AnimatedRefreshButtonState();
}

class _AnimatedRefreshButtonState extends State<_AnimatedRefreshButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    HapticFeedback.lightImpact();
    _controller.forward(from: 0.0);
    widget.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Semantics(
      button: true,
      label: 'Refresh quote',
      child: IconButton(
        key: const ValueKey('refresh_quote_button'),
        onPressed: _handleTap,
        icon: RotationTransition(
          turns: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
          ),
          child: Icon(
            Icons.refresh_rounded,
            size: 20,
            color: colors.textSecondary,
          ),
        ),
        tooltip: 'Refresh quote',
        splashRadius: 20,
        constraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 44,
        ),
      ),
    );
  }
}
