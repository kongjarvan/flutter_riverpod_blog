import 'package:blog/controller/user_controller.dart';
import 'package:blog/core/routers.dart';
import 'package:blog/util/validator_util.dart';
import 'package:blog/view/component/custom_elevated_button.dart';
import 'package:blog/view/component/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class LoginPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Logger().d("로그인 페이지 빌드 시작");
    final uc = ref.read(userController);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildList(uc, context),
      ),
    );
  }

  ListView buildList(UserController uc, BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.center,
          height: 200,
          child: Text(
            "로그인 페이지 false",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _loginForm(uc, context),
      ],
    );
  }

  Widget _loginForm(UserController uc, BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _username,
            hint: "Username",
            funValidator: validateUsername(),
          ),
          CustomTextFormField(
            controller: _password,
            hint: "Password",
            funValidator: validatePassword(),
          ),
          CustomElevatedButton(
            text: "로그인",
            funPageRoute: () async {
              if (_formKey.currentState!.validate()) {
                uc.login(
                  username: _username.text.trim(),
                  password: _password.text.trim(),
                );
              }
            },
          ),
          TextButton(
            onPressed: () {
              uc.joinForm();
            },
            child: Text("아직 회원가입이 안되어 있나요?"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, Routers.home);
            },
            child: Text("로그인 없이 폼페이지 가보는 테스트"),
          ),
        ],
      ),
    );
  }
}
