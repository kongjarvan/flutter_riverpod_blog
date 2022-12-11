import 'dart:convert';

import 'package:blog/dto/response_dto.dart';
import 'package:http/http.dart';

ResponseDto toResponseDto(Response response) {
  Map<String, dynamic> responseMap = jsonDecode(response.body);

  ResponseDto responseDto = ResponseDto.fromJson(responseMap);
  return responseDto;
}
