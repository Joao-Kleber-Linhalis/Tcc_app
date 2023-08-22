import 'package:flutter/material.dart';
import 'package:quebra_cabecas/adivinhe_palavra/adivinhe_palavra.dart';
import 'package:quebra_cabecas/quebra_cabeca/puzzle_quebra_cabeca.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //alterer entre ambos para mudar o jogo, ainda não coloquei um menu
        home: //AdivinhePalavra());
        PuzzleQuebraCabeca());
        
  }
}
