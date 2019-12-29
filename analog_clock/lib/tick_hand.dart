import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class TickHand extends StatelessWidget {
  const TickHand(this.hour, this.minute, this.color);

  final int hour;
  final int minute;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double angle;
    if (hour != null) {
      angle = 30.0 * hour + (minute / 60.0) * 30;
    } else if (minute != null) {
      angle = 6.0 * minute;
    }
    var radius = angle / 180.0 * pi;
    return Center(
        child: SizedBox.expand(
            child: Transform.rotate(
                angle: 0,
                alignment: Alignment.center,
                child: CustomPaint(
                  painter: _TickHand(hour, minute, color),
                ))));
  }
}

class _TickHand extends CustomPainter {
  _TickHand(this.hour, this.minute, this.color);

  final int hour;
  final int minute;
  final Color color;

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
      ..style = PaintingStyle.stroke //线
      ..color = color
      ..strokeWidth = 2;
    double handLength;
    handLength = 0.22 * stand;
    double angle;
    if (hour != null) {
      angle = 30.0 * hour + (minute / 60.0) * 30;
      canvas.translate(0.03 * stand, 0);
    } else if (minute != null) {
      angle = 6.0 * minute;
      canvas.translate(-0.03 * stand, 0);
    }
    var radians = (90 - angle) / 180.0 * pi;
    var jointRadians;
    if (hour != null) {
      jointRadians = (90 - angle + 15) / 180.0 * pi;
    } else {
      jointRadians = (90 - angle - 15) / 180.0 * pi;
    }
    var handToX = cos(radians) * handLength;
    var handToY = sin(radians) * handLength;
    var handJointX = cos(jointRadians) * handLength / 2;
    var handJointY = sin(jointRadians) * handLength / 2;
    var path = new Path();
    //手臂
    path.moveTo(centerX, centerY);
    path.quadraticBezierTo(centerX + handJointX, centerY - handJointY,
        centerX + handToX, centerY - handToY);
    canvas.drawPath(path, paint);
    //手
    var handX = cos(radians) * (handLength + (0.01 * stand));
    var handY = sin(radians) * (handLength + (0.01 * stand));
    canvas.drawCircle(
        Offset(centerX + handX, centerY - handY), 0.01 * stand, paint);
    //minute hand take sth
    if (hour == null) {
      var swordEndX = cos(radians) * (handLength + (0.23 * stand));
      var swordEndY = sin(radians) * (handLength + (0.23 * stand));
      path.moveTo(centerX + handX, centerY - handY);
      path.lineTo(centerX + swordEndX, centerY - swordEndY);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_TickHand oldDelegate) {
    return oldDelegate.minute != minute || oldDelegate.hour != hour;
  }
}
