import 'package:flutter_tts/flutter_tts.dart';

falar(String text) async {
    try {
      FlutterTts fluttertts = FlutterTts();
      print(text + ' dentro do util');
      await fluttertts.setLanguage("pt-BR");
      await fluttertts.setPitch(1);
      await fluttertts.speak(text);
    } catch (e) {
      print('Erro ao inicializar o flutter_tts: $e');
    }
  }