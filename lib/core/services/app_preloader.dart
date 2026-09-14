import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../database/app_database.dart';

/// Pre-warming utility to ensure zero-jank app startup, font pre-fetching,
/// and instant SQLite connection readiness.
class AppPreloader {
  const AppPreloader();

  /// Pre-warms background runtime assets, fonts, and database singleton concurrently.
  static Future<void> prewarm() async {
    try {
      // 1. Pre-warm database instance singleton
      AppDatabase.instance();

      // 2. Pre-fetch primary Google Fonts asynchronously (safely catching offline/test environments)
      final bindingName = WidgetsBinding.instance.runtimeType.toString();
      if (!bindingName.contains('TestWidgetsFlutterBinding')) {
        // Run in background without unhandled rejections
        GoogleFonts.pendingFonts([
          GoogleFonts.inter(),
          GoogleFonts.amiri(),
          GoogleFonts.lora(fontStyle: FontStyle.italic),
          GoogleFonts.notoSansArabic(),
        ]).catchError((_) => <void>[]);
      }
    } catch (_) {
      // Pre-warming is opportunistic; errors should never block startup
    }
  }
}
