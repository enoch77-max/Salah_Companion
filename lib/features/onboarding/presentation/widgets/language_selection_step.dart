import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/localization/language_registry.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Full-screen Apple-inspired Onboarding Language Selection Step.
/// Automatically detects and highlights the device's native language as default,
/// offers English as the primary alternative, and allows 1-tap switching across all 19 languages.
class LanguageSelectionStep extends StatefulWidget {
  final AppLanguage currentLanguage;
  final ValueChanged<AppLanguage> onLanguageSelected;

  const LanguageSelectionStep({
    super.key,
    required this.currentLanguage,
    required this.onLanguageSelected,
  });

  @override
  State<LanguageSelectionStep> createState() => _LanguageSelectionStepState();
}

class _LanguageSelectionStepState extends State<LanguageSelectionStep> {
  late final AppLanguage _systemLanguage;
  late final AppLanguage _englishLanguage;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _systemLanguage = LanguageRegistry.resolveDeviceLanguage();
    _englishLanguage = LanguageRegistry.getLanguage('en');
  }

  void _select(AppLanguage lang) {
    HapticFeedback.selectionClick();
    widget.onLanguageSelected(lang);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);
    final isNativeSameAsEnglish = _systemLanguage.code == 'en';

    final filteredLanguages = LanguageRegistry.supportedLanguages.where((lang) {
      if (_searchQuery.trim().isEmpty) return true;
      final q = _searchQuery.toLowerCase();
      return lang.nativeName.toLowerCase().contains(q) ||
          lang.englishName.toLowerCase().contains(q) ||
          lang.code.toLowerCase().contains(q);
    }).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top Colorful Medallion (Shadowless, Lighter Variant)
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF60A5FA), // Light Sky Blue
                  Color(0xFF3B82F6), // Vibrant Azure
                ],
              ),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.translate_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
        const SizedBox(height: 18),

        Text(
          l10n?.onboardingChooseLanguage ?? 'Choose Your Language',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),

        Text(
          l10n?.onboardingChooseLanguageSubtitle ??
              'Select your preferred language for prayer times, guidance, and reflections.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.textSecondary,
            fontSize: 13,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 20),

        // Quick 2-Option Highlighted Cards (Native vs English)
        Row(
          children: [
            // 1. Detected System / Native Language Card
            Expanded(
              child: _buildQuickOptionCard(
                context: context,
                language: _systemLanguage,
                subtitle: l10n?.systemDefault ?? 'System Default',
                isSelected: widget.currentLanguage.code == _systemLanguage.code,
                key: const ValueKey('onboarding_system_lang_card'),
                colors: colors,
              ),
            ),
            if (!isNativeSameAsEnglish) ...[
              const SizedBox(width: 10),
              // 2. English (Secondary Preferred) Card
              Expanded(
                child: _buildQuickOptionCard(
                  context: context,
                  language: _englishLanguage,
                  subtitle: 'English',
                  isSelected: widget.currentLanguage.code == 'en',
                  key: const ValueKey('onboarding_english_lang_card'),
                  colors: colors,
                ),
              ),
            ],
          ],
        ),

        const SizedBox(height: 16),

        // Search Bar
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colors.divider),
          ),
          child: TextField(
            onChanged: (val) => setState(() => _searchQuery = val),
            style: TextStyle(color: colors.textPrimary, fontSize: 13),
            decoration: InputDecoration(
              hintText: l10n?.searchLanguagePlaceholder ?? 'Search from 19 supported languages...',
              hintStyle: TextStyle(color: colors.textTertiary, fontSize: 12),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              prefixIcon: Icon(Icons.search_rounded, size: 18, color: colors.textTertiary),
              border: InputBorder.none,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Full 19-Language Card List
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.divider),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 6),
            itemCount: filteredLanguages.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              indent: 52,
              color: colors.divider,
            ),
            itemBuilder: (context, idx) {
              final lang = filteredLanguages[idx];
              final isSelected = widget.currentLanguage.code == lang.code;

              return InkWell(
                key: ValueKey('lang_item_${lang.code}'),
                onTap: () => _select(lang),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Text(lang.flag, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lang.nativeName,
                              style: TextStyle(
                                color: isSelected ? colors.primary : colors.textPrimary,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              lang.englishName,
                              style: TextStyle(
                                color: colors.textTertiary,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: colors.primarySoft,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: colors.primary,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickOptionCard({
    required BuildContext context,
    required AppLanguage language,
    required String subtitle,
    required bool isSelected,
    required Key key,
    required AppCustomColors colors,
  }) {
    return GestureDetector(
      key: key,
      onTap: () => _select(language),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? colors.primarySoft : colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colors.primary : colors.divider,
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  language.flag,
                  style: const TextStyle(fontSize: 22),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle_rounded,
                    color: colors.primary,
                    size: 18,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              language.nativeName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isSelected ? colors.primary : colors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isSelected
                    ? colors.primary.withValues(alpha: 0.8)
                    : colors.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
