import 'package:anterin/utils/token.dart';
import 'package:dio/dio.dart';

Future<Dio> httpInstance() async {
  final headers = {
    'Accept': 'application/json',
  };

  final token = await AuthToken.get();

  if (token != null) {
    headers['Authorization'] = 'Bearer $token';
  }

  final options = BaseOptions(
    baseUrl: 'http://localhost:8000',
    headers: headers,
  );

  return Dio(options);
}
