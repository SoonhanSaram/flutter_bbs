import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bbs/model/models_reply.dart';
import 'package:http/http.dart' as http;

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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("댓글영역"),
          Container(
            width: double.maxFinite,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: FutureBuilder(
                  future: _replies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // 로딩 중에는 로딩 인디케이터 표시
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // 에러 메시지 표시
                    } else if (!snapshot.hasData) {
                      return const Text('No data available'); // 데이터가 없는 경우 메시지 표시
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length ?? 0,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              children: [
                                OriginalReply(
                                  replies: snapshot.data as List<Reply>,
                                  index: index,
                                ),
                                // ReReply(
                                // replies: _replies,
                                // index: index,
                                // ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                )),
          )
        ],
      ),
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
  OriginalReply({super.key, required List<Reply> replies, required this.index}) : _replies = replies;

  final List<Reply> _replies;
  int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: ListTile(
        leading: Text(
          "${_replies[index].rNickName} :",
        ),
        title: Text(
          _replies[index].rContent,
        ),
      ),
    );
  }
}
