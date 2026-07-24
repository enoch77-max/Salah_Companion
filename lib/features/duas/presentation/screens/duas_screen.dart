import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';

class DuaItem {
  final String id;
  final String category;
  final String title;
  final String arabic;
  final String transliteration;
  final String translation;
  final String source;
  final int repeatCount;

  const DuaItem({
    required this.id,
    required this.category,
    required this.title,
    required this.arabic,
    required this.transliteration,
    required this.translation,
    required this.source,
    this.repeatCount = 1,
  });
}

class DuasScreen extends StatefulWidget {
  const DuasScreen({super.key});

  static const List<DuaItem> defaultDuas = [
    DuaItem(
      id: 'dua_morning_1',
      category: 'Morning',
      title: 'Morning Remembrance',
      arabic: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ',
      transliteration: 'Asbahna wa-asbahal-mulku lillahi wal-hamdu lillah.',
      translation: 'We have entered the morning and the kingdom belongs to Allah, praise be to Allah.',
      source: 'Sahih Muslim 2723',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_morning_2',
      category: 'Morning',
      title: 'Protection from Harm',
      arabic: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
      transliteration: 'Bismillahil-ladhi la yadurru ma\'as-mihi shay\'un fil-ardi wa la fis-sama\'i wa Huwas-Sami\'ul-\'Alim.',
      translation: 'In the name of Allah with Whose name nothing can cause harm in the earth nor in the heaven, and He is the All-Hearing, the All-Knowing.',
      source: 'Sunan Abi Dawud 5088',
      repeatCount: 3,
    ),
    DuaItem(
      id: 'dua_evening_1',
      category: 'Evening',
      title: 'Evening Remembrance',
      arabic: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ',
      transliteration: 'Amsayna wa-amsal-mulku lillahi wal-hamdu lillah.',
      translation: 'We have reached the evening and the kingdom belongs to Allah, praise be to Allah.',
      source: 'Sahih Muslim 2723',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_after_prayer_1',
      category: 'After Prayer',
      title: 'Ayat al-Kursi',
      arabic: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ',
      transliteration: 'Allahu la ilaha illa Huwal-Hayyul-Qayyum. La ta\'khudhuhu sinatun wa la nawm.',
      translation: 'Allah! There is no deity except Him, the Ever-Living, the Sustainer of all existence. Neither drowsiness overtakes Him nor sleep.',
      source: 'Surah Al-Baqarah 2:255 / An-Nasa\'i',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_daily_1',
      category: 'Daily',
      title: 'Before Eating',
      arabic: 'بِسْمِ اللَّهِ',
      transliteration: 'Bismillah.',
      translation: 'In the name of Allah.',
      source: 'Sunan Abi Dawud 3767',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_travel_1',
      category: 'Travel',
      title: 'Dua for Traveling',
      arabic: 'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَٰذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ وَإِنَّا إِلَىٰ رَبِّنَا لَمُنْقَلِبُونَ',
      transliteration: 'Subhanal-ladhi sakhkhara lana hadha wa ma kunna lahu muqrinin, wa inna ila Rabbina lamunqalibun.',
      translation: 'Glory to Him Who has subjected this to us, though we were unable to conquer it, and indeed, to our Lord we will return.',
      source: 'Surah Az-Zukhruf 43:13-14',
      repeatCount: 1,
    ),
  ];

  @override
  State<DuasScreen> createState() => _DuasScreenState();
}

class _DuasScreenState extends State<DuasScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'Morning',
    'Evening',
    'After Prayer',
    'Daily',
    'Travel',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final filteredDuas = DuasScreen.defaultDuas.where((dua) {
      final matchesCategory = _selectedCategory == 'All' || dua.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          dua.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          dua.transliteration.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          dua.translation.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          dua.source.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Duas & Azkar',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Column(
        children: [
          // Search Input Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              key: const ValueKey('dua_search_field'),
              style: TextStyle(color: colors.textPrimary),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val.trim();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search duas, translations, or sources...',
                hintStyle: TextStyle(color: colors.textTertiary),
                prefixIcon: Icon(Icons.search_rounded, color: colors.textSecondary),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear_rounded, color: colors.textSecondary),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: colors.surface,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: colors.divider),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: colors.divider),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: colors.primary),
                ),
              ),
            ),
          ),

          // Category Chips Bar
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return ChoiceChip(
                  key: ValueKey('category_chip_$category'),
                  label: Text(category),
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
                        _selectedCategory = category;
                      });
                    }
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Duas List
          Expanded(
            child: filteredDuas.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu_book_rounded, size: 48, color: colors.textTertiary),
                        const SizedBox(height: 12),
                        Text(
                          'No Duas Found',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: colors.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredDuas.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final dua = filteredDuas[index];
                      return Container(
                        decoration: ShapeDecoration(
                          color: colors.surface,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: colors.divider, width: 1.0),
                          ),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title & Badges
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    dua.title,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: colors.textPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                if (dua.repeatCount > 1)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: ShapeDecoration(
                                      color: colors.primarySoft,
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      'Read ${dua.repeatCount}x',
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            color: colors.primaryText,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Arabic Script (Amiri)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: ShapeDecoration(
                                color: colors.elevatedBackground,
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Text(
                                dua.arabic,
                                style: AppTypography.quranicStyle(
                                  fontSize: 22,
                                  color: colors.textPrimary,
                                ),
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Transliteration
                            Text(
                              dua.transliteration,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: colors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),

                            const SizedBox(height: 8),

                            // Translation (Lora italic)
                            Text(
                              dua.translation,
                              style: AppTypography.quoteTranslationStyle(
                                fontSize: 14,
                                color: colors.textPrimary,
                              ),
                            ),

                            const SizedBox(height: 14),
                            Divider(color: colors.divider),
                            const SizedBox(height: 8),

                            // Citation Source Footer
                            Row(
                              children: [
                                Icon(Icons.bookmark_border_rounded, size: 14, color: colors.primary),
                                const SizedBox(width: 6),
                                Text(
                                  dua.source,
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: colors.primaryText,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
