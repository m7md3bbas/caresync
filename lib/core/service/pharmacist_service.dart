import 'package:caresync/core/service/api_service.dart';
import 'package:caresync/models/all_pharmacist_model.dart';
import 'package:dio/dio.dart';

class PharmacistService {
  final Dio _dio = ApiClient.dio;

  Future<List<SinglePharmacy>> getPharmacistCategories() async {
    final response = await _dio.get('pharmacists-categories/');
    if (response.statusCode == 200) {
      final data = response.data as List;
      return data.map((item) => SinglePharmacy.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch pharmacies');
    }
  }
}
