import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quebra_cabecas/components/game_item.dart';
import 'package:quebra_cabecas/domain/game.dart';
import 'package:quebra_cabecas/domain/game_list.dart';

class GameGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  GameGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameList>(context);
    final List<Game> loadedGames =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedGames.length,
      //Delega o quadradinho de cada item
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: loadedGames[index],
        child: GameItem(),
      ),
    );
  }
}
