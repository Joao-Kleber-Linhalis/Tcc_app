import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:quebra_cabecas/components/dica_alert_dialog.dart';
import 'package:quebra_cabecas/games/shape_match/shape_match_widget.dart';
import 'package:quebra_cabecas/uteis/widgts/botao.dart';
import 'package:quebra_cabecas/uteis/widgts/confetti.dart';

class ShapeMatch extends StatefulWidget {
  const ShapeMatch({super.key});

  @override
  State<ShapeMatch> createState() => _ShapeMatchState();
}

class _ShapeMatchState extends State<ShapeMatch> {
  late ConfettiController _controllerCenter;
  GlobalKey<ShapeMatchWidgetState> globalKey = GlobalKey();
  final String text = "Pressione as letras para formar a palavra!";
  final String dicaPath = "images/dica_adivinhe_palavra.gif";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerCenter = ConfettiHelper.createController();
    Future.delayed(Duration(seconds: 2), () {
      globalKey.currentState?.generateList();
    });
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  void _exibirEfeito() {
    ConfettiHelper.showConfetti(_controllerCenter);
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
        title: const FittedBox(child: Text("Som das Letras")),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
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
                  InkWell(
                    onTap: () => globalKey.currentState!.generateList(),
                    child: Icon(
                      Icons.repeat_outlined,
                      size: 45,
                      color: Colors.yellow[200],
                    ),
                  ),
                ],
              ),
            ),
            ConfettiHelper.confettiWidget(_controllerCenter),
            Container(
              margin: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: Image.asset(
                "images/shape_match_image.png",
                fit: BoxFit.contain,
                //width: MediaQuery.of(context).size.width*0.2,
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ShapeMatchWidget(
                    key: globalKey,
                    size: constraints.biggest, //passar tamanho
                    conffeti: _exibirEfeito,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
