import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quebra_cabecas/domain/game.dart';
import 'package:quebra_cabecas/domain/game_list.dart';
import 'package:quebra_cabecas/uteis/nav.dart';

import 'game_item.dart';

class GameGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  GameGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameList>(context);
    final List<Game> loadedGames =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: loadedGames.length,
      itemBuilder: (ctx, index) => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ChangeNotifierProvider.value(
          value: loadedGames[index],
          child: GameItem(),
        ),
      ),
    );
  }
}
