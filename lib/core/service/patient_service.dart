import 'package:caresync/core/service/api_service.dart';
import 'package:dio/dio.dart';

class PatientService {
  final Dio _dio = ApiClient.dio;

  Future<Response> searchPatientByNationalId(String nationalId, String token) {
    return _dio.get(
      'search-patient/$nationalId/',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
