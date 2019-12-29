import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class TickEye extends StatelessWidget {
  const TickEye(this.second, this.color);

  final int second;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox.expand(
            child: CustomPaint(
      painter: _TickEye(second, color),
    )));
  }
}

class _TickEye extends CustomPainter {
  _TickEye(this.second, this.color);

  int second;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var height = size.height;
    var centerX = width / 2;
    var centerY = height / 2;
    double stand = width;
    if (width > height) stand = height;
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //线
      ..color = color
      ..strokeWidth = 1;
    //eye center centerX - (0.07 * stand), centerY - (0.18 * stand)
    //long R = 0.05*stand short R = 0.02*stand
    var shortR = 0.02 * stand / 2;
    var longR = 0.05 * stand / 2;
    var coner = 90 - second * 6;
    if (coner < 0) coner += 360;
    var radius = coner / 180.0 * pi;
    var pointX = cos(radius) * longR;
    var pointY = sin(radius) * shortR;
    var leftEyeCenterX = centerX - (0.07 * stand);
    var leftEyeCenterY = centerY - (0.18 * stand);
    var rightEyeCenterX = centerX + (0.07 * stand);
    var rightEyeCenterY = centerY - (0.18 * stand);
    //left eye
    canvas.drawCircle(Offset(leftEyeCenterX + pointX, leftEyeCenterY - pointY),
        0.01 * stand, paint);
    //eye center centerX - (0.07 * stand), centerY - (0.18 * stand)
    //long R = 0.05*stand short R = 0.02*stand
    canvas.drawCircle(
        Offset(rightEyeCenterX + pointX, rightEyeCenterY - pointY),
        0.01 * stand,
        paint);
    /*canvas.drawPoints(PointMode.points,
        [Offset(centerX - (0.07 * stand), centerY - (0.17 * stand))], paint);*/
  }

  @override
  bool shouldRepaint(_TickEye oldDelegate) {
    return oldDelegate.second != second;
  }
}
