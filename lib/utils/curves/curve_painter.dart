import 'package:pathshala/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = AppColors.white;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.15);
    path.quadraticBezierTo(size.width * 0.0, size.height * 0.2,
        size.width * 0.11, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.89, size.height * 0.2,
        size.width * 0.89, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.98, size.height * 0.2, size.width * 1,
        size.height * 0.25);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
