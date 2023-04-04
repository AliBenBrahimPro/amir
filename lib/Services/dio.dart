import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();
  dio.options.baseUrl = 'http://192.168.1.101:8000/api';
  dio.options.headers['accept'] = 'application/json';
  dio.options.validateStatus = (_) => true;
  dio.options.contentType = Headers.jsonContentType;
  dio.options.responseType = ResponseType.json;
  return dio;
}
