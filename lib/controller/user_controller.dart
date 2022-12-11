import 'package:blog/core/routers.dart';
import 'package:blog/domain/device/user_session.dart';
import 'package:blog/domain/user/user.dart';
import 'package:blog/domain/user/user_api_repository.dart';
import 'package:blog/dto/auth_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

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

  Future<void> join({
    required String username,
    required String password,
    required String email,
  }) async {
    JoinReqDto joinReqDto = JoinReqDto(username: username, password: password, email: email);

    ResponseDto responseDto = await _ref.read(userApiRepositoryProvider).join(joinReqDto);

    if (responseDto.code == 1) {
      User user = User.fromJson(responseDto.data);
      print('가입된 유저 이름 : ${user.username}');
      Navigator.popAndPushNamed(context, Routers.loginForm);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('가입 실패')),
      );
    }
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    LoginReqDto loginReqDto = LoginReqDto(username: username, password: password);

    ResponseDto responseDto = await _ref.read(userApiRepositoryProvider).login(loginReqDto);

    if (responseDto.code == 1) {
      // User user = User.fromJson(responseDto.data);
      // print('가입된 유저 이름 : ${user.username}');
      Logger().d('code: 1');
      Navigator.popAndPushNamed(context, Routers.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패')),
      );
    }
  }

  void loginForm() {
    Navigator.popAndPushNamed(context, Routers.loginForm);
  }

  void joinForm() {
    Navigator.popAndPushNamed(context, Routers.joinForm);
  }

  Future<void> logout() async {
    UserSession.logout();
  }
}
