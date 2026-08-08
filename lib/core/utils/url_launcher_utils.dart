import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Centralized utility for reliably opening external web URLs with fallback mechanisms.
abstract class UrlLauncherUtils {
  /// Opens [urlString] in an external browser or application.
  /// Falls back to platform default launching, and if unsupported, copies the URL to clipboard with UI feedback.
  static Future<void> openUrl(BuildContext context, String urlString) async {
    final uri = Uri.parse(urlString);

    try {
      // 1. Primary Attempt: Launch external application/browser
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (launched) return;

      // 2. Secondary Fallback: Launch using platform default mode
      final launchedDefault = await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
      );

      if (launchedDefault) return;
    } catch (_) {
      // Catch any platform channel exception and fall through to clipboard copy
    }

    // 3. Ultimate Fallback: Copy URL to clipboard and show feedback SnackBar
    await Clipboard.setData(ClipboardData(text: urlString));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Copied URL to clipboard: $urlString'),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
