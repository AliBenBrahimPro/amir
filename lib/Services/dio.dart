import 'package:amir/global/environment.dart';
import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();
  dio.options.baseUrl = Environment.apiUrl;
  dio.options.headers['accept'] = 'application/json';
  dio.options.validateStatus = (_) => true;
  dio.options.contentType = Headers.jsonContentType;
  dio.options.responseType = ResponseType.json;
  return dio;
}
