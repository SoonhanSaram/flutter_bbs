import 'package:flutter/material.dart';
import 'package:flutter_bbs/widgets/drop_down_button.dart';
import 'package:flutter_bbs/provider/functions_basic.dart';
import 'package:flutter_bbs/provider/functions_writing.dart';
import 'package:flutter_bbs/widgets/button.dart';
import 'package:provider/provider.dart';

class PostWritePage extends StatefulWidget {
  const PostWritePage({super.key});

  @override
  State<PostWritePage> createState() => _PostWritePageState();
}

class _PostWritePageState extends State<PostWritePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  int _contentLength = 0;
  @override
  Widget build(BuildContext context) {
    FunctionsWriting functionsWriting = Provider.of<FunctionsWriting>(context, listen: false);
    String currentBoard = context.read<FunctionsBasic>().currentBoard;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "게시판 선택 : ",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            width: 1.0,
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ),
                      ),
                      child: const DropDownButtons(),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: "제목을 입력해주세요",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: Colors.black,
                      ),
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 200),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                        ),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "내용을 입력해주세요",
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                          controller: _contentController,
                          keyboardType: TextInputType.multiline,
                          onChanged: (text) {
                            // 글자 수 변경 시에 상태 업데이트
                            setState(() {
                              _contentLength = text.length;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Text(
                      _contentLength <= 600 ? "$_contentLength/600" : "글자수를 초과했습니다.", // 현재 글자 수 / 최대 글자 수
                      style: TextStyle(
                        fontSize: _contentLength <= 600 ? 12 : 16,
                        color: _contentLength <= 600 ? Colors.grey : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              VariousButton(
                buttonTitle: "게시글 작성",
                function: () {
                  try {
                    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
                      functionsWriting.callSnackBar(context, "제목과 내용을 입력해주세요");
                    } else if (_titleController.text.length <= 40 || _contentController.text.length <= 600) {
                      functionsWriting.callPosting(
                        context,
                        _titleController.text,
                        _contentController.text,
                        currentBoard,
                      );
                      _titleController.text = "";
                      _contentController.text = "";
                      Navigator.pop(context);
                    } else {
                      functionsWriting.callSnackBar(context, "제목과 내용의 글자수를 확인해주세요");
                    }
                  } catch (e) {}
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
