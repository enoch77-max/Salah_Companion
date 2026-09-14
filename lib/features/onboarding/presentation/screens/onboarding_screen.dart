import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../core/localization/language_registry.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../widgets/language_selection_step.dart';
import '../widgets/permission_priming_step.dart';
import '../widgets/spiritual_dedication_step.dart';
import '../widgets/trust_manifesto_step.dart';
import '../widgets/visual_feature_showcase_step.dart';

/// Next-Generation Full-Screen Apple-Grade Onboarding Experience for Salah Companion.
/// Synthesizes top Mobbin UX patterns, interactive micro-demos, 100% privacy trust pledge,
/// permission priming, and instant 19-language auto-detection with prominent Back navigation.
class OnboardingScreen extends StatefulWidget {
  final VoidCallback? onFinish;
  final ValueChanged<Locale>? onLocaleChanged;
  final bool isReplay;

  const OnboardingScreen({
    super.key,
    this.onFinish,
    this.onLocaleChanged,
    this.isReplay = false,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalStages = 5;

  late AppLanguage _selectedLanguage;
  bool _isNextPressed = false;
  bool _isBackPressed = false;
  bool _isSkipPressed = false;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = LanguageRegistry.resolveDeviceLanguage();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentLocale = Localizations.maybeLocaleOf(context);
    if (currentLocale != null) {
      _selectedLanguage = LanguageRegistry.getLanguage(currentLocale.languageCode);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    HapticFeedback.mediumImpact();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_completed_onboarding', true);

    if (widget.onFinish != null) {
      widget.onFinish!();
    } else if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _nextPage() {
    if (_currentPage < _totalStages - 1) {
      HapticFeedback.selectionClick();
      setState(() {
        _currentPage = _currentPage + 1;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      HapticFeedback.selectionClick();
      setState(() {
        _currentPage = _currentPage - 1;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    } else if (widget.isReplay && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation & Progress Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back / Close button or Step pill
                  if (_currentPage > 0)
                    GestureDetector(
                      key: const ValueKey('onboarding_top_back_btn'),
                      onTap: _previousPage,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: colors.divider),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 18,
                          color: colors.textPrimary,
                        ),
                      ),
                    )
                  else if (widget.isReplay)
                    GestureDetector(
                      key: const ValueKey('onboarding_close_btn'),
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: colors.divider),
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          size: 18,
                          color: colors.textPrimary,
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: colors.primarySoft,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_currentPage + 1} OF $_totalStages',
                        style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),

                  // Progress dots indicator
                  Row(
                    children: List.generate(_totalStages, (index) {
                      final isCurrent = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: 6,
                        width: isCurrent ? 20 : 6,
                        decoration: BoxDecoration(
                          color: isCurrent ? colors.primary : colors.dividerStrong,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  ),

                  // Skip CTA Button
                  GestureDetector(
                    key: const ValueKey('onboarding_skip_btn'),
                    onTap: _completeOnboarding,
                    onTapDown: (_) => setState(() => _isSkipPressed = true),
                    onTapUp: (_) => setState(() => _isSkipPressed = false),
                    onTapCancel: () => setState(() => _isSkipPressed = false),
                    child: AnimatedScale(
                      scale: _isSkipPressed ? 0.92 : 1.0,
                      duration: const Duration(milliseconds: 100),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: colors.divider),
                        ),
                        child: Text(
                          l10n?.onboardingSkip ?? 'Skip',
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Scrollable Content Viewport
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _currentPage = page),
                physics: const BouncingScrollPhysics(),
                children: [
                  // Stage 0: Language Selection
                  _buildPageWrapper(
                    LanguageSelectionStep(
                      currentLanguage: _selectedLanguage,
                      onLanguageSelected: (lang) {
                        setState(() => _selectedLanguage = lang);
                        widget.onLocaleChanged?.call(Locale(lang.code));
                      },
                    ),
                  ),

                  // Stage 1: Dedicated Multi-Slide Visual Feature Showcase
                  _buildPageWrapper(
                    const VisualFeatureShowcaseStep(),
                  ),

                  // Stage 2: Trust & Privacy Manifesto
                  _buildPageWrapper(
                    const TrustManifestoStep(),
                  ),

                  // Stage 3: Contextual Permission Priming
                  _buildPageWrapper(
                    const PermissionPrimingStep(),
                  ),

                  // Stage 4: Spiritual Dedication & Bismillah
                  _buildPageWrapper(
                    const SpiritualDedicationStep(),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Bottom Floating Action Bar with Back & Continue/Complete CTAs
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Back Button (shown on stages 1 through 4)
                  if (_currentPage > 0) ...[
                    GestureDetector(
                      key: const ValueKey('onboarding_back_btn'),
                      onTap: _previousPage,
                      onTapDown: (_) => setState(() => _isBackPressed = true),
                      onTapUp: (_) => setState(() => _isBackPressed = false),
                      onTapCancel: () => setState(() => _isBackPressed = false),
                      child: AnimatedScale(
                        scale: _isBackPressed ? 0.94 : 1.0,
                        duration: const Duration(milliseconds: 100),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                          decoration: ShapeDecoration(
                            color: colors.surface,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: BorderSide(color: colors.divider, width: 1.2),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_back_rounded,
                                color: colors.textPrimary,
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                l10n?.onboardingBack ?? 'Back',
                                style: TextStyle(
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],

                  // Primary Next / Continue / Bismillah CTA
                  Expanded(
                    child: GestureDetector(
                      key: const ValueKey('onboarding_main_cta'),
                      onTap: _nextPage,
                      onTapDown: (_) => setState(() => _isNextPressed = true),
                      onTapUp: (_) => setState(() => _isNextPressed = false),
                      onTapCancel: () => setState(() => _isNextPressed = false),
                      child: AnimatedScale(
                        scale: _isNextPressed ? 0.96 : 1.0,
                        duration: const Duration(milliseconds: 100),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                          decoration: ShapeDecoration(
                            color: colors.primary,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            shadows: [
                              BoxShadow(
                                color: colors.primary.withValues(alpha: 0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    _currentPage == _totalStages - 1
                                        ? (l10n?.onboardingBeginJourney ?? 'Bismillah • Get Started')
                                        : (l10n?.onboardingNext ?? 'Continue'),
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: colors.background,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                _currentPage == _totalStages - 1
                                    ? Icons.check_circle_rounded
                                    : Icons.arrow_forward_rounded,
                                color: colors.background,
                                size: 20,
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
    );
  }

  Widget _buildPageWrapper(Widget child) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: child,
        ),
      ),
    );
  }
}
