import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/services/app_haptics.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Authentic Friday Hadith Guide popup window with modern borderless depth,
/// manuscript paper aesthetic, and pure typography.
///
/// Displays authentic hadiths and scholarly rulings for:
/// - Before Jumu'ah / Dhuhr Prayer (Tahiyyat al-Masjid, 4 Sunnah before Dhuhr at home)
/// - After Jumu'ah at Mosque (4 Rak'ahs - Sahih Muslim 881)
/// - After Jumu'ah at Home (2 Rak'ahs - Sahih al-Bukhari 937, Sahih Muslim 882)
class FridayHadithGuidePopup extends StatelessWidget {
  final Animation<double>? animation;
  final VoidCallback? onClose;

  const FridayHadithGuidePopup({
    super.key,
    this.animation,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? const Color(0xFF06080C) : const Color(0xFFFFF7F2);
    final accentGoldOrEmerald =
        isDark ? const Color(0xFFD4A574) : const Color(0xFF0F766E);
    final accentText =
        isDark ? const Color(0xFFE8C9A0) : const Color(0xFF0F766E);

    final bool isHeaderVisible = animation == null || animation!.value >= 0.99;

    return PopScope(
      canPop: true,
      child: Container(
        decoration: BoxDecoration(
          color: colors.paperBackground,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: colors.cardBorder,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.45 : 0.15),
              blurRadius: 28.0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final scrollContent = SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Card 1: Before Jumu'ah / Dhuhr Prayer
                  _buildHadithCard(
                    title: l10n?.fridayHadithBeforeCardTitle ??
                        'Before Jumu\'ah / Dhuhr Prayer',
                    desc: l10n?.fridayHadithBeforeCardDesc ??
                        'At the mosque: When you enter, pray Tahiyyat al-Masjid (2 Rak\'ahs), then voluntary prayers until the Imam ascends the pulpit. At home (Dhuhr): Pray 4 Rak\'ahs Sunnah Mu\'akkadah before Dhuhr.',
                    icon: Icons.wb_sunny_rounded,
                    cardBg: cardBg,
                    accentColor: accentText,
                    colors: colors,
                  ),
                  const SizedBox(height: 10),

                  // Card 2: After Jumu'ah at Mosque (4 Rak'ahs)
                  _buildHadithCard(
                    title: l10n?.fridayHadithAfterMosqueTitle ??
                        'After Jumu\'ah at the Mosque (4 Rak\'ahs)',
                    desc: l10n?.fridayHadithAfterMosqueDesc ??
                        'Abu Hurairah reported: The Messenger of Allah ﷺ said: \'When one of you prays Jumu\'ah, let him pray four Rak\'ahs after it.\' (Sahih Muslim 881)',
                    icon: Icons.mosque_rounded,
                    cardBg: cardBg,
                    accentColor: accentText,
                    colors: colors,
                    isHadithQuote: true,
                  ),
                  const SizedBox(height: 10),

                  // Card 3: After Jumu'ah at Home (2 Rak'ahs)
                  _buildHadithCard(
                    title: l10n?.fridayHadithAfterHomeTitle ??
                        'After Jumu\'ah at Home (2 Rak\'ahs)',
                    desc: l10n?.fridayHadithAfterHomeDesc ??
                        'Ibn Umar reported: \'The Prophet ﷺ would not pray after Jumu\'ah until he departed, and then he would pray two Rak\'ahs in his house.\' (Sahih al-Bukhari 937, Sahih Muslim 882)',
                    icon: Icons.home_rounded,
                    cardBg: cardBg,
                    accentColor: accentText,
                    colors: colors,
                    isHadithQuote: true,
                  ),
                ],
              ),
            );

            final bottomActionButton = Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
              child: SizedBox(
                height: 46,
                child: FilledButton(
                  onPressed: () {
                    AppHaptics.light();
                    onClose?.call();
                    Navigator.of(context).pop();
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: accentGoldOrEmerald,
                    foregroundColor:
                        isDark ? const Color(0xFF12151C) : Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    l10n?.closeGuideBtn ?? 'Close Guide',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: isDark ? const Color(0xFF12151C) : Colors.white,
                    ),
                  ),
                ),
              ),
            );

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Header: Squircle Icon + Title + Close Button
                // When animating via CardExpandRoute, the shared header glides on top.
                Opacity(
                  opacity: isHeaderVisible ? 1.0 : 0.0,
                  child: _buildTopHeader(
                    context,
                    colors,
                    l10n,
                    isDark,
                    accentGoldOrEmerald,
                    accentText,
                  ),
                ),

                // Scrollable Content
                if (constraints.maxHeight.isFinite)
                  Expanded(child: scrollContent)
                else
                  Flexible(child: scrollContent),

                // Pinned Bottom Action Button with Symmetrical Padding
                bottomActionButton,
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopHeader(
    BuildContext context,
    AppCustomColors colors,
    AppLocalizations? l10n,
    bool isDark,
    Color accentGoldOrEmerald,
    Color accentText,
  ) {
    return Container(
      padding: const EdgeInsets.only(left: 18.0, right: 14.0, top: 14.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accentGoldOrEmerald.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.menu_book_rounded,
              size: 18,
              color: accentText,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n?.fridayHadithGuideSheetTitle ??
                      "Sunnah Prayers of Jumu'ah: Hadith Guide",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 15.0,
                        color: colors.textPrimary,
                        letterSpacing: -0.2,
                      ),
                ),
                const SizedBox(height: 1.0),
                Text(
                  'Authentic Sunnah Rulings • Bukhari & Muslim',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w500,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 20),
            color: colors.textSecondary,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              AppHaptics.light();
              onClose?.call();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHadithCard({
    required String title,
    required String desc,
    required IconData icon,
    required Color cardBg,
    required Color accentColor,
    required AppCustomColors colors,
    bool isHadithQuote = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: colors.cardBorder,
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: accentColor),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w400,
              fontStyle: isHadithQuote ? FontStyle.italic : FontStyle.normal,
              color: colors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
