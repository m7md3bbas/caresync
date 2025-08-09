import 'dart:convert';
import 'package:caresync/core/cache/cache_manager.dart';
import 'package:caresync/core/service/cached_api_service.dart';
import 'package:caresync/models/doctor_schedule_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class OfflineService {
  final CacheManager _cacheManager = CacheManager();
  final CachedApiService _cachedApiService = CachedApiService();

  // ===== CONNECTIVITY CHECK =====

  Future<bool> isOnline() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Stream<List<ConnectivityResult>> get connectivityStream {
    return Connectivity().onConnectivityChanged;
  }

  // ===== OFFLINE DATA MANAGEMENT =====

  Future<void> saveOfflineAction(
    String actionType,
    Map<String, dynamic> data,
  ) async {
    final actionId = DateTime.now().millisecondsSinceEpoch.toString();
    final offlineAction = {
      'id': actionId,
      'type': actionType,
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    };

    await _cacheManager.cacheOfflineData(actionId, offlineAction);
  }

  List<Map<String, dynamic>> getOfflineActions() {
    return _cachedApiService.getOfflineActions();
  }

  Future<void> syncOfflineActions(String token) async {
    if (!await isOnline()) {
      return;
    }

    final actions = getOfflineActions();
    if (actions.isEmpty) {
      return;
    }

    for (final action in actions) {
      try {
        final actionType = action['type'] as String;
        final actionData = action['data'] as Map<String, dynamic>;

        switch (actionType) {
          case 'add_schedule':
            await _cachedApiService.addScheduleWithCache(
              token,
              DoctorSchedule.fromJson(actionData),
            );
            break;
          case 'update_schedule':
            await _cachedApiService.updateScheduleWithCache(
              token,
              actionData['id'] as int,
              DoctorSchedule.fromJson(actionData['schedule']),
            );
            break;
          case 'delete_schedule':
            await _cachedApiService.deleteScheduleWithCache(
              token,
              actionData['id'] as int,
              actionData['weekStartDate'] as String,
            );
            break;
        }
        await _cacheManager.cacheBox.delete('offline_data_${action['id']}');
        print('✅ Synced offline action: $actionType');
      } catch (e) {
        print('❌ Failed to sync offline action: $e');
      }
    }

    print('✅ Offline sync completed');
  }

  Future<void> addScheduleOffline(DoctorSchedule schedule) async {
    await saveOfflineAction('add_schedule', schedule.toJson());
  }

  Future<void> updateScheduleOffline(int id, DoctorSchedule schedule) async {
    await saveOfflineAction('update_schedule', {
      'id': id,
      'schedule': schedule.toJson(),
    });
  }

  Future<void> deleteScheduleOffline(int id, String weekStartDate) async {
    await saveOfflineAction('delete_schedule', {
      'id': id,
      'weekStartDate': weekStartDate,
    });
  }

  // ===== CACHE VALIDATION =====

  bool isCacheValid(String dataType, Duration maxAge) {
    final lastSync = _cacheManager.getLastSync(dataType);
    if (lastSync == null) return false;

    final now = DateTime.now();
    return now.difference(lastSync) < maxAge;
  }

  // ===== OFFLINE INDICATOR =====

  Future<bool> shouldShowOfflineIndicator() async {
    final isConnected = await isOnline();
    final hasOfflineActions = getOfflineActions().isNotEmpty;

    return !isConnected && hasOfflineActions;
  }

  // ===== CACHE PRELOADING =====

  Future<void> preloadEssentialData(String token) async {
    try {
      print('🔄 Preloading essential data for offline use...');

      // Preload user profile
      await _cachedApiService.getUserProfileWithCache(token);

      // Preload current week schedules
      final now = DateTime.now();
      final currentWeek = _getStartOfWeek(now);
      final nextWeek = currentWeek.add(const Duration(days: 7));

      await _cachedApiService.getSchedulesWithCache(
        token,
        _formatDate(currentWeek),
      );
      await _cachedApiService.getSchedulesWithCache(
        token,
        _formatDate(nextWeek),
      );

      print('✅ Essential data preloaded');
    } catch (e) {
      print('❌ Error preloading essential data: $e');
    }
  }

  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // ===== CACHE STATISTICS =====

  Map<String, dynamic> getOfflineStatistics() {
    final actions = getOfflineActions();
    final stats = _cacheManager.getCacheStatistics();

    return {
      'offline_actions_count': actions.length,
      'cache_statistics': stats,
      'last_sync': {
        'doctor_schedules': _cacheManager.getLastSync('doctor_schedules'),
        'patient_appointments': _cacheManager.getLastSync(
          'patient_appointments',
        ),
        'pharmacy_data': _cacheManager.getLastSync('pharmacy_data'),
        'user_profile': _cacheManager.getLastSync('user_profile'),
      },
    };
  }

  // ===== CACHE CLEANUP =====

  Future<void> cleanupExpiredCache() async {
    try {
      print('🧹 Cleaning up expired cache...');

      // This will be handled by the cache manager's expiry logic
      // Just trigger a cleanup check
      await _cacheManager.preloadCache();

      print('✅ Cache cleanup completed');
    } catch (e) {
      print('❌ Error during cache cleanup: $e');
    }
  }
}
