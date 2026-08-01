import 'package:flutter/material.dart';

/// Custom authentic open book (Dua / Quran) vector icon.
class DuaHandsIcon extends StatelessWidget {
  final Color color;
  final double size;
  final bool isSelected;

  const DuaHandsIcon({
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
        painter: _OpenBookIconPainter(
          color: color,
          isSelected: isSelected,
        ),
      ),
    );
  }
}

class _OpenBookIconPainter extends CustomPainter {
  final Color color;
  final bool isSelected;

  _OpenBookIconPainter({
    required this.color,
    required this.isSelected,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintFill = Paint()
      ..color = color
      ..style = isSelected ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final paintStroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final paintInnerLines = Paint()
      ..color = isSelected ? Colors.white.withValues(alpha: 0.65) : color.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final cx = size.width / 2;
    final w = size.width;
    final h = size.height;

    // Left Page Outer Boundary
    final leftPage = Path()
      ..moveTo(cx, h * 0.28)
      ..quadraticBezierTo(cx - w * 0.22, h * 0.18, cx - w * 0.44, h * 0.24)
      ..lineTo(cx - w * 0.44, h * 0.72)
      ..quadraticBezierTo(cx - w * 0.22, h * 0.66, cx, h * 0.76)
      ..close();

    // Right Page Outer Boundary
    final rightPage = Path()
      ..moveTo(cx, h * 0.28)
      ..quadraticBezierTo(cx + w * 0.22, h * 0.18, cx + w * 0.44, h * 0.24)
      ..lineTo(cx + w * 0.44, h * 0.72)
      ..quadraticBezierTo(cx + w * 0.22, h * 0.66, cx, h * 0.76)
      ..close();

    if (isSelected) {
      canvas.drawPath(leftPage, paintFill);
      canvas.drawPath(rightPage, paintFill);
    } else {
      canvas.drawPath(leftPage, paintStroke);
      canvas.drawPath(rightPage, paintStroke);
    }

    // Spine Line in Center
    canvas.drawLine(
      Offset(cx, h * 0.28),
      Offset(cx, h * 0.76),
      paintStroke,
    );

    // Left Page Text Lines
    canvas.drawLine(Offset(cx - w * 0.35, h * 0.38), Offset(cx - w * 0.10, h * 0.40), paintInnerLines);
    canvas.drawLine(Offset(cx - w * 0.35, h * 0.50), Offset(cx - w * 0.10, h * 0.52), paintInnerLines);
    canvas.drawLine(Offset(cx - w * 0.30, h * 0.62), Offset(cx - w * 0.10, h * 0.63), paintInnerLines);

    // Right Page Text Lines
    canvas.drawLine(Offset(cx + w * 0.10, h * 0.40), Offset(cx + w * 0.35, h * 0.38), paintInnerLines);
    canvas.drawLine(Offset(cx + w * 0.10, h * 0.52), Offset(cx + w * 0.35, h * 0.50), paintInnerLines);
    canvas.drawLine(Offset(cx + w * 0.10, h * 0.63), Offset(cx + w * 0.30, h * 0.62), paintInnerLines);

    // Center Ribbon Bookmark hanging at bottom
    final ribbonPath = Path()
      ..moveTo(cx, h * 0.76)
      ..lineTo(cx - w * 0.05, h * 0.88)
      ..lineTo(cx, h * 0.84)
      ..lineTo(cx + w * 0.05, h * 0.88)
      ..close();

    final paintRibbon = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.drawPath(ribbonPath, paintRibbon);
  }

  @override
  bool shouldRepaint(covariant _OpenBookIconPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.isSelected != isSelected;
  }
}
