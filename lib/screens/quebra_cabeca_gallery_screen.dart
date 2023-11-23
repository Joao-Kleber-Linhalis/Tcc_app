import 'package:flutter/material.dart';
import 'package:quebra_cabecas/components/quebra_cabeca_grid.dart';

class QuebraCabecaGalleryScreen extends StatefulWidget {
  const QuebraCabecaGalleryScreen({super.key});

  @override
  State<QuebraCabecaGalleryScreen> createState() =>
      _QuebraCabecaGalleryScreenState();
}

class _QuebraCabecaGalleryScreenState extends State<QuebraCabecaGalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Galeria de Quebra-Cabeças"),
        centerTitle: true,
        actions: [],
      ),
      //Grid pra mostar os jogos
      body: QuebraCabecaGrid(),
    );
  }
}
