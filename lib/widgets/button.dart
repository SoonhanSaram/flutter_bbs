import 'package:flutter/material.dart';

class VariousButton extends StatelessWidget {
  const VariousButton({Key? key, required this.buttonTitle, required this.function}) : super(key: key);

  final String buttonTitle;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {function()},
      child: Text(buttonTitle ?? "버튼"),
    );
  }
}
