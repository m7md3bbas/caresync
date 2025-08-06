import 'package:caresync/core/service/api_service.dart';
import 'package:caresync/models/doctor_schedule_model.dart';
import 'package:dio/dio.dart';

class DoctorScheduleService {
  final Dio _dio = ApiClient.dio;

  Future<List<DoctorSchedule>> getSchedules(String token, String week) async {
    try {
      final response = await _dio.get(
        '/appointments/doctor/schedule/',
        queryParameters: {'week': week},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );
      return (response.data as List)
          .map((e) => DoctorSchedule.fromJson(e))
          .toList();
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load schedules');
    }
  }

  Future<void> addSchedule(String token, DoctorSchedule schedule) async {
    print(schedule.toJson());
    try {
      await _dio.post(
        '/appointments/doctor/schedule/',
        data: schedule.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to add schedule');
    }
  }

  Future<void> updateSchedule(
    String token,
    int id,
    DoctorSchedule schedule,
  ) async {
    try {
      await _dio.put(
        '/appointments/doctor/schedule/$id/',
        data: schedule.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to update schedule');
    }
  }

  Future<void> deleteSchedule(String token, int id) async {
    try {
      await _dio.delete(
        '/doctor/schedule/$id/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to delete schedule');
    }
  }
}
