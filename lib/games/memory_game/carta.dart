import 'dart:math';

class Carta {
  int index;
  int qtd;
  String fruta = "🍎";
  bool back;

  Carta({required this.qtd, required this.index,this.back =false});

  static List<Carta> generateRandomList(int maxNumber) {
    int size = 8;
    List<Carta> cartas = [];
    List<int> uniqueNumbers = [];
    Random random = Random();

    while (uniqueNumbers.length < size / 2) {
      int randomNumber = random.nextInt(maxNumber) + 1;
      if (!uniqueNumbers.contains(randomNumber)) {
        uniqueNumbers.add(randomNumber);
      }
    }

    for (var i = 0; i < uniqueNumbers.length; i++) {
      cartas.add(Carta(qtd: uniqueNumbers[i], index: i,back: true));
      cartas.add(Carta(qtd: uniqueNumbers[i], index: i));
    }

    

    cartas.shuffle();

    return cartas;
  }
}
