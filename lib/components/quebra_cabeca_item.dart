import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quebra_cabecas/domain/animal.dart';
import 'package:quebra_cabecas/domain/animal_list.dart';
import 'package:quebra_cabecas/games/quebra_cabeca/puzzle_quebra_cabeca.dart';
import 'package:quebra_cabecas/uteis/nav.dart';

class QuebraCabecaItem extends StatelessWidget {
  const QuebraCabecaItem({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnimalList>(context);
    final List<Animal> allAnimals = provider.animalsList;
    final type = Provider.of<AnimalsType>(context, listen: false);
    final List<Animal> animals = allAnimals.where((element) => element.type == type.tableName).toList();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: FittedBox(
            child: Text(
              type.tableName,
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: Colors.black54,
        ),
        child: GestureDetector(
          child: type.bgImage.startsWith('http')
              ? Image.network(
                  type.bgImage,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  type.bgImage,
                  fit: BoxFit.cover,
                ),
          onTap: () {
            push(context, PuzzleQuebraCabeca(animals: animals));
          },
        ),
      ),
    );
  }
}