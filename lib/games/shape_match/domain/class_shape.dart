import 'package:flutter/material.dart';

class ClassShape {
  Offset currentPos;
  Offset defaultPos;
  Offset pointOrigin;
  Size childSize;
  String pathImage;
  String titleShape;
  bool isDone;
  int uniqueId;

  MaterialColor color;

  ClassShape({
    required this.currentPos,
    required this.defaultPos,
    required this.pointOrigin,
    required this.childSize,
    required this.pathImage,
    required this.titleShape,
    required this.uniqueId,
    this.isDone = false,
    this.color = Colors.yellow,
  });

  //Condição para a forma ir para a posição correta
  bool arriveDest() => (currentPos - defaultPos).distance < 15;

  void setDone(){
    isDone = true;
    color = Colors.green;
    currentPos= defaultPos;
  }
}
