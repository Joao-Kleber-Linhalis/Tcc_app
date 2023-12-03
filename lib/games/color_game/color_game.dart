import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quebra_cabecas/components/dica_alert_dialog.dart';
import 'package:quebra_cabecas/components/vitoria_alert_dialog.dart';

import 'color_name.dart';

class ColorGame extends StatefulWidget {
  const ColorGame({super.key});

  @override
  State<ColorGame> createState() => _ColorGameState();
}

class _ColorGameState extends State<ColorGame> {
  Map<String, bool> score = {};
  late Map choices;
  final String text = "Pressione as letras para formar a palavra!";
  final String dicaPath = "images/dica_adivinhe_palavra.gif";

  int seed = 0;

  Map<String, Color> generateRandomColorMap(int numberOfColors) {
    final List<String> colorNames = [
      "Vermelho",
      "Azul",
      "Verde",
      "Amarelo",
      "Roxo",
      "Laranja",
      "Rosa",
      "Marrom",
      "Cinza",
      "Preto",
    ];
    final List<Color> availableColors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.brown,
      Colors.grey,
      Colors.black,
    ];

    final Map<String, Color> colorMap = {};

    final random = Random();

    for (int i = 0; i < numberOfColors; i++) {
      final randomIndex = random.nextInt(availableColors.length);
      final colorName = colorNames[randomIndex];
      final randomColor = availableColors[randomIndex];

      colorMap[colorName] = randomColor;
    }

    return colorMap;
  }

  void showTutorialIndicator() {
    showDialog(
      context: context,
      builder: (context) {
        return DicaAlertDialog(
          dicaText: text,
          dicaPath: dicaPath,
        );
      },
    );
  }

  void showVitoriaIndicator() {
    showDialog(
      context: context,
      builder: (context) {
        return VitoriaAlertDialog(resetGame: resetGame);
      },
    );
  }

  bool allColorsPlacedCorrectly() {
    return score.length == choices.length &&
        score.values.every((placedCorrectly) => placedCorrectly == true);
  }

  void resetGame() {
    setState(() {
      // Gera novamente as escolhas
      choices = generateRandomColorMap(6);

      // Limpa o mapa de pontuação
      score.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    choices = generateRandomColorMap(6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rota das Cores"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              //Botão de Tutorial
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => showTutorialIndicator(),
                    child: Icon(
                      Icons.question_mark_outlined,
                      size: 45,
                      color: Colors.yellow[200],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: choices.entries.map((entry) {
                      String choiseColor = entry.key;
                      Color choiseColorValue = entry.value;
                      return Draggable<String>(
                        data: choiseColor,
                        feedback: ColorName(
                          colorName: choiseColor,
                          color: choiseColorValue,
                        ),
                        childWhenDragging:
                            ColorName(colorName: "❔", color: Colors.white),
                        child: ColorName(
                          colorName:
                              score[choiseColor] == true ? '✅' : choiseColor,
                          color: choiseColorValue,
                        ),
                      );
                    }).toList()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: choices.entries.map(
                    (entry) {
                      String choiseColor = entry.key;
                      Color choiseColorValue = entry.value;
                      return _buildDragTarget(
                          choiseColor, choiseColorValue, entry);
                    },
                  ).toList()
                    ..shuffle(Random(seed)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragTarget(String colorName, Color cor, entry) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> incoming, List reject) {
        if (score[colorName] == true) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Text("Acertou!"),
          );
        } else {
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: cor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.1,
          );
        }
      },
      onWillAcceptWithDetails: (details) => details.data == colorName,
      onAcceptWithDetails: (details) {
        setState(() {
          score[colorName] = true;
        });
        if (allColorsPlacedCorrectly()) {
          // Jogo concluido
          showVitoriaIndicator();
        }
      },
    );
  }
}