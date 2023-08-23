import 'package:flutter/material.dart';
import 'package:quebra_cabecas/domain/game_list.dart';
import 'package:provider/provider.dart';
import 'package:quebra_cabecas/screens/game_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GameList(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
        ),
        //alterer entre ambos para mudar o jogo, ainda não coloquei um menu
        home: GameOverviewScreen(),
      ),
    );
  }
}
