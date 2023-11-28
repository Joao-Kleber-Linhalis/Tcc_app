import 'package:flutter/material.dart';
import 'package:quebra_cabecas/uteis/speak.dart';

class dica_alert_dialog extends StatelessWidget {
  dica_alert_dialog({
    super.key,
    required this.dicaText,
    required this.dicaPath,
  });

  final String dicaText;
  final String dicaPath;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Info'),
      content: Container(
        width: MediaQuery.of(context)
            .copyWith()
            .size
            .width, // Ajuste conforme necessário
        height: 250, // Ajuste conforme necessário
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround, // Ajuste conforme necessário
          children: [
            InkWell(
              child: FittedBox(
                child: Text(
                  dicaText,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () {
                falar(dicaText);
              },
            ),
            Image.asset(
              dicaPath,
              width: MediaQuery.of(context)
                  .copyWith()
                  .size
                  .width, // Ajuste conforme necessário
              height: 100, // Ajuste conforme necessário
              fit: BoxFit.scaleDown,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Fechar o indicador de tutorial
              },
              child: const Text(
                'Entendi',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
