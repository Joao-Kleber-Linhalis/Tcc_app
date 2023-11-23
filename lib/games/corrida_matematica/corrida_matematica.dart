import 'package:flutter/material.dart';

import 'roath_path_widget.dart';

class CorridaMatematica extends StatefulWidget {
  const CorridaMatematica({super.key});

  @override
  State<CorridaMatematica> createState() => _CorridaMatematicaState();
}

class _CorridaMatematicaState extends State<CorridaMatematica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: RoadPathWidget(),
        )
      ]),
    );
  }
}
