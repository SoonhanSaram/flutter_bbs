import 'package:flutter/material.dart';

class ContainerTextField extends StatelessWidget {
  ContainerTextField({super.key, required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(222, 222, 222, 0.8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(padding: const EdgeInsets.only(left: 12), child: child),
    );
  }
}
