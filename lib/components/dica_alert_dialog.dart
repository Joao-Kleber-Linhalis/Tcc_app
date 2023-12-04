import 'package:flutter/material.dart';
import 'package:quebra_cabecas/uteis/speak.dart';

class DicaAlertDialog extends StatelessWidget {
  DicaAlertDialog({
    Key? key,
    required this.dicaText,
    required this.dicaPath,
  }) : super(key: key);

  final String dicaText;
  final String dicaPath;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 70,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                child: FittedBox(
                  child: Text(
                    dicaText,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Cor do texto da dica
                    ),
                  ),
                ),
                onTap: () {
                  falar(dicaText);
                },
              ),
              SizedBox(height: 20),
              Image.asset(
                dicaPath,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Fechar o indicador de tutorial
                },
                child: const Text(
                  'Entendi',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 30,
            child: Icon(
              Icons.lightbulb,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}
