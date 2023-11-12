import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quebra_cabecas/games/shape_match/domain/class_shape.dart';

class ShapeMatchWidget extends StatefulWidget {
  Size size;
  ShapeMatchWidget({super.key, required this.size});

  @override
  State<ShapeMatchWidget> createState() => ShapeMatchWidgetState();
}

class ShapeMatchWidgetState extends State<ShapeMatchWidget>
    with SingleTickerProviderStateMixin {

  Timer? inactivityTimer;
  static const int inactivityDuration = 10;    
  bool tutorialDialogShown = false;

  late Size size;
  List<ClassShape> classShapes = [];
  Offset? offsetTouch;
  Offset? currentOffsetCurrent;
  int? indexChild;

  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 0,
      vsync: this,
    );

    inactivityTimer = Timer.periodic(Duration(seconds: inactivityDuration), (timer) {
      // Exibe o indicador de tutorial após um período de inatividade
      if (!tutorialDialogShown) {
        showTutorialIndicator();
      }
    });

    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        // Conferir se index child é nulo
        if (indexChild != null) {
          ClassShape currentShape =
              classShapes.firstWhere((shape) => shape.uniqueId == indexChild);

          currentShape.currentPos = pointAtPercent(
            currentOffsetCurrent!,
            currentShape.pointOrigin,
            animation.value,
          );

          if(animation.isCompleted){
            currentShape.color = Colors.yellow;

            offsetTouch = null;
            indexChild = null;
            animationController.stop();
            animationController.reset();
          }
          setState(() {});

        }
      });
  }

  @override
  void dispose() {
    inactivityTimer?.cancel();
    super.dispose();
  }

  void resetInactivityTimer() {
    inactivityTimer?.cancel();
    inactivityTimer = Timer.periodic(Duration(seconds: inactivityDuration), (timer) {
      if (!tutorialDialogShown) {
        showTutorialIndicator();
      }
    });
  }

  // Método para exibir o indicador de tutorial
  void showTutorialIndicator() {
    tutorialDialogShown = true;
    // Adicione aqui a lógica para exibir o indicador de tutorial
    // Pode ser um modal, uma mensagem na tela, etc.
    // Por exemplo:
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Dica'),
          content: Text('Arraste a peça para o local indicado!'),
          actions: [
            TextButton(
              onPressed: () {
                tutorialDialogShown = false;
                Navigator.pop(context); // Fechar o indicador de tutorial
              },
              child: Text('Entendi'),
            ),
          ],
        );
      },
    );
  }

  ClassShape? findFirstUnmatchedShape() {
  for (ClassShape shape in classShapes) {
    if (!shape.isDone) {
      return shape;
    }
  }
  return null;
}


  @override
  Widget build(BuildContext context) {
    size = widget.size;
    if (classShapes.isEmpty) generateList();

    return Listener(
      onPointerUp: (event) {
        resetInactivityTimer();
        if (indexChild != null) {
          ClassShape currentShape =
              classShapes.firstWhere((shape) => shape.uniqueId == indexChild);
          currentOffsetCurrent = currentShape.currentPos;
          animationController.value = 0;
          animationController.forward();
          setState(() {});
        }
      },
      onPointerMove: (event) {
        resetInactivityTimer();
        if (offsetTouch != null && indexChild != null) {
          ClassShape currentShape =
              classShapes.firstWhere((shape) => shape.uniqueId == indexChild);

          if (currentShape.arriveDest()) {
            //está feito
            currentShape.setDone();
            indexChild = null;
          } else {
            //se não estiver, mover para posição atual
            currentShape.currentPos = event.localPosition - offsetTouch!;
          }

          setState(() {});
        }
      },
      child: Container(
        child: Stack(
          children: [
            if (classShapes.isNotEmpty)
              ...classShapes.asMap().entries.map((row) {
                ClassShape shape = row.value;
                return Positioned(
                  left: shape.defaultPos.dx,
                  top: shape.defaultPos.dy,
                  child: Container(
                    color: Colors.grey, //cor da forma
                    width: shape.childSize.width,
                    height: shape.childSize.height,
                    alignment: Alignment.topCenter,
                    child: Text(
                      shape.titleShape,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }).toList(),

            //Declaração para mover
            if (classShapes.isNotEmpty)
              ...classShapes.asMap().entries.map((row) {
                ClassShape shape = row.value;
                return Positioned(
                  left: shape.currentPos.dx,
                  top: shape.currentPos.dy,
                  child: Listener(
                    onPointerDown: (event) {
                      if (shape.isDone) {
                        return; //Se já estiver completo, ignora o toque
                      }

                      shape.color = Colors.red;
                      ClassShape temp = classShapes.removeAt(row.key);
                      classShapes.insert(0, temp);

                      //Salvar Posição atual
                      offsetTouch = event.localPosition;

                      //Salvar id do shape atual tocado
                      indexChild = shape.uniqueId;

                      setState(() {});
                    },
                    child: Container(
                      width: shape.childSize.width,
                      height: shape.childSize.height,
                      color: Colors.green,
                    ),
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }

  Offset pointAtPercent(Offset from, Offset target, double percent) {
    return Offset(
      from.dx + (target.dx - from.dx) * percent,
      from.dy + (target.dy - from.dy) * percent,
    );
  }

  void generateList() {
    print("cachorro");

    double width = 60;
    double height = 80;
    double padding = 10;

    classShapes = [];

    //calcular quantas formas no width atual mas tbm pode setar um tamanho fixo, como apenas 6 e etc...
    int totalShape = size.width ~/ (width + padding * 2);
    

    width = (size.width - (padding * 2) * totalShape) / totalShape;
    height = width;
    //height = (size.height - (padding * 2) * totalShape) / totalShape;

    //calcular pos para cada forma
    for (var i = 0; i < totalShape; i++) {
      Offset offset =
          Offset(((i + 1) * padding + (width + padding) * i), padding);
      Offset currentPos = Offset(((i + 1) * padding + (width + padding) * i),
          size.height - height - (padding * 1));

      ClassShape classShape = ClassShape(
        titleShape: "Test ${i + 1}",
        childSize: Size(width, height),
        currentPos: currentPos,
        defaultPos: offset,
        pointOrigin: currentPos,
        pathImage: "sample image",
        uniqueId: new Random().nextInt(1000000),
      );

      classShapes.add(classShape);
    }

    //Embaralhar
    classShapes.shuffle();

    //Setar posição atual após embaralhar
    int count = 0;
    classShapes = classShapes.map((shape) {
      Offset currentPos = Offset(
        ((count + 1) * padding + (width + padding) * count),
        size.height - height - (padding * 1),
      );

      shape.currentPos = currentPos;
      shape.pointOrigin = currentPos;

      count++;
      return shape;
    }).toList();

    //rebuild
    setState(() {});

    print("Size list ${classShapes.length}");
  }
}
