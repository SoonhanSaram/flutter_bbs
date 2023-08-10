import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BoardList extends StatefulWidget {
  const BoardList({super.key});

  @override
  State<BoardList> createState() => _BoardListState();
}

class _BoardListState extends State<BoardList> {
  List<String> boardNames = [];

  Future<void> getBoardList() async {
    final response = await http.get(
      Uri.parse("http://192.168.0.5:3001/"),
    );
    final listName = jsonDecode(response.body);
    for (int i = 0; i < listName.length; i++) {
      boardNames.add(
        listName[i]['bl_name'],
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getBoardList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: boardNames.length,
      itemBuilder: (
        context,
        index,
      ) {
        return GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Card(
              elevation: 2,
              child: ListTile(
                title: Text(boardNames[index]),
              ),
            ),
          ),
        );
      },
    );
  }
}
