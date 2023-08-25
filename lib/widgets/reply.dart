import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bbs/model/models_reply.dart';
import 'package:flutter_bbs/provider/functions_post.dart';
import 'package:flutter_bbs/provider/functions_reply.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class ReplyWidget extends StatefulWidget {
   const ReplyWidget({super.key});
  


  @override
  State<ReplyWidget> createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  List<Reply>? _replies;

  Future<List<Reply>> getReply(bNum) async {
    final response = await http.get(
        Uri.parse(
          "http://192.168.0.5:3001/reply/",
        ),
        headers: {
          'Contents-Type': "Application/json",
          "b_num": bNum,
        });
    final List<dynamic> result = jsonDecode(response.body);
    return result.map((json) => Reply.fromJson(json)).toList();
  }

  void getReplies(bNum) async {
    try {
      List<Reply> replies = await getReply(bNum);
    } catch (e) {
      print("Error fetching replies: $e");
    }
  }


  @override
  void initState() {
    getReplies(123);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FunctionsReply functionsReply = Provider.of<FunctionsReply>(context, listen:true);
    
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
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: _replies?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        OriginalReply(
                          replySample: ,
                          index: index,
                        ),
                        ReReply(
                          replySample: ,
                          index: index,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ReReply extends StatelessWidget {
  ReReply({super.key, required List<Map<String, dynamic>> replySample, required this.index}) : _replySample = replySample;

  final List<Map<String, dynamic>> _replySample;
  int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      padding: const EdgeInsets.only(left: 16),
      child: ListTile(
        leading: Text(
          _replySample[index]['id'] as String,
        ),
        title: Text(
          _replySample[index]['content'] as String,
        ),
      ),
    );
  }
}

class OriginalReply extends StatelessWidget {
  OriginalReply({super.key, required List<Map<String, dynamic>> replySample, required this.index}) : _replySample = replySample;

  final List<Map<String, dynamic>> _replySample;
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
          _replySample[index]['id'] as String,
        ),
        title: Text(
          _replySample[index]['content'] as String,
        ),
      ),
    );
  }
}
