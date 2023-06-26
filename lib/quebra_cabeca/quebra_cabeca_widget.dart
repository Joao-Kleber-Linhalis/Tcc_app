import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quebra_cabecas/quebra_cabeca/domain/imageBox.dart';
import 'package:quebra_cabecas/quebra_cabeca/domain/peca_quebra_cabeca.dart';
import 'package:image/image.dart' as ui;
import 'dart:math' as math;
import 'package:quebra_cabecas/quebra_cabeca/domain/pos_peca_quebra_cabeca.dart';
import 'package:quebra_cabecas/quebra_cabeca/peca_quebra_cabeca_widget.dart';
export 'quebra_cabeca_widget.dart';

class QuebraCabecaWidget extends StatefulWidget {
  final Widget child;
  final Function() callBackFinish;
  final Function() callBackSucess;
  QuebraCabecaWidget({super.key, required this.child, required  this.callBackFinish, required  this.callBackSucess});

  @override
  State<QuebraCabecaWidget> createState() => QuebraCabecaWidgetState();
}

class QuebraCabecaWidgetState extends State<QuebraCabecaWidget> {
  GlobalKey _globalKey = GlobalKey();
  Size size = Size(0, 0);
  late ui.Image fullImage;

  List<List<PecaQuebraCabeca>> pecas = [];
  ValueNotifier<List<PecaQuebraCabeca>> blockNotifier =
      ValueNotifier<List<PecaQuebraCabeca>>(<PecaQuebraCabeca>[]);
  late CarouselController _carouselController;

  //Atual posicao e index
  Offset _pos = Offset.zero;
  late int _index;

  _getImageFromWidget() async {
    //Pega a imagem atual que está preenchendo o Container
    RenderRepaintBoundary? boundary =
        _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    size = boundary!.size;
    var img = await boundary.toImage();
    var byteData = await img.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData?.buffer.asUint8List();
    return ui.decodeImage(pngBytes!);
  }

  reiniciarQuebraCabeca() {
    //Reinicia
    pecas.clear();
    blockNotifier = ValueNotifier<List<PecaQuebraCabeca>>(<PecaQuebraCabeca>[]);
    //_carouselController = CarouselController();
    blockNotifier.notifyListeners();
    setState(() {});
  }

  //Função que corta a imagem
  Future<void> geradorQuebraCabecaPecas() async {
    //Lista do block de imagens (pecas)
    pecas = [];

    //Pegar a imagem
    fullImage = await _getImageFromWidget();

    // quantas peças y = linhas/altura & x = coluna/largura  
    //PRECISAM SER IGUAIS
    int xSplitCount = 5;
    int ySplitCount = 5;

    double widthPerBlock = fullImage.height / xSplitCount;
    double heightPerBlock = fullImage.height / ySplitCount;

    for (var y = 0; y < ySplitCount; y++) {
      //Imagens temporárias

      List<PecaQuebraCabeca> tempImages = [];
      pecas.add(tempImages);
      for (var x = 0; x < xSplitCount; x++) {
        int posicaoLinhaAleatoria = math.Random().nextInt(2) % 2 == 0 ? 1 : -1;
        int posicaoColunaAleatoria = math.Random().nextInt(2) % 2 == 0 ? 1 : -1;

        Offset offsetCenter = Offset(widthPerBlock / 2, heightPerBlock / 2);

        PosPecaQuebraCabeca posPecaQuebraCabeca = PosPecaQuebraCabeca(
          bottom: y == ySplitCount - 1 ? 0 : posicaoColunaAleatoria,
          left: x == 0
              ? 0
              : -pecas[y][x - 1].pecaQuebraCabecaWidget.imageBox.posicao.right,
          right: x == xSplitCount - 1 ? 0 : posicaoLinhaAleatoria,
          top: y == 0
              ? 0
              : -pecas[y - 1][x].pecaQuebraCabecaWidget.imageBox.posicao.bottom,
        );

        double xAxis = widthPerBlock * x;
        double yAxis = widthPerBlock * y;

        double minSize = math.min(widthPerBlock, heightPerBlock) / 15 * 4;
        offsetCenter = Offset(
          (widthPerBlock / 2) + (posPecaQuebraCabeca.left == 1 ? minSize : 0),
          (heightPerBlock / 2) + (posPecaQuebraCabeca.top == 1 ? minSize : 0),
        );

        xAxis -= posPecaQuebraCabeca.left == 1 ? minSize : 0;
        yAxis -= posPecaQuebraCabeca.top == 1 ? minSize : 0;

        double widthPerBlockTemp = widthPerBlock +
            (posPecaQuebraCabeca.left == 1 ? minSize : 0) +
            (posPecaQuebraCabeca.right == 1 ? minSize : 0);
        double heightPerBlockTemp = widthPerBlock +
            (posPecaQuebraCabeca.top == 1 ? minSize : 0) +
            (posPecaQuebraCabeca.bottom == 1 ? minSize : 0);

        //Criar imagem cortada pra cada bloco

        ui.Image temp = ui.copyCrop(
          fullImage,
          x: xAxis.round(),
          y: yAxis.round(),
          width: widthPerBlockTemp.round(),
          height: heightPerBlockTemp.round(),
        );

        Offset offset = Offset(size.width / 2 - widthPerBlockTemp / 2,
            size.height / 2 - heightPerBlockTemp / 2);

        ImageBox imageBox = ImageBox(
          image: Image.memory(
            ui.encodePng(temp),
            fit: BoxFit.contain,
          ),
          isDone: false,
          offsetCenter: offsetCenter,
          posicao: posPecaQuebraCabeca,
          radiusPoint: minSize,
          size: Size(widthPerBlockTemp, heightPerBlockTemp),
        );

        pecas[y].add(
          PecaQuebraCabeca(
            offset: offset,
            offsetDefault: Offset(xAxis, yAxis),
            pecaQuebraCabecaWidget: PecaQuebraCabecaWidget(
              imageBox: imageBox,
            ),
          ),
        );
      }
    }
    blockNotifier.value = pecas.expand((image) => image).toList();
    blockNotifier.value.shuffle();
    blockNotifier.notifyListeners();
    //_index = 0;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _index = 0;
    _carouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeBox = MediaQuery.of(context).size;

    return ValueListenableBuilder(
        valueListenable: blockNotifier,
        builder: (context, List<PecaQuebraCabeca> pecas, child) {
          //Lista de peças já colocadas e não colocadas
          List<PecaQuebraCabeca> pecasNotDone = pecas
              .where((block) => !block.pecaQuebraCabecaWidget.imageBox.isDone)
              .toList();
          List<PecaQuebraCabeca> pecasDone = pecas
              .where((block) => block.pecaQuebraCabecaWidget.imageBox.isDone)
              .toList();
          return Container(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: sizeBox.width,
                    child: Listener(
                      //Para evento de mover
                      onPointerUp: (event) {
                        if (pecasNotDone.length == 0) {
                          reiniciarQuebraCabeca();
                          widget.callBackFinish.call();
                        }
                        if (_index == -1) {
                          _carouselController.nextPage(
                            duration: Duration(microseconds: 200), //Velocidade para aparecer a proxima peça
                          );
                          setState(() {
                            //_index = 0;
                          });
                        }
                      },
                      onPointerMove: (event) {
                        if (_index == -1) return;

                        Offset offset = event.localPosition - _pos;

                        pecasNotDone[_index].offset = offset;

                        if ((pecasNotDone[_index].offset -
                                    pecasNotDone[_index].offsetDefault)
                                .distance <
                            5) {
                          //Trazer o bloco/peça para perto da posição padrão dele
                          //vai ativar esse if e colocar ele no lugar e marcar como feito

                          pecasNotDone[_index]
                              .pecaQuebraCabecaWidget
                              .imageBox
                              .isDone = true;
                          pecasNotDone[_index].offset =
                              pecasNotDone[_index].offsetDefault;

                          _index = -1;

                          blockNotifier.notifyListeners();
                          widget.callBackSucess.call();
                        }

                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          if (pecas.length == 0) ...[
                            RepaintBoundary(
                              key: _globalKey,
                              child: Container(
                                //color: Colors.white,
                                //height: double.maxFinite,
                                //width: double.maxFinite,
                                child: widget.child,
                              ),
                            )
                          ],
                          Offstage(
                            offstage: !(pecas.length > 0),
                            child: Container(
                              color: Colors.white, //Cor do background das peças
                              width: size.width,
                              height: size.height,
                              child: CustomPaint(
                                painter: QuebraCabecaPintorBackground(pecas),
                                //Pinta o background branco pra deixar a marca de recorte das peças
                                child: Stack(
                                  children: [
                                    if (pecasDone.length > 0)
                                      ...pecasDone.map(
                                        (map) {
                                          return Positioned(
                                            left: map.offset.dx,
                                            top: map.offset.dy,
                                            child: Container(
                                              child: map.pecaQuebraCabecaWidget,
                                            ),
                                          );
                                        },
                                      ),
                                    if (pecasNotDone.length > 0)
                                      ...pecasNotDone.asMap().entries.map(
                                        (map) {
                                          return Positioned(
                                            left: map.value.offset.dx,
                                            top: map.value.offset.dy,
                                            child: Offstage(
                                              offstage: !(_index == map.key),
                                              child: GestureDetector(
                                                //Evento de movimento
                                                onTapDown: (details) {
                                                  if (map
                                                      .value
                                                      .pecaQuebraCabecaWidget
                                                      .imageBox
                                                      .isDone) return;

                                                  setState(() {
                                                    _pos =
                                                        details.localPosition;
                                                    _index = map.key;
                                                  });
                                                },
                                                child: Container(
                                                  child: map.value
                                                      .pecaQuebraCabecaWidget,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //Container inferior com o carrosel de peças que ainda não foram posicionadas
                  Container(
                    color: Colors.black,
                    height: 100,
                    child: CarouselSlider(
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        initialPage: _index,
                        height: 80,
                        aspectRatio: 1,
                        viewportFraction: 0.15,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        disableCenter: false,
                        onPageChanged: (index, reason) {
                          _index = index;
                          setState(() {});
                        },
                      ),
                      items: pecasNotDone.map((peca) {
                        Size sizePeca =
                            peca.pecaQuebraCabecaWidget.imageBox.size;
                        return FittedBox(
                          child: Container(
                            width: sizePeca.width,
                            height: sizePeca.height,
                            child: peca.pecaQuebraCabecaWidget,
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class QuebraCabecaPintorBackground extends CustomPainter {
  List<PecaQuebraCabeca> pecas;

  QuebraCabecaPintorBackground(this.pecas);
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = new Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black12
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    Path path = Path();
    this.pecas.forEach((element) {
      Path pathTemp = getPiecePath(
        element.pecaQuebraCabecaWidget.imageBox.size,
        element.pecaQuebraCabecaWidget.imageBox.radiusPoint,
        element.pecaQuebraCabecaWidget.imageBox.offsetCenter,
        element.pecaQuebraCabecaWidget.imageBox.posicao,
      );

      path.addPath(pathTemp, element.offsetDefault);
    });
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
