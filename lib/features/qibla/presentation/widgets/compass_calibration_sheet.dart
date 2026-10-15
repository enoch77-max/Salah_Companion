import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Modal bottom sheet presenting the Qibla Compass Calibration Guide
/// with real-time sensor accuracy diagnosis, figure-8 motion instructions,
/// and sequential calibration steps.
class CompassCalibrationSheet extends StatelessWidget {
  final double? accuracy;

  const CompassCalibrationSheet({
    super.key,
    this.accuracy,
  });

  /// Presents the [CompassCalibrationSheet] as a styled modal bottom sheet.
  static Future<void> show(BuildContext context, {double? accuracy}) {
    final colors = context.appColors;
    return showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => CompassCalibrationSheet(accuracy: accuracy),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);

    final String accuracyLabel;
    final Color accuracyColor;
    if (accuracy == null || accuracy! < 0) {
      accuracyLabel =
          l10n?.qiblaAccuracyUncalibrated ?? 'Uncalibrated / Unknown';
      accuracyColor = colors.missed;
    } else if (accuracy! <= 15.0) {
      accuracyLabel = l10n?.qiblaAccuracyHigh ?? 'High Accuracy (Ready)';
      accuracyColor = colors.success;
    } else {
      accuracyLabel = l10n?.qiblaAccuracyMedium ?? 'Medium Accuracy';
      accuracyColor = const Color(0xFFF59E0B);
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 38,
            height: 4,
            decoration: BoxDecoration(
              color: colors.dividerStrong,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 18),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.vibration_rounded,
                color: colors.primary,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                l10n?.qiblaCalibGuideTitle ?? 'Compass Calibration Guide',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Sensor Accuracy Status Chip
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: accuracyColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: accuracyColor.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: accuracyColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  accuracyLabel,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: accuracyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Figure 8 Illustration Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
            decoration: ShapeDecoration(
              color: colors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: colors.cardBorder, width: 0.8),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.all_inclusive_rounded,
                  size: 52,
                  color: colors.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n?.qiblaCalibFigure8Instruction ??
                      'Wave your phone in a Figure-8 motion in the air 3 times',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Step-by-Step Instructions
          _CalibrationStepRow(
            stepNumber: '1',
            title:
                l10n?.qiblaCalibClearInterference ??
                'Clear Magnetic Interference',
            subtitle:
                l10n?.qiblaCalibClearInterferenceDesc ??
                'Step away from metal desks, computers, or magnetic phone covers.',
          ),
          const SizedBox(height: 10),
          _CalibrationStepRow(
            stepNumber: '2',
            title:
                l10n?.qiblaCalibHoldFlat ?? 'Hold Device Flat Horizontal',
            subtitle:
                l10n?.qiblaCalibHoldFlatDesc ??
                'Keep your phone flat horizontal parallel to the ground for peak precision.',
          ),
          const SizedBox(height: 10),
          _CalibrationStepRow(
            stepNumber: '3',
            title: l10n?.qiblaCalibFigure8 ?? 'Perform Figure-8 Sweep',
            subtitle:
                l10n?.qiblaCalibFigure8Desc ??
                'Sweep your phone smoothly along an 8-shaped loop in the air.',
          ),
          const SizedBox(height: 22),

          // Dismiss Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 13),
              ),
              child: Text(
                l10n?.qiblaCalibGotIt ?? 'Got It & Calibrated',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalibrationStepRow extends StatelessWidget {
  final String stepNumber;
  final String title;
  final String subtitle;

  const _CalibrationStepRow({
    required this.stepNumber,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: colors.primarySoft,
            shape: BoxShape.circle,
            border: Border.all(color: colors.primary.withValues(alpha: 0.3)),
          ),
          alignment: Alignment.center,
          child: Text(
            stepNumber,
            style: TextStyle(
              color: colors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
