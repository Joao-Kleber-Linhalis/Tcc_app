import 'package:flutter/material.dart';
import 'package:quebra_cabecas/games/quebra_cabeca/domain/pos_peca_quebra_cabeca.dart';

class ImageBox {
  Widget image;
  PosPecaQuebraCabeca posicao;
  Offset offsetCenter;
  Size size;
  double radiusPoint;
  bool isDone;

  ImageBox({
    required this.image,
    required this.isDone,
    required this.offsetCenter,
    required this.posicao,
    required this.radiusPoint,
    required this.size,
  });
}
