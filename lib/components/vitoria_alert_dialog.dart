import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quebra_cabecas/screens/game_overview_screen.dart';
import 'package:quebra_cabecas/uteis/nav.dart';
import 'package:quebra_cabecas/uteis/speak.dart';

class VitoriaAlertDialog extends StatelessWidget {
  final Function() resetGame;
  final bool next;
  final int nivel;

  const VitoriaAlertDialog({Key? key, required this.resetGame, this.next =false,this.nivel = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String win;
    IconData secondIcon = Icons.arrow_forward;
    if(next){
      win = "Você concluiu o Quebra-cabeça";
    }else if(nivel > 0 && nivel != 4){
      win = "Você conclui o nivel $nivel de 4";
    } else{
      win = "Você concluiu o jogo";
      secondIcon = Icons.refresh;
    }
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context, win,secondIcon),
    );
  }

  Widget contentBox(BuildContext context, String win, IconData secondIcon) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 100,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
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
                    win,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green, // Cor do texto de vitória
                    ),
                  ),
                ),
                onTap: () {
                  falar(win);
                },
              ),
              SizedBox(height: 20),
              Lottie.asset(
                'images/win.json',
                width: MediaQuery.of(context).size.width * 0.8,
                height: 100,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      push(context, GameOverviewScreen(), replace: true);
                    },
                    child: Icon(
                      Icons.home,
                      size: 40,
                      color: Colors.blue, // Cor do ícone de voltar
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      pop(context);
                      resetGame();
                    },
                    child: Icon(
                      secondIcon,
                      size: 40,
                      color: Colors.orange, // Cor do ícone de reiniciar
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: 50,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 60,
            ),
          ),
        ),
      ],
    );
  }
}
