import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/presentation/widgets/tasbih_icon.dart';
import '../../../../core/services/app_haptics.dart';
import '../../../../l10n/generated/app_localizations.dart';

class DhikrItem {
  final String id;
  final String title;
  final String arabic;
  final String transliteration;
  final String translation;
  final int defaultTarget;

  const DhikrItem({
    required this.id,
    required this.title,
    required this.arabic,
    required this.transliteration,
    required this.translation,
    this.defaultTarget = 33,
  });

  String getLocalizedTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (id) {
      case 'subhanallah':
        return l10n?.dhikrSubhanAllah ?? title;
      case 'alhamdulillah':
        return l10n?.dhikrAlhamdulillah ?? title;
      case 'allahu_akbar':
        return l10n?.dhikrAllahuAkbar ?? title;
      case 'astaghfirullah':
        return l10n?.dhikrAstaghfirullah ?? title;
      case 'la_ilaha_illallah':
        return l10n?.dhikrLaIlahaIllallah ?? title;
      case 'salawat':
        return l10n?.dhikrSalawat ?? title;
      case 'durood_ibrahim':
        return l10n?.dhikrDuroodIbrahim ?? title;
      default:
        return title;
    }
  }

  String getLocalizedTranslation(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (id) {
      case 'subhanallah':
        return l10n?.dhikrSubhanAllahTranslation ?? translation;
      case 'alhamdulillah':
        return l10n?.dhikrAlhamdulillahTranslation ?? translation;
      case 'allahu_akbar':
        return l10n?.dhikrAllahuAkbarTranslation ?? translation;
      case 'astaghfirullah':
        return l10n?.dhikrAstaghfirullahTranslation ?? translation;
      case 'la_ilaha_illallah':
        return l10n?.dhikrLaIlahaIllallahTranslation ?? translation;
      case 'salawat':
        return l10n?.dhikrSalawatTranslation ?? translation;
      case 'durood_ibrahim':
        return l10n?.dhikrDuroodIbrahimTranslation ?? translation;
      default:
        return translation;
    }
  }
}

class TasbihScreen extends StatefulWidget {
  final bool? overrideIsFriday;
  final DateTime? nowOverride;
  final String? targetDhikrId;

  const TasbihScreen({
    super.key,
    this.overrideIsFriday,
    this.nowOverride,
    this.targetDhikrId,
  });

  static const List<DhikrItem> dhikrs = [
    DhikrItem(
      id: 'subhanallah',
      title: 'SubhanAllah',
      arabic: 'سُبْحَانَ اللَّهِ',
      transliteration: 'SubhanAllah',
      translation: 'Glory be to Allah',
      defaultTarget: 33,
    ),
    DhikrItem(
      id: 'alhamdulillah',
      title: 'Alhamdulillah',
      arabic: 'الْحَمْدُ لِلَّهِ',
      transliteration: 'Alhamdulillah',
      translation: 'Praise be to Allah',
      defaultTarget: 33,
    ),
    DhikrItem(
      id: 'allahu_akbar',
      title: 'Allahu Akbar',
      arabic: 'اللَّهُ أَكْبَرُ',
      transliteration: 'Allahu Akbar',
      translation: 'Allah is the Greatest',
      defaultTarget: 34,
    ),
    DhikrItem(
      id: 'astaghfirullah',
      title: 'Astaghfirullah',
      arabic: 'أَسْتَغْفِرُ اللَّهَ',
      transliteration: 'Astaghfirullah',
      translation: 'I seek forgiveness from Allah',
      defaultTarget: 100,
    ),
    DhikrItem(
      id: 'la_ilaha_illallah',
      title: 'La ilaha illallah',
      arabic: 'لَا إِلَٰهَ إِلَّا اللَّهُ',
      transliteration: 'La ilaha illallah',
      translation: 'There is no deity except Allah',
      defaultTarget: 100,
    ),
  ];

  static const DhikrItem salawatDhikr = DhikrItem(
    id: 'salawat',
    title: 'Salawat',
    arabic: 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ',
    transliteration: "Allahumma Salli 'ala Muhammad",
    translation: 'O Allah, send blessings upon Muhammad',
    defaultTarget: 100,
  );

  static const DhikrItem duroodIbrahimDhikr = DhikrItem(
    id: 'durood_ibrahim',
    title: 'Durood Ibrahim',
    arabic:
        'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ، اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ',
    transliteration:
        "Allahumma salli 'ala Muhammadin wa 'ala ali Muhammad, kama sallayta 'ala Ibrahima wa 'ala ali Ibrahim, innaka Hamidun Majid. Allahumma barik 'ala Muhammadin wa 'ala ali Muhammad, kama barakta 'ala Ibrahima wa 'ala ali Ibrahim, innaka Hamidun Majid.",
    translation:
        "Allahumma salli 'ala Muhammadin wa 'ala ali Muhammad, kama sallayta 'ala Ibrahima wa 'ala ali Ibrahim, innaka Hamidun Majid. Allahumma barik 'ala Muhammadin wa 'ala ali Muhammad, kama barakta 'ala Ibrahima wa 'ala ali Ibrahim, innaka Hamidun Majid.",
    defaultTarget: 33,
  );

  @override
  State<TasbihScreen> createState() => TasbihScreenState();
}

class TasbihScreenState extends State<TasbihScreen>
    with TickerProviderStateMixin {
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

  bool get _isFriday {
    if (widget.overrideIsFriday != null) return widget.overrideIsFriday!;
    final now = widget.nowOverride ?? DateTime.now();
    return now.weekday == DateTime.friday;
  }

  bool get isFriday => _isFriday;
  List<DhikrItem> get effectiveDhikrs => _effectiveDhikrs;
  int get selectedDhikrIndex => _selectedDhikrIndex;

  List<DhikrItem> get _effectiveDhikrs {
    if (_isFriday) {
      return [
        ...TasbihScreen.dhikrs,
        TasbihScreen.salawatDhikr,
        TasbihScreen.duroodIbrahimDhikr,
      ];
    }
    return TasbihScreen.dhikrs;
  }

  void selectDhikrById(String dhikrId) {
    final list = _effectiveDhikrs;
    final index = list.indexWhere((d) => d.id == dhikrId);
    if (index != -1) {
      setState(() {
        _selectedDhikrIndex = index;
        _count = 0;
        _lapCount = 0;
        _target = list[index].defaultTarget;
      });
      _saveTasbihState();
    }
  }

  @override
  void didUpdateWidget(covariant TasbihScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.targetDhikrId != null &&
        widget.targetDhikrId != oldWidget.targetDhikrId) {
      selectDhikrById(widget.targetDhikrId!);
    } else if (widget.overrideIsFriday != oldWidget.overrideIsFriday ||
        widget.nowOverride != oldWidget.nowOverride) {
      final list = _effectiveDhikrs;
      if (_selectedDhikrIndex >= list.length) {
        setState(() {
          _selectedDhikrIndex = 0;
          _count = 0;
          _lapCount = 0;
          _target = list[0].defaultTarget;
        });
        _saveTasbihState();
      }
    }
  }

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
    final list = _effectiveDhikrs;
    final savedId = prefs.getString('tasbih_dhikr_id');
    int initialIndex = prefs.getInt('tasbih_index') ?? 0;
    if (savedId != null) {
      final found = list.indexWhere((d) => d.id == savedId);
      if (found != -1) {
        initialIndex = found;
      }
    }
    if (initialIndex >= list.length) {
      initialIndex = 0;
    }

    if (widget.targetDhikrId != null) {
      final requested = list.indexWhere((d) => d.id == widget.targetDhikrId);
      if (requested != -1) {
        initialIndex = requested;
      }
    }

    setState(() {
      _selectedDhikrIndex = initialIndex;
      _count = prefs.getInt('tasbih_count') ?? 0;
      _lapCount = prefs.getInt('tasbih_lap_count') ?? 0;
      _target =
          prefs.getInt('tasbih_target') ??
          list[_selectedDhikrIndex].defaultTarget;
      _customTarget = prefs.getInt('tasbih_custom_target') ?? _target;
      _autoNext = prefs.getBool('tasbih_auto_next') ?? true;
    });
  }

  void _saveTasbihState() async {
    final prefs = await SharedPreferences.getInstance();
    final list = _effectiveDhikrs;
    if (_selectedDhikrIndex < list.length) {
      await prefs.setString('tasbih_dhikr_id', list[_selectedDhikrIndex].id);
    }
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
          final list = _effectiveDhikrs;
          _selectedDhikrIndex =
              (_selectedDhikrIndex + 1) % list.length;
          _count = 0;
          _lapCount = 0;
          _target = list[_selectedDhikrIndex].defaultTarget;
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
    final list = _effectiveDhikrs;
    setState(() {
      _selectedDhikrIndex =
          (_selectedDhikrIndex + 1) % list.length;
      _count = 0;
      _lapCount = 0;
      _target = list[_selectedDhikrIndex].defaultTarget;
    });
    _saveTasbihState();
  }

  Future<void> _showCustomTargetDialog() async {
    final controller = TextEditingController(text: _customTarget.toString());
    final result = await showDialog<int>(
      context: context,
      builder: (context) {
        final colors = context.appColors;
        final l10n = AppLocalizations.of(context);
        return AlertDialog(
          backgroundColor: colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: colors.cardBorder, width: 0.8),
          ),
          title: Text(
            l10n?.tasbihSetCustomTarget ?? 'Set Custom Target',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            autofocus: true,
            style: TextStyle(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText:
                  l10n?.tasbihTargetHint ?? 'Enter target number (e.g. 50)',
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
              child: Text(
                l10n?.tasbihCancel ?? 'Cancel',
                style: TextStyle(color: colors.textSecondary),
              ),
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
              child: Text(l10n?.tasbihSetTarget ?? 'Set Target'),
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
    final l10n = AppLocalizations.of(context);
    final list = _effectiveDhikrs;
    if (_selectedDhikrIndex >= list.length) {
      _selectedDhikrIndex = 0;
    }
    final activeDhikr = list[_selectedDhikrIndex];
    final nextDhikrIndex =
        (_selectedDhikrIndex + 1) % list.length;
    final nextDhikr = list[nextDhikrIndex];
    final progress = (_count / _target).clamp(0.0, 1.0);
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final navBarClearance =
        58.0 + (bottomPadding > 0 ? 8.0 + bottomPadding : 12.0) + 8.0;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isShortScreen =
                constraints.maxHeight < (activeDhikr.arabic.length > 50 ? 760 : 680);
            final content = Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 6.0,
              ),
              child: Column(
                mainAxisSize: isShortScreen
                    ? MainAxisSize.min
                    : MainAxisSize.max,
                children: [
                  // ─── TOP HEADER ROW (Title) ──────────────────────────────────────
                  Row(
                    children: [
                      TasbihIcon(
                        color: colors.primary,
                        size: 24,
                        isSelected: true,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n?.tasbihTitle ?? 'Digital Tasbih',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.w800,
                                fontSize: 22,
                                letterSpacing: -0.2,
                              ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // ─── 1. FULL HADITH ON TOP ───────────────────────────────────────
                  Container(
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: colors.primarySoft.withValues(alpha: 0.35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: colors.primary.withValues(alpha: 0.25),
                          width: 0.8,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.menu_book_rounded,
                              size: 14,
                              color: colors.primary,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                l10n?.tasbihHadithTitle ?? 'HADITH ON TASBIH',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: colors.primary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          l10n?.tasbihHadithText ??
                              '“Glorify Allah, declare His oneness, and exalt His holiness, and count your remembrance on your fingertips—for indeed, your fingers will be questioned on the Day of Judgment and made to speak.”',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
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
                            l10n?.tasbihHadithReference ??
                                '— Sunan Abi Dawud 1496',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: colors.primaryText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 6),

                  // ─── 2. ZIKR SELECTION BAR ──────────────────────────────────────
                  SizedBox(
                    height: 52,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: list.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final dhikr = list[index];
                        final isSelected = index == _selectedDhikrIndex;
                        return _DhikrSelectorCard(
                          key: ValueKey('dhikr_chip_${dhikr.title}'),
                          title: dhikr.getLocalizedTitle(context),
                          arabic: dhikr.arabic,
                          target: dhikr.defaultTarget,
                          isSelected: isSelected,
                          colors: colors,
                          onTap: () {
                            setState(() {
                              _selectedDhikrIndex = index;
                              _count = 0;
                              _lapCount = 0;
                              _target =
                                  list[index].defaultTarget;
                            });
                            _saveTasbihState();
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 6),

                  // ─── 3. MERGED ACTIVE ZIKR & COUNTER WORKSPACE CARD ─────────────
                  _buildWorkspaceCard(
                    context: context,
                    colors: colors,
                    l10n: l10n,
                    activeDhikr: activeDhikr,
                    nextDhikr: nextDhikr,
                    progress: progress,
                    navBarClearance: navBarClearance,
                    isShortScreen: isShortScreen,
                  ),
                ],
              ),
            );

            if (isShortScreen) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: content,
              );
            }
            return content;
          },
        ),
      ),
    );
  }

  Widget _buildWorkspaceCard({
    required BuildContext context,
    required AppCustomColors colors,
    required AppLocalizations? l10n,
    required DhikrItem activeDhikr,
    required DhikrItem nextDhikr,
    required double progress,
    required double navBarClearance,
    required bool isShortScreen,
  }) {
    final workspaceContent = Column(
      mainAxisAlignment: isShortScreen
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceEvenly,
      mainAxisSize: isShortScreen ? MainAxisSize.min : MainAxisSize.max,
      children: [
        // Merged Active Dhikr Display Header
        if (activeDhikr.arabic.length <= 50) ...[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                activeDhikr.arabic,
                style: AppTypography.quranicStyle(
                  fontSize: 26,
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                activeDhikr.getLocalizedTranslation(context),
                style: AppTypography.quoteTranslationStyle(
                  fontSize: 11.5,
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ] else ...[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                activeDhikr.arabic,
                style: AppTypography.quranicStyle(
                  fontSize: 15.5,
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                ).copyWith(height: 1.65),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                activeDhikr.getLocalizedTranslation(context),
                style: AppTypography.quoteTranslationStyle(
                  fontSize: 11.0,
                  color: colors.textSecondary,
                ).copyWith(height: 1.35),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
        if (isShortScreen) const SizedBox(height: 10),

        // ─── 2. 2D ILLUSTRATED ANIMATED HORIZONTAL TASBIH BEADS & SUNNAH TIP ─
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            const SizedBox(height: 6),
            _SunnahTipBadge(colors: colors, l10n: l10n),
          ],
        ),
        if (isShortScreen) const SizedBox(height: 10),

        // ─── 3. TARGET PRESETS & AUTO-NEXT CONFIGURATION (Side-by-Side Strip) ───
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _TargetSegmentedControl(
                target: _target,
                colors: colors,
                l10n: l10n,
                onSelectTarget: (t) => setState(() {
                  _target = t;
                  _count = 0;
                }),
                onCustomTap: _showCustomTargetDialog,
              ),
              const SizedBox(width: 8),
              _AutoNextChip(
                key: const ValueKey('auto_next_chip'),
                isEnabled: _autoNext,
                colors: colors,
                onTap: () => setState(() {
                  _autoNext = !_autoNext;
                  _saveTasbihState();
                }),
              ),
            ],
          ),
        ),
        if (isShortScreen) const SizedBox(height: 10),

        // ─── 4. ACTION ROW (Compact Red Round Reset & Proportionate Next Dhikr) ──
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _AppleResetButton(
              key: const ValueKey('reset_button'),
              onPressed: _reset,
            ),
            const SizedBox(width: 10),
            _NextDhikrButton(
              key: const ValueKey('next_dhikr_button'),
              nextDhikrTitle: nextDhikr.getLocalizedTitle(context),
              colors: colors,
              l10n: l10n,
              onPressed: _nextDhikr,
            ),
          ],
        ),
      ],
    );

    final cardContainer = Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: navBarClearance),
      decoration: ShapeDecoration(
        color: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: colors.cardBorder, width: 0.8),
        ),
        shadows: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: isShortScreen
          ? workspaceContent
          : LayoutBuilder(
              builder: (context, cardConstraints) {
                const naturalMinHeight = 330.0;
                if (cardConstraints.maxHeight >= naturalMinHeight) {
                  return SizedBox(
                    width: cardConstraints.maxWidth,
                    height: cardConstraints.maxHeight,
                    child: workspaceContent,
                  );
                }
                return SizedBox(
                  width: cardConstraints.maxWidth,
                  height: cardConstraints.maxHeight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: cardConstraints.maxWidth,
                      height: naturalMinHeight,
                      child: workspaceContent,
                    ),
                  ),
                );
              },
            ),
    );

    if (isShortScreen) {
      return cardContainer;
    }
    return Expanded(child: cardContainer);
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
    return Semantics(
      button: true,
      selected: isSelected,
      label: '$title, target $target',
      hint: isSelected ? 'Currently selected' : 'Double tap to select $title',
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: ShapeDecoration(
            color: isSelected ? colors.primarySoft : colors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: isSelected ? colors.primary : colors.cardBorder,
                width: isSelected ? 1.2 : 0.8,
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
                      color: isSelected
                          ? colors.primaryText
                          : colors.textPrimary,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colors.primary.withValues(alpha: 0.2)
                          : colors.surfaceHover,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '$target',
                      style: TextStyle(
                        color: isSelected
                            ? colors.primaryText
                            : colors.textTertiary,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                arabic.replaceAll('\n', ' '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? colors.primary : colors.textSecondary,
                  fontSize: 11,
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

class _AppleResetButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _AppleResetButton({super.key, required this.onPressed});

  @override
  State<_AppleResetButton> createState() => _AppleResetButtonState();
}

class _AppleResetButtonState extends State<_AppleResetButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color redBase =
        isDark ? const Color(0xFFDC2626) : const Color(0xFFE11D48);
    final Color redPressed =
        isDark ? const Color(0xFFB91C1C) : const Color(0xFFBE123C);

    return Semantics(
      button: true,
      label: l10n?.tasbihReset ?? 'Reset counter',
      hint: 'Double tap to reset current count to zero',
      child: Tooltip(
        message: l10n?.tasbihReset ?? 'Reset',
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) {
            setState(() => _isPressed = false);
            widget.onPressed();
          },
          onTapCancel: () => setState(() => _isPressed = false),
          child: AnimatedScale(
            scale: _isPressed ? 0.92 : 1.0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOutCubic,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 38,
              height: 38,
              decoration: ShapeDecoration(
                color: _isPressed ? redPressed : redBase,
                shape: const CircleBorder(),
                shadows: [
                  BoxShadow(
                    color: redBase.withValues(alpha: isDark ? 0.35 : 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.refresh_rounded,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NextDhikrButton extends StatefulWidget {
  final String nextDhikrTitle;
  final AppCustomColors colors;
  final AppLocalizations? l10n;
  final VoidCallback onPressed;

  const _NextDhikrButton({
    super.key,
    required this.nextDhikrTitle,
    required this.colors,
    required this.l10n,
    required this.onPressed,
  });

  @override
  State<_NextDhikrButton> createState() => _NextDhikrButtonState();
}

class _NextDhikrButtonState extends State<_NextDhikrButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final label = widget.l10n?.tasbihNextDhikr(widget.nextDhikrTitle) ??
        'Next: ${widget.nextDhikrTitle}';

    final Color bgColor = _isPressed
        ? (isDark ? const Color(0xFFC09462) : const Color(0xFF0C5D56))
        : colors.primary;

    final Color fgColor =
        isDark ? const Color(0xFF14161D) : Colors.white;

    return Semantics(
      button: true,
      label: 'Next Dhikr: ${widget.nextDhikrTitle}',
      hint: 'Double tap to skip to ${widget.nextDhikrTitle}',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.96 : 1.0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: 38,
            constraints: const BoxConstraints(maxWidth: 200),
            decoration: ShapeDecoration(
              color: bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              shadows: [
                BoxShadow(
                  color: colors.primary.withValues(alpha: isDark ? 0.30 : 0.22),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: fgColor,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.1,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: fgColor.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 11,
                    color: fgColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SunnahTipBadge extends StatelessWidget {
  final AppCustomColors colors;
  final AppLocalizations? l10n;

  const _SunnahTipBadge({
    required this.colors,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: ShapeDecoration(
        color: colors.primarySoft.withValues(alpha: 0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: colors.primary.withValues(alpha: 0.18),
            width: 0.8,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.front_hand_rounded,
            size: 12,
            color: colors.primary,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              l10n?.tasbihBestOnFingers ?? "It's best to count on fingers",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TargetSegmentedControl extends StatelessWidget {
  final int target;
  final AppCustomColors colors;
  final AppLocalizations? l10n;
  final ValueChanged<int> onSelectTarget;
  final VoidCallback onCustomTap;

  const _TargetSegmentedControl({
    required this.target,
    required this.colors,
    required this.l10n,
    required this.onSelectTarget,
    required this.onCustomTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCustomSelected = target != 33 && target != 100;
    final customLabel = isCustomSelected
        ? (l10n?.tasbihCustomTargetCount(target.toString()) ?? 'Custom ($target)')
        : (l10n?.tasbihCustomTarget ?? 'Custom');

    return Container(
      decoration: ShapeDecoration(
        color: colors.surfaceHover,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: colors.cardBorder,
            width: 0.8,
          ),
        ),
      ),
      padding: const EdgeInsets.all(3),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          _buildSegment(
            context: context,
            label: '33',
            isSelected: target == 33,
            onTap: () {
              AppHaptics.selection();
              onSelectTarget(33);
            },
          ),
          const SizedBox(width: 4),
          _buildSegment(
            context: context,
            label: '100',
            isSelected: target == 100,
            onTap: () {
              AppHaptics.selection();
              onSelectTarget(100);
            },
          ),
          const SizedBox(width: 4),
          _buildSegment(
            context: context,
            label: customLabel,
            isSelected: isCustomSelected,
            onTap: () {
              AppHaptics.selection();
              onCustomTap();
            },
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildSegment({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Target $label',
      hint: isSelected ? 'Currently active target' : 'Double tap to select target $label',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: ShapeDecoration(
            color: isSelected ? colors.primary : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            shadows: isSelected
                ? [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.25),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : colors.textSecondary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class _AutoNextChip extends StatefulWidget {
  final bool isEnabled;
  final AppCustomColors colors;
  final VoidCallback onTap;

  const _AutoNextChip({
    super.key,
    required this.isEnabled,
    required this.colors,
    required this.onTap,
  });

  @override
  State<_AutoNextChip> createState() => _AutoNextChipState();
}

class _AutoNextChipState extends State<_AutoNextChip> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.colors;
    final isEnabled = widget.isEnabled;
    final l10n = AppLocalizations.of(context);

    return Semantics(
      button: true,
      toggled: isEnabled,
      label: 'Auto advance to next Dhikr',
      hint: isEnabled
          ? 'Auto advance is on, double tap to toggle off'
          : 'Auto advance is off, double tap to toggle on',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          AppHaptics.selection();
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.96 : 1.0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: ShapeDecoration(
              color: isEnabled
                  ? colors.primarySoft
                  : colors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  color: isEnabled
                      ? colors.primary.withValues(alpha: 0.35)
                      : colors.cardBorder,
                  width: 0.8,
                ),
              ),
              shadows: isEnabled
                  ? [
                      BoxShadow(
                        color: colors.primary.withValues(alpha: 0.08),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isEnabled
                      ? Icons.autorenew_rounded
                      : Icons.sync_disabled_rounded,
                  size: 14,
                  color: isEnabled ? colors.primary : colors.textTertiary,
                ),
                const SizedBox(width: 6),
                Text(
                  l10n?.tasbihAutoNext ?? 'Auto Next',
                  style: TextStyle(
                    color: isEnabled ? colors.primary : colors.textSecondary,
                    fontWeight: isEnabled ? FontWeight.bold : FontWeight.w500,
                    fontSize: 11.5,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isEnabled
                        ? colors.primary
                        : colors.textTertiary.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
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
    (-82.0, 28.0, 0.55), // [2] near-left
    (0.0, 130.0, 0.0), // [3] center (active)
    (82.0, 28.0, 0.55), // [4] near-right
    (118.0, 18.0, 0.75), // [5] far-right
    (155.0, 12.0, 0.90), // [6] off-screen right (exiting)
  ];

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: true,
      label: 'Tasbih counter',
      value: '$count of $target${lapCount > 0 ? ', lap $lapCount' : ''}',
      hint: 'Double tap to count',
      excludeSemantics: true,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: GestureDetector(
          key: const ValueKey('tasbih_counter_button'),
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            height: 138,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // ─── TASBIH STRING ──────────────────────────────────────
                Positioned(
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colors.primary.withValues(alpha: 0.08),
                          colors.primary.withValues(alpha: 0.45),
                          colors.primary.withValues(alpha: 0.08),
                        ],
                      ),
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
                          _buildBead(context, _slots[i], _slots[i + 1], t),
                      ],
                    );
                  },
                ),

                              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── SINGLE TRANSITIONING BEAD ───────────────────────────────────────────
  Widget _buildBead(
    BuildContext context,
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

    // Color lerps for 2D spherical shading (solid 100% opaque to cover rope line completely)
    final highlight = Color.lerp(
      colors.primary,
      colors.surfaceHover,
      darkness,
    )!;
    final body = Color.lerp(colors.primary, colors.surface, darkness)!;
    final rim = Color.lerp(
      Color.lerp(colors.primary, Colors.black, 0.25)!,
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
              color: Color.lerp(
                colors.primary,
                colors.textTertiary,
                darkness,
              )!.withValues(alpha: 0.45),
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
                  child: _counterContent(context, size),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  // ─── COUNTER CONTENT (progress ring + count + target + lap) ──────────────
  Widget _counterContent(BuildContext context, double beadSize) {
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
              backgroundColor: Colors.white.withValues(alpha: 0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
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
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              '/ $target',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (lapCount > 0) ...[
              const SizedBox(height: 2),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                child: Text(
                  AppLocalizations.of(
                        context,
                      )?.tasbihLap(lapCount.toString()) ??
                      'Lap $lapCount',
                  style: const TextStyle(
                    color: Colors.white,
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
