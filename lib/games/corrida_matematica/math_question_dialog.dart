import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quebra_cabecas/screens/game_overview_screen.dart';
import 'package:quebra_cabecas/uteis/speak.dart';

class MathQuestionDialog extends StatefulWidget {
  @override
  _MathQuestionDialogState createState() => _MathQuestionDialogState();
}

class _MathQuestionDialogState extends State<MathQuestionDialog> {
  late int num1;
  late int num2;
  late int correctAnswer;
  late List<int> options;
  late String question;

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    final Random random = Random();

    num1 = random.nextInt(10) + 1; // Números entre 1 e 10
    num2 = random.nextInt(10) + 1;

    correctAnswer = num1 + num2;

    // Criar opções aleatórias
    options = [correctAnswer];

    while (options.length < 4) {
      int wrongAnswer = random.nextInt(19) + 1; // Números entre 1 e 19
      if (!options.contains(wrongAnswer)) {
        options.add(wrongAnswer);
      }
    }

    options.shuffle(); // Embaralhar as opções
    question = 'Quanto é $num1 + $num2?';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: const Text(
        'Pergunta de Matemática',
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              falar(question);
            },
            child: Container(
              alignment: Alignment.center,
              width: size.width,
              child: Text(
                question,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width / 15,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: options
                .map(
                  (option) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    //color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context, option == correctAnswer);
                            },
                            child: Text(
                              '$option',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width / 25),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            falar('$option');
                          },
                          icon: Icon(Icons.volume_up),
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => GameOverviewScreen(),
              ),
            ),
            child: Text("Voltar a Galeria de Jogos"),
          )
        ],
      ),
    );
  }
}
