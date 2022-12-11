import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

final httpConnector = Provider<HttpConnector>((ref) {
  return HttpConnector();
});

class HttpConnector {
  final host = "http://192.168.50.43:8080";
  final headers = {"Content-Type": "application/json; charset=utf-8"};
  final Client _client = Client();

  Future<Response> get(String path, String? jwtToken) async {
    if (jwtToken != null) {
      headers['Authorization'] = jwtToken;
    }
    Logger().d('${headers}');
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.get(uri, headers: headers);
    return response;
  }

  Future<Response> delete(String path, String? jwtToken) async {
    if (jwtToken != null) {
      headers['Authorization'] = jwtToken;
    }
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.delete(uri, headers: headers);
    return response;
  }

  Future<Response> put(String path, String body, String? jwtToken) async {
    if (jwtToken != null) {
      headers['Authorization'] = jwtToken;
    }
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.put(uri, body: body, headers: headers);
    return response;
  }

  Future<Response> post(String path, String body, String? jwtToken) async {
    if (jwtToken != null) {
      headers['Authorization'] = jwtToken;
    }
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.post(uri, body: body, headers: headers);
    return response;
  }
}
