import 'package:flutter/material.dart';
import 'package:flutter_bbs/comps/join.dart';
import 'package:flutter_bbs/provider/functions_user.dart';
import 'package:flutter_bbs/widgets/button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    FunctionsUser functionsUser = Provider.of<FunctionsUser>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("아이디"),
            ContainerTextField(
              child: TextField(
                onChanged: (value) {
                  functionsUser.chekRegExpression("email", value);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                controller: functionsUser.loginIdController,
              ),
            ),
            const Text("비밀번호"),
            ContainerTextField(
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  functionsUser.chekRegExpression("password", functionsUser.passwrdController.text);
                },
                controller: functionsUser.loginPasswrdController,
              ),
            ),
            VariousButton(
              buttonTitle: "로그인",
              function: () => functionsUser.loginUser(context),
            )
          ],
        ),
      ),
    );
  }
}
