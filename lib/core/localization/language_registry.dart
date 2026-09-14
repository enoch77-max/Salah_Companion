import 'dart:ui';

/// Representation of a supported language in Salah Companion.
class AppLanguage {
  final String code;
  final String nativeName;
  final String englishName;
  final bool isRTL;
  final String flag;

  const AppLanguage({
    required this.code,
    required this.nativeName,
    required this.englishName,
    this.isRTL = false,
    required this.flag,
  });

  Locale get locale => Locale(code);
}

/// Registry of all 19 supported languages in Salah Companion.
abstract final class LanguageRegistry {
  static const List<AppLanguage> supportedLanguages = [
    AppLanguage(
      code: 'ar',
      nativeName: 'العربية',
      englishName: 'Arabic',
      isRTL: true,
      flag: '🇸🇦',
    ),
    AppLanguage(
      code: 'en',
      nativeName: 'English',
      englishName: 'English',
      isRTL: false,
      flag: '🇬🇧',
    ),
    AppLanguage(
      code: 'ur',
      nativeName: 'اردو',
      englishName: 'Urdu',
      isRTL: true,
      flag: '🇵🇰',
    ),
    AppLanguage(
      code: 'fa',
      nativeName: 'فارسی',
      englishName: 'Persian',
      isRTL: true,
      flag: '🇮🇷',
    ),
    AppLanguage(
      code: 'bn',
      nativeName: 'বাংলা',
      englishName: 'Bengali',
      isRTL: false,
      flag: '🇧🇩',
    ),
    AppLanguage(
      code: 'tr',
      nativeName: 'Türkçe',
      englishName: 'Turkish',
      isRTL: false,
      flag: '🇹🇷',
    ),
    AppLanguage(
      code: 'id',
      nativeName: 'Bahasa Indonesia',
      englishName: 'Indonesian',
      isRTL: false,
      flag: '🇮🇩',
    ),
    AppLanguage(
      code: 'ms',
      nativeName: 'Bahasa Melayu',
      englishName: 'Malay',
      isRTL: false,
      flag: '🇲🇾',
    ),
    AppLanguage(
      code: 'kk',
      nativeName: 'Қазақша',
      englishName: 'Kazakh',
      isRTL: false,
      flag: '🇰🇿',
    ),
    AppLanguage(
      code: 'uz',
      nativeName: 'Oʻzbekcha',
      englishName: 'Uzbek',
      isRTL: false,
      flag: '🇺🇿',
    ),
    AppLanguage(
      code: 'ky',
      nativeName: 'Кыргызча',
      englishName: 'Kyrgyz',
      isRTL: false,
      flag: '🇰🇬',
    ),
    AppLanguage(
      code: 'az',
      nativeName: 'Azərbaycan',
      englishName: 'Azerbaijani',
      isRTL: false,
      flag: '🇦🇿',
    ),
    AppLanguage(
      code: 'bs',
      nativeName: 'Bosanski',
      englishName: 'Bosnian',
      isRTL: false,
      flag: '🇧🇦',
    ),
    AppLanguage(
      code: 'sq',
      nativeName: 'Shqip',
      englishName: 'Albanian',
      isRTL: false,
      flag: '🇦🇱',
    ),
    AppLanguage(
      code: 'sw',
      nativeName: 'Kiswahili',
      englishName: 'Swahili',
      isRTL: false,
      flag: '🇹🇿',
    ),
    AppLanguage(
      code: 'ru',
      nativeName: 'Русский',
      englishName: 'Russian',
      isRTL: false,
      flag: '🇷🇺',
    ),
    AppLanguage(
      code: 'hi',
      nativeName: 'हिन्दी',
      englishName: 'Hindi',
      isRTL: false,
      flag: '🇮🇳',
    ),
    AppLanguage(
      code: 'fr',
      nativeName: 'Français',
      englishName: 'French',
      isRTL: false,
      flag: '🇫🇷',
    ),
    AppLanguage(
      code: 'de',
      nativeName: 'Deutsch',
      englishName: 'German',
      isRTL: false,
      flag: '🇩🇪',
    ),
  ];

  /// Resolves the default language for the user based on device locale.
  /// If the device locale is one of the supported 19 languages, it is returned.
  /// Otherwise, English ('en') is returned.
  static AppLanguage resolveDeviceLanguage([Locale? deviceLocale]) {
    final locale = deviceLocale ?? PlatformDispatcher.instance.locale;
    final code = locale.languageCode.toLowerCase();
    return supportedLanguages.firstWhere(
      (lang) => lang.code == code,
      orElse: () => supportedLanguages.firstWhere((lang) => lang.code == 'en'),
    );
  }

  /// Finds an [AppLanguage] by its ISO 639-1 code. Defaults to English if not found.
  static AppLanguage getLanguage(String? code) {
    if (code == null) return getLanguage('en');
    return supportedLanguages.firstWhere(
      (lang) => lang.code == code.toLowerCase(),
      orElse: () => supportedLanguages.firstWhere((lang) => lang.code == 'en'),
    );
  }
}
