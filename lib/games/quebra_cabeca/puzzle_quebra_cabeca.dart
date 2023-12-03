import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:quebra_cabecas/components/dica_alert_dialog.dart';
import 'package:quebra_cabecas/domain/animal.dart';
import 'package:quebra_cabecas/games/quebra_cabeca/quebra_cabeca_widget.dart';
import 'package:quebra_cabecas/uteis/widgts/confetti.dart';

class PuzzleQuebraCabeca extends StatefulWidget {
  final List<Animal> animals;
  PuzzleQuebraCabeca({super.key, required this.animals});

  @override
  State<PuzzleQuebraCabeca> createState() => _PuzzleQuebraCabecaState();
}

class _PuzzleQuebraCabecaState extends State<PuzzleQuebraCabeca> {
  late ConfettiController _controllerCenter;
  GlobalKey<QuebraCabecaWidgetState> quebraKey =
      GlobalKey<QuebraCabecaWidgetState>();
  late int index;
  final String text = "Pressione as letras para formar a palavra!";
  final String dicaPath = "images/dica_adivinhe_palavra.gif";

  @override
  void initState() {
    _controllerCenter = ConfettiHelper.createController();
    index = 0;
    // TODO: implement initState
    super.initState();
  }

  void _exibirEfeito() {
    ConfettiHelper.showConfetti(_controllerCenter);
  }

  void _aumentaIndex() {
    if (index < widget.animals.length - 1) {
      quebraKey.currentState?.reiniciarQuebraCabeca();
      index++;
      setState(() {});
    }
  }

  void _diminuiIndex() {
    if (index > 0) {
      quebraKey.currentState?.reiniciarQuebraCabeca();
      index--;
      setState(() {});
    }
  }

  void showTutorialIndicator() {
    showDialog(
      context: context,
      builder: (context) {
        return dica_alert_dialog(
          dicaText: text,
          dicaPath: dicaPath,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quebra Cabeça"),
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).copyWith().colorScheme.background,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                //Botão de dica , botao de questao anterior, botao de proxima questao respectivamente
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => showTutorialIndicator(),
                      child: Icon(
                        Icons.question_mark_outlined,
                        size: 45,
                        color: Colors.yellow[200],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => _diminuiIndex(),
                          child: Icon(
                            Icons.arrow_back_ios_sharp,
                            size: 45,
                            color: Colors.yellow[200],
                          ),
                        ),
                        InkWell(
                          onTap: () => _aumentaIndex(),
                          child: Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 45,
                            color: Colors.yellow[200],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ConfettiHelper.confettiWidget(_controllerCenter),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(border: Border.all(width: 2)),
                    child: QuebraCabecaWidget(
                      callBackFinish: () {
                        _exibirEfeito();
                        Future.delayed(Duration(seconds: 5), () {
                          _aumentaIndex();
                        });
                      },
                      callBackSucess: () {
                        AssetsAudioPlayer.newPlayer().open(
                          Audio("songs/quebra_cabeca_encaixe_peca.mp3"),
                          autoStart: true,
                        );
                      },
                      key: quebraKey,
                      child: Padding(
                        padding: const EdgeInsets.all(
                            0.0), //Margen da imagem, mas sai no quebra-cabeça...
                        child: Image.network(
                          //"https://akns-images.eonline.com/eol_images/Entire_Site/2014230/rs_600x600-140330124617-1024.frozen.jpg?fit=around%7C1200:1200&output-quality=90&crop=1200:1200;center,top",
                          widget.animals[index].image,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          quebraKey.currentState?.reiniciarQuebraCabeca();
                          await quebraKey.currentState
                              ?.geradorQuebraCabecaPecas();
                        },
                        child: Text("Gerar"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await quebraKey.currentState
                              ?.geradorQuebraCabecaPecasFacil();
                        },
                        child: Text("Gerar Fácil"),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
