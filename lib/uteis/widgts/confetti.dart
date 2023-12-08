import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class ConfettiHelper {
  static ConfettiController createController() {
    return ConfettiController(duration: const Duration(seconds: 5));
  }

  static void showConfetti(ConfettiController controller) {
    controller.play();
  }

  static Widget confettiWidget(ConfettiController controller) {
    // Gere um valor aleatório para blastDirection
    //double blastDirection = Random().nextDouble() * (2 * pi) - pi;

    return ConfettiWidget(
      confettiController: controller,
      blastDirection: -pi/2,
      emissionFrequency: 0.05,
      numberOfParticles: 200,
      maxBlastForce: 100,
      minBlastForce: 80,
      blastDirectionality: BlastDirectionality.explosive,
      shouldLoop: false,
    );
  }
}