import 'package:quebra_cabecas/games/adivinhe_palavra/adivinhe_palavra.dart';
import 'package:quebra_cabecas/domain/game.dart';
import 'package:quebra_cabecas/games/color_game/color_game.dart';
import 'package:quebra_cabecas/games/corrida_matematica/dica_screen.dart';
import 'package:quebra_cabecas/games/memory_game/memory_game.dart';
import 'package:quebra_cabecas/games/shape_match/shape_match.dart';
import 'package:quebra_cabecas/screens/quebra_cabeca_gallery_screen.dart';

//Imagens meramente de exemplo

final dummyGames = [
  Game(
    jogo: AdivinhePalavra(),
    nome: "Adivinhe a palavra",
    imageURL: "images/adivinhe-image.png",
  ),
  Game(
    jogo: QuebraCabecaGalleryScreen(),
    nome: "Quebra Cabeça",
    //imageURL:"https://img.freepik.com/vetores-gratis/fundo-de-quebra-cabeca-colorido_1308-117161.jpg?w=2000"),
    imageURL: "images/puzzle-image.png",
  ),
  Game(
    jogo: ShapeMatch(),
    nome: "Som das Letras",
    imageURL: "images/som-palavra-image.png",
  ),
  Game(
    jogo: DicaScreen(),
    nome: "Corrida Matemática",
    imageURL: "images/race-image.png",
  ),
  Game(
    jogo: MemoryGame(),
    nome: "Jogo da Memória",
    imageURL: "images/memory-image.png",
  ),
  Game(
    jogo: ColorGame(),
    nome: "Rota das Cores",
    imageURL: "images/color-image.png",
  ),
];
