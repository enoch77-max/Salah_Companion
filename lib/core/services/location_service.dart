import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Represents geographical location and associated administrative details.
class LocationData {
  final double latitude;
  final double longitude;
  final String? city;
  final String? countryCode;
  final String? countryName;

  const LocationData({
    required this.latitude,
    required this.longitude,
    this.city,
    this.countryCode,
    this.countryName,
  });

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'city': city,
        'countryCode': countryCode,
        'countryName': countryName,
      };

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        city: json['city'] as String?,
        countryCode: json['countryCode'] as String?,
        countryName: json['countryName'] as String?,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationData &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          city == other.city &&
          countryCode == other.countryCode &&
          countryName == other.countryName;

  @override
  int get hashCode =>
      latitude.hashCode ^
      longitude.hashCode ^
      city.hashCode ^
      countryCode.hashCode ^
      countryName.hashCode;
}

/// Custom exception thrown when location fetching fails.
class LocationException implements Exception {
  final String message;
  const LocationException(this.message);

  @override
  String toString() => 'LocationException: $message';
}

/// Service for acquiring device location and reverse geocoding to city/country.
/// Includes local caching via [SharedPreferences] for offline startup fallback.
class LocationService {
  static const String _keyLat = 'location_cached_latitude';
  static const String _keyLng = 'location_cached_longitude';
  static const String _keyCity = 'location_cached_city';
  static const String _keyCountryCode = 'location_cached_country_code';
  static const String _keyCountryName = 'location_cached_country_name';

  final SharedPreferences? _prefs;

  LocationService([this._prefs]);

  Future<SharedPreferences> get _effectivePrefs async =>
      _prefs ?? await SharedPreferences.getInstance();

  /// Gets the current location from hardware GPS.
  /// Reverses geocode into city and ISO country code.
  /// Caches successful location locally for offline fallback.
  Future<LocationData> getCurrentLocation({
    PositionFetcher? positionFetcher,
    PlacemarkFetcher? placemarkFetcher,
  }) async {
    try {
      Position position;
      if (positionFetcher != null) {
        position = await positionFetcher();
      } else {
        final serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          final cached = await getCachedLocation();
          if (cached != null) return cached;
          throw const LocationException('Location services are disabled on the device.');
        }

        var permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            final cached = await getCachedLocation();
            if (cached != null) return cached;
            throw const LocationException('Location permissions were denied.');
          }
        }

        if (permission == LocationPermission.deniedForever) {
          final cached = await getCachedLocation();
          if (cached != null) return cached;
          throw const LocationException(
              'Location permissions are permanently denied. Please enable them in settings.');
        }

        position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            timeLimit: Duration(seconds: 15),
          ),
        );
      }

      String? city;
      String? countryCode;
      String? countryName;

      try {
        List<Placemark> placemarks;
        if (placemarkFetcher != null) {
          placemarks = await placemarkFetcher(position.latitude, position.longitude);
        } else {
          placemarks = await Geocoding().placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );
        }

        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          city = (place.locality?.trim().isNotEmpty ?? false)
              ? place.locality
              : ((place.subAdministrativeArea?.trim().isNotEmpty ?? false)
                  ? place.subAdministrativeArea
                  : place.administrativeArea);
          countryCode = place.isoCountryCode;
          countryName = place.country;
        }
      } catch (_) {
        // Reverse geocoding failed (e.g. offline). Fall back to cached address names if available.
        final cached = await getCachedLocation();
        if (cached != null) {
          city = cached.city;
          countryCode = cached.countryCode;
          countryName = cached.countryName;
        }
      }

      final location = LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        city: city,
        countryCode: countryCode,
        countryName: countryName,
      );

      await cacheLocation(location);
      return location;
    } catch (e) {
      if (e is LocationException) rethrow;
      final cached = await getCachedLocation();
      if (cached != null) return cached;
      throw LocationException('Failed to get location: $e');
    }
  }

  /// Caches [location] in SharedPreferences.
  Future<void> cacheLocation(LocationData location) async {
    final prefs = await _effectivePrefs;
    await prefs.setDouble(_keyLat, location.latitude);
    await prefs.setDouble(_keyLng, location.longitude);
    if (location.city != null) await prefs.setString(_keyCity, location.city!);
    if (location.countryCode != null) {
      await prefs.setString(_keyCountryCode, location.countryCode!);
    }
    if (location.countryName != null) {
      await prefs.setString(_keyCountryName, location.countryName!);
    }
  }

  /// Retrieves cached location from SharedPreferences. Returns null if none cached.
  Future<LocationData?> getCachedLocation() async {
    final prefs = await _effectivePrefs;
    final lat = prefs.getDouble(_keyLat);
    final lng = prefs.getDouble(_keyLng);

    if (lat == null || lng == null) {
      return null;
    }

    return LocationData(
      latitude: lat,
      longitude: lng,
      city: prefs.getString(_keyCity),
      countryCode: prefs.getString(_keyCountryCode),
      countryName: prefs.getString(_keyCountryName),
    );
  }
}

typedef PositionFetcher = Future<Position> Function();
typedef PlacemarkFetcher = Future<List<Placemark>> Function(double latitude, double longitude);
