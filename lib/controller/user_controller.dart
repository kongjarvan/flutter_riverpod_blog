import 'package:blog/core/routers.dart';
import 'package:blog/domain/user/user_api_repository.dart';
import 'package:blog/main.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * view -> Controller 요청
 * Controller -> Repository 요청
 * Repository -> 스프링서버 요청
 * Controller -> ViewModel 응답
 * 
 * 
 * Controller 책임: View 요청 받고,
 *                  Repository에게 통신요청하고,
 *                  비즈니스 로직 처리(페이지 이동, ViewModel 데이터 담기)
 * Repository 책임: 통신하고 파싱하기
 */

final userController = Provider((ref) {
  return UserController(ref);
});

class UserController {
  UserController(this._ref);
  Ref _ref;
  final context = navigatorKey.currentContext!;

  void join({
    required String username,
    required String password,
    required String email,
  }) {
    _ref.read(userApiRepositoryProvider).join(username: username, password: password, email: email);
  }

  void loginForm() {
    Navigator.popAndPushNamed(context, Routers.loginForm);
  }

  void joinForm() {
    Navigator.popAndPushNamed(context, Routers.joinForm);
  }
}
