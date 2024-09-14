import 'package:dio/dio.dart';

Dio http() {
  final headers = {
    'Accept': 'application/json',
  };

  final options = BaseOptions(
    baseUrl: 'http://localhost:8000',
    headers: headers,
  );

  return Dio(options);
}
