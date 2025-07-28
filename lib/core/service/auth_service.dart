import 'package:caresync/core/service/api_service.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/models/doctor_model.dart';
import 'package:caresync/models/login_request_model.dart';
import 'package:caresync/models/password_reset_model.dart';
import 'package:caresync/models/patient_model.dart';
import 'package:caresync/models/pharmacist_model.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = ApiClient.dio;

  Future<Response> registerPatient(PatientModel model) {
    try {
      return _dio.post('register/', data: model.toJson());
    } catch (e) {
      throw Exception("server error");
    }
  }

  Future<Response> registerPharmacist(PharmacistModel model) {
    try {
      return _dio.post('register/', data: model.toJson());
    } catch (e) {
      throw Exception("server error");
    }
  }

  Future<Response> registerDoctor(DoctorModel model) {
    try {
      return _dio.post('register/', data: model.toJson());
    } catch (e) {
      throw Exception("server error");
    }
  }

  Future<Response> login(LoginRequest request) async {
    try {
      final response = await _dio.post('login/', data: request.toJson());

      if (response.statusCode == 200) {
        await SharedPrefHelper.setString(
          SharedPrefKeys.token,
          response.data['access'],
        );
        await SharedPrefHelper.setString(
          SharedPrefKeys.userType,
          response.data['user_type'],
        );
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw Exception(response.data['detail']);
      }
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void logout() async {
    await SharedPrefHelper.remove(SharedPrefKeys.token);
    await SharedPrefHelper.remove(SharedPrefKeys.userType);
  }

  Future<Response> requestPasswordReset(PasswordResetRequest request) {
    return _dio.post('request-password-reset/', data: request.toJson());
  }

  Future<Response> verifyOtp(VerifyOtpRequest request) {
    return _dio.post('verify-otp/', data: request.toJson());
  }

  Future<Response> setNewPassword(SetNewPasswordRequest request) {
    return _dio.post('set-new-password/', data: request.toJson());
  }
}
