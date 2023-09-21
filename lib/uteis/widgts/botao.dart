import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  String texto;
  VoidCallback? ao_clicar;
  FocusNode? marcador_foco;
  Color? cor;
  bool mostrar_progress;

  Botao(
      {required this.texto,
       required this.ao_clicar,
      this.marcador_foco,
      this.cor,
      this.mostrar_progress = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
              backgroundColor: cor,
        ),
        child: mostrar_progress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                texto,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
        onPressed: ao_clicar,
        focusNode: marcador_foco,
      ),
    );
  }
}