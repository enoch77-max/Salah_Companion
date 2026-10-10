import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';

/// Configuration for the persistent shared header during expanding card transitions.
///
/// Guarantees visual continuity and spatial permanence:
/// The title text, squircle icon badge, and glyph NEVER disappear during the
/// expansion from resting card to popup dialog, instead smoothly shifting and
/// resizing to settle into the dialog's top header.
class SharedHeaderConfig {
  final IconData icon;
  final String startTitle;
  final String endTitle;
  final String? endArabicTitle;
  final String? endSubtitle;
  final double startIconSize;
  final double endIconSize;
  final double startIconBoxSize;
  final double endIconBoxSize;
  final double startFontSize;
  final double endFontSize;
  final EdgeInsets startPadding;
  final EdgeInsets endPadding;
  final Color? accentColor;
  final Color? startTextColor;
  final Color? endTextColor;
  final Color? startIconBg;
  final Color? endIconBg;
  final Color? startIconColor;
  final Color? endIconColor;

  const SharedHeaderConfig({
    required this.icon,
    required this.startTitle,
    required this.endTitle,
    this.endArabicTitle,
    this.endSubtitle,
    this.startIconSize = 16.0,
    this.endIconSize = 19.0,
    this.startIconBoxSize = 32.0,
    this.endIconBoxSize = 38.0,
    this.startFontSize = 15.0,
    this.endFontSize = 16.5,
    this.startPadding = const EdgeInsets.all(16.0),
    this.endPadding = const EdgeInsets.only(left: 18.0, right: 14.0, top: 14.0, bottom: 8.0),
    this.accentColor,
    this.startTextColor,
    this.endTextColor,
    this.startIconBg,
    this.endIconBg,
    this.startIconColor,
    this.endIconColor,
  });
}

/// Custom Origin-Aware Expanding Container Transform Route.
///
/// Animates a card from its physical location and size on screen ([originRect])
/// into an expanded dialog/reader surface, and shrinks back to the exact card
/// bounds on dismissal.
///
/// Key Architectural Guarantees:
/// 1. Spatial Permanence: The card container physically expands out of [originRect].
/// 2. Header Continuity: When [headerConfig] is provided, the title text and icon
///    remain at 100% opacity throughout the entire animation, gliding smoothly from
///    the card's local header coordinates to the popup dialog's header position.
/// 3. Rapid & Silky Motion: 300ms forward duration with an asymmetric fluid curve
///    `Cubic(0.08, 0.85, 0.15, 1.0)` for instantaneous user reaction and smooth settle.
/// 4. Zero Ghosting: At t >= 0.999, hands off seamlessly to the popup's native header;
///    on pop, immediately re-engages the shared header to glide back into the card.
class CardExpandRoute<T> extends PageRoute<T> {
  final Rect? originRect;
  final double? targetHeight;
  final double startRadius;
  final double targetRadius;
  final SharedHeaderConfig? headerConfig;
  final Widget? originCardBody;
  final Widget Function(BuildContext context, Animation<double> animation) builder;

  CardExpandRoute({
    required this.builder,
    this.originRect,
    this.targetHeight,
    this.startRadius = 18.0,
    this.targetRadius = 24.0,
    this.headerConfig,
    this.originCardBody,
    super.settings,
  });

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => 'Close';

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 240);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context, animation);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final topPadding = mediaQuery.padding.top;
    final bottomPadding = mediaQuery.padding.bottom;

    // Calculate responsive target rect for expanded popup window
    final double maxDialogWidth = math.min(screenSize.width - 24.0, 540.0);
    final double left = (screenSize.width - maxDialogWidth) / 2.0;
    final double topMargin = topPadding + 14.0;
    final double availableHeight =
        screenSize.height - topMargin - bottomPadding - 16.0;

    final double dialogHeight = targetHeight != null
        ? math.min(availableHeight, targetHeight!)
        : availableHeight;

    final double top = targetHeight != null
        ? (topMargin + (availableHeight - dialogHeight) / 2.0)
        : topMargin;

    final Rect targetRect =
        Rect.fromLTWH(left, top, maxDialogWidth, math.max(dialogHeight, 280.0));

    // Fallback if originRect is null or offscreen
    final Rect startRect = originRect ??
        Rect.fromCenter(
          center: Offset(screenSize.width / 2, screenSize.height / 2),
          width: math.min(screenSize.width - 32.0, 480.0),
          height: 180.0,
        );

    // Asymmetric fluid deceleration curve for opening; snappy acceleration for closing
    final CurvedAnimation curved = CurvedAnimation(
      parent: animation,
      curve: const Cubic(0.08, 0.85, 0.15, 1.0),
      reverseCurve: const Cubic(0.35, 0.0, 0.20, 1.0),
    );

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.appColors;

    return AnimatedBuilder(
      animation: curved,
      builder: (context, _) {
        final t = curved.value;
        final currentRect = Rect.lerp(startRect, targetRect, t)!;
        final currentRadius = lerpDouble(startRadius, targetRadius, t)!;

        // Physicality: Lift elevation immediately off the page
        final double currentElevation = lerpDouble(1.5, 24.0, t)!;
        // Subtle z-plane micro-pop: projects forward slightly during transition then settles
        final double popScale =
            t >= 1.0 ? 1.0 : (1.0 + 0.012 * math.sin(t * math.pi));

        // Staged content cross-morph:
        // 1. Resting Card Body dissolves quickly in the early phase
        final double cardBodyOpacity = (1.0 - (t / 0.18)).clamp(0.0, 1.0);
        // 2. Popup Content emerges smoothly from t = 0.14 to 0.60
        final double popupBodyOpacity = ((t - 0.14) / 0.46).clamp(0.0, 1.0);

        final config = headerConfig;
        final bool showSharedHeader = config != null && t < 0.999;

        return Stack(
          children: [
            // 1. Frosted Backdrop Scrim (darkens and blurs background smoothly)
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (animation.status == AnimationStatus.completed ||
                      animation.status == AnimationStatus.forward) {
                    Navigator.of(context).maybePop();
                  }
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7.0 * t, sigmaY: 7.0 * t),
                  child: Container(
                    color: Colors.black.withValues(
                      alpha: (isDark ? 0.60 : 0.38) * t,
                    ),
                  ),
                ),
              ),
            ),

            // 2. Expanding Container Surface
            Positioned.fromRect(
              rect: currentRect,
              child: Transform.scale(
                scale: popScale,
                alignment: Alignment.center,
                child: Material(
                  color: colors.paperBackground,
                  elevation: currentElevation,
                  shadowColor: Colors.black.withValues(
                    alpha: (isDark ? 0.50 : 0.22) * t,
                  ),
                  borderRadius: BorderRadius.circular(currentRadius),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(currentRadius),
                      border: Border.all(
                        color: colors.cardBorder,
                        width: 1.0,
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Layer A: Popup Content (materializes and glides gently up)
                        if (popupBodyOpacity > 0.0)
                          Positioned.fill(
                            child: Opacity(
                              opacity: popupBodyOpacity,
                              child: OverflowBox(
                                alignment: Alignment.topCenter,
                                minWidth: targetRect.width,
                                maxWidth: targetRect.width,
                                minHeight: targetRect.height,
                                maxHeight: targetRect.height,
                                child: Transform.translate(
                                  offset: Offset(
                                    0,
                                    16.0 * (1.0 - popupBodyOpacity),
                                  ),
                                  child: child,
                                ),
                              ),
                            ),
                          ),

                        // Layer B: Origin Card Body (dissolves cleanly in origin bounds)
                        if (cardBodyOpacity > 0.0 && originCardBody != null)
                          Positioned(
                            top: (config?.startPadding.top ?? 16.0) +
                                (config?.startIconBoxSize ?? 32.0) +
                                8.0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Opacity(
                              opacity: cardBodyOpacity,
                              child: OverflowBox(
                                alignment: Alignment.topCenter,
                                minWidth: startRect.width,
                                maxWidth: startRect.width,
                                minHeight: math.max(
                                  startRect.height -
                                      ((config?.startPadding.top ?? 16.0) +
                                          (config?.startIconBoxSize ?? 32.0) +
                                          8.0),
                                  0.0,
                                ),
                                maxHeight: startRect.height,
                                child: originCardBody!,
                              ),
                            ),
                          ),

                        // Layer C: Persistent Shared Header (NEVER DISAPPEARS)
                        if (showSharedHeader)
                          Positioned(
                            top: lerpDouble(
                              config.startPadding.top,
                              config.endPadding.top,
                              t,
                            )!,
                            left: lerpDouble(
                              config.startPadding.left,
                              config.endPadding.left,
                              t,
                            )!,
                            right: lerpDouble(
                              config.startPadding.right,
                              config.endPadding.right,
                              t,
                            )!,
                            child: _buildSharedHeader(
                              context,
                              config,
                              t,
                              isDark,
                              colors,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Persistent shared header that continuously glides, scales, and morphs
  /// from card header coordinates to popup dialog top header coordinates.
  Widget _buildSharedHeader(
    BuildContext context,
    SharedHeaderConfig config,
    double t,
    bool isDark,
    AppCustomColors colors,
  ) {
    final currentIconBox =
        lerpDouble(config.startIconBoxSize, config.endIconBoxSize, t)!;
    final currentIconGlyph =
        lerpDouble(config.startIconSize, config.endIconSize, t)!;
    final currentRadius = lerpDouble(9.0, 11.0, t)!;

    final defaultAccent = config.accentColor ?? colors.primary;

    final iconBg = Color.lerp(
      config.startIconBg ??
          defaultAccent.withValues(alpha: isDark ? 0.20 : 0.12),
      config.endIconBg ??
          defaultAccent.withValues(alpha: isDark ? 0.18 : 0.10),
      t,
    )!;

    final iconColor = Color.lerp(
      config.startIconColor ??
          (isDark ? colors.primaryText : defaultAccent),
      config.endIconColor ?? defaultAccent,
      t,
    )!;

    final currentFontSize =
        lerpDouble(config.startFontSize, config.endFontSize, t)!;
    final textColor = Color.lerp(
      config.startTextColor ?? colors.textPrimary,
      config.endTextColor ?? colors.textPrimary,
      t,
    )!;

    // Title morphing: if identical, single Text widget. If different, smooth crossfade.
    final bool isSameTitle = config.startTitle == config.endTitle;
    final double startTitleOpacity =
        isSameTitle ? 1.0 : (1.0 - (t / 0.35)).clamp(0.0, 1.0);
    final double endTitleOpacity =
        isSameTitle ? 1.0 : ((t - 0.15) / 0.40).clamp(0.0, 1.0);

    // Subtitle & Arabic title fade-in:
    final double subtitleOpacity = ((t - 0.25) / 0.40).clamp(0.0, 1.0);
    // Close button fade-in:
    final double closeBtnOpacity = ((t - 0.35) / 0.40).clamp(0.0, 1.0);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Squircle Icon Badge
        Container(
          width: currentIconBox,
          height: currentIconBox,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(currentRadius),
            border: Border.all(
              color: iconColor.withValues(alpha: isDark ? 0.30 : 0.20),
              width: 0.8,
            ),
          ),
          child: Center(
            child: Icon(
              config.icon,
              size: currentIconGlyph,
              color: iconColor,
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Title & Metadata Column
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        if (isSameTitle)
                          Text(
                            config.startTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: currentFontSize,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                              letterSpacing: -0.2,
                            ),
                          )
                        else ...[
                          if (startTitleOpacity > 0.0)
                            Opacity(
                              opacity: startTitleOpacity,
                              child: Text(
                                config.startTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: currentFontSize,
                                  fontWeight: FontWeight.w800,
                                  color: textColor,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                          if (endTitleOpacity > 0.0)
                            Opacity(
                              opacity: endTitleOpacity,
                              child: Text(
                                config.endTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: currentFontSize,
                                  fontWeight: FontWeight.w800,
                                  color: textColor,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                  if (config.endArabicTitle != null && subtitleOpacity > 0.0) ...[
                    const SizedBox(width: 8.0),
                    Opacity(
                      opacity: subtitleOpacity,
                      child: Text(
                        config.endArabicTitle!,
                        style: GoogleFonts.amiri(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: defaultAccent,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              if (config.endSubtitle != null && subtitleOpacity > 0.0) ...[
                const SizedBox(height: 1.0),
                Opacity(
                  opacity: subtitleOpacity,
                  child: Text(
                    config.endSubtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        // Close Icon at Dialog Top-Right
        if (closeBtnOpacity > 0.0)
          Opacity(
            opacity: closeBtnOpacity,
            child: Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Icon(
                Icons.close_rounded,
                size: 20.0,
                color: colors.textSecondary,
              ),
            ),
          ),
      ],
    );
  }
}
