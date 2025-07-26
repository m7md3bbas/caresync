import 'package:caresync/core/service/api_service.dart';
import 'package:caresync/models/contact_us_model.dart';
import 'package:dio/dio.dart';

class ContactUsService {
  final Dio _dio = ApiClient.dio;

  Future<Response> sendMessage(ContactUsModel model, String token) {
    return _dio.post(
      'contact-us/',
      data: model.toJson(),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
