import 'package:flutter/material.dart';
import 'package:flutter_bbs/comps/board_list.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.07, vertical: 10.0),
                shadowColor: Colors.grey[500],
                child: const Text(
                  "플러터 게시판 프로젝트",
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
              ),
              const SizedBox(
                width: 500,
                height: 800,
                child: BoardList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
