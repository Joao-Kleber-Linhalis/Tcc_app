import 'package:flutter_tts/flutter_tts.dart';

falar(String text) async {
    try {
      FlutterTts fluttertts = FlutterTts();
      await fluttertts.setLanguage("pt-BR");
      await fluttertts.setPitch(1);
      await fluttertts.speak(text);

      await fluttertts.setSpeechRate(0.5);

    } catch (e) {
      print('Erro ao inicializar o flutter_tts: $e');
    }
  }