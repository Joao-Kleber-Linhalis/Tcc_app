import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quebra_cabecas/components/game_grid.dart';

enum FilterOptions{
  favorite,
  all,
}
 //Tela da galeia de jogos
class GameOverviewScreen extends StatefulWidget {
  const GameOverviewScreen({super.key});

  @override
  State<GameOverviewScreen> createState() => _GameOverviewScreenState();
}

class _GameOverviewScreenState extends State<GameOverviewScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  bool _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Galeria de Jogos"),
        centerTitle: true,
        actions: [
          //Botões superiores
          PopupMenuButton(icon: Icon(Icons.more_vert), 
          itemBuilder: (_) =>[
            PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.all,
              ),
          ],
          onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            }, 
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      //Grid pra mostar os jogos
      body: GameGrid(_showFavoriteOnly),
    );
  }
}