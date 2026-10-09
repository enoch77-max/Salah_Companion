import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/presentation/widgets/tasbih_icon.dart';
import '../../../../core/services/app_haptics.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Friday Companion Suite Widget.
///
/// Displayed exclusively on Fridays (or when [overrideIsFriday] is true) on the Home Dashboard.
/// Contains 4 authentic spiritual practice cards:
/// 1. Surah Al-Kahf card (110 Ayat, authentic Hadith, tap-to-complete with persistent state)
/// 2. Abundant Salawat action card (Sunnah badge, Hadith, action button routing to Tasbih counter)
/// 3. Friday Purification & Etiquettes checklist (Ghusl, Siwak, Clean Clothes with tailored garment vector icon, Early Mosque arrival)
/// 4. Sa'at al-Istijabah card (Hour of Response, Hadith, active indicator between Asr and Maghrib)
class FridayCompanionSuite extends StatefulWidget {
  final bool? overrideIsFriday;
  final DateTime? nowOverride;
  final DateTime? asrDateTime;
  final DateTime? maghribDateTime;
  final VoidCallback? onOpenSalawatTasbih;

  const FridayCompanionSuite({
    super.key,
    this.overrideIsFriday,
    this.nowOverride,
    this.asrDateTime,
    this.maghribDateTime,
    this.onOpenSalawatTasbih,
  });

  @override
  State<FridayCompanionSuite> createState() => _FridayCompanionSuiteState();
}

class _FridayCompanionSuiteState extends State<FridayCompanionSuite> {
  static const String _prefKahfCompleted = 'friday_kahf_completed';
  static const String _prefGhusl = 'friday_etiquette_ghusl';
  static const String _prefSiwak = 'friday_etiquette_siwak';
  static const String _prefClothes = 'friday_etiquette_clothes';
  static const String _prefEarlyMosque = 'friday_etiquette_early_mosque';

  bool _kahfCompleted = false;
  bool _ghuslChecked = false;
  bool _siwakChecked = false;
  bool _clothesChecked = false;
  bool _earlyMosqueChecked = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _kahfCompleted = prefs.getBool(_prefKahfCompleted) ?? false;
        _ghuslChecked = prefs.getBool(_prefGhusl) ?? false;
        _siwakChecked = prefs.getBool(_prefSiwak) ?? false;
        _clothesChecked = prefs.getBool(_prefClothes) ?? false;
        _earlyMosqueChecked = prefs.getBool(_prefEarlyMosque) ?? false;
      });
    }
  }

  Future<void> _toggleKahf() async {
    AppHaptics.selection();
    final updated = !_kahfCompleted;
    setState(() {
      _kahfCompleted = updated;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKahfCompleted, updated);
  }

  Future<void> _toggleEtiquette(String prefKey, bool currentVal, ValueSetter<bool> updateState) async {
    AppHaptics.selection();
    final updated = !currentVal;
    setState(() {
      updateState(updated);
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefKey, updated);
  }

  bool get _effectiveIsFriday {
    if (widget.overrideIsFriday != null) return widget.overrideIsFriday!;
    final now = widget.nowOverride ?? DateTime.now();
    return now.weekday == DateTime.friday;
  }

  bool _isIstijabahActive(DateTime now) {
    if (widget.asrDateTime == null || widget.maghribDateTime == null) {
      return false;
    }
    return now.isAfter(widget.asrDateTime!) && now.isBefore(widget.maghribDateTime!);
  }

  @override
  Widget build(BuildContext context) {
    if (!_effectiveIsFriday) {
      return const SizedBox.shrink();
    }

    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final now = widget.nowOverride ?? DateTime.now();
    final isIstijabahNow = _isIstijabahActive(now);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Suite Section Header
        _buildSuiteSectionHeader(context, colors, l10n, isDark),
        const SizedBox(height: 12),

        // 1. Surah Al-Kahf Card
        _buildKahfCard(context, colors, l10n, isDark),
        const SizedBox(height: 12),

        // 2. Abundant Salawat Counter Card
        _buildSalawatCard(context, colors, l10n, isDark),
        const SizedBox(height: 12),

        // 3. Friday Purification & Etiquettes Checklist Card
        _buildEtiquettesCard(context, colors, l10n, isDark),
        const SizedBox(height: 12),

        // 4. Sa'at al-Istijabah Card
        _buildIstijabahCard(context, colors, l10n, isDark, isIstijabahNow),
      ],
    );
  }

  /// Header row announcing Friday Special Deeds Suite
  Widget _buildSuiteSectionHeader(
    BuildContext context,
    AppCustomColors colors,
    AppLocalizations? l10n,
    bool isDark,
  ) {
    final accentColor = isDark ? const Color(0xFFD4A574) : const Color(0xFF0F766E);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Row(
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            size: 13,
            color: accentColor,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              l10n?.fridaySuiteHeader ?? 'FRIDAY SUNNAH & SPECIAL DEEDS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colors.textSecondary,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Card 1: Surah Al-Kahf with 110 Ayat badge, Hadith, and tap-to-complete
  Widget _buildKahfCard(
    BuildContext context,
    AppCustomColors colors,
    AppLocalizations? l10n,
    bool isDark,
  ) {
    final accentColor = isDark ? const Color(0xFFD4A574) : const Color(0xFF0F766E);
    final accentText = isDark ? const Color(0xFFE8C9A0) : const Color(0xFF0F766E);

    return Container(
      decoration: ShapeDecoration(
        color: colors.surface,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: _kahfCompleted
                ? colors.success.withValues(alpha: 0.45)
                : colors.dividerStrong,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: Icon + Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  Icons.auto_stories_rounded,
                  size: 16,
                  color: accentText,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n?.surahKahfTitle ?? 'Surah Al-Kahf',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Badges: 110 Ayat + Light Between Two Fridays
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: colors.surfaceHover,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: colors.divider,
                    width: 0.8,
                  ),
                ),
                child: Text(
                  '110 Ayat',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    color: colors.textSecondary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.30),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  l10n?.surahKahfBadge ?? 'Light Between Two Fridays',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: accentText,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),

          // Hadith Quote Text
          Text(
            l10n?.surahKahfHadith ??
                'Whoever recites Surah Al-Kahf on Friday will have a light shining for him between the two Fridays. (Al-Bayhaqi)',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: colors.textSecondary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),

          // Completion Action Button
          InkWell(
            onTap: _toggleKahf,
            borderRadius: BorderRadius.circular(10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 12.0),
              decoration: BoxDecoration(
                color: _kahfCompleted
                    ? colors.successSoft
                    : accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _kahfCompleted
                      ? colors.success.withValues(alpha: 0.6)
                      : accentColor.withValues(alpha: 0.4),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _kahfCompleted
                        ? Icons.check_circle_rounded
                        : Icons.check_circle_outline_rounded,
                    size: 15,
                    color: _kahfCompleted ? colors.successText : accentText,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _kahfCompleted
                        ? (l10n?.readCompleted ?? 'Completed')
                        : (l10n?.markAsRead ?? 'Mark as Read'),
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: _kahfCompleted ? colors.successText : accentText,
                      letterSpacing: 0.2,
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

  /// Card 2: Abundant Salawat Tap Counter
  Widget _buildSalawatCard(
    BuildContext context,
    AppCustomColors colors,
    AppLocalizations? l10n,
    bool isDark,
  ) {
    final accentColor = isDark ? const Color(0xFFD4A574) : const Color(0xFF0F766E);
    final accentText = isDark ? const Color(0xFFE8C9A0) : const Color(0xFF0F766E);

    return Container(
      decoration: ShapeDecoration(
        color: colors.surface,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: colors.dividerStrong,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: Icon + Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  Icons.favorite_rounded,
                  size: 16,
                  color: accentText,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n?.salawatTitle ?? 'Abundant Salawat upon the Prophet ﷺ',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Badge: Presented Directly
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 2.0),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.30),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  l10n?.salawatBadge ?? 'Presented Directly',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                    color: accentText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),

          // Hadith Text
          Text(
            l10n?.salawatHadith ??
                'Increase your supplications for blessings upon me on Friday, for your supplications are presented to me. (Abu Dawud)',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: colors.textSecondary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),

          // Action Button: Do Salawat -> Navigates to Tasbih Screen
          InkWell(
            onTap: () {
              AppHaptics.light();
              widget.onOpenSalawatTasbih?.call();
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.28),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TasbihIcon(
                    size: 16,
                    color: isDark ? const Color(0xFF12151C) : Colors.white,
                    isSelected: true,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n?.doSalawat ?? 'Do Salawat',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: isDark ? const Color(0xFF12151C) : Colors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 15,
                    color: isDark ? const Color(0xFF12151C) : Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Card 3: Friday Purification & Etiquettes Checklist
  Widget _buildEtiquettesCard(
    BuildContext context,
    AppCustomColors colors,
    AppLocalizations? l10n,
    bool isDark,
  ) {
    final accentColor = isDark ? const Color(0xFFD4A574) : const Color(0xFF0F766E);
    final accentText = isDark ? const Color(0xFFE8C9A0) : const Color(0xFF0F766E);

    return Container(
      decoration: ShapeDecoration(
        color: colors.surface,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: colors.dividerStrong,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: Icon + Title + Reference
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  Icons.checklist_rounded,
                  size: 17,
                  color: accentText,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.fridayEtiquettesTitle ?? 'Sunnahs & Etiquettes of Friday',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      l10n?.fridayEtiquettesRef ?? 'Authentic Traditions of Friday',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w500,
                        color: colors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 4 Checklist Items
          // 1. Ghusl
          _buildChecklistItem(
            title: l10n?.fridayGhusl ?? 'Ghusl (Ritual Bath) before prayer',
            icon: Icons.water_drop_rounded,
            isChecked: _ghuslChecked,
            colors: colors,
            accentText: accentText,
            onTap: () => _toggleEtiquette(
              _prefGhusl,
              _ghuslChecked,
              (val) => _ghuslChecked = val,
            ),
          ),
          const SizedBox(height: 8),

          // 2. Siwak
          _buildChecklistItem(
            title: l10n?.fridaySiwak ?? 'Using the Siwak (Tooth-stick) & perfume',
            icon: Icons.brush_rounded,
            isChecked: _siwakChecked,
            colors: colors,
            accentText: accentText,
            onTap: () => _toggleEtiquette(
              _prefSiwak,
              _siwakChecked,
              (val) => _siwakChecked = val,
            ),
          ),
          const SizedBox(height: 8),

          // 3. Clean Clothes with Tailored Garment / Thobe Icon
          _buildChecklistItem(
            title: l10n?.fridayCleanClothes ?? 'Wearing one\'s best and cleanest garments',
            customIcon: TailoredGarmentIcon(
              size: 16,
              color: _clothesChecked ? colors.successText : accentText,
            ),
            isChecked: _clothesChecked,
            colors: colors,
            accentText: accentText,
            onTap: () => _toggleEtiquette(
              _prefClothes,
              _clothesChecked,
              (val) => _clothesChecked = val,
            ),
          ),
          const SizedBox(height: 8),

          // 4. Early Mosque Arrival
          _buildChecklistItem(
            title: l10n?.fridayEarlyMosque ?? 'Arriving early to the mosque for Khutbah',
            icon: Icons.mosque_rounded,
            isChecked: _earlyMosqueChecked,
            colors: colors,
            accentText: accentText,
            onTap: () => _toggleEtiquette(
              _prefEarlyMosque,
              _earlyMosqueChecked,
              (val) => _earlyMosqueChecked = val,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem({
    required String title,
    IconData? icon,
    Widget? customIcon,
    required bool isChecked,
    required AppCustomColors colors,
    required Color accentText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.5),
        decoration: BoxDecoration(
          color: isChecked
              ? colors.successSoft.withValues(alpha: 0.15)
              : colors.surfaceHover.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isChecked
                ? colors.success.withValues(alpha: 0.45)
                : colors.divider.withValues(alpha: 0.5),
            width: 0.8,
          ),
        ),
        child: Row(
          children: [
            // Leading Icon
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: isChecked
                    ? colors.successSoft
                    : accentText.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: customIcon ??
                    Icon(
                      icon,
                      size: 14,
                      color: isChecked ? colors.successText : accentText,
                    ),
              ),
            ),
            const SizedBox(width: 9),

            // Item Title
            Expanded(
              child: Text(
                title,
                softWrap: true,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: isChecked ? FontWeight.w600 : FontWeight.w500,
                  color: isChecked ? colors.textSecondary : colors.textPrimary,
                  decoration: isChecked ? TextDecoration.lineThrough : null,
                  decorationColor: colors.textSecondary,
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Checkbox Indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: isChecked ? colors.success : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isChecked
                      ? colors.success
                      : colors.dividerStrong,
                  width: 1.5,
                ),
              ),
              child: isChecked
                  ? const Center(
                      child: Icon(
                        Icons.check_rounded,
                        size: 11,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  /// Card 4: Sa'at al-Istijabah Card
  Widget _buildIstijabahCard(
    BuildContext context,
    AppCustomColors colors,
    AppLocalizations? l10n,
    bool isDark,
    bool isActiveNow,
  ) {
    final accentColor = isDark ? const Color(0xFFD4A574) : const Color(0xFF0F766E);
    final accentText = isDark ? const Color(0xFFE8C9A0) : const Color(0xFF0F766E);

    return Container(
      decoration: ShapeDecoration(
        color: colors.surface,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: isActiveNow
                ? colors.primary.withValues(alpha: 0.6)
                : colors.dividerStrong,
            width: isActiveNow ? 1.5 : 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: Icon + Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isActiveNow
                      ? colors.primarySoft
                      : accentColor.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  Icons.access_time_filled_rounded,
                  size: 16,
                  color: isActiveNow ? colors.primaryText : accentText,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n?.istijabahTitle ?? 'Hour of Response (Sa\'at al-Istijabah)',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Badges: Active (if active) + Supplication Accepted
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              if (isActiveNow)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: colors.primarySoft,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: colors.primary.withValues(alpha: 0.6),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: colors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n?.badgeCurrent ?? 'ACTIVE',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          color: colors.primaryText,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 2.0),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.30),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  l10n?.istijabahBadge ?? 'Supplication Accepted',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                    color: accentText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),

          // Hadith Text
          Text(
            l10n?.istijabahHadith ??
                'On Friday there is an hour when no Muslim servant asks Allah for something good but He grants it to him — seek it in the last hour after Asr. (Abu Dawud, An-Nasa\'i)',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: colors.textSecondary,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

/// Bespoke Tailored Garment / Thobe Vector Icon
/// Custom painter representing an authentic thobe/robe with neckline and placket.
class TailoredGarmentIcon extends StatelessWidget {
  final double size;
  final Color color;

  const TailoredGarmentIcon({
    super.key,
    this.size = 18.0,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _TailoredGarmentPainter(color: color),
    );
  }
}

class _TailoredGarmentPainter extends CustomPainter {
  final Color color;
  const _TailoredGarmentPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.16)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Tailored thobe silhouette
    final path = Path();
    // Left collar
    path.moveTo(w * 0.38, h * 0.12);
    // Neckline curve
    path.quadraticBezierTo(w * 0.50, h * 0.20, w * 0.62, h * 0.12);
    // Right shoulder
    path.lineTo(w * 0.85, h * 0.22);
    // Right outer sleeve
    path.lineTo(w * 0.92, h * 0.44);
    // Right sleeve cuff
    path.lineTo(w * 0.78, h * 0.48);
    // Right underarm
    path.lineTo(w * 0.72, h * 0.38);
    // Right robe body flare down to hem
    path.lineTo(w * 0.78, h * 0.90);
    // Hem curve
    path.quadraticBezierTo(w * 0.50, h * 0.94, w * 0.22, h * 0.90);
    // Left robe body up to underarm
    path.lineTo(w * 0.28, h * 0.38);
    // Left underarm
    path.lineTo(w * 0.22, h * 0.48);
    // Left sleeve cuff
    path.lineTo(w * 0.08, h * 0.44);
    // Left shoulder
    path.lineTo(w * 0.15, h * 0.22);
    path.close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);

    // Front placket line down chest
    canvas.drawLine(
      Offset(w * 0.50, h * 0.20),
      Offset(w * 0.50, h * 0.45),
      strokePaint..strokeWidth = 1.1,
    );
  }

  @override
  bool shouldRepaint(covariant _TailoredGarmentPainter oldDelegate) =>
      oldDelegate.color != color;
}
