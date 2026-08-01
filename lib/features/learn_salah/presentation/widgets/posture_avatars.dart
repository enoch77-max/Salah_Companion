import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 2D Faceless Vector Graphic Avatar demonstrating exact Prophetic Salah postures.
class PostureAvatarWidget extends StatelessWidget {
  final String postureKey;
  final double width;
  final double height;
  final Color? primaryColor;

  const PostureAvatarWidget({
    super.key,
    required this.postureKey,
    this.width = 160.0,
    this.height = 160.0,
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final avatarPrimary = primaryColor ?? (isDark ? const Color(0xFF10B981) : const Color(0xFF0D9488));
    final avatarBody = isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB);
    final avatarHead = isDark ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB);
    final matColor = isDark ? const Color(0xFFD97706).withValues(alpha: 0.25) : const Color(0xFFF59E0B).withValues(alpha: 0.35);

    final assetPath = _getAssetPath(postureKey);

    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: avatarPrimary.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        shadows: [
          BoxShadow(
            color: avatarPrimary.withValues(alpha: 0.08),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: assetPath != null
            ? Image.asset(
                assetPath,
                width: width,
                height: height,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => CustomPaint(
                  size: Size(width, height),
                  painter: _PostureAvatarPainter(
                    postureKey: postureKey,
                    primaryColor: avatarPrimary,
                    bodyColor: avatarBody,
                    headColor: avatarHead,
                    matColor: matColor,
                    isDark: isDark,
                  ),
                ),
              )
            : CustomPaint(
                size: Size(width, height),
                painter: _PostureAvatarPainter(
                  postureKey: postureKey,
                  primaryColor: avatarPrimary,
                  bodyColor: avatarBody,
                  headColor: avatarHead,
                  matColor: matColor,
                  isDark: isDark,
                ),
              ),
      ),
    );
  }

  static String? _getAssetPath(String key) {
    switch (key) {
      case 'standing_niyyah':
      case 'qiyam_chest':
        return 'assets/images/salah/standing_niyyah.png';
      case 'raf_al_yadayn':
      case 'itidal':
        return 'assets/images/salah/raf_al_yadayn.png';
      case 'ruku':
        return 'assets/images/salah/ruku.png';
      case 'sujood':
        return 'assets/images/salah/sujood.png';
      case 'iftirash':
      case 'tawarruk':
      case 'tashahhud_finger':
        return 'assets/images/salah/tashahhud_finger.png';
      case 'taslim':
        return 'assets/images/salah/taslim.png';
      default:
        return null;
    }
  }
}

class _PostureAvatarPainter extends CustomPainter {
  final String postureKey;
  final Color primaryColor;
  final Color bodyColor;
  final Color headColor;
  final Color matColor;
  final bool isDark;

  _PostureAvatarPainter({
    required this.postureKey,
    required this.primaryColor,
    required this.bodyColor,
    required this.headColor,
    required this.matColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Draw Prayer Mat on ground
    final matPaint = Paint()
      ..color = matColor
      ..style = PaintingStyle.fill;
    final matBorderPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final matPath = Path()
      ..moveTo(size.width * 0.15, size.height * 0.85)
      ..lineTo(size.width * 0.85, size.height * 0.85)
      ..lineTo(size.width * 0.90, size.height * 0.95)
      ..lineTo(size.width * 0.10, size.height * 0.95)
      ..close();

    canvas.drawPath(matPath, matPaint);
    canvas.drawPath(matPath, matBorderPaint);

    final mainPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    final bodyPaint = Paint()
      ..color = bodyColor
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final headPaint = Paint()
      ..color = headColor
      ..style = PaintingStyle.fill;

    final capPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    switch (postureKey.toLowerCase()) {
      case 'raf_al_yadayn':
        // Head
        canvas.drawCircle(Offset(cx, cy - 42), 14, headPaint);
        canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy - 44), radius: 14.5), math.pi, math.pi, true, capPaint);

        // Body (Robe / Thobe)
        final bodyPath = Path()
          ..moveTo(cx - 18, cy - 25)
          ..lineTo(cx + 18, cy - 25)
          ..lineTo(cx + 24, cy + 40)
          ..lineTo(cx - 24, cy + 40)
          ..close();
        canvas.drawPath(bodyPath, bodyPaint);

        // Raised Arms for Raf' al-Yadayn (Level with shoulders/earlobes, NOT above head)
        final armLeft = Path()
          ..moveTo(cx - 18, cy - 20)
          ..lineTo(cx - 28, cy - 28)
          ..lineTo(cx - 28, cy - 42);
        canvas.drawPath(armLeft, strokePaint);

        final armRight = Path()
          ..moveTo(cx + 18, cy - 20)
          ..lineTo(cx + 28, cy - 28)
          ..lineTo(cx + 28, cy - 42);
        canvas.drawPath(armRight, strokePaint);

        // Raised Open Palms level with earlobes
        canvas.drawCircle(Offset(cx - 28, cy - 42), 4.5, mainPaint);
        canvas.drawCircle(Offset(cx + 28, cy - 42), 4.5, mainPaint);
        break;

      case 'qiyam_chest':
        // Head
        canvas.drawCircle(Offset(cx, cy - 42), 14, headPaint);
        canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy - 44), radius: 14.5), math.pi, math.pi, true, capPaint);

        // Body
        final bodyPath = Path()
          ..moveTo(cx - 18, cy - 25)
          ..lineTo(cx + 18, cy - 25)
          ..lineTo(cx + 24, cy + 40)
          ..lineTo(cx - 24, cy + 40)
          ..close();
        canvas.drawPath(bodyPath, bodyPaint);

        // Folded Arms on Chest (Right over Left on Chest)
        final foldedArms = Path()
          ..moveTo(cx - 18, cy - 18)
          ..lineTo(cx - 8, cy - 5)
          ..lineTo(cx + 18, cy - 5)
          ..lineTo(cx + 18, cy - 18)
          ..moveTo(cx + 18, cy - 18)
          ..lineTo(cx - 14, cy - 5);
        canvas.drawPath(foldedArms, strokePaint);

        // Highlight box over chest
        canvas.drawCircle(Offset(cx, cy - 5), 8, mainPaint);
        break;

      case 'ruku':
        // 90-Degree Flat Bowing
        // Legs standing
        final legsPath = Path()
          ..moveTo(cx + 20, cy + 40)
          ..lineTo(cx + 20, cy + 5)
          ..lineTo(cx + 5, cy + 5)
          ..lineTo(cx + 5, cy + 40);
        canvas.drawPath(legsPath, strokePaint);

        // Horizontal Spine & Back
        final bodyPath = Path()
          ..moveTo(cx + 20, cy + 5)
          ..lineTo(cx - 35, cy + 5)
          ..lineTo(cx - 35, cy - 12)
          ..lineTo(cx + 20, cy - 12)
          ..close();
        canvas.drawPath(bodyPath, bodyPaint);

        // Head level with spine
        canvas.drawCircle(Offset(cx - 52, cy - 3), 13, headPaint);

        // Arms reaching to knees
        final armPath = Path()
          ..moveTo(cx - 25, cy - 5)
          ..lineTo(cx + 15, cy + 8);
        canvas.drawPath(armPath, strokePaint);

        // Highlight flat spine line
        canvas.drawLine(Offset(cx - 45, cy - 14), Offset(cx + 25, cy - 14), strokePaint..color = primaryColor);
        break;

      case 'itidal':
        // Standing Straight after Ruku
        canvas.drawCircle(Offset(cx, cy - 42), 14, headPaint);
        canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy - 44), radius: 14.5), math.pi, math.pi, true, capPaint);

        final bodyPath = Path()
          ..moveTo(cx - 18, cy - 25)
          ..lineTo(cx + 18, cy - 25)
          ..lineTo(cx + 24, cy + 40)
          ..lineTo(cx - 24, cy + 40)
          ..close();
        canvas.drawPath(bodyPath, bodyPaint);

        // Arms at side or slightly raised
        canvas.drawLine(Offset(cx - 18, cy - 20), Offset(cx - 26, cy + 10), strokePaint);
        canvas.drawLine(Offset(cx + 18, cy - 20), Offset(cx + 26, cy + 10), strokePaint);
        break;

      case 'sujood':
        // Prostration on 7 Limbs
        // Forehead & Nose on ground (Left side)
        canvas.drawCircle(Offset(cx - 42, cy + 26), 12, headPaint);

        // Body arched up in Sujud
        final sujudBody = Path()
          ..moveTo(cx - 40, cy + 20)
          ..cubicTo(cx - 30, cy - 20, cx + 10, cy - 25, cx + 25, cy + 10)
          ..lineTo(cx + 35, cy + 30)
          ..lineTo(cx - 45, cy + 30)
          ..close();
        canvas.drawPath(sujudBody, bodyPaint);

        // Elevated Arm / Elbow off ground
        final sujudArm = Path()
          ..moveTo(cx - 30, cy + 15)
          ..lineTo(cx - 20, cy + 2)
          ..lineTo(cx - 35, cy + 28);
        canvas.drawPath(sujudArm, strokePaint);

        // 7 Bones indicators (7 small golden glow spots)
        final bones = [
          Offset(cx - 46, cy + 30), // Forehead/Nose
          Offset(cx - 35, cy + 30), // Palms
          Offset(cx - 5, cy + 30),  // Knees
          Offset(cx + 35, cy + 30), // Toes
        ];
        for (final b in bones) {
          canvas.drawCircle(b, 4, mainPaint);
        }
        break;

      case 'iftirash':
      case 'tawarruk':
      case 'tashahhud_finger':
        // Extreme Close-up: Right Hand Resting on Knee with Raised Index Finger
        // 1. White Thobe Knee / Thigh background fabric
        final kneeFabric = Path()
          ..moveTo(0, size.height * 0.45)
          ..cubicTo(size.width * 0.3, size.height * 0.35, size.width * 0.7, size.height * 0.35, size.width, size.height * 0.45)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();

        final fabricPaint = Paint()
          ..color = isDark ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6)
          ..style = PaintingStyle.fill;
        canvas.drawPath(kneeFabric, fabricPaint);

        final fabricBorder = Paint()
          ..color = primaryColor.withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
        canvas.drawPath(kneeFabric, fabricBorder);

        // 2. Sleeve (White Thobe cuff coming from top left)
        final sleevePath = Path()
          ..moveTo(size.width * 0.05, size.height * 0.20)
          ..lineTo(size.width * 0.35, size.height * 0.35)
          ..lineTo(size.width * 0.28, size.height * 0.48)
          ..lineTo(size.width * 0.0, size.height * 0.32)
          ..close();
        final sleevePaint = Paint()
          ..color = isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB)
          ..style = PaintingStyle.fill;
        canvas.drawPath(sleevePath, sleevePaint);

        // 3. Right Hand & Clenched Fist resting on knee
        // Clenched fingers (Pinky, Ring, Middle, Thumb)
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(size.width * 0.30, size.height * 0.40, size.width * 0.32, size.height * 0.22),
            const Radius.circular(12),
          ),
          bodyPaint,
        );

        // Thumb forming ring with middle finger
        canvas.drawCircle(Offset(size.width * 0.42, size.height * 0.52), 10, headPaint);

        // 4. Extended & Raised Index Finger pointing towards Qiblah
        final indexFingerPath = Path()
          ..moveTo(size.width * 0.38, size.height * 0.40)
          ..lineTo(size.width * 0.78, size.height * 0.32) // Extended straight forward
          ..lineTo(size.width * 0.76, size.height * 0.25)
          ..lineTo(size.width * 0.35, size.height * 0.34)
          ..close();

        final fingerPaint = Paint()
          ..color = primaryColor
          ..style = PaintingStyle.fill;
        canvas.drawPath(indexFingerPath, fingerPaint);

        // Fingertip Sunnah motion indicator glow
        canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.28), 6.0, mainPaint);
        canvas.drawCircle(
          Offset(size.width * 0.78, size.height * 0.28),
          10.0,
          Paint()
            ..color = primaryColor.withValues(alpha: 0.35)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0,
        );
        break;

      case 'taslim':
        // Head turned right
        canvas.drawCircle(Offset(cx + 12, cy - 40), 14, headPaint);
        canvas.drawArc(Rect.fromCircle(center: Offset(cx + 12, cy - 42), radius: 14.5), math.pi, math.pi, true, capPaint);

        final taslimBody = Path()
          ..moveTo(cx - 18, cy - 25)
          ..lineTo(cx + 18, cy - 25)
          ..lineTo(cx + 24, cy + 40)
          ..lineTo(cx - 24, cy + 40)
          ..close();
        canvas.drawPath(taslimBody, bodyPaint);

        // Turn indicator arrow
        final turnArrow = Path()
          ..moveTo(cx - 15, cy - 42)
          ..cubicTo(cx - 5, cy - 56, cx + 15, cy - 56, cx + 25, cy - 42);
        canvas.drawPath(turnArrow, strokePaint);
        break;

      default:
        // Default Standing Niyyah
        canvas.drawCircle(Offset(cx, cy - 42), 14, headPaint);
        canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy - 44), radius: 14.5), math.pi, math.pi, true, capPaint);

        final bodyPath = Path()
          ..moveTo(cx - 18, cy - 25)
          ..lineTo(cx + 18, cy - 25)
          ..lineTo(cx + 24, cy + 40)
          ..lineTo(cx - 24, cy + 40)
          ..close();
        canvas.drawPath(bodyPath, bodyPaint);

        canvas.drawLine(Offset(cx - 18, cy - 20), Offset(cx - 22, cy + 20), strokePaint);
        canvas.drawLine(Offset(cx + 18, cy - 20), Offset(cx + 22, cy + 20), strokePaint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _PostureAvatarPainter oldDelegate) {
    return oldDelegate.postureKey != postureKey ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.isDark != isDark;
  }
}
