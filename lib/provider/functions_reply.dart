import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bbs/comps/login.dart';
import 'package:flutter_bbs/model/models_reply.dart';
import 'package:flutter_bbs/widgets/custom_popup.dart';
import 'package:flutter_bbs/widgets/custom_snackbar.dart';
import 'package:http/http.dart' as http;

class FunctionsReply extends ChangeNotifier {
  TextEditingController textEditingController = TextEditingController();
  int _postNumber = 0;
  int get postNumber => _postNumber;

  Future<void> savePostNumber(postNum) async {
    _postNumber = await postNum;
    print(_postNumber);
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
          "postNum": _postNumber.toString(),
        },
      );
      final result = jsonDecode(response.body);
      if (result['결과'] == "성공") {
        textEditingController.clear();
        Navigator.pushNamedAndRemoveUntil(context, '/postDetail', (route) => route.isFirst || route.settings.name == '/postDetail');
      } else {
        callSnackBar(
          context,
          result['결과'],
        );
      }
    } else if (token == null) {
      customShowPopup(
        context,
        "댓글 입력 오류",
        "로그인 정보가 없습니다.",
        "취소",
        "로그인 하러 가기",
        const LoginPage(),
      );
    }
  }
}
