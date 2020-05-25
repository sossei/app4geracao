import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vm;

class RoundedBorderPainter extends CustomPainter {
  final Color leftBorderColor;
  final Color rightBorderColor;
  final Color bottomBorderColor;
  final Color topBorderColor;
  final double strokeWidth;
  final StrokeCap strokeCap = StrokeCap.round;
  double radiusTop;
  double radiusBottom;

  Size size;

  RoundedBorderPainter({
    this.leftBorderColor = Colors.black,
    this.rightBorderColor = Colors.black,
    this.topBorderColor = Colors.black,
    this.bottomBorderColor = Colors.black,
    this.strokeWidth = 2,
    this.radiusTop = 1,
    this.radiusBottom = 1,
  }) {
    if (radiusBottom <= 1) this.radiusBottom = 1;
    if (radiusTop <= 1) this.radiusTop = 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    radiusTop =
        size.shortestSide / 2 < radiusTop ? size.shortestSide / 2 : radiusTop;
    radiusBottom = size.shortestSide / 2 < radiusBottom
        ? size.shortestSide / 2
        : radiusBottom;
    this.size = size;
    Paint topPaint = Paint()
      ..color = topBorderColor
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap
      ..style = PaintingStyle.stroke;
    Paint rightPaint = Paint()
      ..color = rightBorderColor
      ..strokeCap = strokeCap
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    Paint bottomPaint = Paint()
      ..color = bottomBorderColor
      ..strokeCap = strokeCap
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    Paint leftPaint = Paint()
      ..strokeCap = strokeCap
      ..color = leftBorderColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawPath(getPath1(), topPaint);
    canvas.drawPath(getPath2(), rightPaint);
    canvas.drawPath(getPath3(), bottomPaint);
    canvas.drawPath(getPath4(), leftPaint);
  }

  Path getPath1() {
    return Path()
      ..addPath(getTopLeftPath2(), Offset(0, 0))
      ..addPath(getTopPath(), Offset(0, 0))
      ..addPath(getTopRightPath1(), Offset(0, 0));
  }

  Path getPath2() {
    return Path()
      ..addPath(getTopRightPath2(), Offset(0, 0))
      ..addPath(getRightPath(), Offset(0, 0))
      ..addPath(getBottomRightPath1(), Offset(0, 0));
  }

  Path getPath3() {
    return Path()
      ..addPath(getBottomRightPath2(), Offset(0, 0))
      ..addPath(getBottomPath(), Offset(0, 0))
      ..addPath(getBottomLeftPath1(), Offset(0, 0));
  }

  Path getPath4() {
    return Path()
      ..addPath(getBottomLeftPath2(), Offset(0, 0))
      ..addPath(getLeftPath(), Offset(0, 0))
      ..addPath(getTopLeftPath1(), Offset(0, 0));
  }

  Path getTopPath() {
    return Path()
      ..moveTo(0 + radiusTop, 0)
      ..lineTo(size.width - radiusTop, 0);
  }

  Path getRightPath() {
    return Path()
      ..moveTo(size.width, 0 + radiusTop)
      ..lineTo(size.width, size.height - radiusBottom);
  }

  Path getBottomPath() {
    return Path()
      ..moveTo(size.width - radiusBottom, size.height)
      ..lineTo(0 + radiusBottom, size.height);
  }

  Path getLeftPath() {
    return Path()
      ..moveTo(0, size.height - radiusBottom)
      ..lineTo(0, 0 + radiusTop);
  }

  Path getTopRightPath1() {
    return Path()
      ..addArc(
        Rect.fromLTWH(
            size.width - (radiusTop * 2), 0, radiusTop * 2, radiusTop * 2),
        vm.radians(-45),
        vm.radians(-45),
      );
  }

  Path getTopRightPath2() {
    return Path()
      ..addArc(
        Rect.fromLTWH(
            size.width - (radiusTop * 2), 0, radiusTop * 2, radiusTop * 2),
        vm.radians(0),
        vm.radians(-45),
      );
  }

  Path getBottomRightPath1() {
    return Path()
      ..addArc(
        Rect.fromLTWH(
            size.width - (radiusBottom * 2),
            size.height - (radiusBottom * 2),
            radiusBottom * 2,
            radiusBottom * 2),
        vm.radians(45),
        vm.radians(-45),
      );
  }

  Path getBottomRightPath2() {
    return Path()
      ..addArc(
        Rect.fromLTWH(
            size.width - (radiusBottom * 2),
            size.height - (radiusBottom * 2),
            radiusBottom * 2,
            radiusBottom * 2),
        vm.radians(90),
        vm.radians(-45),
      );
  }

  Path getBottomLeftPath1() {
    return Path()
      ..addArc(
        Rect.fromLTWH(0, size.height - (radiusBottom * 2), radiusBottom * 2,
            radiusBottom * 2),
        vm.radians(135),
        vm.radians(-45),
      );
  }

  Path getBottomLeftPath2() {
    return Path()
      ..addArc(
        Rect.fromLTWH(0, size.height - (radiusBottom * 2), radiusBottom * 2,
            radiusBottom * 2),
        vm.radians(180),
        vm.radians(-45),
      );
  }

  Path getTopLeftPath1() {
    return Path()
      ..addArc(
        Rect.fromLTWH(0, 0, radiusTop * 2, radiusTop * 2),
        vm.radians(225),
        vm.radians(-45),
      );
  }

  Path getTopLeftPath2() {
    return Path()
      ..addArc(
        Rect.fromLTWH(0, 0, radiusTop * 2, radiusTop * 2),
        vm.radians(270),
        vm.radians(-45),
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
