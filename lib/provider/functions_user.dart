import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class FunctionsUser extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  String? _token;
  String? get token => _token;

  TextEditingController userNameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController passwrdController = TextEditingController();
  TextEditingController checkPasswrdController = TextEditingController();
  TextEditingController loginIdController = TextEditingController();
  TextEditingController loginPasswrdController = TextEditingController();
  String _userMajor = "";
  String get userMajor => _userMajor;
  bool _emailValidation = false;
  bool get emailValidation => _emailValidation;
  bool _nickNameValidation = false;
  bool get nickNameValidation => _nickNameValidation;
  bool _passwrdValidation = false;
  bool get passwrdValidation => _passwrdValidation;
  bool _chekpasswrd = false;
  bool get chekpasswrd => _chekpasswrd;

  void checkPassword() {
    if (passwrdController.text == checkPasswrdController.text) {
      _chekpasswrd = true;
    } else {
      _chekpasswrd = false;
    }
    notifyListeners();
  }

  void chekRegExpression(String type, String value) {
    if (type == "email") {
      _emailValidation = false;
      String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]*@[a-zA-Z0-9]*.[a-zA-Z]{2,3}$";
      _emailValidation = RegExp(pattern).hasMatch(value);
    } else if (type == "password") {
      _passwrdValidation = false;
      String pattern = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{10,20}$";
      _passwrdValidation = RegExp(pattern).hasMatch(value);
    } else if (type == "nickname") {
      _nickNameValidation = false;
      String pattern = r"^[a-zA-Z0-9가-힣]{2,12}$";
      _nickNameValidation = RegExp(pattern).hasMatch(value);
    }
    notifyListeners();
  }

  Future<void> getMajor(major) async {
    _userMajor = major;
  }

  void controllersClear() {
    userNameController.clear();
    nickNameController.clear();
    passwrdController.clear();
    checkPasswrdController.clear();
  }

  void callSnackBar(context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  //회원가입 method
  Future<void> joinUser(BuildContext context) async {
    if (_chekpasswrd && _emailValidation && _nickNameValidation && _passwrdValidation && userMajor.isNotEmpty) {
      final response = await http.post(
        Uri.parse("http://192.168.0.5:3001/user/join"),
        headers: {"Contents-Type": "Application/json"},
        body: {
          "email": userNameController.text,
          "nickName": nickNameController.text,
          "password": passwrdController.text,
          "major": userMajor,
        },
      );
      final result = jsonDecode(response.body);
      if (response.statusCode == 403) {
        callSnackBar(
          context,
          result['결과'],
        );
        controllersClear();
      } else if (response.statusCode == 200) {
        callSnackBar(
          context,
          result['결과'],
        );
        _userMajor = "";
        controllersClear();
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }
    }
  }

  //로그인
  Future<void> loginUser(BuildContext context) async {
    final response = await http.post(
      Uri.parse("http://192.168.0.5:3001/user/login"),
      headers: {'Contents-Type': "Application/json"},
      body: {
        "email": loginIdController.text,
        "password": loginPasswrdController.text,
      },
    );

    final result = jsonDecode(response.body);

    // node 서버로부터 받아온 token 담기
    final token = result['accessToken'];

    await _storage.write(
      key: 'userInfo',
      value: token,
    );

    tokenUpdate();
    // controller clear
    loginIdController.clear();
    loginPasswrdController.clear();

    Navigator.pop(context);
  }

  // token 업데이트
  Future<void> tokenUpdate() async {
    _token = await _storage.read(key: 'userInfo');

    print(_token);
    notifyListeners();
  }

  // token 삭제
  Future<void> tokenDelete() async {
    await _storage.delete(key: 'userInfo');
    _token = await _storage.read(key: 'userInfo');

    notifyListeners();
  }
}
