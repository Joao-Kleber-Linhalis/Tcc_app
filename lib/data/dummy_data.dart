import 'package:quebra_cabecas/games/adivinhe_palavra/adivinhe_palavra.dart';
import 'package:quebra_cabecas/domain/game.dart';
import 'package:quebra_cabecas/games/corrida_matematica/corrida_matematica.dart';
import 'package:quebra_cabecas/games/quebra_cabeca/puzzle_quebra_cabeca.dart';
import 'package:quebra_cabecas/games/shape_match/shape_match.dart';
import 'package:quebra_cabecas/screens/quebra_cabeca_gallery_screen.dart';

//Imagens meramente de exemplo

final dummyGames = [
  Game(
      jogo: AdivinhePalavra(),
      nome: "Adivinhe a palavra",
      imageURL:
          "https://store-images.s-microsoft.com/image/apps.51490.13510798887526643.2ccfb2da-daa6-4920-902a-d8361f4e6546.4e262467-6b45-4455-971d-743d6b508153?mode=scale&q=90&h=720&w=1280",),
  Game(
      jogo: QuebraCabecaGalleryScreen(),
      nome: "Quebra Cabeça",
      //imageURL:"https://img.freepik.com/vetores-gratis/fundo-de-quebra-cabeca-colorido_1308-117161.jpg?w=2000"),
      imageURL:"images/puzzle-image.png",),
  Game(
    jogo: ShapeMatch(),
    nome: "Correspondência de formas",
    imageURL: "https://www.artesanatopassoapassoja.com.br/wp-content/uploads/2021/01/formas-geometricas.jpg",
  ),
  Game(
    jogo: CorridaMatematica(),
    nome: "Corrida Matemática",
    imageURL: "images/race-image.png"
  ),
];
