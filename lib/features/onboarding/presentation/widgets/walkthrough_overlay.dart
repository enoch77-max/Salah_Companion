import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salah_companion/app/theme/app_theme.dart';

/// Interactive Apple-inspired Onboarding Feature Walkthrough Overlay.
class WalkthroughOverlay extends StatefulWidget {
  final VoidCallback onDismiss;

  const WalkthroughOverlay({
    super.key,
    required this.onDismiss,
  });

  @override
  State<WalkthroughOverlay> createState() => _WalkthroughOverlayState();
}

class _WalkthroughOverlayState extends State<WalkthroughOverlay> {
  int _currentStep = 0;
  final int _totalSteps = 4;
  bool _isNextPressed = false;
  bool _isSkipPressed = false;

  void _nextStep() {
    HapticFeedback.selectionClick();
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      widget.onDismiss();
    }
  }

  void _skip() {
    HapticFeedback.selectionClick();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Stack(
      children: [
        // Semi-transparent scrim backdrop
        Positioned.fill(
          child: GestureDetector(
            onTap: () {}, // Block taps underneath
            child: Container(
              color: Colors.black.withValues(alpha: 0.55),
            ),
          ),
        ),

        // Central Apple-Inspired Frosted Glass Card
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 420),
              decoration: ShapeDecoration(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                  side: BorderSide(
                    color: colors.dividerStrong,
                    width: 1.0,
                  ),
                ),
                shadows: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                    spreadRadius: -4,
                  ),
                ],
              ),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Container(
                    color: colors.surface.withValues(alpha: 0.95),
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Top Bar: Step Counter & Skip Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: colors.primarySoft,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${_currentStep + 1} OF $_totalSteps',
                                style: TextStyle(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                            GestureDetector(
                              key: const ValueKey('walkthrough_skip_button'),
                              onTapDown: (_) => setState(() => _isSkipPressed = true),
                              onTapUp: (_) {
                                setState(() => _isSkipPressed = false);
                                _skip();
                              },
                              onTapCancel: () => setState(() => _isSkipPressed = false),
                              child: AnimatedScale(
                                scale: _isSkipPressed ? 0.92 : 1.0,
                                duration: const Duration(milliseconds: 100),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: colors.background.withValues(alpha: 0.6),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: colors.divider,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Text(
                                    'Skip',
                                    style: TextStyle(
                                      color: colors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Animated Step Content Viewport
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          switchInCurve: Curves.easeOutCubic,
                          switchOutCurve: Curves.easeInCubic,
                          child: _buildStepContent(context, _currentStep),
                        ),

                        const SizedBox(height: 24),

                        // Bottom Navigation Bar: Page Dots & Next/Done Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Page Dots Indicator
                            Row(
                              children: List.generate(_totalSteps, (index) {
                                final isCurrent = index == _currentStep;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  margin: const EdgeInsets.only(right: 6),
                                  height: 8,
                                  width: isCurrent ? 24 : 8,
                                  decoration: BoxDecoration(
                                    color: isCurrent ? colors.primary : colors.dividerStrong,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                );
                              }),
                            ),

                            // Next / Get Started Button
                            GestureDetector(
                              key: const ValueKey('walkthrough_next_button'),
                              onTapDown: (_) => setState(() => _isNextPressed = true),
                              onTapUp: (_) {
                                setState(() => _isNextPressed = false);
                                _nextStep();
                              },
                              onTapCancel: () => setState(() => _isNextPressed = false),
                              child: AnimatedScale(
                                scale: _isNextPressed ? 0.94 : 1.0,
                                duration: const Duration(milliseconds: 100),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  decoration: ShapeDecoration(
                                    color: colors.primary,
                                    shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: colors.primary.withValues(alpha: 0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        _currentStep == _totalSteps - 1 ? 'Get Started' : 'Next',
                                        style: TextStyle(
                                          color: colors.background,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Icon(
                                        _currentStep == _totalSteps - 1
                                            ? Icons.check_circle_rounded
                                            : Icons.arrow_forward_rounded,
                                        color: colors.background,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepContent(BuildContext context, int step) {
    final colors = context.appColors;

    switch (step) {
      case 0:
        return KeyedSubtree(
          key: const ValueKey('walkthrough_step_0'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: colors.primarySoft,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mosque_rounded,
                  color: colors.primary,
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome to Salah Companion',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.2,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your authentic, distraction-free companion for accurate prayer times, daily reflections, Qibla directional guidance, and authentic Sunnah practices.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.textSecondary,
                      height: 1.4,
                    ),
              ),
            ],
          ),
        );

      case 1:
        return KeyedSubtree(
          key: const ValueKey('walkthrough_step_1'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated Left-to-Right Edge Swipe Gesture Callout
              const _AnimatedSwipeGestureDemo(),

              const SizedBox(height: 16),
              Text(
                'Swipe Left Edge for Menu',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.2,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Swipe from the far-left edge of your screen to immediately reveal your Saved items, Prayer Tracker statistics, and Theme preferences anywhere in the app.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.textSecondary,
                      height: 1.4,
                    ),
              ),
            ],
          ),
        );

      case 2:
        return KeyedSubtree(
          key: const ValueKey('walkthrough_step_2'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: Color(0xFFF59E0B),
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Authentic Sunnah & Guidance',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.2,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Access daily Quranic verses, Sahih Hadiths, authentic Duas, and Sunnah Raka\'at prayer guidance without clutter or unverified content.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.textSecondary,
                      height: 1.4,
                    ),
              ),
            ],
          ),
        );

      case 3:
      default:
        return KeyedSubtree(
          key: const ValueKey('walkthrough_step_3'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFF0EA5E9).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome_motion_rounded,
                  color: Color(0xFF0EA5E9),
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Qibla, Tasbih & Customization',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.2,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Use the Qibla compass, digital Tasbih counter, and top-right Settings to customize calculation methods, notifications, and Madhab options anytime.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.textSecondary,
                      height: 1.4,
                    ),
              ),
            ],
          ),
        );
    }
  }
}

/// Interactive Looping Animation displaying a hand/finger swiping from the left edge to the right.
class _AnimatedSwipeGestureDemo extends StatefulWidget {
  const _AnimatedSwipeGestureDemo();

  @override
  State<_AnimatedSwipeGestureDemo> createState() => _AnimatedSwipeGestureDemoState();
}

class _AnimatedSwipeGestureDemoState extends State<_AnimatedSwipeGestureDemo> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _swipeAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    _swipeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.75, curve: Curves.easeInOutCubic),
      ),
    );

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 1.0), weight: 15),
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.0), weight: 60),
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.0), weight: 25),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.divider, width: 1.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Simulated App Screen Edge Representation
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 14,
            child: Container(
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.25),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
            ),
          ),

          // Sliding Navigation Drawer Mock Surface
          AnimatedBuilder(
            animation: _swipeAnimation,
            builder: (context, child) {
              final drawerWidth = 140.0 * _swipeAnimation.value;
              return Positioned(
                left: 0,
                top: 10,
                bottom: 10,
                width: drawerWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 10,
                        offset: const Offset(3, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 6,
                          decoration: BoxDecoration(
                            color: colors.primary,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 60,
                          height: 4,
                          decoration: BoxDecoration(
                            color: colors.textSecondary.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: 45,
                          height: 4,
                          decoration: BoxDecoration(
                            color: colors.textSecondary.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Animated Finger & Glowing Swipe Path
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final startX = 10.0;
              final travelX = 140.0;
              final currentX = startX + (travelX * _swipeAnimation.value);
              final opacity = _opacityAnimation.value;

              return Positioned(
                left: currentX,
                top: 40,
                child: Opacity(
                  opacity: opacity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Glowing Ripple Touch Indicator
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.primary.withValues(alpha: 0.2),
                          border: Border.all(
                            color: colors.primary,
                            width: 2.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colors.primary.withValues(alpha: 0.4),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.touch_app_rounded,
                            color: colors.primary,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: colors.primary,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Bottom Callout Label
          Positioned(
            right: 12,
            bottom: 8,
            child: Text(
              'SWIPE FROM LEFT EDGE →',
              style: TextStyle(
                color: colors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
