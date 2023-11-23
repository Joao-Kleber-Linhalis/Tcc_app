import 'package:flutter/material.dart';
import 'package:quebra_cabecas/data/animal_data.dart';
import 'package:quebra_cabecas/domain/animal.dart';

class AnimalList with ChangeNotifier{
  List<Animal> _animalsList = animals;
  List<Animal> get animalsList => [..._animalsList];
  List<Animal> animalsListType(String type){
    return _animalsList.where((animal) => animal.type == type).toList();
  }

  void addAnimal(Animal animal){
    _animalsList.add(animal);
    notifyListeners();
  }
}