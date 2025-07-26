import 'package:caresync/core/service/api_service.dart';
import 'package:caresync/models/doctor_model.dart';
import 'package:caresync/models/login_request_model.dart';
import 'package:caresync/models/password_reset_model.dart';
import 'package:caresync/models/patient_model.dart';
import 'package:caresync/models/pharmacist_model.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = ApiClient.dio;

  Future<Response> registerPatient(PatientModel model) {
    return _dio.post('register/', data: model.toJson());
  }

  Future<Response> registerPharmacist(PharmacistModel model) {
    return _dio.post('register/', data: model.toJson());
  }

  Future<Response> registerDoctor(DoctorModel model) {
    return _dio.post('register/', data: model.toJson());
  }

  Future<Response> login(LoginRequest request) {
    return _dio.post('login/', data: request.toJson());
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
