import 'package:desafio_cadastro_cep/repostories/back4app/back4app_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4AppCustonDio {
  final _dio = Dio();

  Dio get dio => _dio;

  Back4AppCustonDio() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
    _dio.interceptors.add(Back4AppDioInterceptor());
  }
}
