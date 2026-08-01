import 'dart:math' as math;

/// World Magnetic Model (WMM2025) Geomagnetic Field Calculator.
///
/// Computes Magnetic Declination (the angle between Magnetic North and True Geographic North)
/// anywhere on Earth for epochs 2025.0 through 2030.0 using standard WMM Gauss coefficients.
class GeomagneticCalculator {
  static const double _wgs84SemiMajorKm = 6378.137;
  static const double _wgs84Flattening = 1.0 / 298.257223563;
  static const double _wgs84SemiMinorKm =
      _wgs84SemiMajorKm * (1.0 - _wgs84Flattening);
  static const double _wgs84EccentricitySq =
      1.0 - (_wgs84SemiMinorKm * _wgs84SemiMinorKm) / (_wgs84SemiMajorKm * _wgs84SemiMajorKm);
  static const double _referenceRadiusKm = 6371.2;

  /// WMM2025 Gauss Coefficients (Epoch 2025.0, degrees n=1..6)
  /// [n, m, g (nT), h (nT), dg (nT/yr), dh (nT/yr)]
  static const List<List<double>> _wmm2025Coeffs = [
    [1, 0, -29404.5, 0.0, 6.7, 0.0],
    [1, 1, -1450.7, 4652.9, 7.7, -25.1],
    [2, 0, -2500.0, 0.0, -11.5, 0.0],
    [2, 1, 3022.6, -2991.6, -6.2, -7.1],
    [2, 2, 1676.8, -734.8, -6.9, -11.2],
    [3, 0, 1363.9, 0.0, 3.3, 0.0],
    [3, 1, -2381.0, -80.6, -3.3, 6.4],
    [3, 2, 1236.2, 251.7, -0.3, 1.3],
    [3, 3, 535.8, -547.4, -1.4, -12.1],
    [4, 0, 903.1, 0.0, -0.5, 0.0],
    [4, 1, 808.8, 282.8, -0.3, 0.8],
    [4, 2, -384.8, -234.4, -2.6, 2.6],
    [4, 3, -40.5, 70.0, 7.2, 2.0],
    [4, 4, -168.3, -311.6, -4.7, -1.4],
    [5, 0, -230.9, 0.0, -0.5, 0.0],
    [5, 1, 355.6, 47.5, 0.4, 0.4],
    [5, 2, 218.6, 141.7, 1.3, -0.7],
    [5, 3, -115.8, -123.5, -0.5, 1.8],
    [5, 4, -146.4, -107.0, -0.4, -0.8],
    [5, 5, -95.1, 108.4, 1.2, 0.7],
    [6, 0, 72.8, 0.0, -0.3, 0.0],
    [6, 1, 65.2, -20.5, -0.3, -0.6],
    [6, 2, 68.6, 25.2, 0.8, -0.9],
    [6, 3, -74.3, 67.8, 1.5, 0.4],
    [6, 4, -8.2, -60.1, -1.4, 1.2],
    [6, 5, 12.2, 8.8, -0.3, -0.4],
    [6, 6, -18.4, 19.4, 0.7, 0.2],
  ];

  /// Computes Magnetic Declination in degrees.
  /// Positive = East declination, Negative = West declination.
  static double calculateDeclination({
    required double latitude,
    required double longitude,
    double altitudeMeters = 0.0,
    DateTime? date,
  }) {
    final targetDate = date ?? DateTime.now();
    final yearFraction = targetDate.year +
        (targetDate.difference(DateTime(targetDate.year, 1, 1)).inDays / 365.25);
    final dt = yearFraction - 2025.0;

    final latRad = latitude * math.pi / 180.0;
    final lonRad = longitude * math.pi / 180.0;
    final altKm = altitudeMeters / 1000.0;

    // 1. Convert WGS84 Geodetic Coordinates to Geocentric Coordinates
    final sinLat = math.sin(latRad);
    final cosLat = math.cos(latRad);
    final rc = _wgs84SemiMajorKm /
        math.sqrt(1.0 - _wgs84EccentricitySq * sinLat * sinLat);
    final xp = (rc + altKm) * cosLat;
    final zp = (rc * (1.0 - _wgs84EccentricitySq) + altKm) * sinLat;
    final rKm = math.sqrt(xp * xp + zp * zp);
    final geocentricLatRad = math.atan2(zp, xp);
    final colatRad = (math.pi / 2.0) - geocentricLatRad;
    final psiRad = latRad - geocentricLatRad;

    final cosColat = math.cos(colatRad);
    final sinColat = math.sin(colatRad);

    const int maxDegree = 6;
    final p = List.generate(
        maxDegree + 1, (_) => List<double>.filled(maxDegree + 1, 0.0));
    final dp = List.generate(
        maxDegree + 1, (_) => List<double>.filled(maxDegree + 1, 0.0));

    p[0][0] = 1.0;
    dp[0][0] = 0.0;

    p[1][0] = cosColat;
    dp[1][0] = -sinColat;

    p[1][1] = sinColat;
    dp[1][1] = cosColat;

    for (int n = 2; n <= maxDegree; n++) {
      for (int m = 0; m <= n; m++) {
        if (n == m) {
          final double k = math.sqrt((2 * n - 1) / (2 * n));
          p[n][n] = k * sinColat * p[n - 1][n - 1];
          dp[n][n] = k * (cosColat * p[n - 1][n - 1] + sinColat * dp[n - 1][n - 1]);
        } else if (n == m + 1) {
          final double k = math.sqrt(2 * n - 1);
          p[n][m] = k * cosColat * p[n - 1][m];
          dp[n][m] = k * (-sinColat * p[n - 1][m] + cosColat * dp[n - 1][m]);
        } else {
          final double k1 = math.sqrt(((2 * n - 1) * (2 * n - 3)) / ((n - m) * (n + m)));
          final double k2 = math.sqrt(((n + m - 1) * (n - m - 1)) / ((n - m) * (n + m)));
          p[n][m] = k1 * cosColat * p[n - 1][m] - k2 * p[n - 2][m];
          dp[n][m] = k1 * (-sinColat * p[n - 1][m] + cosColat * dp[n - 1][m]) - k2 * dp[n - 2][m];
        }
      }
    }

    double bR = 0.0;
    double bTheta = 0.0;
    double bLambda = 0.0;

    final ratio = _referenceRadiusKm / rKm;

    final cosMlon = List<double>.filled(maxDegree + 1, 0.0);
    final sinMlon = List<double>.filled(maxDegree + 1, 0.0);
    for (int m = 0; m <= maxDegree; m++) {
      cosMlon[m] = math.cos(m * lonRad);
      sinMlon[m] = math.sin(m * lonRad);
    }

    for (final coeff in _wmm2025Coeffs) {
      final int n = coeff[0].toInt();
      final int m = coeff[1].toInt();
      final double g = coeff[2] + coeff[4] * dt;
      final double h = coeff[3] + coeff[5] * dt;

      final double currentRatioPower = math.pow(ratio, n + 2).toDouble();

      final double gcosHsin = g * cosMlon[m] + h * sinMlon[m];
      final double gsinHcos = -g * sinMlon[m] + h * cosMlon[m];

      bR += currentRatioPower * (n + 1) * gcosHsin * p[n][m];
      bTheta += currentRatioPower * gcosHsin * dp[n][m];
      if (sinColat != 0.0) {
        bLambda += currentRatioPower * m * gsinHcos * p[n][m] / sinColat;
      }
    }

    // Convert from Spherical Geocentric (-bTheta = North) to Geodetic (X=North, Y=East, Z=Down)
    final cosPsi = math.cos(psiRad);
    final sinPsi = math.sin(psiRad);
    final bx = bTheta * cosPsi + bR * sinPsi;
    final by = -bLambda;

    final declinationRad = math.atan2(by, bx);
    return declinationRad * 180.0 / math.pi;
  }
}
