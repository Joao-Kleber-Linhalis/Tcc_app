import 'dart:math';

import 'package:flutter/material.dart';

class CheckPointClass extends ChangeNotifier {
  int percentInt;
  bool complete = false;

  CheckPointClass(this.percentInt);

  setComplete(bool complete) {
    this.complete = complete;
    notifyListeners();
  }

  static List<CheckPointClass> generateRandomCheckPoints() {
    final random = Random();
    final minCheckPoints = 5;
    final maxCheckPoints = 10;
    final minPercent = 10;
    final maxPercent = 90;

    int numberOfCheckPoints =
        minCheckPoints + random.nextInt(maxCheckPoints - minCheckPoints + 1);

    List<int> availablePositions = List.generate(
        maxPercent - minPercent + 1, (index) => minPercent + index);
    List<CheckPointClass> checkPoints = [];

    for (int i = 0; i < numberOfCheckPoints; i++) {
      if (availablePositions.isEmpty) {
        // Se todas as posições foram usadas, podemos sair do loop
        break;
      }

      int randomIndex = random.nextInt(availablePositions.length);
      int randomPercent = availablePositions[randomIndex];

      checkPoints.add(CheckPointClass(randomPercent));
      availablePositions.remove(randomPercent);

      // Remover posições próximas para garantir uma distribuição mais equilibrada
      for (int j = 1; j <= 5; j++) {
        availablePositions.remove(randomPercent + j);
        availablePositions.remove(randomPercent - j);
      }
    }

     checkPoints.sort((a, b) => a.percentInt.compareTo(b.percentInt));

    return checkPoints;
  }
}
