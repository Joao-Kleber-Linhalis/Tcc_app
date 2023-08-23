import 'package:flutter/material.dart';

class Game with ChangeNotifier{
  final Widget jogo;
  bool isFavorite;
  final String nome;
  final String imageURL;

  Game({
    required this.jogo,
    this.isFavorite = false,
    required this.nome,
    required this.imageURL
  });

  void toggleFavorite(){
    isFavorite = !isFavorite;
    notifyListeners();
  }
}