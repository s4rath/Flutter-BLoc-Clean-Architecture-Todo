import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl:
            "https://1265e306-d34f-40b0-ac2f-ea2b2c6c569d-00-1t7ipffkmtc6f.sisko.replit.dev",
        headers: {'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
      ),
    );
  }
}
