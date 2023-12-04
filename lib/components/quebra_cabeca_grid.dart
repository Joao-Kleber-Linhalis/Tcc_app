import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quebra_cabecas/components/quebra_cabeca_item.dart';
import 'package:quebra_cabecas/domain/animal.dart';
import 'package:quebra_cabecas/domain/animal_type_list.dart';

class QuebraCabecaGrid extends StatelessWidget {
  const QuebraCabecaGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnimalTypeList>(context);
    final List<AnimalsType> types = provider.typeList;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: types.length,
      //Delega o quadradinho de cada item
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: types[index],
        child: QuebraCabecaItem(),
      ),
    );
  }
}