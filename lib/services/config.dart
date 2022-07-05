import 'package:awesome_app/env.dart';
import 'package:dio/dio.dart';

Dio getDio() {
  Dio dio = new Dio();
  dio.options.baseUrl = Env.PEXEL_API;
  dio.options.headers['Authorization'] = Env.PEXEL_KEY;
  dio.options.connectTimeout = 5000;
  dio.options.receiveTimeout = 3000;
  return dio;
}
