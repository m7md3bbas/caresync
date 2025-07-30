import 'package:caresync/core/service/api_service.dart';
import 'package:caresync/models/appoinment_model.dart';
import 'package:caresync/models/prescription_model.dart';
import 'package:dio/dio.dart';

class DoctorService {
  final Dio _dio = ApiClient.dio;

  Future<Response> getDoctorCategories() {
    return _dio.get('doctors-categories/');
  }

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

  Future<List<Appointment>> getDoctorAppointments(String token) async {
    final response = await _dio.get(
      '/appointments/doctor/appointments/',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      return List<Appointment>.from(response.data);
    } else {
      throw Exception('Failed to fetch appointments');
    }
  }
}
