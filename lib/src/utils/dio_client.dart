import 'package:dio/dio.dart';

import '../features/home/domain/model/exceptions/not_authorized_exception.dart';

class DioClient {
  static const baseUrl = 'http://192.168.0.160:3333';

  static Dio getDio() {
    final dio = Dio();

    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 5);

    return dio;
  }

  static Dio getDioWithToken(String token) {
    final dio = getDio();

    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    return dio;
  }

  static Exception handleDioException(DioException e) {
    if (e.response != null) {
      if (e.response!.statusCode == 401) {
        return NotAuthorizedException('Não autorizado');
      } else if (e.response!.statusCode == 400) {
        return Exception('Erro 400');
      }
    }
    return Exception(e.toString());
  }
}
