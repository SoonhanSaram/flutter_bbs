import 'package:flutter/material.dart';
import 'package:flutter_bbs/provider/functions_basic.dart';
import 'package:flutter_bbs/provider/functions_writing.dart';
import 'package:provider/provider.dart';

class DropDownButtons extends StatefulWidget {
  const DropDownButtons({super.key});

  @override
  State<DropDownButtons> createState() => _DropDownButtonsState();
}

class _DropDownButtonsState extends State<DropDownButtons> {
  String _selectedItem = "";
  @override
  Widget build(BuildContext context) {
    String currentBoard = context.watch<FunctionsBasic>().currentBoard;
    List<String> boardNames = context.watch<FunctionsBasic>().boardNames;
    FunctionsWriting functionsWriting = Provider.of<FunctionsWriting>((context), listen: false);

    return PopupMenuButton<String>(
      onSelected: (String newValue) {
        setState(() {
          _selectedItem = newValue;
          functionsWriting.updateBoard(newValue);
        });
      },
      itemBuilder: (BuildContext context) {
        return boardNames.map<PopupMenuEntry<String>>(
          (String value) {
            return PopupMenuItem<String>(
              value: value,
              child: Text(value),
            );
          },
        ).toList();
      },
      child: ListTile(
        title: Text(_selectedItem == "" ? currentBoard : _selectedItem),
        trailing: const Icon(Icons.arrow_drop_down),
      ),
    );
  }
}
