import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bbs/comps/login.dart';
import 'package:flutter_bbs/model/models_reply.dart';
import 'package:flutter_bbs/provider/functions_reply.dart';
import 'package:flutter_bbs/provider/functions_user.dart';
import 'package:flutter_bbs/widgets/custom_popup.dart';
import 'package:flutter_bbs/widgets/custom_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ReplyWidget extends StatefulWidget {
  ReplyWidget({
    super.key,
    required this.postNumber,
  });

  int postNumber;
  @override
  State<ReplyWidget> createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  late Future<List<Reply>> _replies;

  Future<List<Reply>> getReply(postNumber) async {
    final response = await http.get(
        Uri.parse(
          "http://192.168.0.5:3001/getReply/",
        ),
        headers: {
          'Contents-Type': "Application/json",
          "postnum": postNumber.toString(),
        });
    final List<dynamic> result = jsonDecode(response.body);
    return result.map((json) => Reply.fromJson(json)).toList();
  }

  // Future<void> getReplies(postNumber) async {
  //   try {
  //     _replies = await getReply(postNumber);
  //     print("실행 완료");
  //   } catch (e) {
  //     print("Error fetching replies: $e");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _replies = getReply(widget.postNumber);
  }

  @override
  Widget build(BuildContext context) {
    FunctionsUser functionsUser = Provider.of<FunctionsUser>(context, listen: true);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 300,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
            child: FutureBuilder(
              future: _replies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // 로딩 중에는 로딩 인디케이터 표시
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // 에러 메시지 표시
                } else if (!snapshot.hasData) {
                  return const Text('댓글 수 : 0'); // 데이터가 없는 경우 메시지 표시
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length ?? 0,
                    itemBuilder: (context, index) {
                      return Card(
                        child: OriginalReply(
                          token: functionsUser.token ?? "",
                          replies: snapshot.data as List<Reply>,
                          index: index,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}

// class ReReply extends StatelessWidget {
// ReReply({super.key, required List<Reply> replies, required this.index});
//
// final List<Reply> _replies;
// int index;
// @override
// Widget build(BuildContext context) {
// return Container(
// decoration: const BoxDecoration(
// border: Border(
// bottom: BorderSide(color: Colors.black),
// ),
// ),
// padding: const EdgeInsets.only(left: 16),
// child: ListTile(
// leading: Text(
// _replies[index]['rNickName'] as String,
// ),
// title: Text(
// _replies[index]['rContent'] as String,
// ),
// ),
// );
// }
// }

class OriginalReply extends StatelessWidget {
  OriginalReply({super.key, required List<Reply> replies, required this.index, this.token = ""}) : _replies = replies;

  final List<Reply> _replies;
  int index;
  String token;
  Future<void> deleteReply(token, context, replyNumber) async {
    if (token == "") {
      customShowPopup(
        context,
        "댓글 삭제 오류",
        "로그인 정보가 없습니다.",
        "취소",
        "로그인 하러 가기",
        const LoginPage(),
      );
    } else {
      final response = await http.delete(
        Uri.parse("http://192.168.0.5:3001/reply/delete"),
        headers: {
          "Contents-Type": "Application/json",
          "Access-Token": token,
          "replyNumber": replyNumber.toString(),
        },
      );
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        callSnackBar(context, result['결과']);
        Navigator.pushNamedAndRemoveUntil(context, '/postDetail', (route) => route.isFirst || route.settings.name == '/postDetail');
      } else if (response.statusCode == 401) {
        callSnackBar(context, result['결과']);
      }
      result['댓글'].map((json) => Reply.fromJson(json)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    FunctionsReply functionsReply = Provider.of<FunctionsReply>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          )),
      child: ListTile(
        trailing: _replies[index].rDDate == null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        deleteReply(token, context, _replies[index].rNum);
                      },
                      child: const Icon(Icons.delete_outline_outlined),
                    ),
                    const Text(" | "),
                    GestureDetector(
                      onTap: () {
                        functionsReply.modifyReply(token, context, _replies[index].rNum);
                      },
                      child: const Icon(Icons.edit_note_outlined),
                    ),
                  ],
                ),
              )
            : null,
        leading: Text(
          "${_replies[index].rNickName} :",
        ),
        title: Text(
          _replies[index].rUDate == null && _replies[index].rDDate == null
              ? _replies[index].rContent
              : _replies[index].rDDate == null
                  ? "[댓글수정] ${_replies[index].rContent}"
                  : "[삭제된 댓글 입니다.]",
        ),
      ),
    );
  }
}
