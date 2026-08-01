import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/services/battery_service.dart';

/// Frosted-glass modal bottom sheet warning users when battery optimization is enabled on Android.
class BatteryOptimizationSheet extends StatelessWidget {
  final VoidCallback onFixPressed;
  final VoidCallback onRemindLaterPressed;
  final VoidCallback onDontAskAgainPressed;
  final String? oemGuidance;

  const BatteryOptimizationSheet({
    super.key,
    required this.onFixPressed,
    required this.onRemindLaterPressed,
    required this.onDontAskAgainPressed,
    this.oemGuidance,
  });

  /// Displays the modal bottom sheet using [showModalBottomSheet].
  static Future<T?> show<T>(
    BuildContext context, {
    required VoidCallback onFixPressed,
    required VoidCallback onRemindLaterPressed,
    required VoidCallback onDontAskAgainPressed,
    String? oemGuidance,
    String? manufacturer,
    BatteryService? batteryService,
  }) {
    final effectiveGuidance = oemGuidance ??
        (manufacturer != null && batteryService != null
            ? batteryService.getOemGuidance(manufacturer)
            : null);

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (sheetContext) => BatteryOptimizationSheet(
        onFixPressed: onFixPressed,
        onRemindLaterPressed: onRemindLaterPressed,
        onDontAskAgainPressed: onDontAskAgainPressed,
        oemGuidance: effectiveGuidance,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final textTheme = Theme.of(context).textTheme;

    return ClipPath(
      clipper: const ShapeBorderClipper(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: appColors.surface.withValues(alpha: 0.90),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Drag indicator handle
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: appColors.textTertiary.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Warning / battery icon
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: appColors.missedSoft,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.battery_alert_rounded,
                      size: 36,
                      color: appColors.missed,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    'Prayer alerts may be delayed',
                    style: textTheme.titleLarge?.copyWith(
                      color: appColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // Body text
                  Text(
                    'Battery optimization is on for Salah Companion. Some devices delay or block the adhan when this is enabled.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: appColors.textSecondary,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  // OEM guidance section (if provided)
                  if (oemGuidance != null && oemGuidance!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: appColors.elevatedBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: appColors.dividerStrong,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 20,
                            color: appColors.primary,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              oemGuidance!,
                              style: textTheme.bodySmall?.copyWith(
                                color: appColors.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Action Buttons
                  // Primary: Fix it
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: appColors.primary,
                        foregroundColor: Colors.white,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onFixPressed();
                      },
                      child: const Text(
                        'Disable Battery Optimization',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Secondary: Remind me later
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: appColors.textPrimary,
                        side: BorderSide(color: appColors.dividerStrong),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onRemindLaterPressed();
                      },
                      child: const Text(
                        'Remind me later',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Tertiary: Don't ask again
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: appColors.textSecondary,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onDontAskAgainPressed();
                      },
                      child: const Text(
                        "Don't ask again",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
