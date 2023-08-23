import 'package:quebra_cabecas/adivinhe_palavra/adivinhe_palavra.dart';
import 'package:quebra_cabecas/domain/game.dart';
import 'package:quebra_cabecas/quebra_cabeca/puzzle_quebra_cabeca.dart';

final dummyGames = [
  Game(
      jogo: AdivinhePalavra(),
      nome: "Adivinhe a palavra",
      imageURL:
          "https://store-images.s-microsoft.com/image/apps.51490.13510798887526643.2ccfb2da-daa6-4920-902a-d8361f4e6546.4e262467-6b45-4455-971d-743d6b508153?mode=scale&q=90&h=720&w=1280"),
  Game(
      jogo: PuzzleQuebraCabeca(),
      nome: "Quebra Cabeça",
      imageURL:
          "https://img.freepik.com/vetores-gratis/fundo-de-quebra-cabeca-colorido_1308-117161.jpg?w=2000"),
];
