import 'package:flutter/material.dart';
import 'package:flutter_bbs/comps/main_list.dart';
import 'package:flutter_bbs/provider/functions_basic.dart';
import 'package:flutter_bbs/provider/functions_user.dart';
import 'package:flutter_bbs/widgets/button.dart';
import 'package:flutter_bbs/widgets/title_card.dart';
import 'package:provider/provider.dart';

class IndexSample extends StatelessWidget {
  const IndexSample({super.key});

  @override
  Widget build(BuildContext context) {
    Function getBoard = context.watch<FunctionsBasic>().getBoard;
    String? token = context.watch<FunctionsUser>().token;
    FunctionsUser functionsUser = Provider.of<FunctionsUser>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: titleCard(title: "플러터 게시판 프로젝트"),
              ),
              const SizedBox(
                width: 500,
                height: 800,
                child: MainList(),
              )
            ],
          ),
        ),
        floatingActionButton: token == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  VariousButton(
                    buttonTitle: "회원가입",
                    function: () async {
                      getBoard();
                      Navigator.pushNamed(context, '/join');
                    },
                  ),
                  VariousButton(
                    buttonTitle: "로그인",
                    function: () async {
                      {
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                  ),
                ],
              )
            : VariousButton(
                buttonTitle: "로그아웃",
                function: () async {
                  await functionsUser.tokenDelete();
                }),
      ),
    );
  }
}
