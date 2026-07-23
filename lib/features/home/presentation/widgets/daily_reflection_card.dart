import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../reflection/domain/models/daily_content.dart';

/// Vintage Paper Reflection Card Widget.
///
/// Features:
/// - Background: Elevated BG fill (`#12151C` dark / `#EDE9E4` light)
/// - Border: Hairline border using `Divider Strong` (`0x17FFFFFF` dark / `0x1A000000` light)
/// - Continuous squircle curvature (`ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20))`)
/// - Decorative quotation mark in `Primary Soft` color in header
/// - Arabic text: Amiri font (`quranicStyle`/`hadithStyle`), RTL direction
/// - Translation text: Lora italic (`quoteTranslationStyle`), textPrimary color
/// - Caption: `reference` + for Hadith (`grade` • `gradedBy`), Inter UI font, textSecondary color
/// - Star toggle action: filled primary when favorited, outline textSecondary when not, with scale feedback.
class DailyReflectionCard extends StatelessWidget {
  final DailyContentItem content;
  final bool isFavorited;
  final VoidCallback onToggleFavorite;
  final VoidCallback? onShare;

  const DailyReflectionCard({
    super.key,
    required this.content,
    required this.isFavorited,
    required this.onToggleFavorite,
    this.onShare,
  });

  String _buildCaptionText() {
    if (content.type == DailyContentType.hadith) {
      final parts = <String>[];
      if (content.grade != null && content.grade!.trim().isNotEmpty) {
        parts.add(content.grade!.trim());
      }
      if (content.gradedBy != null && content.gradedBy!.trim().isNotEmpty) {
        parts.add(content.gradedBy!.trim());
      }
      if (parts.isNotEmpty) {
        return '${content.reference} • ${parts.join(' • ')}';
      }
    }
    return content.reference;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final TextStyle arabicTextStyle = content.type == DailyContentType.ayah
        ? AppTypography.quranicStyle(color: colors.textPrimary)
        : AppTypography.hadithStyle(color: colors.textPrimary);

    final TextStyle translationTextStyle = AppTypography.quoteTranslationStyle(
      color: colors.textPrimary,
    );

    final TextStyle captionStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
              color: colors.textSecondary,
            ) ??
        TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colors.textSecondary,
        );

    return Container(
      decoration: ShapeDecoration(
        color: colors.elevatedBackground,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: colors.dividerStrong,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Decorative quotation mark
                Icon(
                  Icons.format_quote_rounded,
                  size: 28,
                  color: colors.primarySoft,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onShare != null)
                      IconButton(
                        onPressed: onShare,
                        icon: Icon(
                          Icons.share_rounded,
                          size: 20,
                          color: colors.textSecondary,
                        ),
                        tooltip: 'Share',
                        splashRadius: 20,
                        constraints: const BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                        ),
                      ),
                    _AnimatedFavoriteButton(
                      isFavorited: isFavorited,
                      onToggle: onToggleFavorite,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Arabic Text (RTL)
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                content.arabicText,
                textAlign: TextAlign.center,
                style: arabicTextStyle,
              ),
            ),
            const SizedBox(height: 16),
            // Translation Text (Lora italic)
            Text(
              content.translationText,
              textAlign: TextAlign.center,
              style: translationTextStyle,
            ),
            const SizedBox(height: 16),
            // Caption (Inter, textSecondary)
            Text(
              _buildCaptionText(),
              textAlign: TextAlign.center,
              style: captionStyle,
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
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.82).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
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
      label: widget.isFavorited ? 'Remove from favorites' : 'Add to favorites',
      value: widget.isFavorited ? 'Favorited' : 'Not favorited',
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
                  widget.isFavorited ? Icons.star_rounded : Icons.star_outline_rounded,
                  key: const ValueKey('star_icon'),
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
