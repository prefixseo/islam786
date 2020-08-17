import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class RadialPainter extends CustomPainter {
  final Color bgColor;
  final Color lineColor;
  final double width;
  final double percent;

  RadialPainter({this.bgColor, this.lineColor, this.width, this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgLine = new Paint()
      ..color = bgColor
      ..strokeCap = StrokeCap.round
      ..style=PaintingStyle.stroke
      ..strokeWidth=width;

    Paint completedLine = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style=PaintingStyle.stroke
      ..strokeWidth=width;

    Offset center= Offset(size.width/2, size.height/2);
    double radius= min(size.width/2, size.height/2);
    double sweepAngle=2*pi*percent;
    canvas.drawCircle(center, radius, bgLine);
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi/2,
        sweepAngle,
        false,
        completedLine
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}