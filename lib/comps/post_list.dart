import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bbs/comps/post_detail.dart';
import 'package:flutter_bbs/provider/functions_basic.dart';
import 'package:flutter_bbs/provider/functions_post.dart';
import 'package:flutter_bbs/provider/functions_reply.dart';
import 'package:flutter_bbs/widgets/post_tiles.dart';
import 'package:flutter_bbs/widgets/custom_title_card.dart';
import 'package:provider/provider.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone) {
    if (isMarkedAsDone ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Marked as done!'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentBoard = context.watch<FunctionsBasic>().currentBoard;
    FunctionsBasic functionsBasic = Provider.of<FunctionsBasic>(context, listen: true);
    FunctionsPost functionsPost = Provider.of<FunctionsPost>(context, listen: true);
    FunctionsReply functionsReply = Provider.of<FunctionsReply>(context, listen: true);
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
              functionsBasic.posts.isNotEmpty ? _buildPostListView(functionsBasic.posts, functionsPost, functionsReply) : _buildNoPostsMessage(),
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

  Widget _buildPostListView(List<Map<String, dynamic>> posts, FunctionsPost functionsPost, FunctionsReply functionsReply) {
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
                getPost: () async {
                  functionsPost.getPost(posts[index]['b_num'], context);
                  await functionsReply.savePostNumber(posts[index]['b_num']);
                },
                countReply: posts[index]['repliesCount'],
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
