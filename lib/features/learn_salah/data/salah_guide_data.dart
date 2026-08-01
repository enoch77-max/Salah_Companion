import '../domain/models/salah_learning_models.dart';

/// Comprehensive authentic Sunnah database for Learn Salah feature.
/// Grounded strictly in authentic Hadith (Sahih al-Bukhari, Sahih Muslim, Sunan Abi Dawud, etc.) & Quran.
class SalahGuideData {
  static const String propheticHadithQuote =
      '"Pray as you have seen me praying."\n— Prophet Muhammad ﷺ (Sahih al-Bukhari, Hadith 631)';

  // ---------------------------------------------------------------------------
  // STEP-BY-STEP PROPHETIC GUIDE (STEPS 0 TO 9)
  // ---------------------------------------------------------------------------
  static const List<SalahStep> propheticSteps = [
    // Step 0: Prerequisites
    SalahStep(
      stepNumber: 0,
      title: 'Preparing Your Heart & Body',
      subtitle: 'Prerequisites (Shuroot as-Salah)',
      postureKey: 'standing_niyyah',
      category: SalahRuleCategory.prerequisite,
      ruleTypeBadgeText: 'PREREQUISITE (SHURUT)',
      detailedInstruction:
          'Before stepping onto your prayer mat, you must fulfill internal and external purity conditions to stand before the Lord of the Worlds.',
      keyActionPoints: [
        'Taharah (Ritual Purity): Perform perfect Wudu (ablution) or Ghusl.',
        'Cleanliness: Clean body, clothing, and place of prayer from impurities.',
        'Covering Awrah: Navel to knees for men; entire body except face and hands for women.',
        'Facing Qiblah: Stand upright facing the direction of the Ka\'bah in Makkah.',
        'Intention (Niyyah): Resolve in your heart which prayer you are performing. Do NOT speak your intention aloud (uttering Niyyah audibly is Bid\'ah).',
      ],
      references: [
        ScripturalReference(
          title: 'Purification is Half of Faith',
          bookOrSurah: 'Sahih Muslim',
          citation: 'Sahih Muslim, Hadith 223',
          fullTextEnglish:
              'Abu Malik at-Ash\'ari reported: The Messenger of Allah ﷺ said: "Purity is half of faith and al-Hamdu lillahi (all praise be to Allah) fills the scale, and Subhan-Allah (Glory be to Allah) and al-Hamdu lillahi fill that which is between heaven and earth."',
          narrator: 'Abu Malik at-Ash\'ari (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Wudu Required for Validity of Salah',
          bookOrSurah: 'Sahih al-Bukhari & Sahih Muslim',
          citation: 'Sahih al-Bukhari, Hadith 6954 / Sahih Muslim, Hadith 225',
          fullTextEnglish:
              'Abu Hurairah reported: The Messenger of Allah ﷺ said: "Allah does not accept the prayer of any one of you who is in a state of impurity until he performs Wudu."',
          narrator: 'Abu Hurairah (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Prescribed Times of Salah',
          bookOrSurah: 'Surah An-Nisa',
          citation: 'Surah An-Nisa (4:103)',
          fullTextEnglish:
              'Indeed, the prayer has been enjoined upon the believers at prescribed times.',
          grade: 'Quran',
        ),
        ScripturalReference(
          title: 'Intention is Strictly an Act of the Heart',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 1',
          fullTextEnglish:
              'Omar bin Al-Khattab narrated: I heard Allah\'s Messenger ﷺ saying: "The reward of deeds depends upon the intentions and every person will get the reward according to what he has intended."',
          narrator: 'Omar bin Al-Khattab (RA)',
          grade: 'Sahih',
        ),
      ],
    ),

    // Step 1: Takbirat al-Ihram & Qiyam
    SalahStep(
      stepNumber: 1,
      title: 'Commencing with Majesty',
      subtitle: 'Takbirat al-Ihram & Qiyam',
      postureKey: 'raf_al_yadayn',
      category: SalahRuleCategory.pillar,
      ruleTypeBadgeText: 'PILLAR (FARD)',
      arabicRecitation: 'اللَّهُ أَكْبَرُ',
      transliteration: 'Allahu Akbar',
      englishTranslation: 'Allah is the Greatest.',
      detailedInstruction:
          'Stand upright facing the Qiblah. Raise both hands to the level of your shoulders or earlobes with palms facing the Qiblah, and audibly say "Allahu Akbar". Fold your right hand over your left hand, wrist, and forearm upon your chest.',
      keyActionPoints: [
        'Stand upright (Qiyam) for obligatory prayers if physically able.',
        'Fix your gaze down at the place of prostration (Sujud). Looking at the sky is strictly forbidden.',
        'Raise hands (Raf\' al-Yadayn) level with shoulders or earlobes.',
        'Say "Allahu Akbar" audibly to enter the sacred state of prayer.',
        'Place right hand over left hand, wrist, and forearm directly upon your chest.',
      ],
      references: [
        ScripturalReference(
          title: 'Command to Stand in Devotion',
          bookOrSurah: 'Surah Al-Baqarah',
          citation: 'Surah Al-Baqarah (2:238)',
          fullTextEnglish:
              'Maintain with care the prayers and [in particular] the middle prayer and stand before Allah with devotion.',
          grade: 'Quran',
        ),
        ScripturalReference(
          title: 'Opening Key to Prayer',
          bookOrSurah: 'Sunan Abi Dawud & Jami\' at-Tirmidhi',
          citation: 'Sunan Abi Dawud, Hadith 61 / Jami\' at-Tirmidhi, Hadith 3',
          fullTextEnglish:
              'Ali bin Abi Talib narrated that the Messenger of Allah ﷺ said: "The key to prayer is purification; its beginning is the Takbeer and its end is the Tasleem."',
          narrator: 'Ali bin Abi Talib (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Raising Hands & Folding on Chest',
          bookOrSurah: 'Sahih al-Bukhari & Sunan an-Nasa\'i',
          citation: 'Sahih al-Bukhari, Hadith 735 / Sunan an-Nasa\'i, Hadith 890',
          fullTextEnglish:
              'Wa\'il bin Hujr narrated: "I saw the Messenger of Allah ﷺ raise his hands when he entered into prayer and say Allahu Akbar... then he placed his right hand over his left hand, wrist, and lower forearm upon his chest."',
          narrator: 'Wa\'il bin Hujr (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Stern Warning Against Looking at Sky',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 750',
          fullTextEnglish:
              'Anas bin Malik narrated: The Prophet ﷺ said: "What is wrong with those people who look towards the sky during the prayer?" His talk grew stern until he said: "They should stop looking towards the sky during the prayer, otherwise their eyesight would be snatched away."',
          narrator: 'Anas bin Malik (RA)',
          grade: 'Sahih',
        ),
      ],
    ),

    // Step 2: The Recitations
    SalahStep(
      stepNumber: 2,
      title: 'The Divine Dialogue',
      subtitle: 'Opening Supplication & Surah Al-Fatiha',
      postureKey: 'qiyam_chest',
      category: SalahRuleCategory.pillar,
      ruleTypeBadgeText: 'PILLAR (FARD)',
      arabicRecitation:
          'سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ وَتَبَارَكَ اسْمُكَ وَتَعَالَى جَدُّكَ وَلَا إِلَهَ غَيْرُكَ\n\nأَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ\n\nبِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ\n\nالْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ ۝ الرَّحْمَنِ الرَّحِيمِ ۝ مَالِكِ يَوْمِ الدِّينِ ۝ إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ۝ اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ ۝ صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ\n\nآمين',
      transliteration:
          'Subhanakallahumma wa bihamdika wa tabarakasmuka wa ta\'ala jadduka wa la ilaha ghairuk.\n\nA\'udhu billahi minash-shaitanir-rajim.\n\nBismillah ar-Rahman ar-Rahim.\n\nAlhamdu lillahi Rabbil-\'alamin. Ar-Rahmanir-Rahim. Maliki Yawmid-Din. Iyyaka na\'budu wa iyyaka nasta\'in. Ihdinas-Siratal-Mustaqim. Siratal-ladhina an\'amta \'alayhim, ghayril-maghdubi \'alayhim wa lad-daallin.\n\nAmeen.',
      englishTranslation:
          'Glory and praise be to You, O Allah. Blessed is Your Name, exalted is Your Majesty, and there is no deity worthy of worship besides You.\n\nI seek refuge in Allah from Satan, the accursed.\n\nIn the Name of Allah, the Most Gracious, the Most Merciful.\n\nAll praise is for Allah—Lord of all worlds, the Most Compassionate, Most Merciful, Master of the Day of Judgment. You alone we worship and You alone we ask for help. Guide us on the Straight Path—the path of those You have blessed, not of those who incurred Your wrath, nor of those who are astray.\n\nAmeen (O Allah, answer our prayer).',
      detailedInstruction:
          'Silently recite Dua al-Istiftaah, seek refuge with Ta\'awwudh, silently say Basmalah, and then recite Surah Al-Fatiha in every Rakah. Pause after each verse. Say "Ameen" aloud after finishing Al-Fatiha. In the first two Rakahs, recite an additional Surah from the Quran.',
      keyActionPoints: [
        'Recite Opening Supplication (Dua al-Istiftaah) silently.',
        'Silently seek refuge from Shaitan (Ta\'awwudh) and say Bismillah (Basmalah).',
        'Recite Surah Al-Fatiha verse by verse in every single Rakah (Non-negotiable Pillar).',
        'Say "Ameen" aloud at the end of Al-Fatiha.',
        'Recite an additional Surah or passages from Quran in the first 2 Rakahs.',
      ],
      references: [
        ScripturalReference(
          title: 'Surah Al-Fatiha is an Essential Pillar of Salah',
          bookOrSurah: 'Sahih al-Bukhari & Sahih Muslim',
          citation: 'Sahih al-Bukhari, Hadith 756 / Sahih Muslim, Hadith 394',
          fullTextEnglish:
              'Ubadah bin as-Samit narrated: The Messenger of Allah ﷺ said: "There is no prayer for the one who does not recite the Opening of the Book (Surah Al-Fatiha)."',
          narrator: 'Ubadah bin as-Samit (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Saying Ameen with the Angels',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 780',
          fullTextEnglish:
              'Abu Hurairah narrated: Allah\'s Messenger ﷺ said: "When the Imam says: \'Ghairil-maghdubi alayhim walad-daalleen\', then say \'Ameen\', for if one\'s utterance of Ameen coincides with that of the angels, then his past sins will be forgiven."',
          narrator: 'Abu Hurairah (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Opening Supplication (Thana)',
          bookOrSurah: 'Sunan Abi Dawud & Jami\' at-Tirmidhi',
          citation: 'Sunan Abi Dawud, Hadith 775 / Jami\' at-Tirmidhi, Hadith 243',
          fullTextEnglish:
              'Aishah narrated: When the Messenger of Allah ﷺ started his prayer, he would say: "Subhanakallahumma wa bihamdika wa tabarakasmuka wa ta\'ala jadduka wa la ilaha ghairuk."',
          narrator: 'Aishah (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Seeking Refuge When Reciting Quran',
          bookOrSurah: 'Surah An-Nahl',
          citation: 'Surah An-Nahl (16:98)',
          fullTextEnglish:
              'So when you recite the Quran, [first] seek refuge in Allah from Satan, the expelled [from His mercy].',
          grade: 'Quran',
        ),
      ],
    ),

    // Step 3: Ruku'
    SalahStep(
      stepNumber: 3,
      title: 'Bowing in Humility',
      subtitle: 'Ruku\' & Tranquility',
      postureKey: 'ruku',
      category: SalahRuleCategory.pillar,
      ruleTypeBadgeText: 'PILLAR (FARD)',
      arabicRecitation: 'سُبْحَانَ رَبِّيَ الْعَظِيمِ',
      transliteration: 'Subhana Rabbiyal-\'Adheem',
      englishTranslation: 'Glory be to my Lord, the Supreme.',
      detailedInstruction:
          'Say "Allahu Akbar" and raise your hands for Raf\' al-Yadayn while descending into Ruku\'. Bend forward from your waist, keeping your back completely flat and your head level with your spine. Grasp your knees with fingers spread wide. Say "Subhana Rabbiyal-\'Adheem" (at least once obligatory, 3 times recommended). Achieve complete stillness (Tuma\'ninah).',
      keyActionPoints: [
        'Say "Allahu Akbar" and raise hands (Raf\' al-Yadayn) level with shoulders/ears.',
        'Bend at 90 degrees with a flat, straight back and head level with spine.',
        'Grasp knees firmly with fingers spread wide.',
        'Say "Subhana Rabbiyal-\'Adheem" at least once (3 times is Sunnah).',
        'Achieve absolute stillness (Tuma\'ninah); do not rush.',
      ],
      references: [
        ScripturalReference(
          title: 'Raf\' al-Yadayn Before Ruku\'',
          bookOrSurah: 'Sahih al-Bukhari & Sahih Muslim',
          citation: 'Sahih al-Bukhari, Hadith 735 / Sahih Muslim, Hadith 390a',
          fullTextEnglish:
              'Abdullah bin Omar narrated: I saw Allah\'s Messenger ﷺ opening the prayer with Takbir and raising his hands to his shoulders... and he did the same when he said Allahu Akbar for Ruku\' and when he raised his head from Ruku\'.',
          narrator: 'Abdullah bin Omar (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Command for Tasbeeh in Ruku\'',
          bookOrSurah: 'Sunan Abi Dawud',
          citation: 'Sunan Abi Dawud, Hadith 855',
          fullTextEnglish:
              'Uqbah bin Amir narrated: When "Glorify the name of your Lord, the Most Great" was revealed, the Messenger of Allah ﷺ told us: "Do so in your bowings."',
          narrator: 'Uqbah bin Amir (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Stillness (Tuma\'ninah) is Obligatory - Hadith of the Man Who Prayed Badly',
          bookOrSurah: 'Sahih al-Bukhari & Sahih Muslim',
          citation: 'Sahih al-Bukhari, Hadith 757 / Sahih Muslim, Hadith 397',
          fullTextEnglish:
              'Abu Hurairah narrated: A man entered the mosque and prayed, then came and greeted the Prophet ﷺ. The Prophet ﷺ returned the greeting and said: "Go back and pray, for you have not prayed." The man prayed again and returned, and the Prophet ﷺ repeated: "Go back and pray, for you have not prayed" three times. The man said: "By Him Who sent you with the truth, I cannot do better than this, so teach me." The Prophet ﷺ said: "...then bow until you are at ease in bowing, then rise until you stand straight..."',
          narrator: 'Abu Hurairah (RA)',
          grade: 'Sahih',
        ),
      ],
    ),

    // Step 4: I'tidal
    SalahStep(
      stepNumber: 4,
      title: 'Standing Straight in Praise',
      subtitle: 'I\'tidal & Qawmah',
      postureKey: 'itidal',
      category: SalahRuleCategory.pillar,
      ruleTypeBadgeText: 'PILLAR (FARD)',
      arabicRecitation:
          'سَمِعَ اللَّهُ لِمَنْ حَمِدَهُ\n\nرَبَّنَا وَلَكَ الْحَمْدُ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ',
      transliteration:
          'Sami\'allahu liman hamidah.\n\nRabbana wa lakal-hamd, hamdan kathiran tayyiban mubarakan fih.',
      englishTranslation:
          'Allah hears the one who praises Him.\n\nOur Lord, and to You belongs all praise—abundant, pure, and blessed praise.',
      detailedInstruction:
          'Rise up from bowing to a fully upright standing position while raising your hands for Raf\' al-Yadayn and saying "Sami\'allahu liman hamidah" (for Imam and solo worshipper). Once completely upright, say "Rabbana wa lakal-hamd". Pause until every vertebra returns to its natural place.',
      keyActionPoints: [
        'Rise up from Ruku\' while raising hands (Raf\' al-Yadayn).',
        'Say "Sami\'allahu liman hamidah" while rising.',
        'Stand completely straight and say "Rabbana wa lakal-hamd".',
        'Achieve complete stillness (Tuma\'ninah); rushing invalidates prayer.',
      ],
      references: [
        ScripturalReference(
          title: 'Rising and Praising Allah',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 735',
          fullTextEnglish:
              'Abdullah bin Omar narrated: "...and on raising his head from bowing he used to do the same (raise his hands) and say: \'Sami\'allahu liman hamidah, Rabbana wa lakal-hamd\'."',
          narrator: 'Abdullah bin Omar (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Standing Straight Until Vertebrae Settle',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 828',
          fullTextEnglish:
              'Abu Humaid as-Sa\'idi narrated describing the prayer of the Prophet ﷺ: "When he raised his head from bowing, he stood straight until every bone returned to its proper place."',
          narrator: 'Abu Humaid as-Sa\'idi (RA)',
          grade: 'Sahih',
        ),
      ],
    ),

    // Step 5: Sujud
    SalahStep(
      stepNumber: 5,
      title: 'The Ultimate Surrender',
      subtitle: 'Sujud on 7 Limbs',
      postureKey: 'sujood',
      category: SalahRuleCategory.pillar,
      ruleTypeBadgeText: 'PILLAR (FARD)',
      arabicRecitation: 'سُبْحَانَ رَبِّيَ الْأَعْلَى',
      transliteration: 'Subhana Rabbiyal-A\'laa',
      englishTranslation: 'Glory be to my Lord, the Most High.',
      detailedInstruction:
          'Say "Allahu Akbar" and descend into prostration without raising hands. Prostrate firmly on seven bones: forehead & nose (together), two palms, two knees, and the toes of both feet pointing toward Qiblah. Keep forearms elevated off the ground (do not lay them flat like a dog). Say "Subhana Rabbiyal-A\'laa" (at least once obligatory, 3 times recommended).',
      keyActionPoints: [
        'Say "Allahu Akbar" and descend into Sujud.',
        'Must prostrate firmly on 7 limbs: forehead & nose, 2 palms, 2 knees, 2 sets of toes.',
        'Keep elbows raised and away from body; never lay forearms flat on ground.',
        'Say "Subhana Rabbiyal-A\'laa" at least once (3 times is Sunnah).',
        'Achieve absolute stillness (Tuma\'ninah) in Sujud.',
      ],
      references: [
        ScripturalReference(
          title: 'Commandment to Prostrate on 7 Bones',
          bookOrSurah: 'Sahih al-Bukhari & Sahih Muslim',
          citation: 'Sahih al-Bukhari, Hadith 812 / Sahih Muslim, Hadith 1098',
          fullTextEnglish:
              'Ibn Abbas narrated: The Prophet ﷺ said: "I have been commanded to prostrate on seven bones: on the forehead—and he pointed to his nose—the two hands, the two knees, and the toes of both feet, and not to fold back the clothes or hair."',
          narrator: 'Ibn Abbas (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Prohibition of Spreading Arms Flat Like a Dog',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 822',
          fullTextEnglish:
              'Anas bin Malik narrated: The Prophet ﷺ said: "Straighten yourselves when doing Sujud, and none of you should put his forearms on the ground as a dog does."',
          narrator: 'Anas bin Malik (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Command for Tasbeeh in Sujud',
          bookOrSurah: 'Sahih Muslim & Sunan Abi Dawud',
          citation: 'Sahih Muslim, Hadith 771 / Sunan Abi Dawud, Hadith 855',
          fullTextEnglish:
              'Uqbah bin Amir narrated: When "Glorify the name of your Lord, the Most High" was revealed, the Messenger of Allah ﷺ told us: "Do so in your prostrations."',
          narrator: 'Uqbah bin Amir (RA)',
          grade: 'Sahih',
        ),
      ],
    ),

    // Step 6: Jalsah
    SalahStep(
      stepNumber: 6,
      title: 'Sitting Between Prostrations',
      subtitle: 'Jalsah & Supplication',
      postureKey: 'iftirash',
      category: SalahRuleCategory.pillar,
      ruleTypeBadgeText: 'PILLAR (FARD)',
      arabicRecitation: 'رَبِّ اغْفِرْ لِي، رَبِّ اغْفِرْ لِي',
      transliteration: 'Rabbigh-fir lee, Rabbigh-fir lee',
      englishTranslation: 'My Lord, forgive me. My Lord, forgive me.',
      detailedInstruction:
          'Say "Allahu Akbar" and sit up straight in the Iftirash posture (sit on your left foot while keeping your right foot propped upright with toes pointing Qiblah). Place hands on thighs and knees. Say "Rabbigh-fir lee" at least once. Achieve full tranquility before doing the second Sujud.',
      keyActionPoints: [
        'Say "Allahu Akbar" and sit up straight.',
        'Adopt Iftirash posture: sit on left foot, keep right foot upright.',
        'Place hands flat on knees/thighs.',
        'Say "Rabbigh-fir lee" (My Lord, forgive me) at least once.',
        'Perform second Sujud identically to the first.',
      ],
      references: [
        ScripturalReference(
          title: 'Iftirash Posture & Supplication Between Prostrations',
          bookOrSurah: 'Sunan Abi Dawud & Jami\' at-Tirmidhi',
          citation: 'Sunan Abi Dawud, Hadith 874 / Jami\' at-Tirmidhi, Hadith 284',
          fullTextEnglish:
              'Hudhayfah narrated that he prayed with the Prophet ﷺ, and between the two prostrations he would say: "Rabbigh-fir lee, Rabbigh-fir lee (My Lord, forgive me; My Lord, forgive me)."',
          narrator: 'Hudhayfah bin al-Yaman (RA)',
          grade: 'Sahih',
        ),
      ],
    ),

    // Step 7: Rising for Next Rakah
    SalahStep(
      stepNumber: 7,
      title: 'Rising for the Next Rakah',
      subtitle: 'Jalsah al-Istiraha & Rising',
      postureKey: 'standing_niyyah',
      category: SalahRuleCategory.sunnahAction,
      ruleTypeBadgeText: 'SUNNAH PRACTICE',
      detailedInstruction:
          'Upon rising from the second Sujud of the 1st or 3rd Rakah, pause briefly in a sitting posture of rest (Jalsah al-Istiraha) before standing up. Support yourself on the floor with your hands as you stand for the next Rakah. Perform subsequent Rakahs identically, omitting only opening Dua al-Istiftaah.',
      keyActionPoints: [
        'Sit briefly for rest (Jalsah al-Istiraha) before standing up.',
        'Support yourself with hands on ground while standing.',
        'Perform second Rakah identically to first (without repeating Thana).',
      ],
      references: [
        ScripturalReference(
          title: 'Sitting of Rest (Jalsah al-Istiraha)',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 828',
          fullTextEnglish:
              'Malik bin Huwairith as-Laythi reported that he saw the Prophet ﷺ praying, and when he was in an odd Rakah of his prayer, he did not stand up until he sat up straight.',
          narrator: 'Malik bin Huwairith (RA)',
          grade: 'Sahih',
        ),
      ],
    ),

    // Step 8: Tashahhud & Durood
    SalahStep(
      stepNumber: 8,
      title: 'The Sittings & Tashahhud',
      subtitle: 'Attahiyyaat, Index Finger & Salawat',
      postureKey: 'tashahhud_finger',
      category: SalahRuleCategory.pillar,
      ruleTypeBadgeText: 'PILLAR (FARD)',
      arabicRecitation:
          'التَّحِيَّاتُ لِلَّهِ وَالصَّلَوَاتُ وَالطَّيِّبَاتُ، السَّلَامُ عَلَيْكَ أَيُّهَا النَّبِيُّ وَرَحْمَةُ اللَّهِ وَبَرَكَاتُهُ، السَّلَامُ عَلَيْنَا وَعَلَى عِبَادِ اللَّهِ الصَّالِحِينَ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ\n\nاللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ، اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ',
      transliteration:
          'At-tahiyyatu lillahi was-salawatu wat-tayyibat, as-salamu \'alayka ayyuhan-Nabiyyu wa rahmatullahi wa barakatuh, as-salamu \'alayna wa \'ala \'ibadillahis-salihin. Ash-hadu an la ilaha illallahu wa ash-hadu anna Muhammadan \'abduhu wa Rasuluh.\n\nAllahumma salli \'ala Muhammadin wa \'ala ali Muhammadin kama sallayta \'ala Ibrahima wa \'ala ali Ibrahima innaka Hamidun Majid. Allahumma barik \'ala Muhammadin wa \'ala ali Muhammadin kama barakta \'ala Ibrahima wa \'ala ali Ibrahima innaka Hamidun Majid.',
      englishTranslation:
          'All compliments, prayers, and pure things are for Allah. Peace be upon you, O Prophet, and the mercy of Allah and His blessings. Peace be upon us and upon the righteous servants of Allah. I bear witness that there is no deity worthy of worship except Allah, and I bear witness that Muhammad is His servant and Messenger.\n\nO Allah, send prayers upon Muhammad and upon the family of Muhammad, as You sent prayers upon Ibrahim and upon the family of Ibrahim; You are indeed Praiseworthy, Most Glorious. O Allah, send blessings upon Muhammad and upon the family of Muhammad, as You sent blessings upon Ibrahim and upon the family of Ibrahim; You are indeed Praiseworthy, Most Glorious.',
      detailedInstruction:
          'In 3 or 4 Rakah prayers, sit in Iftirash after 2nd Rakah for First Tashahhud. In the Final Tashahhud, sit in Tawarruk posture (left thigh flat on ground, left foot under right leg, sitting on left buttock). Point right index finger toward Qiblah and move/shake it slightly throughout Tashahhud. Recite Salawat (Durood-e-Ibrahim) and seek refuge from 4 trials.',
      keyActionPoints: [
        'First Tashahhud: Sit in Iftirash posture after 2nd Rakah.',
        'Final Tashahhud: Sit in Tawarruk posture (left foot pushed out, sitting on buttock).',
        'Right index finger: Form a ring with thumb & middle finger, point and move index finger toward Qiblah.',
        'Recite Attahiyyaat and Salawat (Durood-e-Ibrahim).',
        'Seek refuge from 4 trials: Grave, Hellfire, Life & Death, Dajjal.',
      ],
      references: [
        ScripturalReference(
          title: 'Teaching of Tashahhud by Ibn Mas\'ud',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 835',
          fullTextEnglish:
              'Abdullah bin Mas\'ud narrated: Allah\'s Messenger ﷺ taught me the Tashahhud taking my hand between his hands... "At-tahiyyatu lillahi was-salawatu wat-tayyibat..."',
          narrator: 'Abdullah bin Mas\'ud (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Pointing & Moving Index Finger in Tashahhud',
          bookOrSurah: 'Sahih Muslim & Sunan an-Nasa\'i',
          citation: 'Sahih Muslim, Hadith 579a / Sunan an-Nasa\'i, Hadith 1219',
          fullTextEnglish:
              'Wa\'il bin Hujr narrated: "I saw the Prophet ﷺ raise his finger and move it, supplicating with it during Tashahhud."',
          narrator: 'Wa\'il bin Hujr (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Tawarruk Posture in Final Sitting',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 828',
          fullTextEnglish:
              'Abu Humaid as-Sa\'idi narrated: "In the final Rakah, the Prophet ﷺ pushed his left foot forward and sat on his left buttock in the Tawarruk position."',
          narrator: 'Abu Humaid as-Sa\'idi (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Seeking Refuge from 4 Trials After Salawat',
          bookOrSurah: 'Sahih al-Bukhari & Sahih Muslim',
          citation: 'Sahih al-Bukhari, Hadith 835 / Sahih Muslim, Hadith 1324',
          fullTextEnglish:
              'Abu Hurairah narrated: The Messenger of Allah ﷺ said: "When any one of you finishes the last Tashahhud, he should seek refuge with Allah from four things: From the punishment of Hell, from the punishment of the grave, from the trials of life and death, and from the evil of the Dajjal (Antichrist)."',
          narrator: 'Abu Hurairah (RA)',
          grade: 'Sahih',
        ),
      ],
    ),

    // Step 9: Taslim
    SalahStep(
      stepNumber: 9,
      title: 'Concluding with Peace',
      subtitle: 'Taslim Right & Left',
      postureKey: 'taslim',
      category: SalahRuleCategory.pillar,
      ruleTypeBadgeText: 'PILLAR (FARD)',
      arabicRecitation:
          'السَّلَامُ عَلَيْكُمْ وَرَحْمَةُ اللَّهِ\n\nالسَّلَامُ عَلَيْكُمْ وَرَحْمَةُ اللَّهِ',
      transliteration:
          'As-salamu \'alaykum wa rahmatullah.\n\nAs-salamu \'alaykum wa rahmatullah.',
      englishTranslation:
          'Peace and mercy of Allah be upon you.\n\nPeace and mercy of Allah be upon you.',
      detailedInstruction:
          'Turn your head fully to the right until the whiteness of your right cheek is visible to those behind you, saying "As-salamu \'alaykum wa rahmatullah". Then turn your head fully to the left and repeat the same. This concludes your prayer. Do NOT wave or point your hands while saying Salam.',
      keyActionPoints: [
        'Turn head right and say "As-salamu \'alaykum wa rahmatullah".',
        'Turn head left and say "As-salamu \'alaykum wa rahmatullah".',
        'Do NOT wave hands during Taslim (strictly prohibited in Sahih Muslim 431).',
        'Prayer is officially concluded.',
      ],
      references: [
        ScripturalReference(
          title: 'Taslim Concludes the Prayer',
          bookOrSurah: 'Sunan Abi Dawud & Jami\' at-Tirmidhi',
          citation: 'Sunan Abi Dawud, Hadith 61 / Jami\' at-Tirmidhi, Hadith 3',
          fullTextEnglish:
              'Ali bin Abi Talib narrated that the Messenger of Allah ﷺ said: "...and its end is the Tasleem."',
          narrator: 'Ali bin Abi Talib (RA)',
          grade: 'Sahih',
        ),
        ScripturalReference(
          title: 'Prohibition of Waving Hands During Taslim',
          bookOrSurah: 'Sahih Muslim',
          citation: 'Sahih Muslim, Hadith 431',
          fullTextEnglish:
              'Jabir bin Samurah narrated: The Messenger of Allah ﷺ came to us and said: "Why do I see you waving your hands as if they were the tails of headstrong horses? Be still in prayer!"',
          narrator: 'Jabir bin Samurah (RA)',
          grade: 'Sahih',
        ),
      ],
    ),
  ];

  // ---------------------------------------------------------------------------
  // THE 14 PILLARS OF SALAH (ARKAN AS-SALAH)
  // ---------------------------------------------------------------------------
  static const List<SalahCategoryItem> pillars = [
    SalahCategoryItem(
      id: 'pillar_1',
      name: 'Standing (Qiyam)',
      arabicName: 'القيام مع القدرة',
      description: 'Standing upright during obligatory prayers for those physically able.',
      postureKey: 'standing_niyyah',
      category: SalahRuleCategory.pillar,
      consequenceIfOmitted:
          'If omitted without genuine disability, the entire prayer becomes invalid.',
      references: [
        ScripturalReference(
          title: 'Command to Stand',
          bookOrSurah: 'Surah Al-Baqarah',
          citation: 'Surah Al-Baqarah (2:238)',
          fullTextEnglish: 'And stand before Allah with devotion.',
          grade: 'Quran',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'pillar_2',
      name: 'Opening Takbir (Takbirat al-Ihram)',
      arabicName: 'تكبيرة الإحرام',
      description: 'Audibly reciting "Allahu Akbar" to enter into the sacred state of prayer.',
      postureKey: 'raf_al_yadayn',
      category: SalahRuleCategory.pillar,
      consequenceIfOmitted: 'The prayer never commences; invalid.',
      references: [
        ScripturalReference(
          title: 'Takbeer Begins Prayer',
          bookOrSurah: 'Sunan Abi Dawud',
          citation: 'Sunan Abi Dawud, Hadith 61',
          fullTextEnglish: '...its beginning is the Takbeer and its end is the Tasleem.',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'pillar_3',
      name: 'Reciting Surah Al-Fatiha',
      arabicName: 'قراءة الفاتحة',
      description: 'Reciting Surah Al-Fatiha in every single Rakah.',
      postureKey: 'qiyam_chest',
      category: SalahRuleCategory.pillar,
      consequenceIfOmitted: 'Prayer is void without Al-Fatiha.',
      references: [
        ScripturalReference(
          title: 'No Prayer Without Al-Fatiha',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 756',
          fullTextEnglish: 'There is no prayer for the one who does not recite the Opening of the Book.',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'pillar_4',
      name: 'Bowing (Ruku\')',
      arabicName: 'الركوع',
      description: 'Bending forward with flat back and hands holding knees.',
      postureKey: 'ruku',
      category: SalahRuleCategory.pillar,
      consequenceIfOmitted: 'Invalidates Rakah; Sujood as-Sahw cannot compensate.',
      references: [
        ScripturalReference(
          title: 'Ruku\' in Prayer',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 793',
          fullTextEnglish: 'Then bow until you are at ease in bowing.',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'pillar_5',
      name: 'Rising from Bowing',
      arabicName: 'الرفع من الركوع',
      description: 'Elevating body back toward standing position.',
      postureKey: 'itidal',
      category: SalahRuleCategory.pillar,
      consequenceIfOmitted: 'Invalidates prayer.',
      references: [
        ScripturalReference(
          title: 'Rising from Bowing',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 828',
          fullTextEnglish: 'He would raise his head from bowing...',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'pillar_6',
      name: 'Standing Upright (I\'tidal)',
      arabicName: 'الاعتدال قائماً',
      description: 'Standing completely straight until joints settle before Sujud.',
      postureKey: 'itidal',
      category: SalahRuleCategory.pillar,
      consequenceIfOmitted: 'Rushing to Sujud without standing straight invalidates prayer.',
      references: [
        ScripturalReference(
          title: 'Standing Straight',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 757',
          fullTextEnglish: '...then raise your head and stand up straight...',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'pillar_7',
      name: 'Prostration (Sujud) on 7 Limbs',
      arabicName: 'السجود على الأعضاء السبعة',
      description: 'Placing forehead/nose, 2 palms, 2 knees, 2 sets of toes firmly on floor.',
      postureKey: 'sujood',
      category: SalahRuleCategory.pillar,
      consequenceIfOmitted: 'Invalidates prayer.',
      references: [
        ScripturalReference(
          title: '7 Bones Commandment',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 812',
          fullTextEnglish: 'I have been commanded to prostrate on seven bones...',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'pillar_8',
      name: 'Rising from Prostration',
      arabicName: 'الرفع من السجود',
      description: 'Elevating upper body from first Sujud.',
      postureKey: 'iftirash',
      category: SalahRuleCategory.pillar,
      consequenceIfOmitted: 'Invalidates prayer.',
      references: [
        ScripturalReference(
          title: 'Rising from Sujud',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 793',
          fullTextEnglish: 'Then raise your head until you sit comfortably...',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'pillar_9',
      name: 'Sitting Between Two Prostrations',
      arabicName: 'الجلسة بين السجدتين',
      description: 'Sitting calmly in Iftirash posture between the two Sujood.',
      postureKey: 'iftirash',
      category: SalahRuleCategory.pillar,
      consequenceIfOmitted: 'Invalidates prayer.',
      references: [
        ScripturalReference(
          title: 'Sitting Between Sujood',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 793',
          fullTextEnglish: '...and sit up at ease between the two prostrations.',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'pillar_10',
      name: 'Tranquility (Tuma\'ninah) in All Actions',
      arabicName: 'الطمأنينة في جميع الأفعال',
      description: 'Achieving stillness and calm in every position; do not rush.',
      postureKey: 'ruku',
      category: SalahRuleCategory.pillar,
      consequenceIfOmitted: 'Rushing renders the entire prayer legally void.',
      references: [
        ScripturalReference(
          title: 'Hadith of Musi\' al-Salat',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 757',
          fullTextEnglish: 'Go back and pray, for you have not prayed.',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'pillar_11',
      name: 'Final Tashahhud',
      arabicName: 'التشهد الأخير',
      description: 'Reciting Attahiyyaat supplication in the last sitting.',
      postureKey: 'tashahhud_finger',
      category: SalahRuleCategory.pillar,
      consequenceIfOmitted: 'Invalidates prayer.',
      references: [
        ScripturalReference(
          title: 'Final Tashahhud Command',
          bookOrSurah: 'Sahih Muslim',
          citation: 'Sahih Muslim, Hadith 403',
          fullTextEnglish: 'When one of you sits in prayer, let him say At-tahiyyatu lillahi...',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'pillar_12',
      name: 'Sitting for Final Tashahhud',
      arabicName: 'الجلوس للتشهد الأخير',
      description: 'Physical act of sitting in Tawarruk position for final Tashahhud.',
      postureKey: 'tawarruk',
      category: SalahRuleCategory.pillar,
      consequenceIfOmitted: 'Invalidates prayer.',
      references: [
        ScripturalReference(
          title: 'Sitting in Tawarruk',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 828',
          fullTextEnglish: 'In the final Rakah he sat on his left buttock in Tawarruk.',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'pillar_13',
      name: 'Salawat (Blessings on the Prophet ﷺ)',
      arabicName: 'الصلاة على النبي ﷺ',
      description: 'Reciting Durood-e-Ibrahim in the final sitting.',
      postureKey: 'tashahhud_finger',
      category: SalahRuleCategory.pillar,
      consequenceIfOmitted: 'Invalidates prayer.',
      references: [
        ScripturalReference(
          title: 'Durood Ibrahim',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 3369',
          fullTextEnglish: 'O Allah, send prayers upon Muhammad and upon the family of Muhammad...',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'pillar_14',
      name: 'Concluding Salam (Taslim)',
      arabicName: 'التسليم',
      description: 'Saying "As-salamu \'alaykum wa rahmatullah" to exit prayer.',
      postureKey: 'taslim',
      category: SalahRuleCategory.pillar,
      consequenceIfOmitted: 'Prayer is not exited legally; invalid.',
      references: [
        ScripturalReference(
          title: 'Tasleem Concludes Prayer',
          bookOrSurah: 'Sunan Abi Dawud',
          citation: 'Sunan Abi Dawud, Hadith 61',
          fullTextEnglish: '...and its end is the Tasleem.',
          grade: 'Sahih',
        ),
      ],
    ),
  ];

  // ---------------------------------------------------------------------------
  // THE 8 OBLIGATIONS OF SALAH (WAAJIBAAT AS-SALAH)
  // ---------------------------------------------------------------------------
  static const List<SalahCategoryItem> obligations = [
    SalahCategoryItem(
      id: 'ob_1',
      name: 'Transitional Takbirs',
      arabicName: 'جميع التكبيرات غير تكبيرة الإحرام',
      description: 'Saying "Allahu Akbar" when moving between positions.',
      postureKey: 'raf_al_yadayn',
      category: SalahRuleCategory.obligation,
      consequenceIfOmitted:
          'Deliberate omission invalidates prayer. Forgetfulness is compensated by Sujood as-Sahw.',
      references: [
        ScripturalReference(
          title: 'Transitional Takbirs',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 789',
          fullTextEnglish: 'The Prophet ﷺ used to recite Takbir when going down and standing up...',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'ob_2',
      name: 'The Tasmee\' (Sami\'allahu liman hamidah)',
      arabicName: 'قول: سمع الله لمن حمده',
      description: 'Saying "Sami\'allahu liman hamidah" when rising from Ruku\' (Imam & Solo).',
      postureKey: 'itidal',
      category: SalahRuleCategory.obligation,
      consequenceIfOmitted: 'Forgot = Sujood as-Sahw.',
      references: [
        ScripturalReference(
          title: 'Tasmee\' Citation',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 735',
          fullTextEnglish: 'On raising his head from bowing he used to say Sami\'allahu liman hamidah.',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'ob_3',
      name: 'The Tahmeed (Rabbanaa wa lakal-hamd)',
      arabicName: 'قول: ربنا ولك الحمد',
      description: 'Saying "Rabbanaa wa lakal-hamd" when standing upright.',
      postureKey: 'itidal',
      category: SalahRuleCategory.obligation,
      consequenceIfOmitted: 'Forgot = Sujood as-Sahw.',
      references: [
        ScripturalReference(
          title: 'Tahmeed Citation',
          bookOrSurah: 'Sahih Muslim',
          citation: 'Sahih Muslim, Hadith 390a',
          fullTextEnglish: 'When he stood upright he said Rabbana wa lakal-hamd.',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'ob_4',
      name: 'Glorification in Bowing (Tasbeeh Ruku\')',
      arabicName: 'قول: سبحان ربي العظيم في الركوع',
      description: 'Reciting "Subhana Rabbiyal-\'Adheem" at least once in Ruku\'.',
      postureKey: 'ruku',
      category: SalahRuleCategory.obligation,
      consequenceIfOmitted: 'Forgot = Sujood as-Sahw.',
      references: [
        ScripturalReference(
          title: 'Tasbeeh Ruku\' Command',
          bookOrSurah: 'Sunan Abi Dawud',
          citation: 'Sunan Abi Dawud, Hadith 855',
          fullTextEnglish: 'Do so in your bowings.',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'ob_5',
      name: 'Glorification in Prostration (Tasbeeh Sujud)',
      arabicName: 'قول: سبحان ربي الأعلى في السجود',
      description: 'Reciting "Subhana Rabbiyal-A\'laa" at least once in Sujud.',
      postureKey: 'sujood',
      category: SalahRuleCategory.obligation,
      consequenceIfOmitted: 'Forgot = Sujood as-Sahw.',
      references: [
        ScripturalReference(
          title: 'Tasbeeh Sujud Command',
          bookOrSurah: 'Sahih Muslim',
          citation: 'Sahih Muslim, Hadith 771',
          fullTextEnglish: 'Do so in your prostrations.',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'ob_6',
      name: 'Supplication Between Prostrations',
      arabicName: 'قول: رب اغفر لي بين السجدتين',
      description: 'Saying "Rabbigh-fir lee" at least once in Jalsah.',
      postureKey: 'iftirash',
      category: SalahRuleCategory.obligation,
      consequenceIfOmitted: 'Forgot = Sujood as-Sahw.',
      references: [
        ScripturalReference(
          title: 'Rabbigh-fir lee Citation',
          bookOrSurah: 'Sunan Abi Dawud',
          citation: 'Sunan Abi Dawud, Hadith 874',
          fullTextEnglish: 'Between the two prostrations he would say Rabbigh-fir lee.',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'ob_7',
      name: 'First Tashahhud',
      arabicName: 'التشهد الأول',
      description: 'Reciting Attahiyyaat in middle sitting of 3 or 4 Rakah prayer.',
      postureKey: 'tashahhud_finger',
      category: SalahRuleCategory.obligation,
      consequenceIfOmitted: 'Forgot = Sujood as-Sahw.',
      references: [
        ScripturalReference(
          title: 'First Tashahhud Citation',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 835',
          fullTextEnglish: 'Blessed salutations are for Allah...',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'ob_8',
      name: 'Sitting for First Tashahhud',
      arabicName: 'الجلوس للتشهد الأول',
      description: 'Physical act of sitting in middle Rakah for Tashahhud.',
      postureKey: 'iftirash',
      category: SalahRuleCategory.obligation,
      consequenceIfOmitted: 'Forgot = Sujood as-Sahw.',
      references: [
        ScripturalReference(
          title: 'Sitting for First Tashahhud',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 835',
          fullTextEnglish: 'The Prophet sat after 2 Rakahs for Tashahhud.',
          grade: 'Sahih',
        ),
      ],
    ),
  ];

  // ---------------------------------------------------------------------------
  // COMMON ERRORS TO AVOID
  // ---------------------------------------------------------------------------
  static const List<SalahCategoryItem> errorsToAvoid = [
    SalahCategoryItem(
      id: 'err_1',
      name: 'Audible Intention (Niyyah)',
      arabicName: 'التلفظ بالنية',
      description: 'Uttering spoken formulas of intention ("I intend to pray 4 Rakahs...").',
      postureKey: 'standing_niyyah',
      category: SalahRuleCategory.errorToAvoid,
      consequenceIfOmitted: 'Bid\'ah (Religious innovation); has no basis in Sunnah.',
      references: [
        ScripturalReference(
          title: 'Intention is Strictly in the Heart',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 1',
          fullTextEnglish: 'The reward of deeds depends upon the intentions...',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'err_2',
      name: 'Rushing & Lack of Tranquility',
      arabicName: 'النقار وعدم الطمأنينة',
      description: 'Pecking like a crow; rushing through bowing and prostrating.',
      postureKey: 'ruku',
      category: SalahRuleCategory.errorToAvoid,
      consequenceIfOmitted: 'Invalidates the entire prayer completely.',
      references: [
        ScripturalReference(
          title: 'Hadith of Musi\' al-Salat',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 757',
          fullTextEnglish: 'Go back and pray, for you have not prayed.',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'err_3',
      name: 'Spreading Forearms Flat Like a Dog',
      arabicName: 'انبساط الذراعين كالكلب',
      description: 'Laying forearms flat on the ground during Sujud.',
      postureKey: 'sujood',
      category: SalahRuleCategory.errorToAvoid,
      consequenceIfOmitted: 'Forbidden (Haram/Makrooh Tahrimi).',
      references: [
        ScripturalReference(
          title: 'Prohibition of Dog-like Sujud',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 822',
          fullTextEnglish: 'Never spread your arms on the ground as dogs do.',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'err_4',
      name: 'Looking at Sky or Wandering Eyes',
      arabicName: 'الالتفات ورَفْع البَصَر إِلَى السَّمَاء',
      description: 'Looking up at the ceiling/sky or side-to-side during prayer.',
      postureKey: 'standing_niyyah',
      category: SalahRuleCategory.errorToAvoid,
      consequenceIfOmitted: 'Risk having eyesight snatched away; Satan steals from prayer.',
      references: [
        ScripturalReference(
          title: 'Warning Against Looking at Sky',
          bookOrSurah: 'Sahih al-Bukhari',
          citation: 'Sahih al-Bukhari, Hadith 750',
          fullTextEnglish: 'Otherwise their eyesight would be snatched away.',
          grade: 'Sahih',
        ),
      ],
    ),
    SalahCategoryItem(
      id: 'err_5',
      name: 'Waving Hands During Taslim',
      arabicName: 'الإشارة باليدين عند التسليم',
      description: 'Waving or pointing hands to right/left while saying Salam.',
      postureKey: 'taslim',
      category: SalahRuleCategory.errorToAvoid,
      consequenceIfOmitted: 'Prohibited in Sahih Muslim 431.',
      references: [
        ScripturalReference(
          title: 'Prohibition of Waving Hands',
          bookOrSurah: 'Sahih Muslim',
          citation: 'Sahih Muslim, Hadith 431',
          fullTextEnglish: 'Why do I see you waving your hands as if they were tails of horses?',
          grade: 'Sahih',
        ),
      ],
    ),
  ];
}
