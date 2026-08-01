import '../services/location_service.dart';

/// Utility class for formatting location names consistently in a single language.
///
/// Prevents mixed-language strings such as `"الدمام, Saudi Arabia"` by translating
/// city names and ISO country codes according to the target language locale.
abstract final class LocationFormatter {
  /// Country ISO 3166-1 alpha-2 code to English country name map.
  static const Map<String, String> countryNamesEnglish = {
    'SA': 'Saudi Arabia',
    'AE': 'United Arab Emirates',
    'EG': 'Egypt',
    'KW': 'Kuwait',
    'QA': 'Qatar',
    'BH': 'Bahrain',
    'OM': 'Oman',
    'JO': 'Jordan',
    'LB': 'Lebanon',
    'IQ': 'Iraq',
    'SY': 'Syria',
    'YE': 'Yemen',
    'PS': 'Palestine',
    'MA': 'Morocco',
    'DZ': 'Algeria',
    'TN': 'Tunisia',
    'LY': 'Libya',
    'SD': 'Sudan',
    'TR': 'Turkey',
    'PK': 'Pakistan',
    'IN': 'India',
    'BD': 'Bangladesh',
    'ID': 'Indonesia',
    'MY': 'Malaysia',
    'GB': 'United Kingdom',
    'US': 'United States',
    'CA': 'Canada',
    'AU': 'Australia',
    'DE': 'Germany',
    'FR': 'France',
  };

  /// Country ISO 3166-1 alpha-2 code to Arabic country name map.
  static const Map<String, String> countryNamesArabic = {
    'SA': 'المملكة العربية السعودية',
    'AE': 'الإمارات العربية المتحدة',
    'EG': 'مصر',
    'KW': 'الكويت',
    'QA': 'قطر',
    'BH': 'البحرين',
    'OM': 'سلطنة عُمان',
    'JO': 'الأردن',
    'LB': 'لبنان',
    'IQ': 'العراق',
    'SY': 'سوريا',
    'YE': 'اليمن',
    'PS': 'فلسطين',
    'MA': 'المغرب',
    'DZ': 'الجزائر',
    'TN': 'تونس',
    'LY': 'ليبيا',
    'SD': 'السودان',
    'TR': 'تركيا',
    'PK': 'باكستان',
    'IN': 'الهند',
    'BD': 'بنغلاديش',
    'ID': 'إندونيسيا',
    'MY': 'ماليزيا',
    'GB': 'المملكة المتحدة',
    'US': 'الولايات المتحدة الأمريكية',
    'CA': 'كندا',
    'AU': 'أستراليا',
    'DE': 'ألمانيا',
    'FR': 'فرنسا',
  };

  /// Common Arabic city names to English transliteration map.
  static const Map<String, String> arabicToEnglishCities = {
    'الدمام': 'Dammam',
    'الرياض': 'Riyadh',
    'جدة': 'Jeddah',
    'مكة': 'Makkah',
    'مكة المكرمة': 'Makkah',
    'المدينة': 'Madinah',
    'المدينة المنورة': 'Madinah',
    'الخبر': 'Khobar',
    'الظهران': 'Dhahran',
    'الهفوف': 'Hofuf',
    'الطائف': 'Taif',
    'تبوك': 'Tabuk',
    'بريدة': 'Buraidah',
    'خميس مشيط': 'Khamis Mushait',
    'أبها': 'Abha',
    'نجران': 'Najran',
    'جازان': 'Jizan',
    'حائل': 'Hail',
    'الجبيل': 'Jubail',
    'الخرج': 'Kharj',
    'ينبع': 'Yanbu',
    'القاهرة': 'Cairo',
    'الإسكندرية': 'Alexandria',
    'دبي': 'Dubai',
    'أبو ظبي': 'Abu Dhabi',
    'الشارقة': 'Sharjah',
    'الدوحة': 'Doha',
    'الكويت': 'Kuwait City',
    'مسقط': 'Muscat',
    'عمان': 'Amman',
    'بيروت': 'Beirut',
    'بغداد': 'Baghdad',
    'إسطنبول': 'Istanbul',
    'أنقرة': 'Ankara',
    'إسلام آباد': 'Islamabad',
    'كراتشي': 'Karachi',
    'لاهور': 'Lahore',
    'دكا': 'Dhaka',
    'جاكرتا': 'Jakarta',
    'كوالالمبور': 'Kuala Lumpur',
  };

  /// Regex detecting Arabic script characters (`\u0600` to `\u06FF`).
  static final RegExp _arabicScriptRegex = RegExp(r'[\u0600-\u06FF]');

  /// Checks whether a given string contains Arabic script.
  static bool containsArabic(String text) => _arabicScriptRegex.hasMatch(text);

  /// Formats a [LocationData] object into a clean, single-language string.
  ///
  /// Parameters:
  /// - [location]: The location data to format.
  /// - [languageCode]: Target language code (`'en'` or `'ar'`). Defaults to `'en'`.
  static String format(LocationData location, {String languageCode = 'en'}) {
    final rawCity = location.city?.trim();
    final rawCountry = location.countryName?.trim();
    final code = location.countryCode?.trim().toUpperCase();

    final isArabicTarget = languageCode.toLowerCase().startsWith('ar');

    String? formattedCity = rawCity;
    String? formattedCountry;

    if (isArabicTarget) {
      // 1. Target is ARABIC
      if (code != null && countryNamesArabic.containsKey(code)) {
        formattedCountry = countryNamesArabic[code];
      } else if (rawCountry != null && containsArabic(rawCountry)) {
        formattedCountry = rawCountry;
      } else {
        formattedCountry = rawCountry;
      }
    } else {
      // 2. Target is ENGLISH (default)
      // Resolve Country Name in English
      if (code != null && countryNamesEnglish.containsKey(code)) {
        formattedCountry = countryNamesEnglish[code];
      } else if (rawCountry != null && !containsArabic(rawCountry)) {
        formattedCountry = rawCountry;
      } else {
        formattedCountry = rawCountry;
      }

      // Resolve City Name in English (transliterate if city is in Arabic)
      if (rawCity != null) {
        if (arabicToEnglishCities.containsKey(rawCity)) {
          formattedCity = arabicToEnglishCities[rawCity];
        } else if (containsArabic(rawCity)) {
          // If city is Arabic but not in dictionary, attempt fallback or clean representation
          final cleanKey = rawCity.replaceAll('ال', '').trim();
          formattedCity = arabicToEnglishCities[cleanKey] ?? rawCity;
        }
      }
    }

    // Combine formatted city and country without mixing scripts
    if (formattedCity != null && formattedCity.isNotEmpty && formattedCountry != null && formattedCountry.isNotEmpty) {
      final cityIsArabic = containsArabic(formattedCity);
      final countryIsArabic = containsArabic(formattedCountry);

      // If scripts still mismatch, force country to match city script or format cleanly
      if (!isArabicTarget && cityIsArabic && !countryIsArabic) {
        // If city is in Arabic and could not be transliterated, show transliterated city or English country
        final transliterated = arabicToEnglishCities[formattedCity];
        if (transliterated != null) {
          return '$transliterated, $formattedCountry';
        }
        return formattedCountry;
      }

      final separator = isArabicTarget || cityIsArabic ? '، ' : ', ';
      return '$formattedCity$separator$formattedCountry';
    }

    if (formattedCity != null && formattedCity.isNotEmpty) {
      return formattedCity;
    }

    if (formattedCountry != null && formattedCountry.isNotEmpty) {
      return formattedCountry;
    }

    return 'Location Set';
  }
}
