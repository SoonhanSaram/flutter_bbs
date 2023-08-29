import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FunctionsBasic extends ChangeNotifier {
  String _currentBoard = "";
  final List<String> _boardNames = [];
  List<String> get boardNames => _boardNames;
  final List<Map<String, dynamic>> _posts = [];
  List<Map<String, dynamic>> get posts => _posts;

  // 학과 리스트 가져오기
  Future<void> getBoard() async {
    boardNames.clear();
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

  String get currentBoard => _currentBoard;
  // 학과별 글 가져오기
  Future<void> getBoardList(String boardName) async {
    _posts.clear();
    if (boardName.isNotEmpty) {
      _currentBoard = boardName;
      final response = await http.get(
        Uri.parse(
          "http://192.168.0.5:3001/board/$boardName",
        ),
      );
      final postsData = jsonDecode(response.body);
      for (int i = 0; i < postsData.length; i++) {
        _posts.add(postsData[i]);
      }
      print(_posts);
      notifyListeners();
    } else {
      print("게시판 검색 실패");
    }
  }
}
