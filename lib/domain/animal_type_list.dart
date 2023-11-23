import 'package:flutter/material.dart';
import 'package:quebra_cabecas/data/animal_data.dart';
import 'package:quebra_cabecas/domain/animal.dart';

class AnimalTypeList with ChangeNotifier{
  List<AnimalsType> _animalsTypeList = animalTypesList;
  List<AnimalsType> get typeList => [..._animalsTypeList];

  void addAnimal(AnimalsType animalsType){
    _animalsTypeList.add(animalsType);
    notifyListeners();
  }
}