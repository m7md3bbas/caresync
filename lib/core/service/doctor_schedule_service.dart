import 'package:caresync/core/service/api_service.dart';
import 'package:caresync/core/service/cached_api_service.dart';
import 'package:caresync/models/doctor_schedule_model.dart';
import 'package:dio/dio.dart';

class DoctorScheduleService {
  final CachedApiService _cachedApiService = CachedApiService();

  Future<List<DoctorSchedule>> getSchedules(String token, String week) async {
    return await _cachedApiService.getSchedulesWithCache(token, week);
  }

  Future<DoctorSchedule> addSchedule(
    String token,
    DoctorSchedule schedule,
  ) async {
    return await _cachedApiService.addScheduleWithCache(token, schedule);
  }

  Future<DoctorSchedule> updateSchedule(
    String token,
    int id,
    DoctorSchedule schedule,
  ) async {
    return await _cachedApiService.updateScheduleWithCache(token, id, schedule);
  }

  Future<void> deleteSchedule(String token, int id, String weekStartDate) async {
    await _cachedApiService.deleteScheduleWithCache(token, id, weekStartDate);
  }

  // Cache management methods
  Future<void> clearCache() async {
    await _cachedApiService.clearApiCache();
  }

  Map<String, int> getCacheStatistics() {
    return _cachedApiService.getCacheStatistics();
  }
}
