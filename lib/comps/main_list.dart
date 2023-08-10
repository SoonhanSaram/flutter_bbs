import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bbs/provider/functions_basic.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MainList extends StatefulWidget {
  const MainList({super.key});

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  List<String> boardNames = [];
// initState 에서 비동기 함수를 쓸 수 없다. 그래서 아래 함수가 다 실행되기 전에 화면이
// init 되는 현상을 겪음
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

// 아래 함수를 통해서 한 번 더 비동기화 시켜 화면을 제대로 보여줌
  Future<void> _initialize() async {
    await getBoardList(); // 비동기 함수 호출
    setState(() {}); // 데이터를 가져온 후에 위젯을 업데이트
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FunctionsBasic functionsBasic = Provider.of<FunctionsBasic>((context), listen: false);
    return ListView.builder(
      itemCount: boardNames.length,
      itemBuilder: (
        context,
        index,
      ) {
        return GestureDetector(
          onTap: () {
            functionsBasic.getBoardList(boardNames[index]);
            Navigator.pushNamed(context, '/board');
          },
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
