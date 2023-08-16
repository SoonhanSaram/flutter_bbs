import 'package:flutter/material.dart';
import 'package:flutter_bbs/provider/functions_post.dart';
import 'package:flutter_bbs/widgets/title_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String> postData = context.read<FunctionsPost>().currentPost;
    String sdate = DateFormat("yy년 MM월 dd일 hh:mm").format(DateTime.parse(postData['sdate']!));
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02, horizontal: MediaQuery.of(context).size.height * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              titleCard(title: "제목 : ${postData['title']}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: titleCard(
                      title: "작성자 : ${postData['nickName']}",
                      size: 16,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Expanded(
                    child: titleCard(title: "조회수 : ${postData['views']}", size: 16),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.height * 0.8,
                height: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: Colors.black,
                  ),
                ),
                child: Text(
                  "${postData['content']}",
                ),
              ),
              titleCard(title: "작성일자 : $sdate", size: 20),
            ],
          ),
        ),
      )),
    );
  }
}
