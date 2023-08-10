import 'package:flutter/material.dart';
import 'package:flutter_bbs/provider/functions_basic.dart';
import 'package:provider/provider.dart';

class BoardList extends StatelessWidget {
  const BoardList({super.key});

  @override
  Widget build(BuildContext context) {
    String currentBoard = context.watch<FunctionsBasic>().currentBoard;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Text("$currentBoard 게시판"),
          //  ListView.builder(
          // itemBuilder: (context, index) {
          // return const Card(
          // child: ListTile(),
          // );
          // },
        ),
      ),
    );
  }
}
