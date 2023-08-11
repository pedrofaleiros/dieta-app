import 'package:dio/dio.dart';

class DioClient {
  static const baseUrl = 'http://localhost:3333';

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
}
