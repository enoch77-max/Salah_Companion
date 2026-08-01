import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/presentation/widgets/tasbih_icon.dart';
import '../../../../core/services/app_haptics.dart';

class DhikrItem {
  final String title;
  final String arabic;
  final String transliteration;
  final String translation;
  final int defaultTarget;

  const DhikrItem({
    required this.title,
    required this.arabic,
    required this.transliteration,
    required this.translation,
    this.defaultTarget = 33,
  });
}

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  static const List<DhikrItem> dhikrs = [
    DhikrItem(
      title: 'SubhanAllah',
      arabic: 'سُبْحَانَ اللَّهِ',
      transliteration: 'SubhanAllah',
      translation: 'Glory be to Allah',
      defaultTarget: 33,
    ),
    DhikrItem(
      title: 'Alhamdulillah',
      arabic: 'الْحَمْدُ لِلَّهِ',
      transliteration: 'Alhamdulillah',
      translation: 'Praise be to Allah',
      defaultTarget: 33,
    ),
    DhikrItem(
      title: 'Allahu Akbar',
      arabic: 'اللَّهُ أَكْبَرُ',
      transliteration: 'Allahu Akbar',
      translation: 'Allah is the Greatest',
      defaultTarget: 34,
    ),
    DhikrItem(
      title: 'Astaghfirullah',
      arabic: 'أَسْتَغْفِرُ اللَّهَ',
      transliteration: 'Astaghfirullah',
      translation: 'I seek forgiveness from Allah',
      defaultTarget: 100,
    ),
    DhikrItem(
      title: 'La ilaha illallah',
      arabic: 'لَا إِلَٰهَ إِلَّا اللَّهُ',
      transliteration: 'La ilaha illallah',
      translation: 'There is no deity except Allah',
      defaultTarget: 100,
    ),
  ];

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> with TickerProviderStateMixin {
  int _selectedDhikrIndex = 0;
  int _count = 0;
  int _target = 33;
  int _customTarget = 33;
  int _lapCount = 0;
  bool _autoNext = true;

  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  late AnimationController _slideController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 90),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    // Conveyor belt: t goes 0→1. At both endpoints the visual is
    // identical (each bead has shifted to the next slot which looks
    // the same), so forward(from: 0.0) produces zero snap-back.
    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOutCubic),
    );

    _loadSavedTasbihState();
  }

  Future<void> _loadSavedTasbihState() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _selectedDhikrIndex = prefs.getInt('tasbih_index') ?? 0;
      if (_selectedDhikrIndex >= TasbihScreen.dhikrs.length) _selectedDhikrIndex = 0;
      _count = prefs.getInt('tasbih_count') ?? 0;
      _lapCount = prefs.getInt('tasbih_lap_count') ?? 0;
      _target = prefs.getInt('tasbih_target') ?? TasbihScreen.dhikrs[_selectedDhikrIndex].defaultTarget;
      _customTarget = prefs.getInt('tasbih_custom_target') ?? _target;
      _autoNext = prefs.getBool('tasbih_auto_next') ?? true;
    });
  }

  void _saveTasbihState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tasbih_index', _selectedDhikrIndex);
    await prefs.setInt('tasbih_count', _count);
    await prefs.setInt('tasbih_lap_count', _lapCount);
    await prefs.setInt('tasbih_target', _target);
    await prefs.setInt('tasbih_custom_target', _customTarget);
    await prefs.setBool('tasbih_auto_next', _autoNext);
  }

  @override
  void dispose() {
    _animController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _increment() {
    _animController.forward().then((_) => _animController.reverse());
    _slideController.forward(from: 0.0);

    setState(() {
      _count++;
      if (_count >= _target) {
        AppHaptics.tasbihTargetReached();
        if (_autoNext) {
          _selectedDhikrIndex = (_selectedDhikrIndex + 1) % TasbihScreen.dhikrs.length;
          _count = 0;
          _lapCount = 0;
          _target = TasbihScreen.dhikrs[_selectedDhikrIndex].defaultTarget;
        } else {
          _lapCount++;
          _count = 0;
        }
      } else {
        AppHaptics.tasbihClick();
      }
    });
    _saveTasbihState();
  }

  void _reset() {
    AppHaptics.medium();
    setState(() {
      _count = 0;
      _lapCount = 0;
    });
    _saveTasbihState();
  }

  void _nextDhikr() {
    AppHaptics.medium();
    setState(() {
      _selectedDhikrIndex = (_selectedDhikrIndex + 1) % TasbihScreen.dhikrs.length;
      _count = 0;
      _lapCount = 0;
      _target = TasbihScreen.dhikrs[_selectedDhikrIndex].defaultTarget;
    });
    _saveTasbihState();
  }

  Future<void> _showCustomTargetDialog() async {
    final controller = TextEditingController(text: _customTarget.toString());
    final result = await showDialog<int>(
      context: context,
      builder: (context) {
        final colors = context.appColors;
        return AlertDialog(
          backgroundColor: colors.surface,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            'Set Custom Target',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: colors.textPrimary, fontWeight: FontWeight.bold),
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
              style: FilledButton.styleFrom(backgroundColor: colors.primary),
              onPressed: () {
                final val = int.tryParse(controller.text);
                if (val != null && val > 0) {
                  Navigator.pop(context, val);
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Text('Set Target'),
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
      _saveTasbihState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final activeDhikr = TasbihScreen.dhikrs[_selectedDhikrIndex];
    final nextDhikrIndex = (_selectedDhikrIndex + 1) % TasbihScreen.dhikrs.length;
    final nextDhikr = TasbihScreen.dhikrs[nextDhikrIndex];
    final progress = (_count / _target).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              // ─── TOP HEADER ROW (Title) ──────────────────────────────────────
              Row(
                children: [
                  TasbihIcon(color: colors.primary, size: 24, isSelected: true),
                  const SizedBox(width: 8),
                  Text(
                    'Digital Tasbih',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          letterSpacing: -0.2,
                        ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // ─── 1. FULL HADITH ON TOP ───────────────────────────────────────
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: colors.primarySoft.withValues(alpha: 0.35),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: colors.primary.withValues(alpha: 0.25), width: 1.0),
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome_rounded, size: 14, color: colors.primary),
                        const SizedBox(width: 6),
                        Text(
                          'HADITH ON TASBIH',
                          style: TextStyle(
                            color: colors.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '“Glorify Allah, declare His oneness, and exalt His holiness, and count your remembrance on your fingertips—for indeed, your fingers will be questioned on the Day of Judgment and made to speak.”',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colors.textPrimary,
                            height: 1.35,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '— Sunan Abi Dawud 1496',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colors.primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // ─── 2. ZIKR SELECTION BAR ──────────────────────────────────────
              SizedBox(
                height: 52,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: TasbihScreen.dhikrs.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final dhikr = TasbihScreen.dhikrs[index];
                    final isSelected = index == _selectedDhikrIndex;
                    return _DhikrSelectorCard(
                      key: ValueKey('dhikr_chip_${dhikr.title}'),
                      title: dhikr.title,
                      arabic: dhikr.arabic,
                      target: dhikr.defaultTarget,
                      isSelected: isSelected,
                      colors: colors,
                      onTap: () {
                        setState(() {
                          _selectedDhikrIndex = index;
                          _count = 0;
                          _lapCount = 0;
                          _target = TasbihScreen.dhikrs[index].defaultTarget;
                        });
                        _saveTasbihState();
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              // ─── 3. MERGED ACTIVE ZIKR & COUNTER WORKSPACE CARD ─────────────
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: ShapeDecoration(
                    color: colors.surface,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(color: colors.divider, width: 1.0),
                    ),
                    shadows: [
                      BoxShadow(
                        color: colors.shadow.withValues(alpha: 0.05),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Merged Active Dhikr Display Header
                      Column(
                        mainAxisSize: MainAxisSize.min,
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
                          const SizedBox(height: 2),
                          Text(
                            activeDhikr.translation,
                            style: AppTypography.quoteTranslationStyle(
                              fontSize: 12,
                              color: colors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),

                      // ─── 2D ILLUSTRATED ANIMATED HORIZONTAL TASBIH BEADS ─────────────
                      _Illustrated2DTasbihBeads(
                        slideAnimation: _slideAnimation,
                        scaleAnimation: _scaleAnimation,
                        progress: progress,
                        count: _count,
                        target: _target,
                        lapCount: _lapCount,
                        colors: colors,
                        onTap: _increment,
                      ),

                      // Target Presets Segment Bar
                      Row(
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
                          const SizedBox(width: 6),
                          _TargetChip(
                            label: '100',
                            isSelected: _target == 100,
                            onTap: () => setState(() {
                              _target = 100;
                              _count = 0;
                            }),
                          ),
                          const SizedBox(width: 6),
                          _TargetChip(
                            label: _target != 33 && _target != 100 ? 'Custom ($_target)' : 'Custom',
                            isSelected: _target != 33 && _target != 100,
                            onTap: _showCustomTargetDialog,
                          ),
                          const SizedBox(width: 6),
                          _AutoNextChip(
                            key: const ValueKey('auto_next_chip'),
                            isEnabled: _autoNext,
                            onTap: () => setState(() {
                              _autoNext = !_autoNext;
                              _saveTasbihState();
                            }),
                          ),
                        ],
                      ),

                      // ─── ACTION ROW (Reset on Left, Next Dhikr on Right) ─────────────
                      Row(
                        children: [
                          _AppleResetButton(
                            key: const ValueKey('reset_button'),
                            onPressed: _reset,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SizedBox(
                              height: 36,
                              child: OutlinedButton.icon(
                                onPressed: _nextDhikr,
                                icon: Icon(Icons.arrow_forward_rounded, size: 14, color: colors.primary),
                                label: Text(
                                  'Next: ${nextDhikr.title}',
                                  style: TextStyle(
                                    color: colors.primaryText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: colors.primarySoft.withValues(alpha: 0.5),
                                  side: BorderSide(color: colors.primary.withValues(alpha: 0.3), width: 1),
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class _DhikrSelectorCard extends StatelessWidget {
  final String title;
  final String arabic;
  final int target;
  final bool isSelected;
  final AppCustomColors colors;
  final VoidCallback onTap;

  const _DhikrSelectorCard({
    super.key,
    required this.title,
    required this.arabic,
    required this.target,
    required this.isSelected,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? colors.primaryText : colors.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: isSelected ? colors.primary.withValues(alpha: 0.2) : colors.surfaceHover,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '$target',
                    style: TextStyle(
                      color: isSelected ? colors.primaryText : colors.textTertiary,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              arabic,
              style: TextStyle(
                color: isSelected ? colors.primary : colors.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppleResetButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _AppleResetButton({
    super.key,
    required this.onPressed,
  });

  @override
  State<_AppleResetButton> createState() => _AppleResetButtonState();
}

class _AppleResetButtonState extends State<_AppleResetButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: ShapeDecoration(
            color: _isPressed ? colors.primarySoft : colors.surface,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: _isPressed ? colors.primary.withValues(alpha: 0.4) : colors.divider,
                width: 1.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.refresh_rounded,
                size: 14,
                color: _isPressed ? colors.primary : colors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                'Reset',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: _isPressed ? colors.primaryText : colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
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
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: ShapeDecoration(
          color: isSelected ? colors.primarySoft : colors.surface,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? colors.primary : colors.divider,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isSelected ? colors.primaryText : colors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 11,
              ),
        ),
      ),
    );
  }
}

class _AutoNextChip extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onTap;

  const _AutoNextChip({
    super.key,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: ShapeDecoration(
          color: isEnabled ? colors.primarySoft : colors.surface,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isEnabled ? colors.primary : colors.divider,
              width: isEnabled ? 1.5 : 1.0,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isEnabled ? Icons.autorenew_rounded : Icons.sync_disabled_rounded,
              size: 13,
              color: isEnabled ? colors.primaryText : colors.textTertiary,
            ),
            const SizedBox(width: 4),
            Text(
              'Auto Next',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isEnabled ? colors.primaryText : colors.textSecondary,
                    fontWeight: isEnabled ? FontWeight.bold : FontWeight.w500,
                    fontSize: 11,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Illustrated2DTasbihBeads extends StatelessWidget {
  final Animation<double> slideAnimation;
  final Animation<double> scaleAnimation;
  final double progress;
  final int count;
  final int target;
  final int lapCount;
  final AppCustomColors colors;
  final VoidCallback onTap;

  const _Illustrated2DTasbihBeads({
    required this.slideAnimation,
    required this.scaleAnimation,
    required this.progress,
    required this.count,
    required this.target,
    required this.lapCount,
    required this.colors,
    required this.onTap,
  });

  // ─── SLOT DEFINITIONS ────────────────────────────────────────────────────
  // Each slot: (xOffset from center, diameter, darkness)
  // darkness: 0.0 = bright warm primary,  1.0 = fully dark
  //
  // 7 slots form a conveyor belt. On each tap 6 beads slide one slot right:
  //   offLeft → farLeft → nearLeft → CENTER → nearRight → farRight → offRight
  //
  // At t=1 every bead occupies the slot that its neighbor occupied at t=0,
  // which is visually identical → zero snap when controller resets.
  static const _slots = <(double x, double size, double dark)>[
    (-155.0, 12.0, 0.90), // [0] off-screen left  (entering)
    (-118.0, 18.0, 0.75), // [1] far-left
    (-82.0, 28.0, 0.55),  // [2] near-left
    (0.0, 130.0, 0.0),    // [3] center (active)
    (82.0, 28.0, 0.55),   // [4] near-right
    (118.0, 18.0, 0.75),  // [5] far-right
    (155.0, 12.0, 0.90),  // [6] off-screen right (exiting)
  ];

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: GestureDetector(
        key: const ValueKey('tasbih_counter_button'),
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.hardEdge,
            children: [
              // ─── TASBIH STRING ──────────────────────────────────────
              Positioned(
                left: 20,
                right: 20,
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      colors.primary.withValues(alpha: 0.08),
                      colors.primary.withValues(alpha: 0.45),
                      colors.primary.withValues(alpha: 0.08),
                    ]),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withValues(alpha: 0.15),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),

              // ─── BEADS (6 beads, each slides from slot[i] → slot[i+1]) ──
              AnimatedBuilder(
                animation: slideAnimation,
                builder: (context, _) {
                  final t = slideAnimation.value; // 0.0 → 1.0
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      for (int i = 0; i < _slots.length - 1; i++)
                        _buildBead(_slots[i], _slots[i + 1], t),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── SINGLE TRANSITIONING BEAD ───────────────────────────────────────────
  Widget _buildBead(
    (double, double, double) from,
    (double, double, double) to,
    double t,
  ) {
    // Interpolate position, size, and darkness between slots
    final x = from.$1 + (to.$1 - from.$1) * t;
    final size = from.$2 + (to.$2 - from.$2) * t;
    final darkness = (from.$3 + (to.$3 - from.$3) * t).clamp(0.0, 1.0);

    // Counter text fades based on bead size:
    // invisible below 80dp, fully visible at 130dp
    final textOpacity = ((size - 80) / 50).clamp(0.0, 1.0);

    // Color lerps for 2D spherical shading
    final highlight = Color.lerp(colors.primary, colors.surfaceHover, darkness)!;
    final body = Color.lerp(
      colors.primary.withValues(alpha: 0.85),
      colors.surface,
      darkness,
    )!;
    final rim = Color.lerp(
      colors.primary.withValues(alpha: 0.6),
      colors.elevatedBackground,
      darkness,
    )!;

    return Transform.translate(
      offset: Offset(x, 0),
      child: SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              center: const Alignment(-0.3, -0.3),
              radius: 0.85,
              colors: [highlight, body, rim],
            ),
            border: Border.all(
              color: Color.lerp(colors.primary, colors.textTertiary, darkness)!
                  .withValues(alpha: 0.45),
              width: size > 60 ? 3.0 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.shadow.withValues(alpha: size > 60 ? 0.35 : 0.2),
                blurRadius: size > 60 ? 8 : 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          // Show counter content only when bead is large enough
          child: textOpacity > 0.01
              ? Opacity(
                  opacity: textOpacity,
                  child: _counterContent(size),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  // ─── COUNTER CONTENT (progress ring + count + target + lap) ──────────────
  Widget _counterContent(double beadSize) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Progress ring
        Padding(
          padding: const EdgeInsets.all(5),
          child: SizedBox.expand(
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 6,
              backgroundColor: colors.surfaceHover,
              valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
            ),
          ),
        ),
        // Counter text
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              count.toString().padLeft(2, '0'),
              style: AppTypography.timerStyle(
                fontSize: 34,
                color: colors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              '/ $target',
              style: TextStyle(
                color: colors.textTertiary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (lapCount > 0) ...[
              const SizedBox(height: 2),
              Container(
                decoration: BoxDecoration(
                  color: colors.primarySoft,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                child: Text(
                  'Lap $lapCount',
                  style: TextStyle(
                    color: colors.primaryText,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
