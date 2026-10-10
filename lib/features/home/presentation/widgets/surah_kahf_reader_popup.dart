import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/services/app_haptics.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/surah_kahf_data.dart';

/// Reading mode for Surah Al-Kahf.
enum KahfReadingMode {
  mushaf,
  verseByVerse,
}

/// Beautiful, immersive modal reader for Surah Al-Kahf.
///
/// Features:
/// - Warm authentic manuscript paper background (colors.paperBackground) matching DailyReflectionCard
/// - Authentic Uthmani script recitation with generous vertical rhythm and Tashkeel clearance
/// - Unboxed, majestic calligraphic Bismillah header
/// - Continuous Mushaf view with traditional circular Ayah stop medallions
/// - Verse-by-verse view with Amiri Arabic and Lora italic English translation
/// - Clean, ergonomic reading toolbar with dual-mode selector and tactile font size stepper
/// - Live reading progress indicator line
/// - Bottom sticky action bar with Close and Mark as Read controls
class SurahKahfReaderPopup extends StatefulWidget {
  final bool isInitiallyCompleted;
  final ValueChanged<bool>? onStatusChanged;
  final Animation<double>? animation;

  const SurahKahfReaderPopup({
    super.key,
    this.isInitiallyCompleted = false,
    this.onStatusChanged,
    this.animation,
  });

  @override
  State<SurahKahfReaderPopup> createState() => _SurahKahfReaderPopupState();
}

class _SurahKahfReaderPopupState extends State<SurahKahfReaderPopup> {
  late bool _isCompleted;
  KahfReadingMode _readingMode = KahfReadingMode.mushaf;
  double _fontSize = 22.0;
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.isInitiallyCompleted;
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll <= 0) {
      if (_scrollProgress != 0.0) setState(() => _scrollProgress = 0.0);
      return;
    }
    final progress = (_scrollController.position.pixels / maxScroll).clamp(0.0, 1.0);
    if ((progress - _scrollProgress).abs() > 0.01) {
      setState(() => _scrollProgress = progress);
    }
  }

  void _adjustFontSize(double delta) {
    AppHaptics.selection();
    setState(() {
      _fontSize = (_fontSize + delta).clamp(18.0, 36.0);
    });
  }

  void _toggleReadingMode(KahfReadingMode mode) {
    if (_readingMode == mode) return;
    AppHaptics.selection();
    setState(() {
      _readingMode = mode;
      _scrollProgress = 0.0;
    });
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0.0);
    }
  }

  void _handleMarkAsRead() {
    AppHaptics.selection();
    final newStatus = !_isCompleted;
    setState(() {
      _isCompleted = newStatus;
    });
    widget.onStatusChanged?.call(newStatus);
    Navigator.of(context).pop(newStatus);
  }

  void _handleClose() {
    AppHaptics.light();
    Navigator.of(context).pop(_isCompleted);
  }

  /// Converts standard numbers to decorative Arabic-Indic numerals.
  String _toArabicIndic(int number) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    final s = number.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final d = int.tryParse(s[i]);
      if (d != null) {
        buffer.write(arabicDigits[d]);
      } else {
        buffer.write(s[i]);
      }
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    // Dynamic theme accents calibrated by app theme
    final Color themePrimary = colors.primary;
    final Color themeLuminous = isDark ? colors.primaryText : colors.primary;
    final Color themeSurface = colors.primarySoft;
    final Color themeBorder = colors.primary.withValues(alpha: isDark ? 0.35 : 0.25);

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        // Preserves return value if system back is triggered
      },
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
        child: Column(
          children: [
            // 1. Clean Top Header with Title and Close Button
            _buildTopHeader(context, colors, isDark, themeLuminous, themeSurface),

            // 2. Ergonomics Toolbar (Mushaf / Verses, Font Size, Progress Line)
            _buildErgonomicsToolbar(context, colors, isDark, themePrimary, themeLuminous, themeSurface, themeBorder),

            // 3. Scrollable Quran Content (Continuous Mushaf or Verse-by-Verse)
            Expanded(
              child: _buildQuranContent(context, colors, isDark, themeLuminous, themeSurface, themeBorder),
            ),

            // 4. Bottom Sticky Action Bar (Close & Mark as Read)
            _buildBottomActionBar(context, colors, l10n, isDark, themePrimary, themeLuminous),
          ],
        ),
      ),
    );
  }

  /// Top header with clean surah information and close button
  Widget _buildTopHeader(
    BuildContext context,
    AppCustomColors colors,
    bool isDark,
    Color themeLuminous,
    Color themeSurface,
  ) {
    final isHeaderVisible =
        widget.animation == null || widget.animation!.value >= 0.99;

    return Opacity(
      opacity: isHeaderVisible ? 1.0 : 0.0,
      child: Container(
        padding: const EdgeInsets.only(left: 18.0, right: 14.0, top: 14.0, bottom: 8.0),
        child: Row(
        children: [
          // Book Icon Badge in Subtle Theme Squircle
          Container(
            width: 38.0,
            height: 38.0,
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: isDark ? 0.18 : 0.10),
              borderRadius: BorderRadius.circular(11.0),
              border: Border.all(
                color: colors.primary.withValues(alpha: isDark ? 0.30 : 0.20),
                width: 0.8,
              ),
            ),
            child: Icon(
              Icons.auto_stories_rounded,
              size: 19.0,
              color: colors.primary,
            ),
          ),
          const SizedBox(width: 12.0),

          // Title and metadata
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      SurahKahfData.surahNameEnglish,
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w800,
                        color: colors.textPrimary,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      SurahKahfData.surahNameArabic,
                      style: GoogleFonts.amiri(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1.0),
                Text(
                  '110 Verses • Makki • Jumu\'ah Sunnah',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w500,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Close circular button
          InkWell(
            onTap: _handleClose,
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1B18) : const Color(0xFFE4D8C8),
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.cardBorder,
                  width: 0.8,
                ),
              ),
              child: Icon(
                Icons.close_rounded,
                size: 17.0,
                color: colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  /// Reading Toolbar: View Mode & Font Size Adjuster seamlessly styled on paper
  Widget _buildErgonomicsToolbar(
    BuildContext context,
    AppCustomColors colors,
    bool isDark,
    Color themePrimary,
    Color themeLuminous,
    Color themeSurface,
    Color themeBorder,
  ) {
    final capsuleBg = isDark ? const Color(0xFF1E1B18) : const Color(0xFFE4D8C8);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Row(
            children: [
              // Dual-Mode Selector: Mushaf vs Verses
              Container(
                height: 36.0,
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  color: capsuleBg,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: colors.cardBorder, width: 0.7),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildModeButton(
                      mode: KahfReadingMode.mushaf,
                      label: 'Mushaf',
                      icon: Icons.menu_book_rounded,
                      colors: colors,
                      isDark: isDark,
                      themePrimary: themePrimary,
                    ),
                    const SizedBox(width: 2.0),
                    _buildModeButton(
                      mode: KahfReadingMode.verseByVerse,
                      label: 'Verses',
                      icon: Icons.format_list_numbered_rounded,
                      colors: colors,
                      isDark: isDark,
                      themePrimary: themePrimary,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Exquisite Font Size Stepper with paper-matched buttons
              _buildFontSizeStepper(colors, isDark, themeLuminous, themeSurface, themeBorder),
            ],
          ),
        ),

        // Delicate Reading Progress Indicator Line
        LinearProgressIndicator(
          value: _scrollProgress,
          backgroundColor: colors.cardBorder.withValues(alpha: 0.35),
          valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
          minHeight: 2.0,
        ),
      ],
    );
  }

  /// Custom Exquisite Font Size Stepper with tactile squircle buttons and recessed size badge
  Widget _buildFontSizeStepper(
    AppCustomColors colors,
    bool isDark,
    Color themeLuminous,
    Color themeSurface,
    Color themeBorder,
  ) {
    final canDecrease = _fontSize > 18.0;
    final canIncrease = _fontSize < 36.0;

    final Color capsuleBg = isDark ? const Color(0xFF1E1B18) : const Color(0xFFE4D8C8);
    final Color buttonBg = isDark ? const Color(0xFF2C2722) : const Color(0xFFFAF6F0);

    return Container(
      height: 36.0,
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: capsuleBg,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: colors.cardBorder, width: 0.7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Decrease Font Size Button
          Tooltip(
            message: 'Decrease font size',
            child: InkWell(
              onTap: canDecrease ? () => _adjustFontSize(-2.0) : null,
              borderRadius: BorderRadius.circular(7.0),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                opacity: canDecrease ? 1.0 : 0.35,
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: buttonBg,
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(
                      color: colors.cardBorder,
                      width: 0.7,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                        blurRadius: 2.0,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'A',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 1),
                      Icon(
                        Icons.remove_rounded,
                        size: 10.5,
                        color: colors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4.0),

          // 2. Current Size Badge in Luminous Theme Color
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: colors.primarySoft,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: colors.primary.withValues(alpha: 0.35), width: 0.6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${_fontSize.toInt()}',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    color: colors.primary,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(width: 2.0),
                Text(
                  'pt',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    color: colors.primary.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4.0),

          // 3. Increase Font Size Button
          Tooltip(
            message: 'Increase font size',
            child: InkWell(
              onTap: canIncrease ? () => _adjustFontSize(2.0) : null,
              borderRadius: BorderRadius.circular(7.0),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                opacity: canIncrease ? 1.0 : 0.35,
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: buttonBg,
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(
                      color: colors.cardBorder,
                      width: 0.7,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                        blurRadius: 2.0,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'A',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w900,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 1),
                      Icon(
                        Icons.add_rounded,
                        size: 11.0,
                        color: colors.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton({
    required KahfReadingMode mode,
    required String label,
    required IconData icon,
    required AppCustomColors colors,
    required bool isDark,
    required Color themePrimary,
  }) {
    final isSelected = _readingMode == mode;
    return InkWell(
      onTap: () => _toggleReadingMode(mode),
      borderRadius: BorderRadius.circular(8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: isSelected ? themePrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 13.0,
              color: isSelected
                  ? (isDark ? const Color(0xFF1F1B17) : Colors.white)
                  : colors.textSecondary,
            ),
            const SizedBox(width: 5.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? (isDark ? const Color(0xFF1F1B17) : Colors.white)
                    : colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Quran Content View: Either Mushaf continuous or Verse-by-Verse cards
  Widget _buildQuranContent(
    BuildContext context,
    AppCustomColors colors,
    bool isDark,
    Color themeLuminous,
    Color themeSurface,
    Color themeBorder,
  ) {
    if (_readingMode == KahfReadingMode.mushaf) {
      return _buildMushafContinuousView(colors, isDark, themeLuminous, themeSurface, themeBorder);
    } else {
      return _buildVerseByVerseView(colors, isDark, themeLuminous, themeSurface, themeBorder);
    }
  }

  /// Continuous Mushaf View: Optimal authentic Friday Tilawah on paper
  Widget _buildMushafContinuousView(
    AppCustomColors colors,
    bool isDark,
    Color themeLuminous,
    Color themeSurface,
    Color themeBorder,
  ) {
    final verses = SurahKahfData.verses;

    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Sacred Calligraphic Bismillah Header directly on paper
          _buildBismillahBanner(colors, isDark, themeLuminous),
          const SizedBox(height: 14.0),

          // Flow of continuous Arabic text with authentic circular ayah medallions
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text.rich(
              TextSpan(
                children: [
                  for (final verse in verses) ...[
                    TextSpan(
                      text: '${verse.arabic} ',
                      style: GoogleFonts.amiri(
                        fontSize: _fontSize,
                        fontWeight: FontWeight.w400,
                        color: colors.textPrimary,
                        height: 2.8,
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        width: (_fontSize * 1.0).clamp(20.0, 30.0),
                        height: (_fontSize * 1.0).clamp(20.0, 30.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.primary.withValues(alpha: isDark ? 0.18 : 0.10),
                          border: Border.all(
                            color: colors.primary.withValues(alpha: isDark ? 0.45 : 0.35),
                            width: 0.8,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _toArabicIndic(verse.number),
                            style: GoogleFonts.amiri(
                              fontSize: (_fontSize * 0.46).clamp(10.0, 14.5),
                              fontWeight: FontWeight.bold,
                              color: colors.primary,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const TextSpan(text: ' '),
                  ],
                ],
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: 28.0),
        ],
      ),
    );
  }

  /// Verse-by-Verse View: Arabic with English Translation on paper-harmonized cards
  Widget _buildVerseByVerseView(
    AppCustomColors colors,
    bool isDark,
    Color themeLuminous,
    Color themeSurface,
    Color themeBorder,
  ) {
    final verses = SurahKahfData.verses;
    final cardBg = isDark
        ? const Color(0xFF1E1A17).withValues(alpha: 0.75)
        : const Color(0xFFF7F2EB).withValues(alpha: 0.85);

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      itemCount: verses.length + 1,
      separatorBuilder: (context, index) => const SizedBox(height: 12.0),
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildBismillahBanner(colors, isDark, themeLuminous);
        }

        final verse = verses[index - 1];
        return Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: colors.cardBorder,
              width: 0.8,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Verse Number Pill & Medallion
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: colors.primarySoft,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: colors.primary.withValues(alpha: 0.35),
                        width: 0.7,
                      ),
                    ),
                    child: Text(
                      '18:${verse.number}',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: colors.primary,
                      ),
                    ),
                  ),
                  Text(
                    '۝ ${_toArabicIndic(verse.number)}',
                    style: GoogleFonts.amiri(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),

              // Arabic Text (Right-to-Left)
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  verse.arabic,
                  style: GoogleFonts.amiri(
                    fontSize: _fontSize,
                    fontWeight: FontWeight.w400,
                    color: colors.textPrimary,
                    height: 2.4,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),

              // Hairline Divider
              Divider(
                color: colors.divider.withValues(alpha: 0.6),
                height: 1.0,
                thickness: 0.6,
              ),
              const SizedBox(height: 10.0),

              // English Translation (Left-to-Right) in authentic Lora italic
              Text(
                verse.translation,
                style: GoogleFonts.lora(
                  fontSize: (_fontSize * 0.56).clamp(13.0, 17.0),
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: colors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Sacred Calligraphic Bismillah Header directly on paper
  Widget _buildBismillahBanner(AppCustomColors colors, bool isDark, Color themeLuminous) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              SurahKahfData.bismillahArabic,
              textAlign: TextAlign.center,
              style: GoogleFonts.amiri(
                fontSize: (_fontSize + 5.0).clamp(24.0, 36.0),
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
                height: 1.8,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            SurahKahfData.bismillahEnglish,
            textAlign: TextAlign.center,
            style: GoogleFonts.lora(
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
              color: colors.textSecondary.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 14.0),
          // Subtle ornate divider line
          Center(
            child: Container(
              width: 90.0,
              height: 1.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    colors.primary.withValues(alpha: 0.40),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Bottom Sticky Action Bar: "Close" and "Mark as Read"
  Widget _buildBottomActionBar(
    BuildContext context,
    AppCustomColors colors,
    AppLocalizations? l10n,
    bool isDark,
    Color themePrimary,
    Color themeLuminous,
  ) {
    final closeBg = isDark ? const Color(0xFF1E1B18) : const Color(0xFFE4D8C8);

    return Container(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 12.0,
        bottom: 14.0 + MediaQuery.of(context).padding.bottom * 0.5,
      ),
      decoration: BoxDecoration(
        color: colors.paperBackground,
        border: Border(
          top: BorderSide(color: colors.cardBorder, width: 0.8),
        ),
      ),
      child: Row(
        children: [
          // 1. Close Button (Shrinks back to screen without marking if unread)
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: _handleClose,
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                height: 46.0,
                decoration: BoxDecoration(
                  color: closeBg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: colors.cardBorder,
                    width: 0.8,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close_rounded,
                      size: 16.0,
                      color: colors.textSecondary,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),

          // 2. Mark as Read Button (Elevated Theme Action)
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: _handleMarkAsRead,
              borderRadius: BorderRadius.circular(12.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 46.0,
                decoration: BoxDecoration(
                  color: themePrimary,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: themePrimary.withValues(alpha: 0.35),
                      blurRadius: 10.0,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isCompleted ? Icons.check_circle_rounded : Icons.check_circle_outline_rounded,
                      size: 18.0,
                      color: isDark ? const Color(0xFF1F1B17) : Colors.white,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      _isCompleted ? 'Marked as Read' : 'Mark as Read',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: isDark ? const Color(0xFF1F1B17) : Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
