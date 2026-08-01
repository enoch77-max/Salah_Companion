import 'package:flutter/foundation.dart';

/// Enum representing the category of prayer instruction/rule.
enum SalahRuleCategory {
  prerequisite,
  pillar,
  obligation,
  sunnahVerbal,
  sunnahAction,
  errorToAvoid,
}

/// Scriptural proof reference (Quran Ayah or Hadith) with full untruncated text and citations.
@immutable
class ScripturalReference {
  final String title;
  final String bookOrSurah;
  final String citation; // e.g. "Sahih al-Bukhari 756" or "Surah Al-Baqarah 2:238"
  final String fullTextEnglish;
  final String? fullTextArabic;
  final String? narrator;
  final String grade; // e.g. "Sahih", "Hasan", "Quran"

  const ScripturalReference({
    required this.title,
    required this.bookOrSurah,
    required this.citation,
    required this.fullTextEnglish,
    this.fullTextArabic,
    this.narrator,
    this.grade = 'Sahih',
  });
}

/// Sequential Step in the Prophetic Salah Guide (Step 0 to Step 9).
@immutable
class SalahStep {
  final int stepNumber;
  final String title;
  final String subtitle;
  final String postureKey; // Key for 2D posture avatar painter
  final SalahRuleCategory category;
  final String? arabicRecitation;
  final String? transliteration;
  final String? englishTranslation;
  final String detailedInstruction;
  final List<String> keyActionPoints;
  final List<ScripturalReference> references;
  final String ruleTypeBadgeText; // "PILLAR (FARD)", "OBLIGATION (WAJIB)", "SUNNAH", "PREREQUISITE"

  const SalahStep({
    required this.stepNumber,
    required this.title,
    required this.subtitle,
    required this.postureKey,
    required this.category,
    this.arabicRecitation,
    this.transliteration,
    this.englishTranslation,
    required this.detailedInstruction,
    required this.keyActionPoints,
    required this.references,
    required this.ruleTypeBadgeText,
  });
}

/// Category detail item (Pillar, Obligation, Sunnah, or Error to Avoid).
@immutable
class SalahCategoryItem {
  final String id;
  final String name;
  final String arabicName;
  final String description;
  final String postureKey;
  final SalahRuleCategory category;
  final String consequenceIfOmitted;
  final List<ScripturalReference> references;

  const SalahCategoryItem({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.description,
    required this.postureKey,
    required this.category,
    required this.consequenceIfOmitted,
    required this.references,
  });
}
