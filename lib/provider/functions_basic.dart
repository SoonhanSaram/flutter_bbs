import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FunctionsBasic extends ChangeNotifier {
  String _currentBoard = "";
  String get currentBoard => _currentBoard;
  Future<void> getBoardList(String boardName) async {
    if (boardName.isNotEmpty) {
      print(boardName);
      _currentBoard = boardName;
      final response = await http.get(
        Uri.parse(
          "http://192.168.0.5:3001/board/$boardName",
        ),
      );
      final body = jsonDecode(response.body);
    } else {
      print("게시판 검색 실패");
    }
  }
}
