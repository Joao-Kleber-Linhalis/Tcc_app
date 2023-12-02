import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quebra_cabecas/dependency_injection.dart';
import 'package:quebra_cabecas/domain/animal_list.dart';
import 'package:quebra_cabecas/domain/animal_type_list.dart';
import 'package:quebra_cabecas/domain/game_list.dart';
import 'package:provider/provider.dart';
import 'package:quebra_cabecas/screens/game_overview_screen.dart';
import 'package:quebra_cabecas/screens/opening_screen.dart';

void main() {
  runApp(MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GameList(),
          //Cria a lista de jogos dentro do provider, permitindo acesso dentro de td a arvore de widget
        ),
        ChangeNotifierProvider(
          create: (_) => AnimalList(),
        ),
        ChangeNotifierProvider(
          create: (_) => AnimalTypeList(),
        ),
      ],
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
            background: Colors.cyan,            
          ),
        ),
        home: OpeningScreen(),
      ),
    );
  }
}
