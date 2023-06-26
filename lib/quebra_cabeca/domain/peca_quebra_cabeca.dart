import 'package:flutter/material.dart';
import 'package:quebra_cabecas/quebra_cabeca/peca_quebra_cabeca_widget.dart';

class PecaQuebraCabeca {
  Offset offset;
  Offset offsetDefault;
  PecaQuebraCabecaWidget pecaQuebraCabecaWidget;

  PecaQuebraCabeca(
      {required this.offset,
      required this.offsetDefault,
      required this.pecaQuebraCabecaWidget});
}
