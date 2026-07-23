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
}
