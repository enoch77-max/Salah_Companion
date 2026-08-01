import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/features/learn_salah/data/salah_guide_data.dart';
import 'package:salah_companion/features/learn_salah/domain/models/salah_learning_models.dart';
import 'package:salah_companion/features/learn_salah/presentation/widgets/posture_avatars.dart';

/// Step-by-Step Interactive Prophetic Salah Guide Screen.
class SalahStepByStepScreen extends StatefulWidget {
  final int initialStep;
  const SalahStepByStepScreen({super.key, this.initialStep = 0});

  @override
  State<SalahStepByStepScreen> createState() => _SalahStepByStepScreenState();
}

class _SalahStepByStepScreenState extends State<SalahStepByStepScreen> {
  late PageController _pageController;
  late int _currentStep;

  @override
  void initState() {
    super.initState();
    _currentStep = widget.initialStep.clamp(0, SalahGuideData.propheticSteps.length - 1);
    _pageController = PageController(initialPage: _currentStep);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onStepChanged(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  void _nextStep() {
    if (_currentStep < SalahGuideData.propheticSteps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final totalSteps = SalahGuideData.propheticSteps.length;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.elevatedBackground,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Step $_currentStep of ${totalSteps - 1}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
        ),
      ),
      body: Column(
        children: [
          // Step Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: List.generate(
                totalSteps,
                (index) => Expanded(
                  child: Container(
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      color: index <= _currentStep
                          ? colors.primary
                          : colors.divider.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Main PageView of Steps
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onStepChanged,
              itemCount: totalSteps,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final item = SalahGuideData.propheticSteps[index];
                return _StepDetailCard(step: item);
              },
            ),
          ),

          // Bottom Navigation Buttons (Previous / Next)
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _previousStep,
                        icon: const Icon(Icons.arrow_back_rounded),
                        label: const Text('Previous'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    )
                  else
                    const Spacer(),
                  const SizedBox(width: 12),
                  if (_currentStep < totalSteps - 1)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _nextStep,
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: const Text('Next Step'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          foregroundColor: colors.background,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.check_circle_rounded),
                        label: const Text('Finish Guide'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepDetailCard extends StatefulWidget {
  final SalahStep step;
  const _StepDetailCard({required this.step});

  @override
  State<_StepDetailCard> createState() => _StepDetailCardState();
}

class _StepDetailCardState extends State<_StepDetailCard> {
  bool _isReferencesExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final step = widget.step;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Posture Graphic & Badge Header
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: ShapeDecoration(
              color: colors.surface,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(28),
                side: BorderSide(color: colors.divider, width: 1.0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: ShapeDecoration(
                        color: colors.primary.withValues(alpha: 0.15),
                        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        step.ruleTypeBadgeText,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colors.primary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                      ),
                    ),
                    Text(
                      'STEP ${step.stepNumber}',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: colors.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 2D Posture Vector Graphic Avatar
                PostureAvatarWidget(
                  postureKey: step.postureKey,
                  width: 140,
                  height: 140,
                ).animate().scale(duration: 350.ms, curve: Curves.easeOutCubic),

                const SizedBox(height: 16),
                Text(
                  step.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colors.textPrimary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  step.subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Detailed Instruction Card
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: ShapeDecoration(
              color: colors.surface,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(color: colors.divider, width: 1.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'INSTRUCTION',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colors.textSecondary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  step.detailedInstruction,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.textPrimary,
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: 14),
                ...step.keyActionPoints.map(
                  (point) => Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle_outline_rounded, size: 18, color: colors.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            point,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Arabic Recitation Card (If applicable)
          if (step.arabicRecitation != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: ShapeDecoration(
                color: colors.primary.withValues(alpha: 0.08),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(color: colors.primary.withValues(alpha: 0.3), width: 1.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'RECITATION',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    step.arabicRecitation!,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.8,
                    ),
                  ),
                  if (step.transliteration != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      step.transliteration!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: colors.textPrimary,
                            height: 1.4,
                          ),
                    ),
                  ],
                  if (step.englishTranslation != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      step.englishTranslation!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colors.textSecondary,
                            height: 1.4,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Expandable Evidence & Hadiths Proof Tile
          Material(
            color: colors.surface,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: colors.primary.withValues(alpha: 0.4), width: 1.2),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                setState(() {
                  _isReferencesExpanded = !_isReferencesExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.menu_book_rounded, color: colors.primary, size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Authentic Evidence & Hadiths',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colors.textPrimary,
                                    ),
                              ),
                              Text(
                                '${step.references.length} Untruncated Hadith/Quran proof(s)',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: colors.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedRotation(
                          turns: _isReferencesExpanded ? 0.5 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          child: Icon(Icons.keyboard_arrow_down_rounded, color: colors.primary),
                        ),
                      ],
                    ),
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Padding(
                        padding: const EdgeInsets.only(top: 14.0),
                        child: Column(
                          children: step.references
                              .map(
                                (ref) => Container(
                                  margin: const EdgeInsets.only(bottom: 12.0),
                                  padding: const EdgeInsets.all(14.0),
                                  decoration: ShapeDecoration(
                                    color: colors.elevatedBackground,
                                    shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      side: BorderSide(color: colors.divider, width: 1.0),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              ref.title,
                                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: colors.primary,
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF10B981).withValues(alpha: 0.15),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              ref.grade,
                                              style: const TextStyle(
                                                color: Color(0xFF10B981),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        ref.citation,
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                              color: colors.textSecondary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        ref.fullTextEnglish,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: colors.textPrimary,
                                              height: 1.45,
                                            ),
                                      ),
                                      if (ref.narrator != null) ...[
                                        const SizedBox(height: 6),
                                        Text(
                                          'Narrator: ${ref.narrator}',
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                color: colors.textTertiary,
                                                fontStyle: FontStyle.italic,
                                              ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      crossFadeState: _isReferencesExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
