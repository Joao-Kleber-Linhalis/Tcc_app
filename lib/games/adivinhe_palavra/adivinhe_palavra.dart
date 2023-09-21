import 'package:flutter/material.dart';
import 'package:quebra_cabecas/games/adivinhe_palavra/adivinhe_palavra_widget.dart';
import 'package:quebra_cabecas/games/adivinhe_palavra/data/list_questions.dart';
import 'package:quebra_cabecas/games/adivinhe_palavra/domain/question.dart';

class AdivinhePalavra extends StatefulWidget {
  const AdivinhePalavra({super.key});

  @override
  State<AdivinhePalavra> createState() => _AdivinhePalavraState();
}

class _AdivinhePalavraState extends State<AdivinhePalavra> {
  GlobalKey<AdivinhePalavraWidgetState> globalKey =
      GlobalKey<AdivinhePalavraWidgetState>();

  @override
  void initState() {
    super.initState();
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
            color: Colors.green,
            child: Column(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        color: Colors.blue,
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
