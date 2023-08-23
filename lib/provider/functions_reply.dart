import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FunctionsReply extends ChangeNotifier {
  TextEditingController textEditingController = TextEditingController();

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

  Future<void> getReply(bNum) async {
    final response = await http.get(
        Uri.parse(
          "http://192.168.0.5:3001/reply/",
        ),
        headers: {
          'Contents-Type': "Application/json",
          "b_num": bNum,
        });
    final result = jsonDecode(response.body);
    print(result);
  }

  Future<void> postReply(token, context) async {
    if (token != null) {
      final response = await http.post(
        Uri.parse("http://192.168.0.5:3001/reply/insert"),
        headers: {
          "Contents-Type": "Application/json",
          "Access-Token": token,
        },
        body: {
          "content": textEditingController.text,
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
