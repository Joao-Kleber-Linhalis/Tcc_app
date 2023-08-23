import 'package:flutter/material.dart';
import 'package:quebra_cabecas/data/dummy_data.dart';
import 'package:quebra_cabecas/domain/game.dart';

class GameList with ChangeNotifier{
  List<Game> _items = dummyGames;
  List<Game> get items => [..._items];
  List<Game> get favoriteItems => _items.where((jogo) => jogo.isFavorite).toList();

  void addJogo(Game jogo){
    _items.add(jogo);
    notifyListeners();
  }
  }