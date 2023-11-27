import "package:awesome_snackbar_content/awesome_snackbar_content.dart";
import "package:connectivity_wrapper/connectivity_wrapper.dart";
import "package:flutter/material.dart";
import "package:quebra_cabecas/screens/game_overview_screen.dart";
import "package:quebra_cabecas/uteis/nav.dart";

class OpeningScreen extends StatefulWidget {
  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {

  _checkConnection(){
    setState(() {
      _connected = true;
    });
    Future future = Future.delayed(Duration(seconds: 5));
    future.then(
      (value) async => {
        if (await ConnectivityWrapper.instance.isConnected)
          {
            print("Com internet"),
            push(context, GameOverviewScreen(), replace: true),
          }
        else
          {
            print("Sem internet"),
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar),
            setState(() {
              _connected = false;
            }),
          }
      },
    );
  }

  bool _connected = true;

  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Sem conexão',
      message:
          "O dispositivo não está conectado à Internet, conecte-o e tente novamente",
      contentType: ContentType.failure,
    ),
  );

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/icon-app.png",
              fit: BoxFit.contain,
              width:
                  screenWidth, // Ajuste o tamanho da imagem para ser igual à largura da tela
            ),
            const SizedBox(
                height:
                    16), // Espaçamento entre a imagem e o LinearProgressIndicator
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
              child: _connected
                  ? const LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        _checkConnection();
                      },
                      child: Text('Tentar Novamente'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
