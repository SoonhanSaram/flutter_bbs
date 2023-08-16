import 'package:flutter/material.dart';
import 'package:flutter_bbs/widgets/drop_down_button.dart';
import 'package:flutter_bbs/provider/functions_user.dart';
import 'package:flutter_bbs/widgets/button.dart';
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("이메일"),
            TextField(
              onChanged: (value) {
                functionsUser.chekRegExpression("email", value);
              },
              decoration: InputDecoration(helperText: emailValidation == true ? "사용할 수 있는 이메일입니다." : null),
              controller: functionsUser.userNameController,
            ),
            const Text("닉네임"),
            TextField(
              decoration: InputDecoration(
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
            const Text("비밀번호"),
            TextField(
              obscureText: true,
              onChanged: (value) {
                functionsUser.chekRegExpression("password", functionsUser.passwrdController.text);
              },
              decoration: InputDecoration(
                helperText: passwrdValidation == false && functionsUser.passwrdController.text.isNotEmpty
                    ? "대문자, 소문자, 특수문자, 숫자를 포함한 10자 이상으로 만들어주세요"
                    : passwrdValidation == true
                        ? "사용할 수 있는 비밀번호입니다."
                        : null,
                helperStyle: TextStyle(color: passwrdValidation == false ? Colors.red : Colors.white),
              ),
              controller: functionsUser.passwrdController,
            ),
            const Text("비밀번호 확인"),
            TextField(
              obscureText: true,
              onChanged: (value) {
                functionsUser.checkPassword();
              },
              controller: functionsUser.checkPasswrdController,
              decoration: InputDecoration(
                helperText: checkPasswrd == false && functionsUser.checkPasswrdController.text.isNotEmpty ? "비밀번호를 확인 해주세요." : null,
                helperStyle: TextStyle(color: checkPasswrd == false && functionsUser.checkPasswrdController.text.isNotEmpty ? Colors.red : null),
              ),
            ),
            const Text("소속학과"),
            const DropDownButtons(),
            VariousButton(
              buttonTitle: "회원가입 완료",
              function: () => functionsUser.joinUser(context),
            )
          ],
        ),
      ),
    );
  }
}
