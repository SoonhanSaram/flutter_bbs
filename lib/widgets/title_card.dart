import 'package:flutter/material.dart';

class titleCard extends StatelessWidget {
  titleCard({super.key, required this.title, this.size = 36});

  String title;
  double size;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(
        title,
        style: TextStyle(fontSize: size == 36 ? 36 : size),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
