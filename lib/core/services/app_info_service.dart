import 'package:package_info_plus/package_info_plus.dart';

/// Centralized service for accessing dynamic application metadata & dynamic versioning.
class AppInfoService {
  static PackageInfo? _packageInfo;

  /// Fallback static version if platform channel is uninitialized (e.g. unit testing environment).
  static const String fallbackVersion = '1.0.17';
  static const String fallbackBuildNumber = '17';

  /// Initializes package info from platform channel.
  static Future<void> init() async {
    try {
      _packageInfo = await PackageInfo.fromPlatform();
    } catch (_) {
      // Graceful fallback for non-platform or test environments
    }
  }

  /// App Version String (e.g. "1.0.3")
  static String get version {
    return _packageInfo?.version ?? fallbackVersion;
  }

  /// App Build Number String (e.g. "3")
  static String get buildNumber {
    return _packageInfo?.buildNumber ?? fallbackBuildNumber;
  }

  /// Full formatted version string (e.g. "v1.0.3")
  static String get versionDisplay {
    return 'v$version';
  }

  /// Full formatted footer text (e.g. "Salah Companion v1.0.3 • Sahih Authentic")
  static String get drawerFooterText {
    return 'Salah Companion v$version • Sahih Authentic';
  }

  /// Settings full version string (e.g. "Salah Companion v1.0.3 (Build 3)")
  static String get settingsVersionText {
    return 'Salah Companion v$version (Build $buildNumber)';
  }
}
