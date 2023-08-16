import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bbs/comps/post_detail.dart';
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
  final ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone) {
    if (isMarkedAsDone ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Marked as done!'),
      ));
    }
  }

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
                child: _buildTitleCard(currentBoard),
              ),
              functionsBasic.posts.isNotEmpty ? _buildPostListView(functionsBasic.posts, functionsPost) : _buildNoPostsMessage(),
            ],
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(context, functionsBasic),
      ),
    );
  }

  Widget _buildTitleCard(String title) {
    return titleCard(
      title: "$title 게시판",
    );
  }

  Widget _buildPostListView(List<Map<String, dynamic>> posts, FunctionsPost functionsPost) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return OpenContainer(
          transitionType: _transitionType,
          openBuilder: (BuildContext context, VoidCallback _) {
            return const PostDetail();
          },
          onClosed: _showMarkedAsDoneSnackbar,
          tappable: false,
          closedBuilder: (context, action) {
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: PostTiles(
                getPost: () {
                  functionsPost.getPost(posts[index]['b_num'], context);
                },
                views: posts[index]['b_views'] ?? "",
                title: posts[index]['b_title'] ?? "",
                nickname: posts[index]['b_nickname'] ?? "",
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildNoPostsMessage() {
    return titleCard(
      title: "게시물이 없습니다.",
    );
  }

  Widget _buildFloatingActionButton(BuildContext context, FunctionsBasic functionsBasic) {
    return ElevatedButton(
      onPressed: () {
        if (functionsBasic.boardNames.isEmpty) {
          functionsBasic.getBoard();
        }
        Navigator.pushNamed(context, '/writePost');
      },
      child: const Icon(Icons.post_add_rounded),
    );
  }
}
