import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quebra_cabecas/games/shape_match/domain/class_shape.dart';
import 'package:quebra_cabecas/uteis/speak.dart';

class ShapeMatchWidget extends StatefulWidget {
  final void Function() conffeti;
  final Size size;
  ShapeMatchWidget({super.key, required this.size, required this.conffeti});

  @override
  State<ShapeMatchWidget> createState() => ShapeMatchWidgetState();
}

class ShapeMatchWidgetState extends State<ShapeMatchWidget>
    with SingleTickerProviderStateMixin {

  late Size size;
  List<ClassShape> classShapes = [];
  Offset? offsetTouch;
  Offset? currentOffsetCurrent;
  int? indexChild;

  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 0,
      vsync: this,
    );


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

          if (animation.isCompleted) {
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
    super.dispose();
  }


  // Método para exibir o indicador de tutorial

  ClassShape? findFirstUnmatchedShape() {
    for (ClassShape shape in classShapes) {
      if (!shape.isDone) {
        return shape;
      }
    }
    return null;
  }

  _confetti(){
    widget.conffeti();
  }

  @override
  Widget build(BuildContext context) {
    size = widget.size;
    if (classShapes.isEmpty) generateList();

    return Listener(
      onPointerUp: (event) {
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
        bool todosConcluidos = classShapes.every((shape) => shape.isDone);
           if(todosConcluidos){
            _confetti();
           }
      },
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (classShapes.isNotEmpty)
              ...classShapes.asMap().entries.map((row) {
                ClassShape shape = row.value;
                return Positioned(
                  left: shape.defaultPos.dx,
                  top: shape.defaultPos.dy,
                  child: InkWell(
                    onTap: () {
                      falar(shape.titleShape);
                    },
                    child: Container(
                      color: Colors.grey, //cor da forma
                      width: shape.childSize.width,
                      height: shape.childSize.height,
                      alignment: Alignment.center,
                      child: shape.isDone
                          ? Center(
                              child: Text(
                                shape.titleShape,
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          : null,
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
                      child: InkWell(
                        onTap: () {
                          if (shape.isDone) {
                            falar(shape.titleShape);
                          }
                        },
                        child: Container(
                          width: shape.childSize.width,
                          height: shape.childSize.height,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              shape.titleShape,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ));
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

    double width = 60;
    double height = 80;
    double padding = 5;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    classShapes = [];

    // Lista de letras do alfabeto
    List<String> alphabet = List.generate(
        26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));

    //calcular quantas formas no width atual mas tbm pode setar um tamanho fixo, como apenas 6 e etc...
    int totalShape = size.width ~/ (width + padding * 2);

    width = (size.width - (padding * 2) * totalShape) / totalShape;
    height = width;
    //height = (size.height - (padding * 2) * totalShape) / totalShape;
  
    //calcular pos para cada forma
    for (var i = 0; i < totalShape; i++) {
      Offset offset =
          Offset(((i + 1) * padding + (width + padding) * i), padding + (screenHeight/10));
      Offset currentPos = Offset(((i + 1) * padding + (width + padding) * i),
          size.height - height - (padding * 1));

      if (alphabet.isNotEmpty) {
        // Obter uma letra aleatória do alfabeto
        int randomIndex = Random().nextInt(alphabet.length);
        String randomLetter = alphabet[randomIndex];

        ClassShape classShape = ClassShape(
          titleShape: randomLetter, // Usar a letra aleatória no título
          childSize: Size(width, height),
          currentPos: currentPos,
          defaultPos: offset,
          pointOrigin: currentPos,
          pathImage: "sample image",
          uniqueId: Random().nextInt(1000000),
        );

        classShapes.add(classShape);

        // Remover a letra usada para garantir que não seja repetida
        alphabet.removeAt(randomIndex);
      }
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
