import 'package:pathshala/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MediumCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = AppColors.primary;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.0, size.height * 0.8,
        size.width * 0.11, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.89, size.height * 0.8,
        size.width * 0.89, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.98, size.height * 0.8, size.width * 1,
        size.height * 0.97);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
