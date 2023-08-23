import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quebra_cabecas/domain/game.dart';
import 'package:quebra_cabecas/uteis/nav.dart';

class GameItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: FittedBox(
            child: Text(
              game.nome,
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: Colors.black54,
          leading: Consumer<Game>(
            builder: (ctx, game, _) => IconButton(
              onPressed: () {
                game.toggleFavorite();
              },
              icon: Icon(
                  game.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        child: GestureDetector(
          child: Image.network(
            game.imageURL,
            fit: BoxFit.cover,
          ),
          onTap: (){
            push(context, game.jogo);
          },
        ),
      ),
    );
  }
}
