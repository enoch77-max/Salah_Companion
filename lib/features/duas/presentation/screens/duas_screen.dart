import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/presentation/widgets/dua_hands_icon.dart';

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
      arabic: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ، لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
      transliteration: 'Asbahna wa-asbahal-mulku lillahi wal-hamdu lillah, la ilaha illallahu wahdahu la sharika lah, lahul-mulku wa lahul-hamdu wa Huwa \'ala kulli shay\'in Qadir.',
      translation: 'We have entered the morning and the kingdom belongs to Allah, praise be to Allah. There is no deity except Allah alone, without partner. To Him belongs the kingdom and all praise, and He has power over all things.',
      source: 'Sahih Muslim 2723',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_morning_2',
      category: 'Morning',
      title: 'Protection from All Harm',
      arabic: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
      transliteration: 'Bismillahil-ladhi la yadurru ma\'as-mihi shay\'un fil-ardi wa la fis-sama\'i wa Huwas-Sami\'ul-\'Alim.',
      translation: 'In the name of Allah with Whose name nothing can cause harm in the earth nor in the heaven, and He is the All-Hearing, the All-Knowing.',
      source: 'Sunan Abi Dawud 5088',
      repeatCount: 3,
    ),
    DuaItem(
      id: 'dua_morning_3',
      category: 'Morning',
      title: 'Sayyid al-Istighfar (Master of Forgiveness)',
      arabic: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَٰهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَىٰ عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
      transliteration: 'Allahumma anta Rabbi la ilaha illa anta, khalaqtani wa ana \'abduka, wa ana \'ala \'ahdika wa wa\'dika mastata\'tu, a\'udhu bika min sharri ma sana\'tu, abu\'u laka bi-ni\'matika \'alayya, wa abu\'u bi-dhanbi faghfir li fa-innahu la yaghfirudh-dhunuba illa anta.',
      translation: 'O Allah, You are my Lord, there is no god but You. You created me and I am Your servant, and I abide by Your covenant and promise as best I can. I seek refuge in You from the evil of what I have done. I acknowledge Your favor upon me, and I acknowledge my sin, so forgive me, for none forgive sins except You.',
      source: 'Sahih al-Bukhari 6306',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_morning_4',
      category: 'Morning',
      title: 'Supplication for Health & Wellbeing',
      arabic: 'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَٰهَ إِلَّا أَنْتَ',
      transliteration: 'Allahumma \'afini fi badani, Allahumma \'afini fi sam\'i, Allahumma \'afini fi basari, la ilaha illa Ant.',
      translation: 'O Allah, grant health to my body; O Allah, grant health to my hearing; O Allah, grant health to my sight. There is no deity except You.',
      source: 'Sunan Abi Dawud 5090',
      repeatCount: 3,
    ),
    DuaItem(
      id: 'dua_evening_1',
      category: 'Evening',
      title: 'Evening Remembrance',
      arabic: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ، لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
      transliteration: 'Amsayna wa-amsal-mulku lillahi wal-hamdu lillah, la ilaha illallahu wahdahu la sharika lah, lahul-mulku wa lahul-hamdu wa Huwa \'ala kulli shay\'in Qadir.',
      translation: 'We have reached the evening and the kingdom belongs to Allah, praise be to Allah. There is no deity except Allah alone, without partner. To Him belongs the kingdom and all praise, and He has power over all things.',
      source: 'Sahih Muslim 2723',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_evening_2',
      category: 'Evening',
      title: 'Refuge in Perfect Words of Allah',
      arabic: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
      transliteration: 'A\'udhu bi-kalimatillahit-tammati min sharri ma khalaq.',
      translation: 'I seek refuge in the perfect words of Allah from the evil of what He has created.',
      source: 'Sahih Muslim 2709',
      repeatCount: 3,
    ),
    DuaItem(
      id: 'dua_after_prayer_1',
      category: 'After Prayer',
      title: 'Ayat al-Kursi (Surah Al-Baqarah 2:255)',
      arabic: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ',
      transliteration: 'Allahu la ilaha illa Huwal-Hayyul-Qayyum. La ta\'khudhuhu sinatun wa la nawm. Lahu ma fis-samawati wa ma fil-ard. Man dhal-ladhi yashfa\'u \'indahu illa bi-idhnih. Ya\'lamu ma bayna aydihim wa ma khalfahum, wa la yuhituna bi-shay\'im-min \'ilmihi illa bima sha\'. Wasi\'a kursiyyuhus-samawati wal-ard, wa la ya\'uduhu hifzuhuma, wa Huwal-\'Aliyyul-\'Azim.',
      translation: 'Allah! There is no deity except Him, the Ever-Living, the Sustainer of all existence. Neither drowsiness overtakes Him nor sleep. To Him belongs whatever is in the heavens and whatever is on the earth. Who is it that can intercede with Him except by His permission? He knows what is before them and what will be after them, and they encompass not a thing of His knowledge except for what He wills. His Kursi extends over the heavens and the earth, and their preservation tires Him not. And He is the Most High, the Most Great.',
      source: 'Surah Al-Baqarah 2:255 / An-Nasa\'i',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_after_prayer_2',
      category: 'After Prayer',
      title: 'Seeking Forgiveness & Peace',
      arabic: 'أَسْتَغْفِرُ اللَّهَ (ثَلَاثًا)، اللَّهُمَّ أَنْتَ السَّلَامُ وَمِنْكَ السَّلَامُ، تَبَارَكْتَ يَا ذَا الْجَلَالِ وَالْإِكْرَامِ',
      transliteration: 'Astaghfirullah (3x). Allahumma Antas-Salamu wa minkas-salam, tabarakta ya Dhal-Jalali wal-Ikram.',
      translation: 'I ask Allah for forgiveness (3 times). O Allah, You are Peace and from You comes peace. Blessed are You, O Owner of Majesty and Honor.',
      source: 'Sahih Muslim 591',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_after_prayer_3',
      category: 'After Prayer',
      title: 'Dua for Assistance in Worship',
      arabic: 'اللَّهُمَّ أَعِنِّي عَلَىٰ ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ',
      transliteration: 'Allahumma a\'inni \'ala dhikrika wa shukrika wa husni \'ibadatik.',
      translation: 'O Allah, help me to remember You, express gratitude to You, and worship You in the best manner.',
      source: 'Sunan Abi Dawud 1522',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_after_prayer_4',
      category: 'After Prayer',
      title: 'Post-Salah Tasbih & Tahmid',
      arabic: 'سُبْحَانَ اللَّهِ (٣٣×)، وَالْحَمْدُ لِلَّهِ (٣٣×)، وَاللَّهُ أَكْبَرُ (٣٣×)، لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
      transliteration: 'SubhanAllah (33x), Alhamdulillah (33x), Allahu Akbar (33x). La ilaha illallahu wahdahu la sharika lah, lahul-mulku wa lahul-hamdu wa Huwa \'ala kulli shay\'in Qadir.',
      translation: 'Glory be to Allah (33x), Praise be to Allah (33x), Allah is the Greatest (33x). There is no deity except Allah alone, without partner. To Him belongs the kingdom and all praise, and He has power over all things.',
      source: 'Sahih Muslim 597',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_forgiveness_1',
      category: 'Forgiveness',
      title: 'Supplication for Repentance',
      arabic: 'رَبِّ اغْفِرْ لِي وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيمُ',
      transliteration: 'Rabbigh-fir li wa tub \'alayya innaka Antat-Tawwabur-Rahim.',
      translation: 'My Lord, forgive me and accept my repentance, indeed You are the Accepting of repentance, the Most Merciful.',
      source: 'Sunan Abi Dawud 1516',
      repeatCount: 100,
    ),
    DuaItem(
      id: 'dua_forgiveness_2',
      category: 'Forgiveness',
      title: 'Dua of Prophet Yunus (In Distress)',
      arabic: 'لَا إِلَٰهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ',
      transliteration: 'La ilaha illa Anta subhanaka inni kuntu minadh-dhalimin.',
      translation: 'There is no deity except You; exalted are You! Indeed, I have been of the wrongdoers.',
      source: 'Jami\' at-Tirmidhi 3505 / Surah Al-Anbiya 21:87',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_protection_1',
      category: 'Protection',
      title: 'Relief from Anxiety & Distress',
      arabic: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ، وَالْعَجْزِ وَالْكَسَلِ، وَالْبُخْلِ وَالْجُبْنِ، وَضَلَعِ الدَّيْنِ وَغَلَبَةِ الرِّجَالِ',
      transliteration: 'Allahumma inni a\'udhu bika minal-hammi wal-hazani, wal-\'ajzi wal-kasali, wal-bukhli wal-jubni, wa dala\'id-dayni wa ghalabatir-rijal.',
      translation: 'O Allah, I seek refuge in You from anxiety and sorrow, weakness and laziness, miserliness and cowardice, the burden of debt and being overpowered by men.',
      source: 'Sahih al-Bukhari 6369',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_protection_2',
      category: 'Protection',
      title: 'Refuge from Severe Trials',
      arabic: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ جَهْدِ الْبَلَاءِ، وَدَرَكِ الشَّقَاءِ، وَسُوءِ الْقَضَاءِ، وَشَمَاتَةِ الْأَعْدَاءِ',
      transliteration: 'Allahumma inni a\'udhu bika min jahdil-balai, wa darakis-shaqai, wa su\'il-qadai, wa shamatatil-a\'da\'.',
      translation: 'O Allah, I seek refuge in You from the difficult trial, attainment of misery, an evil decree, and the malicious joy of enemies.',
      source: 'Sahih al-Bukhari 6347',
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
      id: 'dua_daily_2',
      category: 'Daily',
      title: 'After Eating',
      arabic: 'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنَا وَسَقَانَا وَجَعَلَنَا مُسْلِمِينَ',
      transliteration: 'Alhamdu lillahil-ladhi at\'amana wa saqana wa ja\'alana Muslimin.',
      translation: 'Praise be to Allah Who has fed us and given us drink and made us Muslims.',
      source: 'Jami\' at-Tirmidhi 3458',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_daily_3',
      category: 'Daily',
      title: 'Before Sleeping',
      arabic: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
      transliteration: 'Bismika-llahumma amutu wa ahya.',
      translation: 'In Your name, O Allah, I die and I live.',
      source: 'Sahih al-Bukhari 6312',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_daily_4',
      category: 'Daily',
      title: 'Upon Waking Up',
      arabic: 'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
      transliteration: 'Alhamdu lillahil-ladhi ahyana ba\'da ma amatana wa ilaihin-nushur.',
      translation: 'Praise be to Allah Who gave us life after having caused us to die and unto Him is the resurrection.',
      source: 'Sahih al-Bukhari 6312',
      repeatCount: 1,
    ),
    DuaItem(
      id: 'dua_travel_1',
      category: 'Travel',
      title: 'Dua for Traveling',
      arabic: 'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَٰذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ وَإِنَّا إِلَىٰ رَبِّنَا لَمُنْقَلِبُونَ',
      transliteration: 'Subhanal-ladhi sakhkhara lana hadha wa ma kunna lahu muqrinin, wa inna ila Rabbina lamunqalibun.',
      translation: 'Glory to Him Who has subjected this to us, though we were unable to conquer it, and indeed, to our Lord we will return.',
      source: 'Surah Az-Zukhruf 43:13-14 / Sahih Muslim 1342',
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
    'Forgiveness',
    'Protection',
    'Daily',
    'Travel',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _copyDuaToClipboard(DuaItem dua) {
    final textToCopy = '${dua.title}\n\n${dua.arabic}\n\n${dua.transliteration}\n\n${dua.translation}\n\nSource: ${dua.source}';
    Clipboard.setData(ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Dua copied to clipboard'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
              child: Row(
                children: [
                  DuaHandsIcon(color: colors.primary, size: 28, isSelected: true),
                  const SizedBox(width: 10),
                  Text(
                    'Duas & Azkar',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          letterSpacing: -0.2,
                        ),
                  ),
                ],
              ),
            ),

            // Apple Search Input Bar
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

            // Category Filter Chips Bar
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
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 100),
                      itemCount: filteredDuas.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final dua = filteredDuas[index];
                        return Container(
                          decoration: ShapeDecoration(
                            color: colors.surface,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: BorderSide(color: colors.divider, width: 1.0),
                            ),
                          ),
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      dua.title,
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            color: colors.textPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    key: ValueKey('copy_button_${dua.id}'),
                                    icon: Icon(Icons.copy_rounded, size: 18, color: colors.textSecondary),
                                    tooltip: 'Copy Dua',
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () => _copyDuaToClipboard(dua),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    decoration: ShapeDecoration(
                                      color: colors.primarySoft,
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    child: Text(
                                      '${dua.repeatCount}x',
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            color: colors.primaryText,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Arabic Script
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  dua.arabic,
                                  style: AppTypography.quranicStyle(
                                    color: colors.textPrimary,
                                    fontSize: 22,
                                  ).copyWith(height: 1.8),
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Transliteration
                              Text(
                                dua.transliteration,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: colors.textSecondary,
                                      fontStyle: FontStyle.italic,
                                      height: 1.4,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              // English Translation
                              Text(
                                dua.translation,
                                style: AppTypography.quoteTranslationStyle(
                                  color: colors.textPrimary,
                                  fontSize: 15,
                                ).copyWith(height: 1.4),
                              ),
                              const SizedBox(height: 14),
                              // Source Caption
                              Row(
                                children: [
                                  Icon(Icons.bookmark_outline_rounded, size: 14, color: colors.textTertiary),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      dua.source,
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            color: colors.textTertiary,
                                            fontWeight: FontWeight.w500,
                                          ),
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
      ),
    );
  }
}

