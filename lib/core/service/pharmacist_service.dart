import 'package:caresync/core/service/api_service.dart';
import 'package:dio/dio.dart';

class PharmacistService {
  final Dio _dio = ApiClient.dio;

  Future<Response> getPharmacistCategories() {
    return _dio.get('pharmacists-categories/');
  }
}
