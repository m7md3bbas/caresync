import 'package:caresync/core/service/api_service.dart';
import 'package:caresync/models/get_patient_details.dart';
import 'package:dio/dio.dart';

class PatientService {
  final Dio _dio = ApiClient.dio;

  Future<GetPatientModel> searchPatientByNationalId(
    String nationalId,
    String token,
  ) async {
    try {
      final response = await _dio.get(
        'search-patient/$nationalId/',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return GetPatientModel.fromJson(response.data);
      } else {
        throw Exception(response.data['detail'] ?? 'Failed to fetch patient');
      }
    } catch (e) {
      throw Exception("Server error");
    }
  }
}
