import 'package:flutter/material.dart';

class ColorName extends StatelessWidget {
  final String colorName;
  final Color color;

  ColorName({required this.colorName, required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.1,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          colorName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color, // Use a cor fornecida
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
