import 'package:flutter/material.dart';
import 'package:quebra_cabecas/games/quebra_cabeca/peca_quebra_cabeca_widget.dart';

class PecaQuebraCabeca {
  Offset offset;
  Offset offsetDefault;
  PecaQuebraCabecaWidget pecaQuebraCabecaWidget;
  int numero;

  PecaQuebraCabeca({
    required this.offset,
    required this.offsetDefault,
    required this.pecaQuebraCabecaWidget,
    required this.numero
  });
}
