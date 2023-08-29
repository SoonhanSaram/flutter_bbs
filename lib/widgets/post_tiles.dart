import 'package:flutter/material.dart';

class PostTiles extends StatelessWidget {
  PostTiles({
    super.key,
    required this.getPost,
    required this.views,
    required this.title,
    required this.nickname,
    required this.countReply,
  });

  Function getPost;
  String views;
  String title;
  String nickname;
  int countReply;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.list,
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      onTap: () {
        getPost();
      },
      subtitle: Text(
        nickname,
        overflow: TextOverflow.ellipsis,
      ),
      title: Text(
        countReply == 0 ? title : "$title ($countReply)",
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        views == "" ? "조회수 : 0" : "조회수 : $views",
      ),
    );
  }
}
