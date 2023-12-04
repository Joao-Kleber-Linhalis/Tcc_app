import 'package:flutter/material.dart';
import 'package:quebra_cabecas/games/corrida_matematica/corrida_matematica.dart';
import 'package:quebra_cabecas/uteis/nav.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../components/build_page.dart';

class DicaScreen extends StatefulWidget {
  const DicaScreen({super.key});

  @override
  State<DicaScreen> createState() => _DicaScreenState();
}

class _DicaScreenState extends State<DicaScreen> {
  final _controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Corrida Matemática"),
        centerTitle: true,
      ),
      body: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.2),
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 4;
            });
          },
          controller: _controller,
          children: [
            BuildPage(context: context, color: Theme.of(context).colorScheme.background, urlImage: 'images/race-image.png', title: 'Sobre o jogo', subtitle: 'Ajude o carrinho a chegar até o final acertando as questões de matemática'),
            BuildPage(context: context, color: Theme.of(context).colorScheme.background, urlImage: 'images/corrida_gifs/corrida_example.gif', title: 'Como Jogar', subtitle: 'O carrinho vai dirigir até encontrar uma pergunta na estrada'),
            BuildPage(context: context, color: Theme.of(context).colorScheme.background, urlImage: 'images/corrida_gifs/corrida_example_acerto.gif', title: 'Como Jogar', subtitle: 'Acerte a pergunta e ele vai seguir em frente até a próxima'),
            BuildPage(context: context, color: Theme.of(context).colorScheme.background, urlImage: 'images/corrida_gifs/corrida_example_erro.gif', title: 'Como Jogar', subtitle: 'Erre a pergunta e ele vai voltar para a anterior'),
            BuildPage(context: context, color: Theme.of(context).colorScheme.background, urlImage: 'images/corrida_gifs/corrida_win.gif', title: 'Fim do Jogo', subtitle: 'Ao chegar no final você pode voltar para a galeria ou subir de nivel até um total de 4'),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  
                ),
                foregroundColor: Colors.cyan.shade900,
                backgroundColor: Colors.cyan.shade900,
                minimumSize: const Size.fromHeight(80),
              ),
              onPressed: () {
                push(context, CorridaMatematica(), replace: true);
              },
              child: const Text(
                'Vamos AprenderJuntos',
                style: TextStyle(fontSize: 24,color: Colors.white),
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.width * 0.2,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.zero,
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => _controller.jumpToPage(4),
                    child: const Text("Pular"),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 5,
                      onDotClicked: (index) => _controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                    child: const Text("Próximo"),
                  ),
                ],
              ),
            ),
    );
  }
}
