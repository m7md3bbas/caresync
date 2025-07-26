import 'package:caresync/core/service/api_service.dart';
import 'package:dio/dio.dart';

class ProfileService {
  final Dio _dio = ApiClient.dio;

  Future<Response> getProfile(String token) {
    return _dio.get(
      'profile/',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
