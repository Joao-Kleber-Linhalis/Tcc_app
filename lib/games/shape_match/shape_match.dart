import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(child: Text("Correspondência de formas")),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ConfettiHelper.confettiWidget(_controllerCenter),
            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.all(10),
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
            Container(
              child: Botao(
                  texto: "Reload",
                  ao_clicar: () {
                    globalKey.currentState!.generateList();
                    //_exibirEfeito();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
