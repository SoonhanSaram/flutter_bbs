import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bbs/model/models_reply.dart';
import 'package:http/http.dart' as http;

class FunctionsReply extends ChangeNotifier {
  TextEditingController textEditingController = TextEditingController();
  int _postNumber = 0;
  int get postNumber => _postNumber;
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

  void savePostNumber(postNum) {
    _postNumber = postNum;
    notifyListeners();
  }

  Future<List<Reply>> getReply(bNum) async {
    print(bNum);
    final response = await http.get(
      Uri.parse(
        "http://192.168.0.5:3001/getReply",
      ),
      headers: {
        'Contents-Type': "Application/json",
        "postnum": bNum.toString(),
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body);
      List<Reply> replies = result.map((json) => Reply.fromJson(json)).toList();
      return replies;
    } else {
      throw Exception("Failed to load replies");
    }
  }

  Future<void> postReply(token, context) async {
    print(textEditingController.text);
    if (token != null) {
      final response = await http.post(
        Uri.parse("http://192.168.0.5:3001/reply/insert"),
        headers: {
          "Contents-Type": "Application/json",
          "Access-Token": token,
        },
        body: {
          "content": textEditingController.text,
          "postNum": "2",
        },
      );
      final result = jsonDecode(response.body);
      if (result['결과'] == "성공") {
        textEditingController.clear();
        notifyListeners();
      } else {
        callSnackBar(context, "댓글 등록에 실패했습니다.");
      }
    }
  }
}
