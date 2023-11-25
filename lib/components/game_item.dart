import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quebra_cabecas/domain/game.dart';
import 'package:quebra_cabecas/uteis/nav.dart';

class GameItem extends StatelessWidget {
  const GameItem({super.key});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context, listen: false);
    return GestureDetector(
      onTap: () {
        push(context, game.jogo);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: game.imageURL.startsWith('http')
                    ? Image.network(
                        game.imageURL,
                        fit: BoxFit.contain, // Ajusta o tamanho da imagem
                      )
                    : Image.asset(
                        game.imageURL,
                        fit: BoxFit.contain, // Ajusta o tamanho da imagem
                      ),
              ),
            ),
            Container(
              color: Colors.black54,
              child: ListTile(
                title: Text(
                  game.nome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
                leading: Consumer<Game>(
                  builder: (ctx, game, _) => IconButton(
                    onPressed: () {
                      game.toggleFavorite();
                    },
                    icon: Icon(
                      game.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
