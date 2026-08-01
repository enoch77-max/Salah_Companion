import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Custom authentic vector Islamic Tasbih (Subha / Misbaha) prayer beads icon.
class TasbihIcon extends StatelessWidget {
  final Color color;
  final double size;
  final bool isSelected;

  const TasbihIcon({
    super.key,
    required this.color,
    this.size = 24.0,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        size: Size(size, size),
        painter: _TasbihIconPainter(
          color: color,
          isSelected: isSelected,
        ),
      ),
    );
  }
}

class _TasbihIconPainter extends CustomPainter {
  final Color color;
  final bool isSelected;

  _TasbihIconPainter({
    required this.color,
    required this.isSelected,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintSolid = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final paintStroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final paintString = Paint()
      ..color = color.withValues(alpha: isSelected ? 0.75 : 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final cx = size.width / 2;
    final cy = size.height * 0.38;
    final radius = size.width * 0.30;

    // 1. Central String Loop
    canvas.drawCircle(Offset(cx, cy), radius, paintString);

    // 2. Loop of 9 Prayer Beads
    const beadCount = 9;
    final beadRadius = size.width * 0.075;

    for (int i = 0; i < beadCount; i++) {
      final angle = (i * (2 * math.pi / beadCount)) - (math.pi / 2);
      final bx = cx + radius * math.cos(angle);
      final by = cy + radius * math.sin(angle);

      if (isSelected) {
        canvas.drawCircle(Offset(bx, by), beadRadius, paintSolid);
      } else {
        canvas.drawCircle(Offset(bx, by), beadRadius, paintSolid);
        canvas.drawCircle(Offset(bx, by), beadRadius, paintStroke);
      }
    }

    // 3. Central Imam (Head Bead / Yad) at bottom junction
    final imamTopY = cy + radius - beadRadius * 0.4;
    final imamHeight = size.height * 0.20;
    final imamWidth = size.width * 0.12;

    final imamPath = Path()
      ..moveTo(cx - imamWidth / 2, imamTopY)
      ..lineTo(cx + imamWidth / 2, imamTopY)
      ..lineTo(cx + imamWidth * 0.35, imamTopY + imamHeight)
      ..lineTo(cx - imamWidth * 0.35, imamTopY + imamHeight)
      ..close();

    canvas.drawPath(imamPath, paintSolid);

    // 4. Hanging Tassel Threads & End Drops
    final tasselStartY = imamTopY + imamHeight;
    final tasselLength = size.height * 0.16;

    // Left strand
    canvas.drawLine(
      Offset(cx - 1, tasselStartY),
      Offset(cx - size.width * 0.10, tasselStartY + tasselLength),
      paintString,
    );

    // Center strand
    canvas.drawLine(
      Offset(cx, tasselStartY),
      Offset(cx, tasselStartY + tasselLength * 1.15),
      paintString,
    );

    // Right strand
    canvas.drawLine(
      Offset(cx + 1, tasselStartY),
      Offset(cx + size.width * 0.10, tasselStartY + tasselLength),
      paintString,
    );

    // Terminal droplets
    final dropRadius = size.width * 0.045;
    canvas.drawCircle(Offset(cx - size.width * 0.10, tasselStartY + tasselLength), dropRadius, paintSolid);
    canvas.drawCircle(Offset(cx, tasselStartY + tasselLength * 1.15), dropRadius, paintSolid);
    canvas.drawCircle(Offset(cx + size.width * 0.10, tasselStartY + tasselLength), dropRadius, paintSolid);
  }

  @override
  bool shouldRepaint(covariant _TasbihIconPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.isSelected != isSelected;
  }
}
