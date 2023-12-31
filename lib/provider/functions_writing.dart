import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FunctionsWriting extends ChangeNotifier {
  String _boardName = "";
  String get boardName => _boardName;
  final String _postTitle = "";
  String get postList => _postTitle;
  final String _postContent = "";
  String get postContent => _postContent;

  Future<void> updateBoard(category) async {
    _boardName = category;
  }

  void callSnackBar(context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // 글쓰기
  Future<void> postingBoard(BuildContext context, title, content, String? currentBoard, token) async {
    if (title == "") {
      callSnackBar(context, "제목을 입력해주세요");
    } else if (content == "") {
      callSnackBar(context, "내용을 입력해주세요");
    } else {
      final response = await http.post(
        Uri.parse("http://192.168.0.5:3001/insertPosting"),
        headers: {
          "Contents-Type": "Application/json",
          "Access-Token": token,
        },
        body: {
          "board": _boardName == "" ? currentBoard : _boardName,
          "title": title,
          "content": content,
        },
      );
      _boardName = "";
    }
  }
}
