import 'dart:convert';

import 'package:blog/core/http_connector.dart';
import 'package:blog/dto/auth_req_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userApiRepositoryProvider = Provider<UserApiRepository>((ref) {
  return UserApiRepository(ref);
});

class UserApiRepository {
  UserApiRepository(this._ref);
  Ref _ref;

  void join({required String username, required String password, required String email}) {
    String requestBody = jsonEncode(JoinReqDto(username: username, password: password, email: email).toJson());
    _ref.read(httpConnector).post('/join', requestBody);
  }
}
