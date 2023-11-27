import 'dart:async';
import 'dart:math';
import 'package:advanced_icon/advanced_icon.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:quebra_cabecas/games/adivinhe_palavra/domain/question.dart';
import 'package:quebra_cabecas/games/adivinhe_palavra/domain/question_char.dart';
import 'package:quebra_cabecas/uteis/speak.dart';
import 'package:word_search_safety/word_search_safety.dart';

class AdivinhePalavraWidget extends StatefulWidget {
  final Size size;
  List<Question> listQuestions;

  AdivinhePalavraWidget(this.size, this.listQuestions, {super.key});

  @override
  State<AdivinhePalavraWidget> createState() => AdivinhePalavraWidgetState();
}

class AdivinhePalavraWidgetState extends State<AdivinhePalavraWidget> {
  late Timer inactivityTimer;
  static const int inactivityDuration = 20;
  bool tutorialDialogShown = false;
  late Size size;
  late List<Question> listQuestions;
  int indexQues = 0; //Index da questão atual
  int hintCount = 0;

  AdvancedIconState _state = AdvancedIconState.primary;

  void _changeState() {
    setState(() {
      if (_state == AdvancedIconState.primary) {
        _state = AdvancedIconState.secondary;
        Future.delayed(Duration(seconds: 1), () {
          _state = AdvancedIconState.primary;
          setState(() {});
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    size = widget.size;
    listQuestions = widget.listQuestions;
    gerarAdivinhe();
    inactivityTimer =
        Timer.periodic(Duration(seconds: inactivityDuration), (timer) {
      // Exibe o indicador de tutorial após um período de inatividade
      if (!tutorialDialogShown) {
        Question? firstUnmatchedShape = currentQuestNotDone();
        if (firstUnmatchedShape != null) {
          showTutorialIndicator();
        }
      }
    });
  }

  void showTutorialIndicator() {
    tutorialDialogShown = true;
    const String text = "Pressione as letras para formar a palavra!";
    // Adicione aqui a lógica para exibir o indicador de tutorial
    // Pode ser um modal, uma mensagem na tela, etc.
    // Por exemplo:
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Dica'),
          content: Container(
            width: MediaQuery.of(context)
                .copyWith()
                .size
                .width, // Ajuste conforme necessário
            height: 250, // Ajuste conforme necessário
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround, // Ajuste conforme necessário
              children: [
                InkWell(
                  child: const FittedBox(
                    child: Text(text,
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  onTap: () {
                    falar(text);
                  },
                ),
                Image.asset(
                  "images/dica_adivinhe_palavra.gif",
                  width: MediaQuery.of(context)
                      .copyWith()
                      .size
                      .width, // Ajuste conforme necessário
                  height: 100, // Ajuste conforme necessário
                  fit: BoxFit.scaleDown,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    tutorialDialogShown =
                        false; // Fechar o indicador de tutorial
                    resetInactivityTimer();
                  },
                  child: const Text(
                    'Entendi',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    inactivityTimer.cancel();
  }

  Question? currentQuestNotDone() {
    if (!listQuestions[indexQues].isDone) {
      return listQuestions[indexQues];
    }
    return null;
  }

  Future<void> resetInactivityTimer() async {
    inactivityTimer.cancel();
    inactivityTimer =
        Timer.periodic(Duration(seconds: inactivityDuration), (timer) {
      if (!tutorialDialogShown) {
        Question? firstUnmatchedShape = currentQuestNotDone();
        if (firstUnmatchedShape != null) {
          showTutorialIndicator();
        }
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Question currentQues = listQuestions[indexQues]; //Pega a questão atual
    //print(currentQues);

    return Container(
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            //Botão de dica , botao de questao anterior, botao de proxima questao respectivamente
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    resetInactivityTimer();
                    gerarDica();
                  },
                  child: AdvancedIcon(
                    icon: Icons.lightbulb_outline,
                    secondaryIcon: Icons.lightbulb,
                    size: 45,
                    color: Colors.yellow[200],
                    state: _state,
                    effect: AdvancedIconEffect.bubble,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () => gerarAdivinhe(left: true),
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        size: 45,
                        color: Colors.yellow[200],
                      ),
                    ),
                    InkWell(
                      onTap: () => gerarAdivinhe(next: true),
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
          //Imagem
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  maxWidth: size.width / 2 * 1.8,
                  //maxHeight: size.width / 2,
                ),
                /*child: Image.network(
                  currentQues.pathImage,
                  fit: BoxFit.contain,
                ),*/
                //Para fazer a img clickavel e falar a reposta
                child: InkWell(
                  child: ClipOval(
                    child: Image.network(
                      currentQues.pathImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  onTap: () {
                    falar(currentQues.info);
                    resetInactivityTimer();
                  },
                ),
                //
              ),
            ),
          ),
          //Pergunta
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: InkWell(
              child: Text(
                "${currentQues.question ?? ''}",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.yellow[200],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                falar(currentQues.question);
                resetInactivityTimer;
              },
              //ainda sem funcionar
            ),
          ),

          //Palavra para adivinhar
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: currentQues.puzzles.map((puzzle) {
                    Color? color = Color.fromARGB(255, 75, 212, 240);
                    if (currentQues.isDone) {
                      color = Colors.green;
                    } else if (puzzle.hintShow) {
                      color = Colors.yellow[100];
                    } else if (currentQues.isFull) {
                      color = Colors.red;
                    } else {
                      color = Color.fromARGB(255, 75, 212, 240);
                    }
                    return InkWell(
                      onTap: () {
                        resetInactivityTimer();
                        if (puzzle.hintShow || currentQues.isDone) return;

                        currentQues.isFull = false;
                        puzzle.clearValue();
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: currentQues.puzzles.length <= 7
                            ? constraints.biggest.width / 7 - 6
                            : constraints.biggest.width /
                                    currentQues.puzzles.length -
                                6,
                        height: constraints.biggest.width / 7 - 6,
                        margin: EdgeInsets.all(3),
                        child: Text(
                          "${puzzle.currentValue ?? ''}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),

          //Botões pra resposta
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisCount: 8,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: 16,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                bool statusBtn = currentQues.puzzles
                        .indexWhere((puzzle) => puzzle.currentIndex == index) >=
                    0;
                return LayoutBuilder(
                  builder: (context, constraints) {
                    Color color = statusBtn
                        ? Colors.white54
                        : Color.fromARGB(255, 75, 212, 240);
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                          ),
                          child: Text(
                            "${currentQues.arrayBtns?[index]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            resetInactivityTimer();
                            if (!statusBtn) {
                              setBtnClick(index);
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

//Função para gerar tanto os botões quando a palavra, além de servir para ir pra proxima ou para voltar
  void gerarAdivinhe(
      {List<Question>? loop, bool next = false, bool left = false}) {
     resetInactivityTimer();
    if (loop != null) {
      indexQues = 0;
      listQuestions = [];
      listQuestions.addAll(loop);
    } else {
      if (next && indexQues < listQuestions.length - 1) {
        indexQues++;
        if (listQuestions[indexQues].isDone == false &&
            listQuestions[indexQues].isFull == true) {
          listQuestions[indexQues].isFull = false;
        }
      } else if (left && indexQues > 0) {
        indexQues--;
        if (listQuestions[indexQues].isDone == false &&
            listQuestions[indexQues].isFull == true) {
          listQuestions[indexQues].isFull = false;
        }
      } else if (indexQues >= listQuestions.length - 1) {
        return;
      }
      setState(() {});
      if (listQuestions[indexQues].isDone) return;
    }
    Question currentQues = listQuestions[indexQues];

    setState(() {});
    //API WordSearch faz sozinho tanto a detecção se está certo a resposta quando gerar o puzzle e os botoes pra ele
    final List<String> wl = [currentQues.answer];
    final WSSettings ws = WSSettings(
      width: 16,
      height: 1,
      orientations: List.from([
        WSOrientation.horizontal,
      ]),
    );

    final WordSearchSafety wordSearch = WordSearchSafety();

    final WSNewPuzzle newPuzzle = wordSearch.newPuzzle(wl, ws);

    if (newPuzzle.errors!.isEmpty) {
      currentQues.arrayBtns = newPuzzle.puzzle!.expand((list) => list).toList();
      currentQues.arrayBtns!
          .shuffle(); //Embaralha os botões pra nao ficarem em ordem

      bool isDone = currentQues.isDone;

      if (!isDone) {
        currentQues.puzzles = List.generate(wl[0].split("").length, (index) {
          return QuestionChar(
              correctValue: currentQues.answer.split("")[index]);
        });
      }
    }

    hintCount = 0;
    setState(() {});
  }

  gerarDica() {
    inactivityTimer.cancel();
    resetInactivityTimer();
    //Gera dica, preenchendo algum char aleatório, se ficar completo vai pro proximo
    Question currentQues = listQuestions[indexQues];
    List<QuestionChar> puzzleNoHints = currentQues.puzzles
        .where((puzzle) => !puzzle.hintShow && puzzle.currentIndex == null)
        .toList();
    if (puzzleNoHints.length > 0 &&
        hintCount < (currentQues.answer.length * 0.6)) {
      AssetsAudioPlayer.newPlayer().open(
        Audio("songs/Tip_song.mp3"),
        autoStart: true,
      );
      _changeState();
      hintCount++;
      int indexHint = Random().nextInt(puzzleNoHints.length);
      int countTemp = 0;
      currentQues.puzzles = currentQues.puzzles.map((puzzle) {
        if (!puzzle.hintShow && puzzle.currentIndex == null) countTemp++;
        if (indexHint == countTemp - 1) {
          if (puzzle.hintShow == false) {
            Future.delayed(Duration(seconds: 1), () {
              falar(puzzle.correctValue as String);
            });
          }
          puzzle.hintShow = true;
          puzzle.currentValue = puzzle.correctValue;
          print("current ${puzzle.correctValue}");
          puzzle.currentIndex = currentQues.arrayBtns!
              .indexWhere((btn) => btn == puzzle.correctValue);
        }
        return puzzle;
      }).toList();

      if (currentQues.fieldCompleteCorrect()) {
        currentQues.isDone = true;
        setState(() {});
        Future.delayed(Duration(seconds: 1));
        gerarAdivinhe(next: true);
      }
      setState(() {
        resetInactivityTimer();
      });
    } else {
      falar("Você chegou ao limite de dicas");
    }
  }

  //Função para o click dos botões, confere se está no lugar certo ou errado
  void setBtnClick(int index) {
    Question currentQues = listQuestions[indexQues];

    int currentIndexEmpty =
        currentQues.puzzles.indexWhere((puzzle) => puzzle.currentValue == null);

    if (currentIndexEmpty >= 0) {
      falar(currentQues.arrayBtns![index]);
      currentQues.puzzles[currentIndexEmpty].currentIndex = index;
      currentQues.puzzles[currentIndexEmpty].currentValue =
          currentQues.arrayBtns![index];

      if (currentQues.fieldCompleteCorrect()) {
        currentQues.isDone = true;
        Future.delayed(Duration(seconds: 1), () {
          falar(currentQues.answer);
        });

        setState(() {});
        Future.delayed(Duration(seconds: 10), () {
          gerarAdivinhe(next: true);
        });
      }
      setState(() {});
    }
  }
}
