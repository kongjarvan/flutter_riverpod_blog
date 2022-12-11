import 'dart:convert';

import 'package:blog/core/http_connector.dart';
import 'package:blog/domain/device/user_session.dart';
import 'package:blog/domain/user/user.dart';
import 'package:blog/dto/auth_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/provider/auth_provider.dart';
import 'package:blog/util/response_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userApiRepositoryProvider = Provider<UserApiRepository>((ref) {
  return UserApiRepository(ref);
});

class UserApiRepository {
  UserApiRepository(this._ref);
  Ref _ref;

  Future<ResponseDto> join(JoinReqDto joinReqDto) async {
    String requestBody = jsonEncode(joinReqDto.toJson());
    Response response = await _ref.read(httpConnector).post('/join', requestBody, UserSession.jwtToken);
    return toResponseDto(response);
  }

  Future<ResponseDto> login(LoginReqDto loginReqDto) async {
    Map<String, Object> values = <String, Object>{'counter': 1};
    SharedPreferences.setMockInitialValues(values);

    String requestBody = jsonEncode(loginReqDto.toJson());
    Response response = await _ref.read(httpConnector).post('/login', requestBody, UserSession.jwtToken);
    String jwtToken = response.headers['authorization'].toString();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('jwtToken', jwtToken);

    ResponseDto responseDto = toResponseDto(response);

    User user = User.fromJson(responseDto.data);
    UserSession.login(user, jwtToken);

    Logger().d(jwtToken);
    return responseDto;
  }
}
