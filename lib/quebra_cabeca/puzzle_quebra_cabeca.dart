import 'package:flutter/material.dart';
import 'package:quebra_cabecas/quebra_cabeca/quebra_cabeca_widget.dart';

class PuzzleQuebraCabeca extends StatefulWidget {
  PuzzleQuebraCabeca({super.key});

  @override
  State<PuzzleQuebraCabeca> createState() => _PuzzleQuebraCabecaState();
}

class _PuzzleQuebraCabecaState extends State<PuzzleQuebraCabeca> {

  GlobalKey<QuebraCabecaWidgetState> quebraKey =
      GlobalKey<QuebraCabecaWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quebra Cabeça"),
      ),
      body: Container(
        color: Colors.blue,
        child: SafeArea(
          child: Column(children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(width: 2)),
              child: QuebraCabecaWidget(
                callBackFinish: (){},
                callBackSucess: (){},
                key: quebraKey,
                child: Padding(
                  padding: const EdgeInsets.all(0.0), //Margen da imagem, mas sai no quebra-cabeça...
                  child: Image.network(
                    "https://akns-images.eonline.com/eol_images/Entire_Site/2014230/rs_600x600-140330124617-1024.frozen.jpg?fit=around%7C1200:1200&output-quality=90&crop=1200:1200;center,top",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async{
                      await quebraKey.currentState?.geradorQuebraCabecaPecas();
                    },
                    child: Text("Gerar"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      quebraKey.currentState?.reiniciarQuebraCabeca();
                    },
                    child: Text("Limpar"),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
