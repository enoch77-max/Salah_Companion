import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';

class DhikrItem {
  final String title;
  final String arabic;
  final String translation;

  const DhikrItem({
    required this.title,
    required this.arabic,
    required this.translation,
  });
}

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  static const List<DhikrItem> dhikrs = [
    DhikrItem(
      title: 'SubhanAllah',
      arabic: 'سُبْحَانَ ٱللَّٰهِ',
      translation: 'Glory be to Allah',
    ),
    DhikrItem(
      title: 'Alhamdulillah',
      arabic: 'ٱلْحَمْدُ لِلَّٰهِ',
      translation: 'Praise be to Allah',
    ),
    DhikrItem(
      title: 'Allahu Akbar',
      arabic: 'ٱللَّٰهُ أَكْبَرُ',
      translation: 'Allah is the Greatest',
    ),
    DhikrItem(
      title: 'Astaghfirullah',
      arabic: 'أَسْتَغْفِرُ ٱللَّٰهَ',
      translation: 'I seek forgiveness from Allah',
    ),
    DhikrItem(
      title: 'La ilaha illallah',
      arabic: 'لَا إِلَٰهَ إِلَّا ٱللَّٰهُ',
      translation: 'There is no god but Allah',
    ),
  ];

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> with SingleTickerProviderStateMixin {
  int _selectedDhikrIndex = 0;
  int _target = 33;
  int _customTarget = 33;
  int _count = 0;
  int _lapCount = 0;

  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 90),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _increment() {
    _animController.forward().then((_) => _animController.reverse());

    setState(() {
      _count++;
      if (_count >= _target) {
        HapticFeedback.mediumImpact();
        _lapCount++;
        _count = 0;
      } else {
        HapticFeedback.lightImpact();
      }
    });
  }

  void _reset() {
    HapticFeedback.lightImpact();
    setState(() {
      _count = 0;
      _lapCount = 0;
    });
  }

  Future<void> _showCustomTargetDialog() async {
    final controller = TextEditingController(text: _customTarget.toString());
    final result = await showDialog<int>(
      context: context,
      builder: (context) {
        final colors = context.appColors;
        return AlertDialog(
          backgroundColor: colors.surface,
          title: Text(
            'Set Custom Target',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: colors.textPrimary),
          ),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            autofocus: true,
            style: TextStyle(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Enter target number (e.g. 50)',
              hintStyle: TextStyle(color: colors.textTertiary),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.divider),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.primary),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: colors.textSecondary)),
            ),
            FilledButton(
              onPressed: () {
                final val = int.tryParse(controller.text);
                if (val != null && val > 0) {
                  Navigator.pop(context, val);
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Text('Set'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _customTarget = result;
        _target = result;
        _count = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final activeDhikr = TasbihScreen.dhikrs[_selectedDhikrIndex];
    final progress = (_count / _target).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Digital Tasbih',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            key: const ValueKey('reset_button'),
            icon: Icon(Icons.refresh_rounded, color: colors.textSecondary),
            tooltip: 'Reset Counter',
            onPressed: _reset,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),

            // Dhikr Selector Chips (Horizontal Scroll)
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: TasbihScreen.dhikrs.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final dhikr = TasbihScreen.dhikrs[index];
                  final isSelected = index == _selectedDhikrIndex;
                  return ChoiceChip(
                    key: ValueKey('dhikr_chip_${dhikr.title}'),
                    label: Text(dhikr.title),
                    selected: isSelected,
                    selectedColor: colors.primarySoft,
                    backgroundColor: colors.surface,
                    labelStyle: TextStyle(
                      color: isSelected ? colors.primaryText : colors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                    side: BorderSide(
                      color: isSelected ? colors.primary : colors.divider,
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedDhikrIndex = index;
                          _count = 0;
                        });
                      }
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Active Dhikr Display Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: colors.elevatedBackground,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: colors.dividerStrong, width: 1.0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      activeDhikr.arabic,
                      style: AppTypography.quranicStyle(
                        fontSize: 28,
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      activeDhikr.translation,
                      style: AppTypography.quoteTranslationStyle(
                        fontSize: 14,
                        color: colors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Target Presets Segment Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _TargetChip(
                    label: '33',
                    isSelected: _target == 33,
                    onTap: () => setState(() {
                      _target = 33;
                      _count = 0;
                    }),
                  ),
                  const SizedBox(width: 8),
                  _TargetChip(
                    label: '100',
                    isSelected: _target == 100,
                    onTap: () => setState(() {
                      _target = 100;
                      _count = 0;
                    }),
                  ),
                  const SizedBox(width: 8),
                  _TargetChip(
                    label: _target != 33 && _target != 100 ? 'Custom ($_target)' : 'Custom',
                    isSelected: _target != 33 && _target != 100,
                    onTap: _showCustomTargetDialog,
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Interactive Counter Button (Large Ring / Disk with scale animation)
            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: GestureDetector(
                  key: const ValueKey('tasbih_counter_button'),
                  onTap: _increment,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.surface,
                      border: Border.all(
                        color: colors.primary.withValues(alpha: 0.5),
                        width: 4,
                      ),
                      boxShadow: AppTheme.softShadow(colors.shadow),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Progress ring background
                        SizedBox(
                          width: 206,
                          height: 206,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 8,
                            backgroundColor: colors.surfaceHover,
                            valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
                          ),
                        ),

                        // Text Counter
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _count.toString().padLeft(2, '0'),
                              style: AppTypography.timerStyle(
                                fontSize: 54,
                                color: colors.textPrimary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              '/ $_target',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: colors.textTertiary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            if (_lapCount > 0) ...[
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: colors.primarySoft,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Lap $_lapCount',
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: colors.primaryText,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Helper instructions footer
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(
                'Tap circle to count • Haptics enabled',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.textTertiary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TargetChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TargetChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: ShapeDecoration(
          color: isSelected ? colors.primarySoft : colors.surface,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isSelected ? colors.primary : colors.divider,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isSelected ? colors.primaryText : colors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
