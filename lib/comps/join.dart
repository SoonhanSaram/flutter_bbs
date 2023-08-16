import 'package:flutter/material.dart';
import 'package:flutter_bbs/widgets/drop_down_button.dart';
import 'package:flutter_bbs/provider/functions_user.dart';
import 'package:flutter_bbs/widgets/button.dart';
import 'package:flutter_bbs/widgets/title_card.dart';
import 'package:provider/provider.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    FunctionsUser functionsUser = Provider.of<FunctionsUser>(context, listen: true);
    bool emailValidation = functionsUser.emailValidation;
    bool passwrdValidation = functionsUser.passwrdValidation;
    bool checkPasswrd = functionsUser.chekpasswrd;
    bool nickNameValidation = functionsUser.nickNameValidation;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              titleCard(title: "이메일"),
              const SizedBox(
                height: 20,
              ),
              ContainerTextField(
                child: TextField(
                  onChanged: (value) {
                    functionsUser.chekRegExpression("email", value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: InputBorder.none,
                    helperText: emailValidation == true ? "사용할 수 있는 이메일입니다." : null,
                  ),
                  controller: functionsUser.userNameController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              titleCard(title: "닉네임"),
              const SizedBox(
                height: 20,
              ),
              ContainerTextField(
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.account_circle_outlined),
                      border: InputBorder.none,
                      helperText: nickNameValidation == true
                          ? "사용할 수 있는 닉네임입니다."
                          : functionsUser.nickNameController.text.length > 12
                              ? "닉네임은 최대 12글자 입니다"
                              : null),
                  onChanged: (value) {
                    functionsUser.chekRegExpression("nickname", value);
                  },
                  controller: functionsUser.nickNameController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              titleCard(title: "비밀번호"),
              const SizedBox(
                height: 20,
              ),
              ContainerTextField(
                child: TextField(
                  obscureText: true,
                  onChanged: (value) {
                    functionsUser.chekRegExpression("password", functionsUser.passwrdController.text);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_clock_outlined),
                    border: InputBorder.none,
                    helperText: passwrdValidation == false && functionsUser.passwrdController.text.isNotEmpty
                        ? "대문자, 소문자, 특수문자, 숫자를 포함한 10자 이상으로 만들어주세요"
                        : passwrdValidation == true
                            ? "사용할 수 있는 비밀번호입니다."
                            : null,
                    helperStyle: TextStyle(color: passwrdValidation == false ? Colors.red : Colors.white),
                  ),
                  controller: functionsUser.passwrdController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              titleCard(title: "비밀번호 확인"),
              const SizedBox(
                height: 20,
              ),
              ContainerTextField(
                child: TextField(
                  obscureText: true,
                  onChanged: (value) {
                    functionsUser.checkPassword();
                  },
                  controller: functionsUser.checkPasswrdController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_clock_sharp),
                    border: InputBorder.none,
                    helperText: checkPasswrd == false && functionsUser.checkPasswrdController.text.isNotEmpty ? "비밀번호를 확인 해주세요." : null,
                    helperStyle: TextStyle(
                      color: checkPasswrd == false && functionsUser.checkPasswrdController.text.isNotEmpty ? Colors.red : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              titleCard(title: "소속학과"),
              const SizedBox(
                height: 20,
              ),
              const DropDownButtons(),
              const SizedBox(
                height: 20,
              ),
              VariousButton(
                buttonTitle: "회원가입 완료",
                function: () => functionsUser.joinUser(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerTextField extends StatelessWidget {
  ContainerTextField({super.key, required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(222, 222, 222, 0.8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(padding: const EdgeInsets.only(left: 12), child: child),
    );
  }
}
