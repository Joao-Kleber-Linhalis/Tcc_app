import 'package:flutter/material.dart';
import 'package:quebra_cabecas/data/animal_data.dart';
import 'package:quebra_cabecas/domain/animal.dart';
import 'package:quebra_cabecas/games/adivinhe_palavra/adivinhe_palavra_widget.dart';
import 'package:quebra_cabecas/games/adivinhe_palavra/domain/question.dart';

class AdivinhePalavra extends StatefulWidget {
  const AdivinhePalavra({super.key});

  @override
  State<AdivinhePalavra> createState() => _AdivinhePalavraState();
}

class _AdivinhePalavraState extends State<AdivinhePalavra> {
  GlobalKey<AdivinhePalavraWidgetState> globalKey =
      GlobalKey<AdivinhePalavraWidgetState>();
  
  List<Animal> animal = animals;
  List<Question> listQuestions = [];

  @override
  void initState() {
    super.initState();
    listQuestions = animals.map((animal) {
      return Question(
        question: "Qual é o nome do animal?",
        info: animal.description,
        pathImage: animal.image,
        answer: animal.name.toLowerCase(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adivinhe a palavra"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        color: Theme.of(context).colorScheme.background,
                        child: AdivinhePalavraWidget(
                          constraints.biggest,
                          listQuestions.map((ques) => ques.clone()).toList(),
                          key: globalKey,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      globalKey.currentState?.gerarAdivinhe(
                        loop:
                            listQuestions.map((ques) => ques.clone()).toList(),
                      );
                    },
                    child: Text("Recomeçar"),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
