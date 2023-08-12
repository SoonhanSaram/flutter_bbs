import 'package:flutter/material.dart';
import 'package:flutter_bbs/provider/functions_basic.dart';
import 'package:flutter_bbs/provider/functions_post.dart';
import 'package:flutter_bbs/widgets/post_tiles.dart';
import 'package:flutter_bbs/widgets/title_card.dart';
import 'package:provider/provider.dart';

class BoardList extends StatefulWidget {
  const BoardList({super.key});

  @override
  State<BoardList> createState() => _BoardListState();
}

class _BoardListState extends State<BoardList> {
  final bool _slowAnimation = false;

  @override
  Widget build(BuildContext context) {
    String currentBoard = context.watch<FunctionsBasic>().currentBoard;
    FunctionsBasic functionsBasic = Provider.of<FunctionsBasic>(context, listen: false);
    FunctionsPost functionsPost = Provider.of<FunctionsPost>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                child: titleCard(
                  title: "$currentBoard 게시판",
                ),
              ),
              functionsBasic.posts.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: functionsBasic.posts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          margin: const EdgeInsets.only(top: 8.0, bottom: 12.0, left: 8.0, right: 8.0),
                          child: PostTiles(
                            getPost: () {
                              functionsPost.getPost(functionsBasic.posts[index]['b_num'], context);
                            },
                            views: functionsBasic.posts[index]['b_views'] ?? "",
                            title: functionsBasic.posts[index]['b_title'] ?? "",
                            nickname: functionsBasic.posts[index]['b_nickname'] ?? "",
                          ),
                        );
                      },
                    )
                  : titleCard(
                      title: "게시물이 없습니다.",
                    ),
            ],
          ),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            if (functionsBasic.boardNames.isEmpty) {
              functionsBasic.getBoard();
            }
            Navigator.pushNamed(context, '/writePost');
          },
          child: const Icon(Icons.post_add_rounded),
        ),
      ),
    );
  }
}
