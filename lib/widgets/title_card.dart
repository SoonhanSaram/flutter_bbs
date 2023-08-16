import 'package:flutter/material.dart';

class titleCard extends StatelessWidget {
  titleCard({super.key, required this.title, this.fontSize = 36, this.boxSize = 1});

  String title;
  double fontSize;
  double boxSize;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * boxSize,
            child: Text(
              title,
              style: TextStyle(fontSize: fontSize == 36 ? 36 : fontSize),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
