import 'package:flutter/material.dart';

class BuildPage extends StatelessWidget {
  const BuildPage({
    super.key,
    required this.context,
    required this.color,
    required this.urlImage,
    required this.title,
    required this.subtitle,
  });

  final BuildContext context;
  final Color color;
  final String urlImage;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              urlImage,
              fit: BoxFit.scaleDown,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.cyan.shade900,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(),
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
}
