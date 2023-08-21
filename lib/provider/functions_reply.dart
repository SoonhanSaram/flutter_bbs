import 'package:flutter/material.dart';
import 'package:flutter_bbs/model/models_token.dart';
import 'package:http/http.dart' as http;

class FunctionsReply extends ChangeNotifier {
  TextEditingController textEditingController = TextEditingController();
  final ModelsToken _modelsToken = ModelsToken();
  Future<void> postReply() async {
    print(_modelsToken.getToken);
    final response = await http.post(
      Uri.parse("http://192.168.0.5:3001/reply/insert"),
      headers: {"Contents-Type": "Application/json"},
      body: {
        "content": textEditingController.text,
        "Access-Token": _modelsToken.getToken,
      },
    );
    print(response.body);
  }
}
