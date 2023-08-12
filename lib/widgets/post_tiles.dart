import 'package:flutter/material.dart';

class PostTiles extends StatelessWidget {
  PostTiles({
    super.key,
    required this.getPost,
    required this.views,
    required this.title,
    required this.nickname,
  });

  Function getPost;
  String views;
  String title;
  String nickname;

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
        title,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        views == "" ? "조회수 : 0" : "조회수 : $views",
      ),
    );
  }
}
