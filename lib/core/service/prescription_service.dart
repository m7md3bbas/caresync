import 'package:caresync/core/service/api_service.dart';
import 'package:caresync/models/prescription_model.dart';
import 'package:dio/dio.dart';

class PrescriptionService {
  final Dio _dio = ApiClient.dio;

  Future<Response> addPrescription(
    String patientNationalId,
    PrescriptionModel model,
    String token,
  ) {
    return _dio.post(
      'patients/$patientNationalId/prescriptions/',
      data: model.toJson(),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
