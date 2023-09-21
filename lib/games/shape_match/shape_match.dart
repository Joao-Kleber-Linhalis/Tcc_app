import 'package:flutter/material.dart';
import 'package:quebra_cabecas/games/shape_match/shape_match_widget.dart';
import 'package:quebra_cabecas/uteis/widgts/botao.dart';

class ShapeMatch extends StatefulWidget {
  const ShapeMatch({super.key});

  @override
  State<ShapeMatch> createState() => _ShapeMatchState();
}

class _ShapeMatchState extends State<ShapeMatch> {
  GlobalKey<ShapeMatchWidgetState> globalKey = GlobalKey();

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
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ShapeMatchWidget(
                    key: globalKey,
                    size: constraints.biggest, //passar tamanho
                  );
                },
              ),
            ),
            Container(
              child: Botao(
                  texto: "Reload",
                  ao_clicar: () {
                    globalKey.currentState!.generateList();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
