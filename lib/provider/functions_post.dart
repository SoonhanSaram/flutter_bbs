import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bbs/comps/post_detail.dart';
import 'package:flutter_bbs/transitions/router_transition.dart';
import 'package:http/http.dart' as http;

class FunctionsPost extends ChangeNotifier {
  final Map<String, String> _currentPost = {};
  Map<String, String> get currentPost => _currentPost;

  // 포스팅 디테일 가져오기
  Future<void> getPost(pNum, BuildContext context) async {
    _currentPost.clear();
    try {
      final response = await http.get(Uri.parse("http://192.168.0.5:3001/posts/$pNum"));
      final postData = jsonDecode(response.body);
      _currentPost.addAll({
        "title": postData['b_title'] ?? "",
        "content": postData['b_text'] ?? "",
        "sdate": postData['b_sdate'] ?? "",
        "nickName": postData['b_nickname'] ?? "",
        "views": postData['b_views'] ?? "",
      });
      if (_currentPost.isNotEmpty) {
        Navigator.of(context).push(
          RouterTransition(
            const PostDetail(),
          ),
        );
      }
    } catch (e) {}
  }
}
