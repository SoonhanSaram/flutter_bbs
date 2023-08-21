import 'package:flutter/material.dart';
import 'package:flutter_bbs/provider/functions_post.dart';
import 'package:flutter_bbs/provider/functions_reply.dart';
import 'package:flutter_bbs/widgets/custom_textfield.dart';
import 'package:flutter_bbs/widgets/reply.dart';
import 'package:flutter_bbs/widgets/title_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String> postData = context.read<FunctionsPost>().currentPost;
    String sdate = DateFormat("yy년 MM월 dd일 hh:mm").format(DateTime.parse(postData['sdate']!));
    FunctionsReply functionsReply = Provider.of<FunctionsReply>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleCard(postData['title'] ?? ""),
              _buildAuthorAndViews(postData['nickName'] ?? "", postData['views'] ?? ""),
              SizedBox(height: _getHeight(context, 0.02)),
              _buildContent(context, postData['content'] ?? ""),
              CustomTextfield(
                textEditingController: functionsReply.textEditingController,
                hintText: "댓글을 입력해주세요",
                onTapFunction: () {
                  functionsReply.postReply();
                },
              ),
              ReplyWidget(),
              _buildDate(sdate),
            ],
          ),
        ),
      ),
    );
  }

  double _getHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }

  Widget _buildTitleCard(String title) {
    return titleCard(title: "제목 : $title");
  }

  Widget _buildAuthorAndViews(String author, String views) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCard(
          title: author,
          fontSize: 20,
          boxSize: 0.3,
        ),
        titleCard(
          title: "조회수:$views",
          fontSize: 20,
          boxSize: 0.2,
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, String content) {
    return Container(
      width: double.infinity,
      height: _getHeight(context, 0.8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: SingleChildScrollView(
        child: Text(content),
      ),
    );
  }

  Widget _buildDate(String date) {
    return titleCard(title: "작성일자 : $date", fontSize: 20);
  }
}
