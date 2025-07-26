import 'package:caresync/core/service/api_service.dart';
import 'package:dio/dio.dart';

class DoctorService {
  final Dio _dio = ApiClient.dio;

  Future<Response> getDoctorCategories() {
    return _dio.get('doctors-categories/');
  }
}
