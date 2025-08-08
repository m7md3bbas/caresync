import 'dart:convert';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static final CacheManager _instance = CacheManager._internal();
  factory CacheManager() => _instance;
  CacheManager._internal();

  late Box<String> cacheBox;
  late Box<String> userDataBox;
  late Box<String> apiCacheBox;
  late Box<String> settingsBox;
  
  static const String _cacheBoxName = 'app_cache';
  static const String _userDataBoxName = 'user_data';
  static const String _apiCacheBoxName = 'api_cache';
  static const String _settingsBoxName = 'app_settings';

  // Cache keys
  static const String _userTokenKey = 'user_token';
  static const String _userProfileKey = 'user_profile';
  static const String _doctorSchedulesKey = 'doctor_schedules';
  static const String _patientAppointmentsKey = 'patient_appointments';
  static const String _pharmacyDataKey = 'pharmacy_data';
  static const String _appSettingsKey = 'app_settings';
  static const String _lastSyncKey = 'last_sync';
  static const String _offlineDataKey = 'offline_data';

  Future<void> initialize() async {
    await Hive.initFlutter();
    
    cacheBox = await Hive.openBox<String>(_cacheBoxName);
    userDataBox = await Hive.openBox<String>(_userDataBoxName);
    apiCacheBox = await Hive.openBox<String>(_apiCacheBoxName);
    settingsBox = await Hive.openBox<String>(_settingsBoxName);
  }

  // ===== USER DATA CACHING =====
  
  Future<void> cacheUserToken(String token) async {
    await userDataBox.put(_userTokenKey, token);
  }

  String? getCachedUserToken() {
    return userDataBox.get(_userTokenKey);
  }

  Future<void> cacheUserProfile(Map<String, dynamic> profile) async {
    await userDataBox.put(_userProfileKey, jsonEncode(profile));
  }

  Map<String, dynamic>? getCachedUserProfile() {
    final data = userDataBox.get(_userProfileKey);
    if (data != null) {
      return jsonDecode(data) as Map<String, dynamic>;
    }
    return null;
  }

  // ===== API DATA CACHING =====

  Future<void> cacheApiData(String key, Map<String, dynamic> data, {Duration? expiry}) async {
    final cacheData = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiry': expiry?.inMilliseconds,
    };
    await apiCacheBox.put(key, jsonEncode(cacheData));
  }

  Map<String, dynamic>? getCachedApiData(String key) {
    final data = apiCacheBox.get(key);
    if (data != null) {
      final cacheData = jsonDecode(data) as Map<String, dynamic>;
      final timestamp = cacheData['timestamp'] as int;
      final expiry = cacheData['expiry'] as int?;
      
      // Check if cache is expired
      if (expiry != null) {
        final now = DateTime.now().millisecondsSinceEpoch;
        if (now - timestamp > expiry) {
          apiCacheBox.delete(key);
          return null;
        }
      }
      
      return cacheData['data'] as Map<String, dynamic>;
    }
    return null;
  }

  // ===== DOCTOR SCHEDULES CACHING =====

  Future<void> cacheDoctorSchedules(String weekStart, List<Map<String, dynamic>> schedules) async {
    final key = '${_doctorSchedulesKey}_$weekStart';
    await cacheApiData(key, {'schedules': schedules}, expiry: const Duration(hours: 1));
  }

  List<Map<String, dynamic>>? getCachedDoctorSchedules(String weekStart) {
    final key = '${_doctorSchedulesKey}_$weekStart';
    final data = getCachedApiData(key);
    if (data != null) {
      return (data['schedules'] as List).cast<Map<String, dynamic>>();
    }
    return null;
  }

  // ===== PATIENT APPOINTMENTS CACHING =====

  Future<void> cachePatientAppointments(List<Map<String, dynamic>> appointments) async {
    await cacheApiData(_patientAppointmentsKey, {'appointments': appointments}, expiry: const Duration(minutes: 30));
  }

  List<Map<String, dynamic>>? getCachedPatientAppointments() {
    final data = getCachedApiData(_patientAppointmentsKey);
    if (data != null) {
      return (data['appointments'] as List).cast<Map<String, dynamic>>();
    }
    return null;
  }

  // ===== PHARMACY DATA CACHING =====

  Future<void> cachePharmacyData(List<Map<String, dynamic>> pharmacies) async {
    await cacheApiData(_pharmacyDataKey, {'pharmacies': pharmacies}, expiry: const Duration(hours: 2));
  }

  List<Map<String, dynamic>>? getCachedPharmacyData() {
    final data = getCachedApiData(_pharmacyDataKey);
    if (data != null) {
      return (data['pharmacies'] as List).cast<Map<String, dynamic>>();
    }
    return null;
  }

  // ===== APP SETTINGS CACHING =====

  Future<void> cacheAppSettings(Map<String, dynamic> settings) async {
    await settingsBox.put(_appSettingsKey, jsonEncode(settings));
  }

  Map<String, dynamic>? getCachedAppSettings() {
    final data = settingsBox.get(_appSettingsKey);
    if (data != null) {
      return jsonDecode(data) as Map<String, dynamic>;
    }
    return null;
  }

  // ===== OFFLINE DATA CACHING =====

  Future<void> cacheOfflineData(String key, Map<String, dynamic> data) async {
    await cacheBox.put('${_offlineDataKey}_$key', jsonEncode(data));
  }

  Map<String, dynamic>? getOfflineData(String key) {
    final data = cacheBox.get('${_offlineDataKey}_$key');
    if (data != null) {
      return jsonDecode(data) as Map<String, dynamic>;
    }
    return null;
  }

  // ===== LAST SYNC TIMESTAMP =====

  Future<void> updateLastSync(String dataType) async {
    await cacheBox.put('${_lastSyncKey}_$dataType', DateTime.now().millisecondsSinceEpoch.toString());
  }

  DateTime? getLastSync(String dataType) {
    final timestamp = cacheBox.get('${_lastSyncKey}_$dataType');
    if (timestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    }
    return null;
  }

  // ===== IMAGE CACHING =====

  Future<File?> cacheImage(String url) async {
    try {
      final fileInfo = await DefaultCacheManager().getFileFromCache(url);
      if (fileInfo != null) {
        return fileInfo.file;
      }
      
      final file = await DefaultCacheManager().getSingleFile(url);
      return file;
    } catch (e) {
      print('Error caching image: $e');
      return null;
    }
  }

  Future<void> clearImageCache() async {
    await DefaultCacheManager().emptyCache();
  }

  // ===== CACHE MANAGEMENT =====

  Future<void> clearAllCache() async {
    await cacheBox.clear();
    await userDataBox.clear();
    await apiCacheBox.clear();
    await settingsBox.clear();
    await clearImageCache();
  }

  Future<void> clearApiCache() async {
    await apiCacheBox.clear();
  }

  Future<void> clearUserData() async {
    await userDataBox.clear();
  }

  Future<void> clearSettings() async {
    await settingsBox.clear();
  }

  // ===== CACHE STATISTICS =====

  Map<String, int> getCacheStatistics() {
    return {
      'cache_box': cacheBox.length,
      'user_data_box': userDataBox.length,
      'api_cache_box': apiCacheBox.length,
      'settings_box': settingsBox.length,
    };
  }

  // ===== UTILITY METHODS =====

  bool isCacheValid(String key, Duration maxAge) {
    final data = apiCacheBox.get(key);
    if (data != null) {
      final cacheData = jsonDecode(data) as Map<String, dynamic>;
      final timestamp = cacheData['timestamp'] as int;
      final now = DateTime.now().millisecondsSinceEpoch;
      return (now - timestamp) < maxAge.inMilliseconds;
    }
    return false;
  }

  Future<void> preloadCache() async {
    // Preload frequently accessed data
    final token = getCachedUserToken();
    if (token != null) {
      // Preload user profile
      getCachedUserProfile();
      
      // Preload app settings
      getCachedAppSettings();
    }
  }

  // ===== DISPOSE =====

  Future<void> dispose() async {
    await cacheBox.close();
    await userDataBox.close();
    await apiCacheBox.close();
    await settingsBox.close();
  }
}
