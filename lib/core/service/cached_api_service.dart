import 'dart:convert';
import 'package:caresync/core/cache/cache_manager.dart';
import 'package:caresync/core/service/api_service.dart';
import 'package:caresync/models/doctor_schedule_model.dart';
import 'package:dio/dio.dart';

class CachedApiService {
  final Dio _dio = ApiClient.dio;
  final CacheManager _cacheManager = CacheManager();

  // ===== DOCTOR SCHEDULES WITH CACHING =====

  Future<List<DoctorSchedule>> getSchedulesWithCache(String token, String week) async {
    try {
      // Check cache first
      final cachedSchedules = _cacheManager.getCachedDoctorSchedules(week);
      if (cachedSchedules != null) {
        print('📦 Returning cached schedules for week: $week');
        return cachedSchedules.map((json) => DoctorSchedule.fromJson(json)).toList();
      }

      // Fetch from API
      print('🌐 Fetching schedules from API for week: $week');
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

      final schedules = (response.data as List)
          .map((e) => DoctorSchedule.fromJson(e))
          .toList();

      // Cache the results
      final schedulesJson = schedules.map((s) => s.toJson()).toList();
      await _cacheManager.cacheDoctorSchedules(week, schedulesJson);
      await _cacheManager.updateLastSync('doctor_schedules');

      print('💾 Cached ${schedules.length} schedules for week: $week');
      return schedules;
    } catch (e) {
      print('❌ Error fetching schedules: $e');
      
      // Try to return cached data even if expired
      final cachedSchedules = _cacheManager.getCachedDoctorSchedules(week);
      if (cachedSchedules != null) {
        print('🔄 Returning expired cached data due to API error');
        return cachedSchedules.map((json) => DoctorSchedule.fromJson(json)).toList();
      }
      
      throw Exception('Failed to load schedules');
    }
  }

  Future<DoctorSchedule> addScheduleWithCache(
    String token,
    DoctorSchedule schedule,
  ) async {
    try {
      print('➕ Adding schedule with cache invalidation');
      final response = await _dio.post(
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

      final addedSchedule = DoctorSchedule.fromJson(response.data);

      // Invalidate cache for the specific week
      await _invalidateScheduleCache(schedule.weekStartDate);

      print('✅ Schedule added and cache invalidated');
      return addedSchedule;
    } catch (e) {
      print('❌ Error adding schedule: $e');
      throw Exception('Failed to add schedule');
    }
  }

  Future<DoctorSchedule> updateScheduleWithCache(
    String token,
    int id,
    DoctorSchedule schedule,
  ) async {
    try {
      print('✏️ Updating schedule with cache invalidation');
      final response = await _dio.put(
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

      final updatedSchedule = DoctorSchedule.fromJson(response.data);

      // Invalidate cache for the specific week
      await _invalidateScheduleCache(schedule.weekStartDate);

      print('✅ Schedule updated and cache invalidated');
      return updatedSchedule;
    } catch (e) {
      print('❌ Error updating schedule: $e');
      throw Exception('Failed to update schedule');
    }
  }

  Future<void> deleteScheduleWithCache(
    String token,
    int id,
    String weekStartDate,
  ) async {
    try {
      print('🗑️ Deleting schedule with cache invalidation');
      await _dio.delete(
        '/doctor/schedule/$id/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );

      // Invalidate cache for the specific week
      await _invalidateScheduleCache(weekStartDate);

      print('✅ Schedule deleted and cache invalidated');
    } catch (e) {
      print('❌ Error deleting schedule: $e');
      throw Exception('Failed to delete schedule');
    }
  }

  // ===== PATIENT APPOINTMENTS WITH CACHING =====

  Future<List<Map<String, dynamic>>> getPatientAppointmentsWithCache(String token) async {
    try {
      // Check cache first
      final cachedAppointments = _cacheManager.getCachedPatientAppointments();
      if (cachedAppointments != null) {
        print('📦 Returning cached patient appointments');
        return cachedAppointments;
      }

      // Fetch from API
      print('🌐 Fetching patient appointments from API');
      final response = await _dio.get(
        '/appointments/patient/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );

      final appointments = (response.data as List).cast<Map<String, dynamic>>();

      // Cache the results
      await _cacheManager.cachePatientAppointments(appointments);
      await _cacheManager.updateLastSync('patient_appointments');

      print('💾 Cached ${appointments.length} patient appointments');
      return appointments;
    } catch (e) {
      print('❌ Error fetching patient appointments: $e');
      
      // Try to return cached data even if expired
      final cachedAppointments = _cacheManager.getCachedPatientAppointments();
      if (cachedAppointments != null) {
        print('🔄 Returning expired cached data due to API error');
        return cachedAppointments;
      }
      
      throw Exception('Failed to load patient appointments');
    }
  }

  // ===== PHARMACY DATA WITH CACHING =====

  Future<List<Map<String, dynamic>>> getPharmacyDataWithCache(String token) async {
    try {
      // Check cache first
      final cachedPharmacies = _cacheManager.getCachedPharmacyData();
      if (cachedPharmacies != null) {
        print('📦 Returning cached pharmacy data');
        return cachedPharmacies;
      }

      // Fetch from API
      print('🌐 Fetching pharmacy data from API');
      final response = await _dio.get(
        '/pharmacy/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );

      final pharmacies = (response.data as List).cast<Map<String, dynamic>>();

      // Cache the results
      await _cacheManager.cachePharmacyData(pharmacies);
      await _cacheManager.updateLastSync('pharmacy_data');

      print('💾 Cached ${pharmacies.length} pharmacies');
      return pharmacies;
    } catch (e) {
      print('❌ Error fetching pharmacy data: $e');
      
      // Try to return cached data even if expired
      final cachedPharmacies = _cacheManager.getCachedPharmacyData();
      if (cachedPharmacies != null) {
        print('🔄 Returning expired cached data due to API error');
        return cachedPharmacies;
      }
      
      throw Exception('Failed to load pharmacy data');
    }
  }

  // ===== USER PROFILE WITH CACHING =====

  Future<Map<String, dynamic>> getUserProfileWithCache(String token) async {
    try {
      // Check cache first
      final cachedProfile = _cacheManager.getCachedUserProfile();
      if (cachedProfile != null) {
        print('📦 Returning cached user profile');
        return cachedProfile;
      }

      // Fetch from API
      print('🌐 Fetching user profile from API');
      final response = await _dio.get(
        '/user/profile/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );

      final profile = response.data as Map<String, dynamic>;

      // Cache the results
      await _cacheManager.cacheUserProfile(profile);
      await _cacheManager.updateLastSync('user_profile');

      print('💾 Cached user profile');
      return profile;
    } catch (e) {
      print('❌ Error fetching user profile: $e');
      
      // Try to return cached data even if expired
      final cachedProfile = _cacheManager.getCachedUserProfile();
      if (cachedProfile != null) {
        print('🔄 Returning expired cached data due to API error');
        return cachedProfile;
      }
      
      throw Exception('Failed to load user profile');
    }
  }

  // ===== CACHE MANAGEMENT =====

  Future<void> _invalidateScheduleCache(String weekStartDate) async {
    final key = 'doctor_schedules_$weekStartDate';
    await _cacheManager.apiCacheBox.delete(key);
    print('🗑️ Invalidated cache for week: $weekStartDate');
  }

  Future<void> clearAllCache() async {
    await _cacheManager.clearAllCache();
    print('🧹 All cache cleared');
  }

  Future<void> clearApiCache() async {
    await _cacheManager.clearApiCache();
    print('🧹 API cache cleared');
  }

  Map<String, int> getCacheStatistics() {
    return _cacheManager.getCacheStatistics();
  }

  // ===== OFFLINE SUPPORT =====

  Future<void> cacheOfflineAction(String action, Map<String, dynamic> data) async {
    await _cacheManager.cacheOfflineData(action, data);
    print('📱 Cached offline action: $action');
  }

  List<Map<String, dynamic>> getOfflineActions() {
    final actions = <Map<String, dynamic>>[];
    final keys = _cacheManager.cacheBox.keys.where((key) => key.toString().startsWith('offline_data_'));
    
    for (final key in keys) {
      final data = _cacheManager.getOfflineData(key.toString().replaceFirst('offline_data_', ''));
      if (data != null) {
        actions.add(data);
      }
    }
    
    return actions;
  }

  Future<void> syncOfflineActions(String token) async {
    final actions = getOfflineActions();
    print('🔄 Syncing ${actions.length} offline actions');
    
    for (final action in actions) {
      try {
        final actionType = action['type'] as String;
        final actionData = action['data'] as Map<String, dynamic>;
        
        switch (actionType) {
          case 'add_schedule':
            await addScheduleWithCache(token, DoctorSchedule.fromJson(actionData));
            break;
          case 'update_schedule':
            await updateScheduleWithCache(token, actionData['id'] as int, DoctorSchedule.fromJson(actionData['schedule']));
            break;
          case 'delete_schedule':
            await deleteScheduleWithCache(token, actionData['id'] as int, actionData['weekStartDate'] as String);
            break;
        }
        
        // Remove from offline cache after successful sync
        await _cacheManager.cacheBox.delete('offline_data_${action['id']}');
      } catch (e) {
        print('❌ Failed to sync offline action: $e');
      }
    }
  }
}
