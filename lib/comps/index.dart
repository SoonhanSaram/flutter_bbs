import 'package:flutter/material.dart';
import 'package:flutter_bbs/comps/main_list.dart';
import 'package:flutter_bbs/widgets/title_card.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}
