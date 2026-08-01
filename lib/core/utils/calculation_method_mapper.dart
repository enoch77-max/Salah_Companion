import 'package:adhan_dart/adhan_dart.dart';

/// Utility class to map ISO 2-letter country codes to standard prayer calculation parameters.
class CalculationMethodMapper {
  /// Maps a 2-letter ISO country code (e.g. "EG", "SA", "US") to [CalculationParameters].
  ///
  /// Defaults to [CalculationMethodParameters.muslimWorldLeague()] if the country code
  /// is unknown, null, or unsupported.
  static CalculationParameters getMethodForCountry(String? countryCode) {
    if (countryCode == null || countryCode.trim().isEmpty) {
      return CalculationMethodParameters.muslimWorldLeague();
    }

    final code = countryCode.trim().toUpperCase();
    switch (code) {
      case 'EG':
        return CalculationMethodParameters.egyptian();
      case 'SA':
        return CalculationMethodParameters.ummAlQura();
      case 'US':
      case 'CA':
        return CalculationMethodParameters.northAmerica();
      case 'PK':
      case 'IN':
      case 'BD':
        return CalculationMethodParameters.karachi();
      case 'AE':
        return CalculationMethodParameters.dubai();
      case 'TR':
        return CalculationMethodParameters.turkiye();
      case 'QA':
        return CalculationMethodParameters.qatar();
      case 'KW':
        return CalculationMethodParameters.kuwait();
      case 'SG':
        return CalculationMethodParameters.singapore();
      case 'FR':
        return CalculationMethodParameters.france();
      case 'ID':
        return CalculationMethodParameters.indonesian();
      case 'MA':
        return CalculationMethodParameters.morocco();
      case 'JO':
        return CalculationMethodParameters.jordan();
      case 'DZ':
        return CalculationMethodParameters.algerian();
      case 'TN':
        return CalculationMethodParameters.tunisia();
      case 'RU':
        return CalculationMethodParameters.russia();
      case 'PT':
        return CalculationMethodParameters.portugal();
      default:
        return CalculationMethodParameters.muslimWorldLeague();
    }
  }

  /// Maps a saved calculation method name string to [CalculationParameters], falling back
  /// to country-based default if null or unknown.
  static CalculationParameters getMethodByName(String? methodName, String? countryCode) {
    if (methodName != null && methodName.trim().isNotEmpty) {
      final name = methodName.trim();
      if (name.contains('Umm Al-Qura')) return CalculationMethodParameters.ummAlQura();
      if (name.contains('ISNA') || name.contains('North America')) return CalculationMethodParameters.northAmerica();
      if (name.contains('Egyptian')) return CalculationMethodParameters.egyptian();
      if (name.contains('Karachi')) return CalculationMethodParameters.karachi();
      if (name.contains('Muslim World League')) return CalculationMethodParameters.muslimWorldLeague();
      if (name.contains('Dubai')) return CalculationMethodParameters.dubai();
      if (name.contains('Turkiye') || name.contains('Turkey')) return CalculationMethodParameters.turkiye();
      if (name.contains('Qatar')) return CalculationMethodParameters.qatar();
      if (name.contains('Kuwait')) return CalculationMethodParameters.kuwait();
      if (name.contains('Singapore')) return CalculationMethodParameters.singapore();
      if (name.contains('France')) return CalculationMethodParameters.france();
      if (name.contains('Tehran')) return CalculationMethodParameters.tehran();
    }
    return getMethodForCountry(countryCode);
  }

  /// Maps a saved madhab string to [Madhab].
  static Madhab getMadhabByName(String? madhabName) {
    if (madhabName != null && madhabName.contains('Hanafi')) {
      return Madhab.hanafi;
    }
    return Madhab.shafi;
  }
}
