import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:quebra_cabecas/games/corrida_matematica/domain/check_point_class.dart';

class PathRoadPainter extends CustomPainter with ChangeNotifier {
  double percentRoomOccupied = .85;
  String originalPathStr =
      "M432.682,247.572c94.131,235.595 134.206,442.836 94.131,584.17c-58.611,206.709 -147.219,194.131 -293.789,274.356c-137.721,75.382 -196.382,277.813 0,477.101c115.6,117.31 376.58,63.286 376.58,332.389c0,173.037 -359.942,618.059 -376.58,794.423c-10.624,112.617 112.905,304.078 293.789,226.278c158.448,-68.149 89.341,-236.7 158.448,-306.141c101.098,-101.585 281,-73.267 366.358,0c159.726,137.102 31.79,253.726 159.726,367.689c126.707,112.869 277.597,45.371 326.107,-61.548c54.351,-119.794 80.972,-449.228 -0,-585.661c-80.973,-136.432 -485.833,-84.3 -485.833,-232.933c-0,-148.634 636.152,-373.697 485.833,-658.869c-66.256,-125.694 -549.369,-66.771 -672.18,-173.036c-135.882,-117.576 -71.225,-386.781 0,-454.048c186.347,-175.991 346.073,154.562 505.799,35.3c188.539,-140.777 -131.996,-483.038 -0,-619.47c131.995,-136.433 722.093,-194.111 791.973,-79.863c69.88,114.248 -372.693,524.655 -372.693,765.353c-0,240.698 372.693,501.361 372.693,678.834c0,177.473 -415.952,281.739 -372.693,386.004c43.259,104.266 593.425,61.007 632.248,239.589c38.822,178.582 -266.21,554.603 -399.315,831.905";

  late Path originalPath;
  late Path pathLine;

  List<CheckPointClass> checkPointsInt = [];

  PathRoadPainter() {
    pathLine = originalPath = parseSvgPathData(originalPathStr);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    pathLine = scaleAndOffsetOriginalPath(size);

    canvas.drawPath(
      pathLine,
      Paint()
        ..color = Colors.white
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 50 * percentRoomOccupied,
    );

    //Faixa preta
    canvas.drawPath(
      pathLine,
      Paint()
        ..color = Colors.black
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 40 * percentRoomOccupied,
    );

    //Linha branca
    canvas.drawPath(
      //Fazer pontilhado
      dashPath(pathLine, dashArray: CircularIntervalList([20, 15])),
      Paint()
        ..color = Colors.white
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3 * percentRoomOccupied,
    );

    if (checkPointsInt.isNotEmpty) {
      for (var checkPoint in checkPointsInt) {
        Tangent? tangentCurrent = getTangentFromPercent(checkPoint.percentInt);
        canvas.drawCircle(
            tangentCurrent!.position,
            14 * percentRoomOccupied,
            Paint()
              ..color = Colors.green[800]!
              ..style = PaintingStyle.fill);
      }
    }


    drawStart(canvas);
    drawEnd(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

  Path scaleAndOffsetOriginalPath(Size size) {
    double scaleSize = size.shortestSide *
        percentRoomOccupied /
        originalPath.getBounds().size.shortestSide;
    Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(scaleSize);
    Path line = originalPath.transform(matrix4.storage);

    Size sizePath = line.getBounds().size;
    Offset offsetPath = line.getBounds().topLeft -
        Offset((size.width - sizePath.width) / 2,
            (size.height - sizePath.height) / 2);

    return line.shift(-offsetPath);
  }

  Tangent? getTangentFromPercent(int percentInt) {
    double percentDouble =
        (percentInt / 100) * pathLine.computeMetrics().firstOrNull!.length;
    return pathLine
        .computeMetrics()
        .firstOrNull!
        .getTangentForOffset(percentDouble)!;
  }

  void setCheckPoints(List<CheckPointClass> checkPointsInt) {
    this.checkPointsInt = checkPointsInt;
    notifyListeners();
  }

  void drawStart(Canvas canvas) {
    Tangent? start = getTangentFromPercent(0);
    canvas.drawCircle(
      start!.position,
      40 * percentRoomOccupied,
      Paint()
        ..color = Colors.green[800]! //cor de dentro do circulo
        ..style = PaintingStyle.fill,
    );

    canvas.drawCircle(
      start.position,
      40 * percentRoomOccupied,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5 * percentRoomOccupied,
    );

    // Configurar o texto
    TextSpan span = TextSpan(
      text: "Começo",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
    TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );

    // Colocar o texto no centro do círculo
    tp.layout();
    Offset textOffset = Offset(
      start.position.dx - tp.width / 2,
      start.position.dy - tp.height / 2,
    );

    // Desenhar o texto no canvas
    tp.paint(canvas, textOffset);
  }

  void drawEnd(Canvas canvas) {
    Tangent? end = getTangentFromPercent(100);
    canvas.drawCircle(
      end!.position,
      40 * percentRoomOccupied,
      Paint()
        ..color = Colors.green[800]! //cor de dentro do circulo
        ..style = PaintingStyle.fill,
    );

    canvas.drawCircle(
      end.position,
      40 * percentRoomOccupied,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5 * percentRoomOccupied,
    );

    // Configurar o texto
    TextSpan span = TextSpan(
      text: "Final",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
    TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );

    // Colocar o texto no centro do círculo
    tp.layout();
    Offset textOffset = Offset(
      end.position.dx - tp.width / 2,
      end.position.dy - tp.height / 2,
    );

    // Desenhar o texto no canvas
    tp.paint(canvas, textOffset);
  }

  double getDistanceByPercent(int percent1, int percent2) {
    return (getTangentFromPercent(percent1)!.position -
            getTangentFromPercent(percent2)!.position)
        .distance;
  }

  void eventCheckPoint(int percent, {Function(int)? callBack}) {
    int checkPointIndex = checkPointsInt.indexWhere((e) =>
        getDistanceByPercent(e.percentInt, percent) <= 10 && !e.complete);
    if (checkPointIndex < 0) return;
    callBack?.call(checkPointIndex);
  }
}
