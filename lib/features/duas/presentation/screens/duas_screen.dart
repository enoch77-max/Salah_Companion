import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/presentation/widgets/dua_hands_icon.dart';
import '../../../../l10n/generated/app_localizations.dart';

class DuaItem {
  final String id;
  final String category;
  final String title;
  final String arabic;
  final String transliteration;
  final String translation;
  final String source;
  final int repeatCount;
  final Map<String, String>? titles;
  final Map<String, String>? translations;
  final Map<String, String>? sources;

  const DuaItem({
    required this.id,
    required this.category,
    required this.title,
    required this.arabic,
    required this.transliteration,
    required this.translation,
    required this.source,
    this.repeatCount = 1,
    this.titles,
    this.translations,
    this.sources,
  });

  String getLocalizedTitle(String langCode) {
    if (titles != null && titles!.containsKey(langCode)) {
      return titles![langCode]!;
    }
    return title;
  }

  String getLocalizedTranslation(String langCode) {
    if (translations != null && translations!.containsKey(langCode)) {
      return translations![langCode]!;
    }
    return translation;
  }

  String getLocalizedSource(String langCode) {
    if (sources != null && sources!.containsKey(langCode)) {
      return sources![langCode]!;
    }
    return source;
  }
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
      titles: {
        'bn': 'সকালের যিকির ও তাওহীদের ঘোষণা',
        'ur': 'صبح کے اذکار اور توحید کا اقرار',
        'tr': 'Sabah Zikri ve Tevhid',
        'ar': 'أذكار الصباح وإعلان التوحيد',
      },
      translations: {
        'bn': 'আমরা সকালে উপনীত হয়েছি এবং সমগ্র রাজত্বও আল্লাহর জন্য সকালে উপনীত হয়েছে। সমস্ত প্রশংসা একমাত্র আল্লাহর। আল্লাহ ব্যতীত কোনো সত্য উপাস্য নেই, তিনি এক, তাঁর কোনো অংশীদার নেই। রাজত্ব একমাত্র তাঁরই এবং সমস্ত প্রশংসাও তাঁরই। আর তিনি সর্ববিষয়ে সর্বশক্তিমান।',
        'ur': 'ہم نے صبح کی اور اللہ کے سارے ملک نے صبح کی اور ساری تعریف اللہ ہی کے لیے ہے، اللہ کے سوا کوئی معبود برحق نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں، اسی کی بادشاہی ہے اور اسی کے لیے تمام تعریفیں ہیں اور وہ ہر چیز پر قادر ہے۔',
        'tr': 'Sabaha erdik, mülk de Allah için sabaha erdi. Hamd Allah\'a mahsustur. Allah\'tan başka ilah yoktur, O tektir ve ortağı yoktur. Mülk O\'nundur, hamd O\'nadır ve O her şeye kadirdir.',
        'ar': 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ، لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
      },
      sources: {
        'bn': 'সহীহ মুসলিম ২৭২৩ (ইসলামিক ফাউন্ডেশন)',
        'ur': 'صحیح مسلم 2723 (دار السلام)',
        'tr': 'Sahih-i Müslim 2723 (Diyanet)',
        'ar': 'صحيح مسلم 2723',
      },
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
      titles: {
        'bn': 'সকল অনিষ্ট ও ক্ষতি থেকে রক্ষার দুয়া',
        'ur': 'ہر قسم کے نقصان سے حفاظت کی دعا',
        'tr': 'Her Türlü Zarardan Korunma Duası',
        'ar': 'الاستعاذة والحماية من كل ضرر',
      },
      translations: {
        'bn': 'আল্লাহর নামে, যাঁর নামের বরকতে আসমান ও জমিনের কোনো কিছুই কোনো ক্ষতি করতে পারে না। আর তিনি সর্বশ্রোতা, সর্বজ্ঞ।',
        'ur': 'اللہ کے نام کے ساتھ جس کے نام کی برکت سے زمین اور آسمان میں کوئی چیز نقصان نہیں پہنچا سکتی اور وہی خوب سننے والا، سب کچھ جاننے والا ہے۔',
        'tr': 'İsmiyle yerde ve gökte hiçbir şeyin zarar veremeyeceği Allah\'ın adıyla. O, hakkıyla işiten ve bilendir.',
        'ar': 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
      },
      sources: {
        'bn': 'সুনানে আবু দাউদ ৫০৮৮',
        'ur': 'سنن ابی داؤد 5088',
        'tr': 'Sünen-i Ebu Davud 5088',
        'ar': 'سنن أبي داود 5088',
      },
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
      titles: {
        'bn': 'সাইয়্যিদুল ইস্তিগফার (ক্ষমা প্রার্থনার শ্রেষ্ঠ দুয়া)',
        'ur': 'سید الاستغفار (توبہ و استغفار کی سب سے افضل دعا)',
        'tr': 'Seyyidü\'l-İstiğfar (En Faziletli Tövbe Duası)',
        'ar': 'سيد الاستغفار',
      },
      translations: {
        'bn': 'হে আল্লাহ! আপনিই আমার প্রতিপালক। আপনি ব্যতীত কোনো সত্য উপাস্য নেই। আপনি আমাকে সৃষ্টি করেছেন এবং আমি আপনার বান্দা। আমি আমার সাধ্যমতো আপনার অঙ্গীকার ও প্রতিশ্রুতির উপর প্রতিষ্ঠিত আছি। আমি আমার কৃতকর্মের অনিষ্ট থেকে আপনার নিকট আশ্রয় প্রার্থনা করছি। আমার প্রতি আপনার প্রদত্ত নিয়ামত স্বীকার করছি এবং আমার অপরাধ স্বীকার করছি। অতএব আমাকে ক্ষমা করে দিন, কেননা আপনি ব্যতীত পাপ ক্ষমা করার আর কেউ নেই।',
        'ur': 'اے اللہ! تو ہی میرا رب ہے، تیرے سوا کوئی معبود نہیں، تو نے ہی مجھے پیدا کیا اور میں تیرا بندہ ہوں اور میں اپنی طاقت کے مطابق تیرے عہد اور وعدے پر قائم ہوں۔ میں اپنے کیے کے شر سے تیری پناہ مانگتا ہوں، اپنے اوپر تیری نعمتوں کا اقرار کرتا ہوں اور اپنے گناہوں کا اعتراف کرتا ہوں، پس مجھے بخش دے، کیونکہ تیرے سوا گناہوں کو کوئی نہیں بخش سکتا۔',
        'tr': 'Allah\'ım! Sen benim Rabbimsin, Senden başka ilah yoktur. Beni Sen yarattın ve ben Senin kulunum. Gücüm yettiğince Sana verdiğim söz ve ahid üzerindeyim. Yaptıklarımın şerrinden Sana sığınırım. Üzerimdeki nimetini itiraf eder, günahımı da kabul ederim. Beni bağışla; çünkü günahları ancak Sen bağışlarsın.',
        'ar': 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَٰهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَىٰ عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
      },
      sources: {
        'bn': 'সহীহ বুখারী ৬৩০৬ (ইসলামিক ফাউন্ডেশন)',
        'ur': 'صحیح بخاری 6306 (دار السلام)',
        'tr': 'Sahih-i Buhari 6306 (Diyanet)',
        'ar': 'صحيح البخاري 6306',
      },
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
      titles: {
        'bn': 'সুস্থতা ও নিরাপত্তার দুয়া',
        'ur': 'صحت، عافیت اور سلامتی کی دعا',
        'tr': 'Beden ve Ruh Sağlığı İçin Dua',
        'ar': 'دعاء العافية في البدن والسمع والبصر',
      },
      translations: {
        'bn': 'হে আল্লাহ! আমার শরীর সুস্থ রাখুন। হে আল্লাহ! আমার শ্রবণশক্তি সুস্থ ও নিরাপদ রাখুন। হে আল্লাহ! আমার দৃষ্টিশক্তি সুস্থ রাখুন। আপনি ব্যতীত কোনো সত্য ইলাহ নেই।',
        'ur': 'اے اللہ! مجھے میرے بدن میں عافیت عطا فرما، اے اللہ! مجھے میری سماعت میں عافیت عطا فرما، اے اللہ! مجھے میری بصارت میں عافیت عطا فرما، تیرے سوا کوئی معبود برحق نہیں۔',
        'tr': 'Allah\'ım! Bedenime afiyet ver. Allah\'ım! Kulağıma afiyet ver. Allah\'ım! Gözüme afiyet ver. Senden başka ilah yoktur.',
        'ar': 'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَٰهَ إِلَّا أَنْتَ',
      },
      sources: {
        'bn': 'সুনানে আবু দাউদ ৫০৯০',
        'ur': 'سنن ابی داؤد 5090',
        'tr': 'Sünen-i Ebu Davud 5090',
        'ar': 'سنن أبي داود 5090',
      },
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
      titles: {
        'bn': 'সন্ধ্যার যিকির ও তাওহীদের ঘোষণা',
        'ur': 'شام کے اذکار اور توحید کا اقرار',
        'tr': 'Akşam Zikri ve Tevhid',
        'ar': 'أذكار المساء وإعلان التوحيد',
      },
      translations: {
        'bn': 'আমরা সন্ধ্যায় উপনীত হয়েছি এবং সমগ্র রাজত্বও আল্লাহর জন্য সন্ধ্যায় উপনীত হয়েছে। সমস্ত প্রশংসা আল্লাহর। আল্লাহ ব্যতীত কোনো সত্য উপাস্য নেই, তিনি এক, তাঁর কোনো শরিক নেই। রাজত্ব একমাত্র তাঁরই এবং সমস্ত প্রশংসাও তাঁরই। আর তিনি সর্ববিষয়ে সর্বশক্তিমান।',
        'ur': 'ہم نے شام کی اور اللہ کے سارے ملک نے شام کی اور ساری تعریف اللہ ہی کے لیے ہے، اللہ کے سوا کوئی معبود برحق نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں، اسی کی بادشاہی ہے اور اسی کے لیے تمام تعریفیں ہیں اور وہ ہر چیز پر قادر ہے۔',
        'tr': 'Akşama erdik, mülk de Allah için akşama erdi. Hamd Allah\'a mahsustur. Allah\'tan başka ilah yoktur, O tektir ve ortağı yoktur. Mülk O\'nundur, hamd O\'nadır ve O her şeye kadirdir.',
        'ar': 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ، لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
      },
      sources: {
        'bn': 'সহীহ মুসলিম ২৭২৩ (ইসলামিক ফাউন্ডেশন)',
        'ur': 'صحیح مسلم 2723 (دار السلام)',
        'tr': 'Sahih-i Müslim 2723 (Diyanet)',
        'ar': 'صحيح مسلم 2723',
      },
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
      titles: {
        'bn': 'আল্লাহর পরিপূর্ণ বাণীর আশ্রয়ে অনিষ্ট থেকে মুক্তি',
        'ur': 'اللہ کے مکمل کلمات کے ذریعے مخلوق کے شر سے پناہ',
        'tr': 'Kelimelerin Şifası ve Korunma',
        'ar': 'الاستعاذة بكلمات الله التامات',
      },
      translations: {
        'bn': 'আমি আল্লাহর পরিপূর্ণ বাক্যসমূহের সাহায্যে তাঁর সৃষ্টির সকল অনিষ্ট থেকে আশ্রয় চাই।',
        'ur': 'میں اللہ کے مکمل کلمات کی پناہ لیتا ہوں اس کی پیدا کی ہوئی چیزوں کے شر سے۔',
        'tr': 'Yarattığı şeylerin şerrinden Allah\'ın tastamam kelimelerine sığınırım.',
        'ar': 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
      },
      sources: {
        'bn': 'সহীহ মুসলিম ২৭০৯',
        'ur': 'صحیح مسلم 2709',
        'tr': 'Sahih-i Müslim 2709',
        'ar': 'صحيح مسلم 2709',
      },
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
      titles: {
        'bn': 'আয়াতুল কুরসী (সূরা আল-বাকারা ২:২৫৫)',
        'ur': 'آیۃ الکرسی (سورۃ البقرہ 2:255)',
        'tr': 'Âyetü\'l-Kürsî (Bakara Suresi 2:255)',
        'ar': 'آية الكرسي (سورة البقرة: 255)',
      },
      translations: {
        'bn': 'আল্লাহ, তিনি ব্যতীত কোনো সত্য উপাস্য নেই; তিনি চিরঞ্জীব, সর্বসত্তার ধারক। তন্দ্রা ও নিদ্রা তাঁকে স্পর্শ করে না। আসমান ও জমিনে যা কিছু আছে সবই তাঁর। কে আছে যে তাঁর অনুমতি ছাড়া তাঁর কাছে সুপারিশ করবে? তাদের সামনে ও পেছনে যা কিছু আছে তা তিনি জানেন। আর তাঁর ইচ্ছানুযায়ী যতটুকু তিনি প্রকাশ করেন, তা ছাড়া তাঁর জ্ঞানের কোনো কিছুই তারা পরিবেষ্টন করতে পারে না। তাঁর কুরসী সমস্ত আকাশ ও পৃথিবীকে পরিব্যাপ্ত করে আছে। আর এ দুটির রক্ষণাবেক্ষণ তাঁকে বিন্দুমাত্র ক্লান্ত করে না। তিনি পরম উচ্চ, মহামহিম।',
        'ur': 'اللہ، اس کے سوا کوئی معبود نہیں، وہ زندہ ہے سب کا سنبھالنے والا، نہ اسے اونگھ آتی ہے نہ نیند، اسی کا ہے جو کچھ آسمانوں میں ہے اور جو زمین میں ہے، کون ہے جو اس کی اجازت کے بغیر اس کے حضور سفارش کر سکے؟ وہ جانتا ہے جو کچھ ان کے آگے ہے اور جو کچھ ان کے پیچھے ہے، اور وہ اس کے علم میں سے کسی چیز کا احاطہ نہیں کر سکتے مگر جتنا وہ چاہے، اس کی کرسی آسمانوں اور زمین کو گھیرے ہوئے ہے، اور ان دونوں کی حفاظت اسے نہیں تھکاتی، اور وہ بہت بلند، بڑی عظمت والا ہے۔',
        'tr': 'Allah, O\'ndan başka ilah yoktur; O, Hayy\'dır, Kayyûm\'dur. Kendisine ne bir uyuklama ne de uyku gelir. Göklerde ve yerde ne varsa hepsi O\'nundur. İzni olmadan O\'nun katında kim şefaat edebilir? O, kullarının önlerindekini ve arkalarındakini bilir. Onlar ise O\'nun dilediği kadarından başka ilminden hiçbir şeyi kavrayamazlar. O\'nun kürsüsü gökleri ve yeri kaplamıştır. Onları koruyup gözetmek O\'na güç gelmez. O, çok yücedir, çok büyüktür.',
        'ar': 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ',
      },
      sources: {
        'bn': 'সূরা আল-বাকারা ২:২৫৫ (ইসলামিক ফাউন্ডেশন)',
        'ur': 'سورۃ البقرہ 2:255 (مولانا مودودی)',
        'tr': 'Bakara Suresi 2:255 (Diyanet Meali)',
        'ar': 'سورة البقرة: 255',
      },
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
      titles: {
        'bn': 'নামায পরবর্তী ক্ষমা ও শান্তির দুয়া',
        'ur': 'نماز کے بعد استغفار اور سلامتی کی دعا',
        'tr': 'Namaz Sonrası İstiğfar ve Selam',
        'ar': 'الاستغفار وطلب السلام بعد الصلاة',
      },
      translations: {
        'bn': 'আমি আল্লাহর নিকট ক্ষমা প্রার্থনা করছি (৩ বার)। হে আল্লাহ! আপনিই শান্তি এবং আপনার থেকেই শান্তি আসে। আপনি বরকতময়, হে মহিমাময় ও মর্যাদাবান প্রতিপালক!',
        'ur': 'میں اللہ سے مغفرت طلب کرتا ہوں (تین بار)۔ اے اللہ! تو ہی سلامتی والا ہے اور تیری ہی طرف سے سلامتی ہے، تو برکت والا ہے، اے بزرگی اور عزت والے!',
        'tr': 'Allah\'tan bağışlanma dilerim (3 kez). Allah\'ım! Sen selamsın, selamet de ancak Sendendir. Ey celal ve ikram sahibi! Sen yücelerden yücesin.',
        'ar': 'أَسْتَغْفِرُ اللَّهَ (ثَلَاثًا)، اللَّهُمَّ أَنْتَ السَّلَامُ وَمِنْكَ السَّلَامُ، تَبَارَكْتَ يَا ذَا الْجَلَالِ وَالْإِكْرَامِ',
      },
      sources: {
        'bn': 'সহীহ মুসলিম ৫৯১ (ইসলামিক ফাউন্ডেশন)',
        'ur': 'صحیح مسلم 591 (دار السلام)',
        'tr': 'Sahih-i Müslim 591 (Diyanet)',
        'ar': 'صحيح مسلم 591',
      },
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
      titles: {
        'bn': 'সুন্দরভাবে ইবাদতের তাওফীক প্রার্থনার দুয়া',
        'ur': 'عبادت اور شکر گزاری کی توفیق کی دعا',
        'tr': 'İbadet ve Şükür İçin Yardım Duası',
        'ar': 'دعاء الإعانة على الذكر والشكر وحسن العبادة',
      },
      translations: {
        'bn': 'হে আল্লাহ! আপনার স্মরণ, আপনার প্রতি কৃতজ্ঞতা প্রকাশ এবং সুন্দরভাবে আপনার ইবাদত করতে আমাকে সাহায্য করুন।',
        'ur': 'اے اللہ! اپنے ذکر، اپنے شکر اور اپنی بہترین عبادت پر میری مدد فرما۔',
        'tr': 'Allah\'ım! Seni anmak, Sana şükretmek ve Sana güzelce ibadet etmek konusunda bana yardım et.',
        'ar': 'اللَّهُمَّ أَعِنِّي عَلَىٰ ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ',
      },
      sources: {
        'bn': 'সুনানে আবু দাউদ ১৫২২',
        'ur': 'سنن ابی داؤد 1522',
        'tr': 'Sünen-i Ebu Davud 1522',
        'ar': 'سنن أبي داود 1522',
      },
    ),
    DuaItem(
      id: 'dua_after_prayer_4',
      category: 'After Prayer',
      title: 'Post-Salah Tasbih & Tahmid',
      arabic: 'سُبْحَانَ اللَّهِ (٣٣×)، وَالْحَمْدُ لِلَّهِ (٣٣×)، وَاللَّهُ أَكْبَرُ (٣٣×)، لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِিকَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
      transliteration: 'SubhanAllah (33x), Alhamdulillah (33x), Allahu Akbar (33x). La ilaha illallahu wahdahu la sharika lah, lahul-mulku wa lahul-hamdu wa Huwa \'ala kulli shay\'in Qadir.',
      translation: 'Glory be to Allah (33x), Praise be to Allah (33x), Allah is the Greatest (33x). There is no deity except Allah alone, without partner. To Him belongs the kingdom and all praise, and He has power over all things.',
      source: 'Sahih Muslim 597',
      repeatCount: 1,
      titles: {
        'bn': 'নামায পরবর্তী তসবিহ ও তাহমীদ',
        'ur': 'نماز کے بعد کی تسبیحات',
        'tr': 'Namaz Sonrası Tesbihler',
        'ar': 'التسبيح والتحميد بعد الصلاة',
      },
      translations: {
        'bn': 'আল্লাহ অতি পবিত্র (৩৩ বার), সমস্ত প্রশংসা আল্লাহর (৩৩ বার), আল্লাহ সর্বশ্রেষ্ঠ (৩৩ বার)। আল্লাহ ব্যতীত কোনো সত্য উপাস্য নেই, তিনি এক, তাঁর কোনো শরিক নেই। রাজত্ব একমাত্র তাঁরই এবং সমস্ত প্রশংসাও তাঁরই। আর তিনি সর্ববিষয়ে সর্বশক্তিমান।',
        'ur': 'اللہ پاک ہے (33 بار)، تمام تعریفیں اللہ کے لیے ہیں (33 بار)، اللہ سب سے بڑا ہے (33 بار)۔ اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں، اسی کے لیے بادشاہی ہے اور اسی کے لیے تعریف ہے، اور وہ ہر چیز پر قادر ہے۔',
        'tr': 'Allah\'ı noksan sıfatlardan tenzih ederim (33 kez), Hamd Allah\'a mahsustur (33 kez), Allah en büyüktür (33 kez). Allah\'tan başka ilah yoktur, O tektir, ortağı yoktur. Mülk O\'nundur, hamd O\'nadır ve O her şeye kadirdir.',
        'ar': 'سُبْحَانَ اللَّهِ (٣٣×)، وَالْحَمْدُ لِلَّهِ (٣٣×)، وَاللَّهُ أَكْبَرُ (٣٣×)، لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
      },
      sources: {
        'bn': 'সহীহ মুসলিম ৫৯৭ (ইসলামিক ফাউন্ডেশন)',
        'ur': 'صحیح مسلم 597 (دار السلام)',
        'tr': 'Sahih-i Müslim 597 (Diyanet)',
        'ar': 'صحيح مسلم 597',
      },
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
      titles: {
        'bn': 'তওবা ও ক্ষমা প্রার্থনার দুয়া',
        'ur': 'توبہ اور مغفرت کی مسنون دعا',
        'tr': 'Tövbe ve Bağışlanma Duası',
        'ar': 'دعاء التوبة والاستغفار',
      },
      translations: {
        'bn': 'হে আমার রব! আমাকে ক্ষমা করুন এবং আমার তওবা কবুল করুন, নিশ্চয়ই আপনি তওবা কবুলকারী, পরম দয়ালু।',
        'ur': 'اے میرے رب! مجھے بخش دے اور میری توبہ قبول فرما، بے شک تو ہی توبہ قبول کرنے والا، انتہائی رحم فرمانے والا ہے۔',
        'tr': 'Rabbim! Beni bağışla ve tövbemi kabul et. Şüphesiz Sen tövbeleri çokça kabul edensin, çok merhametlisin.',
        'ar': 'رَبِّ اغْفِرْ لِي وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيمُ',
      },
      sources: {
        'bn': 'সুনানে আবু দাউদ ১৫১৬',
        'ur': 'سنن ابی داؤد 1516',
        'tr': 'Sünen-i Ebu Davud 1516',
        'ar': 'سنن أبي داود 1516',
      },
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
      titles: {
        'bn': 'দোয়ায়ে ইউনুস (বিপদ-আপদ মুক্তির শ্রেষ্ঠ দুয়া)',
        'ur': 'دعائے یونس (تکلیف اور پریشانی میں نجات کی دعا)',
        'tr': 'Yunus (a.s.)\'ın Duası (Sıkıntı Anında)',
        'ar': 'دعاء ذي النون (يونس عليه السلام)',
      },
      translations: {
        'bn': 'আপনি ব্যতীত কোনো সত্য উপাস্য নেই, আপনি অতি পবিত্র! নিশ্চয়ই আমি অপরাধীদের অন্তর্ভুক্ত।',
        'ur': 'تیرے سوا کوئی معبود نہیں، تو پاک ہے، بے شک میں ہی ظالموں میں سے تھا۔',
        'tr': 'Senden başka ilah yoktur. Seni tenzih ederim. Şüphesiz ben zalimlerden oldum.',
        'ar': 'لَا إِلَٰهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ',
      },
      sources: {
        'bn': 'সূরা আল-আম্বিয়া ২১:৮৭ / তিরমিযী ৩৫০৫',
        'ur': 'سورۃ الانبیاء 21:87 / جامع ترمذی 3505',
        'tr': 'Enbiyâ Suresi 21:87 / Tirmizî 3505',
        'ar': 'سورة الأنبياء: 87 / سنن الترمذي 3505',
      },
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
      titles: {
        'bn': 'দুশ্চিন্তা, ঋণ ও অস্থিরতা থেকে মুক্তির দুয়া',
        'ur': 'پریشانی، غم، قرض اور بزدلی سے پناہ کی دعا',
        'tr': 'Kaygı, Hüzün ve Borçtan Kurtulma Duası',
        'ar': 'دعاء تفريج الهم والحزن والديْن',
      },
      translations: {
        'bn': 'হে আল্লাহ! নিশ্চয়ই আমি আপনার কাছে আশ্রয় চাই দুশ্চিন্তা ও দুঃখ-বেদনা থেকে, অক্ষমতা ও অলসতা থেকে, কৃপণতা ও কাপুরুষতা থেকে, ঋণের বোঝা এবং মানুষের দমন-পীড়ন থেকে।',
        'ur': 'اے اللہ! میں غم اور پریشانی سے، عاجزی اور سستی سے، بخل اور بزدلی سے، قرض کے بوجھ سے اور لوگوں کے دباؤ سے تیری پناہ مانگتا ہوں۔',
        'tr': 'Allah\'ım! Keder ve hüzünden, acizlik ve tembellikten, cimrilik ve korkaklıktan, borç yükünden ve insanların kahrından Sana sığınırım.',
        'ar': 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ، وَالْعَجْزِ وَالْكَسَلِ، وَالْبُخْلِ وَالْجُبْنِ، وَضَلَعِ الدَّيْنِ وَغَلَبَةِ الرِّجَالِ',
      },
      sources: {
        'bn': 'সহীহ বুখারী ৬৩৬৯ (ইসলামিক ফাউন্ডেশন)',
        'ur': 'صحیح بخاری 6369 (دار السلام)',
        'tr': 'Sahih-i Buhari 6369 (Diyanet)',
        'ar': 'صحيح البخاري 6369',
      },
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
      titles: {
        'bn': 'কঠিন বিপদ ও দুর্ভাগ্যের আক্রমণ থেকে আশ্রয়',
        'ur': 'سخت آزمائش اور بدبختی سے پناہ کی دعا',
        'tr': 'Ağır Belalardan ve Şerden Sığınma',
        'ar': 'الاستعاذة من جهد البلاء ودرك الشقاء',
      },
      translations: {
        'bn': 'হে আল্লাহ! আমি আপনার কাছে কঠিন বিপদ-মুসিবত, দুর্ভাগ্যের আক্রমণ, অশুভ পরিণতি এবং শত্রুর উপহাস থেকে আশ্রয় চাই।',
        'ur': 'اے اللہ! میں سخت آزمائش، بدبختی کے لاحق ہونے، بری تقدیر کے فیصلے اور دشمنوں کی خوشی سے تیری پناہ مانگتا ہوں۔',
        'tr': 'Allah\'ım! Dayanılmaz beladan, helak edici talihsizlikten, kötü kazadan ve düşmanların sevinmesinden Sana sığınırım.',
        'ar': 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ جَهْدِ الْبَلَاءِ، وَدَرَكِ الشَّقَاءِ، وَسُوءِ الْقَضَاءِ، وَشَمَاتَةِ الْأَعْدَاءِ',
      },
      sources: {
        'bn': 'সহীহ বুখারী ৬৩৪৭ (ইসলামিক ফাউন্ডেশন)',
        'ur': 'صحیح بخاری 6347 (دار السلام)',
        'tr': 'Sahih-i Buhari 6347 (Diyanet)',
        'ar': 'صحيح البخاري 6347',
      },
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
      titles: {
        'bn': 'খাবারের শুরুতে দুয়া',
        'ur': 'کھانے سے پہلے کی دعا',
        'tr': 'Yemekten Önce',
        'ar': 'الدعاء قبل الأكل',
      },
      translations: {
        'bn': 'আল্লাহর নামে শুরু করছি।',
        'ur': 'اللہ کے نام کے ساتھ۔',
        'tr': 'Allah\'ın adıyla.',
        'ar': 'بِسْمِ اللَّهِ',
      },
      sources: {
        'bn': 'সুনানে আবু দাউদ ৩৭৬৭',
        'ur': 'سنن ابی داؤد 3767',
        'tr': 'Sünen-i Ebu Davud 3767',
        'ar': 'سنن أبي داود 3767',
      },
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
      titles: {
        'bn': 'খাবার শেষের দুয়া ও শোকরিয়া',
        'ur': 'کھانے کے بعد کی دعا اور شکر گزاری',
        'tr': 'Yemekten Sonraki Şükür Duası',
        'ar': 'الدعاء بعد الفراغ من الطعام',
      },
      translations: {
        'bn': 'সমস্ত প্রশংসা আল্লাহর জন্য, যিনি আমাদেরকে খাওয়ালেন, পান করালেন এবং মুসলিম বানালেন।',
        'ur': 'سب تعریفیں اللہ ہی کے لیے ہیں جس نے ہمیں کھلایا اور پلایا اور ہمیں مسلمان بنایا۔',
        'tr': 'Bizi yediren, içiren ve bizi Müslüman kılan Allah\'a hamdolsun.',
        'ar': 'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنَا وَسَقَانَا وَجَعَلَنَا مُسْلِمِينَ',
      },
      sources: {
        'bn': 'জামে তিরমিযী ৩৪৫৮',
        'ur': 'جامع ترمذی 3458',
        'tr': 'Tirmizî 3458',
        'ar': 'سنن الترمذي 3458',
      },
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
      titles: {
        'bn': 'ঘুমানোর পূর্বের দুয়া',
        'ur': 'سونے سے پہلے کی مسنون دعا',
        'tr': 'Uyumadan Önceki Dua',
        'ar': 'الدعاء عند النوم',
      },
      translations: {
        'bn': 'হে আল্লাহ! আপনার নামে আমি মৃত্যুবরণ করি (ঘুমাই) এবং জীবিত হই (জাগ্রত হই)।',
        'ur': 'اے اللہ! میں تیرے نام کے ساتھ مرتا (سوتا) ہوں اور جیتا (جاگتا) ہوں۔',
        'tr': 'Allah\'ım! Senin isminle ölür (uyur) ve dirilirim (uyanırım).',
        'ar': 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
      },
      sources: {
        'bn': 'সহীহ বুখারী ৬৩১২ (ইসলামিক ফাউন্ডেশন)',
        'ur': 'صحیح بخاری 6312 (دار السلام)',
        'tr': 'Sahih-i Buhari 6312 (Diyanet)',
        'ar': 'صحيح البخاري 6312',
      },
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
      titles: {
        'bn': 'ঘুম থেকে জাগার দুয়া',
        'ur': 'نیند سے بیدار ہونے کی مسنون دعا',
        'tr': 'Uykudan Uyanınca Okunacak Dua',
        'ar': 'الدعاء عند الاستيقاظ من النوم',
      },
      translations: {
        'bn': 'সমস্ত প্রশংসা আল্লাহর জন্য, যিনি আমাদেরকে মৃত্যু (ঘুম) দেওয়ার পর পুনরায় জীবিত করলেন এবং তাঁর দিকেই সবার পুনরুত্থান।',
        'ur': 'تمام تعریفیں اللہ کے لیے ہیں جس نے ہمیں مارنے کے بعد زندہ کیا اور اسی کی طرف لوٹ کر جانا ہے۔',
        'tr': 'Bizi öldürdükten (uyuttuktan) sonra dirilten (uyandıran) Allah\'a hamdolsun. Dönüş de ancak O\'nadır.',
        'ar': 'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
      },
      sources: {
        'bn': 'সহীহ বুখারী ৬৩১২ (ইসলামিক ফাউন্ডেশন)',
        'ur': 'صحیح بخاری 6312 (دار السلام)',
        'tr': 'Sahih-i Buhari 6312 (Diyanet)',
        'ar': 'صحيح البخاري 6312',
      },
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
      titles: {
        'bn': 'যানবাহনে আরোহণের ও সফরের দুয়া',
        'ur': 'سفر اور سواری کی دعا',
        'tr': 'Yolculuk ve Vasıtaya Binme Duası',
        'ar': 'دعاء ركوب الدابة والسفر',
      },
      translations: {
        'bn': 'পবিত্র ও মহান সেই সত্তা, যিনি এটাকে আমাদের অনুগত করে দিয়েছেন, অথচ আমরা একে বশীভূত করতে সমর্থ ছিলাম না। আর নিশ্চয়ই আমরা আমাদের প্রতিপালকের দিকেই প্রত্যাবর্তনকারী।',
        'ur': 'پاک ہے وہ ذات جس نے اسے ہمارے قابو میں کر دیا حالانکہ ہم اسے قابو میں کرنے والے نہ تھے، اور بے شک ہم اپنے رب ہی کی طرف لوٹنے والے ہیں۔',
        'tr': 'Bunu bizim hizmetimize veren Allah\'ın şânı yücedir, yoksa bizim buna gücümüz yetmezdi. Şüphesiz biz Rabbimize döneceğiz.',
        'ar': 'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَٰذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ وَإِنَّا إِلَىٰ رَبِّنَا لَمُنْقَلِبُونَ',
      },
      sources: {
        'bn': 'সূরা আয-যুখরুফ ৪৩:১৩-১৪ / সহীহ মুসলিম ১৩৪২',
        'ur': 'سورۃ الزخرف 43:13-14 / صحیح مسلم 1342',
        'tr': 'Zuhruf Suresi 43:13-14 / Sahih-i Müslim 1342',
        'ar': 'سورة الزخرف: 13-14 / صحيح مسلم 1342',
      },
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

  String _getCategoryLabel(BuildContext context, String category) {
    final l10n = AppLocalizations.of(context);
    switch (category) {
      case 'All':
        return l10n?.categoryAll ?? 'All';
      case 'Morning':
        return l10n?.categoryMorning ?? 'Morning';
      case 'Evening':
        return l10n?.categoryEvening ?? 'Evening';
      case 'After Prayer':
        return l10n?.categoryAfterPrayer ?? 'After Prayer';
      case 'Forgiveness':
        return l10n?.categoryForgiveness ?? 'Forgiveness';
      case 'Protection':
        return l10n?.categoryProtection ?? 'Protection';
      case 'Daily':
        return l10n?.categoryDaily ?? 'Daily';
      case 'Travel':
        return l10n?.categoryTravel ?? 'Travel';
      default:
        return category;
    }
  }

  void _copyDuaToClipboard(DuaItem dua, String langCode) {
    final title = dua.getLocalizedTitle(langCode);
    final translation = dua.getLocalizedTranslation(langCode);
    final source = dua.getLocalizedSource(langCode);
    final textToCopy = '$title\n\n${dua.arabic}\n\n${dua.transliteration}\n\n$translation\n\nSource: $source';
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
    final l10n = AppLocalizations.of(context);
    final langCode = Localizations.localeOf(context).languageCode;

    final filteredDuas = DuasScreen.defaultDuas.where((dua) {
      final matchesCategory = _selectedCategory == 'All' || dua.category == _selectedCategory;
      final localizedTitle = dua.getLocalizedTitle(langCode);
      final localizedTranslation = dua.getLocalizedTranslation(langCode);
      final localizedSource = dua.getLocalizedSource(langCode);
      final matchesSearch = _searchQuery.isEmpty ||
          dua.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          localizedTitle.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          dua.transliteration.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          dua.translation.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          localizedTranslation.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          dua.source.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          localizedSource.toLowerCase().contains(_searchQuery.toLowerCase());
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
                    l10n?.navDuas ?? 'Duas & Azkar',
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
                  hintText: l10n?.searchPlaceholder ?? 'Search duas, translations, or sources...',
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
                    label: Text(_getCategoryLabel(context, category)),
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
                            l10n?.noSavedItems ?? 'No Duas Found',
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
                        final displayTitle = dua.getLocalizedTitle(langCode);
                        final displayTranslation = dua.getLocalizedTranslation(langCode);
                        final displaySource = dua.getLocalizedSource(langCode);

                        return RepaintBoundary(
                          child: Container(
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
                                        displayTitle,
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
                                      onPressed: () => _copyDuaToClipboard(dua, langCode),
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
                                // Scholarly Localized Translation
                                Text(
                                  displayTranslation,
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
                                        displaySource,
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
