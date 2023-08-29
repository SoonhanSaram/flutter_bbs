import 'package:flutter/material.dart';
import 'package:flutter_bbs/provider/functions_user.dart';
import 'package:flutter_bbs/widgets/custom_button.dart';
import 'package:flutter_bbs/widgets/custom_textfield.dart';
import 'package:flutter_bbs/widgets/custom_title_card.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    FunctionsUser functionsUser = Provider.of<FunctionsUser>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("로그인 페이지"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              titleCard(title: "아이디"),
              CustomTextfield(
                onChangedFunction: () {},
                leadingIcon: Icons.account_circle_outlined,
                surfixIcon: Icons.alternate_email_outlined,
                onTapFunction: () {},
                textEditingController: functionsUser.loginIdController,
              ),
              const SizedBox(
                height: 20,
              ),
              titleCard(title: "비밀번호"),
              CustomTextfield(
                leadingIcon: Icons.password_outlined,
                obscureText: true,
                onChangedFunction: () {},
                onTapFunction: () {},
                textEditingController: functionsUser.loginPasswrdController,
              ),
              const SizedBox(
                height: 20,
              ),
              VariousButton(
                buttonTitle: "로그인",
                function: () => functionsUser.loginUser(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
