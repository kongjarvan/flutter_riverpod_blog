import 'package:blog/domain/user/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider(ref)..initJwtToken();
});

class AuthProvider {
  AuthProvider(this._ref);
  Ref _ref;
  String? jwtToken;
  bool isLogin = false;
  User? user;

  Future<void> initJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    final deviceJwtToken = prefs.getString('jwtToken');
    Logger().d('토큰 저장됨?');
    if (deviceJwtToken != null) {
      Logger().d('토큰 있음');
      Logger().d('${deviceJwtToken}');
      isLogin = true;
      jwtToken = deviceJwtToken;
    }
  }
}
