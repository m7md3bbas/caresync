import 'package:caresync/core/service/api_service.dart';
import 'package:caresync/models/doctor_model.dart';
import 'package:caresync/models/patient_model.dart';
import 'package:caresync/models/pharmacist_model.dart';
import 'package:dio/dio.dart';

abstract class UserProfile {}

class DoctorProfile extends UserProfile {
  final DoctorModel data;
  DoctorProfile(this.data);
}

class PatientProfile extends UserProfile {
  final PatientModel data;
  PatientProfile(this.data);
}

class PharmacistProfile extends UserProfile {
  final PharmacistModel data;
  PharmacistProfile(this.data);
}

class ProfileService {
  final Dio _dio = ApiClient.dio;

  Future<UserProfile> getProfile(String token) async {
    final response = await _dio.get(
      'profile/',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    final data = response.data;
    final userType = data['user_type'];

    switch (userType) {
      case 'doctor':
        return DoctorProfile(DoctorModel.fromJson(data));
      case 'patient':
        return PatientProfile(PatientModel.fromJson(data));
      case 'pharmacist':
        return PharmacistProfile(PharmacistModel.fromJson(data));
      default:
        throw Exception('Unknown user type: $userType');
    }
  }
}
