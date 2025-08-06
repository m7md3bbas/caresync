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
      return _dio.post('register/', data: model.toFormDataMap());
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        throw Exception(e.response?.data);
      } else {
        throw Exception("Network error");
      }
    } catch (e) {
      throw Exception("server error");
    }
  }

  Future<Response> registerPharmacist(PharmacistModel model) async {
    try {
      final formData = await model.toFormData();
      return await _dio.post(
        'register/',
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
      );
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        throw Exception(e.response?.data);
      } else {
        throw Exception("Network error");
      }
    } catch (e) {
      throw Exception("server error");
    }
  }

  Future<Response> registerDoctor(DoctorModel model) async {
    try {
      final response = await _dio.post(
        'register/',
        data: model.toFormData(),
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        print(e.response?.data);
        throw Exception(e.response?.data);
      } else {
        throw Exception("Network error");
      }
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
      }
      return response;
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        throw Exception(e.response?.data);
      } else {
        throw Exception("Network error");
      }
    } catch (e) {
      throw Exception("server error");
    }
  }

  void logout() async {
    await SharedPrefHelper.remove(SharedPrefKeys.token);
    await SharedPrefHelper.remove(SharedPrefKeys.userType);
  }

  Future<Response> requestPasswordReset(PasswordResetRequest request) async {
    try {
      final response = await _dio.post(
        'request-password-reset/',
        data: request.toJson(),
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        throw Exception(e.response?.data);
      } else {
        throw Exception("Network error");
      }
    } catch (e) {
      throw Exception("server error");
    }
  }

  Future<Response> verifyOtp(VerifyOtpRequest request) async {
    try {
      final response = _dio.post('verify-otp/', data: request.toJson());
      return response;
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        throw Exception(e.response?.data);
      } else {
        throw Exception("Network error");
      }
    } catch (e) {
      throw Exception("server error");
    }
  }

  Future<Response> setNewPassword(SetNewPasswordRequest request) async {
    try {
      final response = await _dio.post(
        'set-new-password/',
        data: request.toJson(),
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        throw Exception(e.response?.data);
      } else {
        throw Exception("Network error");
      }
    } catch (e) {
      throw Exception("server error");
    }
  }
}
