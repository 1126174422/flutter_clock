import 'package:flutter/material.dart';

class TickContainer extends StatelessWidget {
  const TickContainer(this.primeColor, this.accColor);

  final Color primeColor;
  final Color accColor;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox.expand(
            child: CustomPaint(
      painter: _TickContainer(primeColor, accColor),
    )));
  }
}

class _TickContainer extends CustomPainter {
  const _TickContainer(this.primeColor, this.accColor);

  final Color primeColor;
  final Color accColor;

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
      ..color = primeColor
      ..strokeWidth = 2;
    //head
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(centerX, centerY - (0.15 * stand)),
            width: 0.33 * stand,
            height: 0.24 * stand),
        paint);
    //ear
    var path = Path();
    path.moveTo(centerX - 0.075 * stand, centerY - 0.26 * stand);
    path.cubicTo(
        centerX - 0.11 * stand,
        centerY - 0.48 * stand,
        centerX,
        centerY - 0.48 * stand,
        centerX - 0.022 * stand,
        centerY - 0.27 * stand);
    canvas.drawPath(path, paint);

    path.moveTo(centerX + 0.075 * stand, centerY - 0.26 * stand);
    path.cubicTo(
        centerX + 0.11 * stand,
        centerY - 0.48 * stand,
        centerX,
        centerY - 0.48 * stand,
        centerX + 0.022 * stand,
        centerY - 0.27 * stand);
    canvas.drawPath(path, paint);
    //body
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(centerX, centerY + (0.12 * stand)),
            width: 0.1 * stand,
            height: 0.3 * stand),
        paint);
    //foot
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(centerX - (0.05 * stand), centerY + (0.4 * stand)),
            width: 0.05 * stand,
            height: 0.02 * stand),
        paint);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(centerX + (0.05 * stand), centerY + (0.4 * stand)),
            width: 0.05 * stand,
            height: 0.02 * stand),
        paint);
    //leg
    path.moveTo(centerX + (0.05 * stand), centerY + (0.39 * stand));
    path.quadraticBezierTo(centerX + (0.05 * stand), centerY + (0.24 * stand),
        centerX + (0.034 * stand), centerY + (0.24 * stand));
    canvas.drawPath(path, paint);

    path.moveTo(centerX - (0.05 * stand), centerY + (0.39 * stand));
    path.quadraticBezierTo(centerX - (0.05 * stand), centerY + (0.24 * stand),
        centerX - (0.034 * stand), centerY + (0.24 * stand));
    canvas.drawPath(path, paint);

    /*//nose
    path = new Path();
    paint.strokeWidth = 1;
    path.moveTo(centerX, centerY - (0.12 * stand));
    path.quadraticBezierTo(centerX - (0.01 * stand), centerY - (0.12 * stand),
        centerX - (0.01 * stand), centerY - (0.11 * stand));
    canvas.drawPath(path, paint);*/
    //eye
    paint
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..color = accColor;
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(centerX - (0.07 * stand), centerY - (0.18 * stand)),
            width: 0.07 * stand,
            height: 0.04 * stand),
        paint);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(centerX + (0.07 * stand), centerY - (0.18 * stand)),
            width: 0.07 * stand,
            height: 0.04 * stand),
        paint);
    //mouth
    canvas.drawLine(Offset(centerX - 0.03 * stand, centerY - (0.07 * stand)),
        Offset(centerX + 0.03 * stand, centerY - (0.07 * stand)), paint);
  }

  @override
  bool shouldRepaint(_TickContainer oldDelegate) {
    return primeColor != oldDelegate.primeColor ||
        accColor != oldDelegate.accColor;
  }
}
