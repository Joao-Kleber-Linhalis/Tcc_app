import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:quebra_cabecas/components/dica_alert_dialog.dart';
import 'package:quebra_cabecas/games/memory_game/carta.dart';
import 'package:quebra_cabecas/screens/game_overview_screen.dart';
import 'package:quebra_cabecas/uteis/nav.dart';

class MemoryGame extends StatefulWidget {
  final int size = 8;

  const MemoryGame({super.key});

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  final String text = "Pressione as letras para formar a palavra!";
  final String dicaPath = "images/dica_adivinhe_palavra.gif";

  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];
  List<Carta> data = [];
  int previousIndex = -1;
  bool flip = false;
  int time = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    data = Carta.generateRandomList(widget.size);
    for (var i = 0; i < widget.size; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time += 1;
      });
    });
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
        title: Text("Jogo da Memória"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Substitua a rota atual pela tela desejada
            push(context, GameOverviewScreen());
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
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
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "⏳ $time",
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  Theme(
                    data: ThemeData.dark(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        //Layout das "cartas"
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) => FlipCard(
                          key: cardStateKeys[index],
                          onFlip: () {
                            print(index);
                            if (!flip) {
                              flip = true;
                              previousIndex = index;
                            } else {
                              flip = false;
                              if (previousIndex != index) {
                                if (data[previousIndex].index !=
                                    data[index].index) {
                                  cardStateKeys[previousIndex]
                                      .currentState
                                      ?.toggleCard();
                                  previousIndex = index;
                                } else {
                                  cardFlips[previousIndex] = false;
                                  cardFlips[index] = false;
                                  print("match");
                                  previousIndex = -1;
                                  if (cardFlips.every((t) => t == false)) {
                                    print("CABO");
                                    showResult();
                                  }
                                }
                              } else {
                                previousIndex = -1;
                              }
                            }
                            setState(() {});
                          },
                          direction: FlipDirection.HORIZONTAL,
                          flipOnTouch: cardFlips[index],
                          front: Container(
                            margin: EdgeInsets.all(4),
                            color: cardFlips[index]
                                ? Colors.green[200]
                                : Colors.deepPurple[200],
                          ),
                          back: Container(
                            margin: EdgeInsets.all(4),
                            color: cardFlips[index]
                                ? Colors.green[400]
                                : Colors.deepPurple[200],
                            child: Center(
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                if (data[index].back) {
                                  return Wrap(
                                    alignment: WrapAlignment.center,

                                    spacing:
                                        1.0, // Espaçamento entre os Text widgets
                                    runSpacing: 1.0,
                                    // Espaçamento entre as linhas
                                    children: List.generate(
                                      data[index].qtd,
                                      (_) => Container(
                                        padding: EdgeInsets.all(
                                            4), // Espaçamento interno do item
                                        child: Text(
                                          data[index].fruta,
                                          style: TextStyle(
                                              fontSize:
                                                  (constraints.maxHeight - 60) /
                                                      (data[index].qtd * 0.7)),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Text(
                                    data[index].qtd.toString(),
                                    style: TextStyle(
                                        fontSize: constraints.maxHeight - 40),
                                  );
                                }
                              }),
                            ),
                          ),
                        ),
                        itemCount: data.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Center(child: Text("Venceu!!")),
        content: Text("Tempo $time"),
        actions: [
          ElevatedButton(
            onPressed: () {
              push(context, MemoryGame());
            },
            child: Text("Proximo"),
          ),
        ],
      ),
    );
  }
}
