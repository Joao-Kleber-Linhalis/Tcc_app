import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'math_question_dialog.dart';
import 'domain/check_point_class.dart';
import 'path_road_painter.dart';

class RoadPathWidget extends StatefulWidget {
  const RoadPathWidget({super.key});

  @override
  State<RoadPathWidget> createState() => _RoadPathWidgetState();
}

class _RoadPathWidgetState extends State<RoadPathWidget>
    with SingleTickerProviderStateMixin {
  late PathRoadPainter pathRoadPainter;

  ValueNotifier<Offset> startNotifier = ValueNotifier<Offset>(Offset.zero);
  ValueNotifier<Offset> endNotifier = ValueNotifier<Offset>(Offset.zero);
  ValueNotifier<double> sliderNotifier = ValueNotifier<double>(0);
  List<CheckPointClass> checkPoints =
      CheckPointClass.generateRandomCheckPoints();

  //Animação
  late AnimationController _animationController;
  late Animation<double> _animation;
  int indexList = 0;

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    pathRoadPainter = PathRoadPainter();
    pathRoadPainter.setCheckPoints(checkPoints);

    //
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 7),
    );

    _animation = Tween<double>(begin: 0, end: 100).animate(_animationController)
      ..addListener(
        () {
          sliderNotifier.value = _animation.value;
          pathRoadPainter.eventCheckPoint(
            _animation.value.toInt(),
            callBack: (index) async {
              Completer<bool?> dialogComplete = Completer<bool?>();
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  _animationController.stop();
                  return MathQuestionDialog();
                },
              ).then((result) {
                dialogComplete.complete(result);
              });
              bool? result = await dialogComplete.future;
              if (result == true) {
                print("Index true: $index");
                checkPoints[index].setComplete(true);
                _animationController.forward();
              } else {
                print(result);
                _animationController.value -= 0.01;
                print("Index false: $index");
                if (index > 0) {
                  checkPoints[index - 1].setComplete(false);
                }
                _animationController.reverse();
              }
            },
          );
        },
      );
    _animationController.forward();
  }

  Future<bool> showStartDialog() async {
    Completer<bool> dialogComplete = Completer<bool>();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pronto para começar?'),
          content: Text('Você está pronto para a corrida?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    ).then((result) {
      dialogComplete.complete(result ?? false);
    });

    return await dialogComplete.future;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _restartWidget(BuildContext context) {
    dispose();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RoadPathWidget()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Corrida maluca"),
      ),
      body: Container(
        color: Colors.cyan,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: pathRoadPainter,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: sliderNotifier,
              builder: (context, value, child) {
                double resize = .7;
                Tangent? tangent =
                    pathRoadPainter.getTangentFromPercent(value.toInt());
                return Positioned(
                  left: tangent!.position.dx - 100 / 2 * resize,
                  top: tangent.position.dy - 100 / 2 * resize,
                  height: 100 * resize,
                  width: 100 * resize,
                  child: Transform.rotate(
                    angle: tangent.angle,
                    child: Transform.translate(
                      offset: Offset.zero,
                      child: SvgPicture.asset(
                        "images/car.svg",
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ElevatedButton(
                onPressed: () {
                  // Chama o método para reiniciar o widget
                  _restartWidget(context);
                },
                child: Text('Reiniciar Widget'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
