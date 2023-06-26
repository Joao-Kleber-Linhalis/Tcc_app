import 'package:flutter/material.dart';
import 'package:quebra_cabecas/quebra_cabeca/domain/imageBox.dart';
import 'package:quebra_cabecas/quebra_cabeca/domain/pos_peca_quebra_cabeca.dart';

class PecaQuebraCabecaWidget extends StatefulWidget {
  final ImageBox imageBox;
  PecaQuebraCabecaWidget({super.key, required this.imageBox});

  @override
  State<PecaQuebraCabecaWidget> createState() => _PecaQuebraCabecaWidgetState();
}

class _PecaQuebraCabecaWidgetState extends State<PecaQuebraCabecaWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: PuzzlePieceClipper(imageBox: widget.imageBox),
      child: CustomPaint(
        foregroundPainter: QuebraCabecaPintor(imageBox: widget.imageBox),
        child: widget.imageBox.image,
      ),
    );
  }
}

class QuebraCabecaPintor extends CustomPainter {
  ImageBox imageBox;
  QuebraCabecaPintor({
    required this.imageBox,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color =
          this.imageBox.isDone ? Colors.white.withOpacity(0.2) : Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(
        getPiecePath(size, this.imageBox.radiusPoint,
            this.imageBox.offsetCenter, this.imageBox.posicao),
        paint);

    if (this.imageBox.isDone) {
      Paint paintDone = Paint()
        ..color = Colors.white.withOpacity(0.2)
        ..style = PaintingStyle.fill
        ..strokeWidth = 2;
      canvas.drawPath(
          getPiecePath(size, this.imageBox.radiusPoint,
              this.imageBox.offsetCenter, this.imageBox.posicao),
          paintDone);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PuzzlePieceClipper extends CustomClipper<Path> {
  ImageBox imageBox;
  PuzzlePieceClipper({required this.imageBox});
  @override
  Path getClip(Size size) {
    return getPiecePath(size, this.imageBox.radiusPoint,
        this.imageBox.offsetCenter, this.imageBox.posicao);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

getPiecePath(
  Size size,
  double radiusPoint,
  Offset offsetcenter,
  PosPecaQuebraCabeca posPecaQuebraCabeca,
) {
  Path path = Path();
  Offset topLeft = Offset(0, 0);
  Offset topRight = Offset(size.width, 0);
  Offset bottomLeft = Offset(0, size.height);
  Offset bottomRight = Offset(size.width, size.height);

  //Calcular ponto superior em 4 pontos
  topLeft = Offset(posPecaQuebraCabeca.left > 0 ? radiusPoint : 0,
          (posPecaQuebraCabeca.top > 0) ? radiusPoint : 0) +
      topLeft;
  topRight = Offset(posPecaQuebraCabeca.right > 0 ? -radiusPoint : 0,
          (posPecaQuebraCabeca.top > 0) ? radiusPoint : 0) +
      topRight;
  bottomRight = Offset(posPecaQuebraCabeca.right > 0 ? -radiusPoint : 0,
          (posPecaQuebraCabeca.bottom > 0) ? -radiusPoint : 0) +
      bottomRight;
  bottomLeft = Offset(posPecaQuebraCabeca.left > 0 ? radiusPoint : 0,
          (posPecaQuebraCabeca.bottom > 0) ? -radiusPoint : 0) +
      bottomLeft;

  //Calcular ponto do meio para min & max

  double topMiddle = posPecaQuebraCabeca.top == 0
      ? topRight.dy
      : (posPecaQuebraCabeca.top > 0
          ? topRight.dy - radiusPoint
          : topRight.dy + radiusPoint);
  double bottomMiddle = posPecaQuebraCabeca.bottom == 0
      ? bottomRight.dy
      : (posPecaQuebraCabeca.bottom > 0
          ? bottomRight.dy + radiusPoint
          : bottomRight.dy - radiusPoint);
  double leftMiddle = posPecaQuebraCabeca.left == 0
      ? topLeft.dx
      : (posPecaQuebraCabeca.left > 0
          ? topLeft.dx - radiusPoint
          : topLeft.dx + radiusPoint);
  double rightMiddle = posPecaQuebraCabeca.right == 0
      ? topRight.dx
      : (posPecaQuebraCabeca.right > 0
          ? bottomRight.dx + radiusPoint
          : bottomRight.dx - radiusPoint);
  path.moveTo(topLeft.dx, topLeft.dy);

  //Top draw
  if (posPecaQuebraCabeca.top != 0) {
    path.extendWithPath(
        calculatePoint(Axis.horizontal, topLeft.dy,
            Offset(offsetcenter.dx, topMiddle), radiusPoint),
        Offset.zero);
  }
  path.lineTo(topRight.dx, topRight.dy);

  //right draw
  if (posPecaQuebraCabeca.right != 0) {
    path.extendWithPath(
        calculatePoint(Axis.vertical, topRight.dx,
            Offset(rightMiddle, offsetcenter.dy), radiusPoint),
        Offset.zero);
  }
  path.lineTo(bottomRight.dx, bottomRight.dy);

  if (posPecaQuebraCabeca.bottom != 0) {
    path.extendWithPath(
        calculatePoint(Axis.horizontal, bottomRight.dy,
            Offset(offsetcenter.dx, bottomMiddle), -radiusPoint),
        Offset.zero);
  }
  path.lineTo(bottomLeft.dx, bottomLeft.dy);

  if (posPecaQuebraCabeca.left != 0) {
    path.extendWithPath(
        calculatePoint(Axis.vertical, bottomLeft.dx,
            Offset(leftMiddle, offsetcenter.dy), -radiusPoint),
        Offset.zero);
  }
  path.lineTo(topLeft.dx, topLeft.dy);

  path.close();
  return path;
}

//Design cada ponta
calculatePoint(Axis axis, double fromPoint, Offset point, double radiusPoint) {
  Path path = Path();
  if (axis == Axis.horizontal) {
    path.moveTo(point.dx - radiusPoint / 2, fromPoint);
    path.lineTo(point.dx - radiusPoint / 2, point.dy);
    path.lineTo(point.dx + radiusPoint / 2, point.dy);
    path.lineTo(point.dx + radiusPoint / 2, fromPoint);
  } else if (axis == Axis.vertical) {
    path.moveTo(fromPoint, point.dy - radiusPoint / 2);
    path.lineTo(point.dx, point.dy - radiusPoint / 2);
    path.lineTo(point.dx, point.dy + radiusPoint / 2);
    path.lineTo(fromPoint, point.dy + radiusPoint / 2);
  }

  return path;
}
