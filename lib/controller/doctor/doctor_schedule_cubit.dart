import 'package:caresync/controller/doctor/doctor_schedule_state.dart';
import 'package:caresync/models/doctor_schedule_model.dart';
import 'package:caresync/core/service/doctor_schedule_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorScheduleCubit extends Cubit<DoctorScheduleState> {
  final DoctorScheduleService service;

  DoctorScheduleCubit(this.service)
    : super(const DoctorScheduleState(status: DoctorScheduleStatus.initial));

  Future<void> fetchSchedules(String token, String weekStartDate) async {
    emit(state.copyWith(status: DoctorScheduleStatus.loading));
    try {
      final schedules = await service.getSchedules(token, weekStartDate);
      print('📦 Fetched ${schedules.length} schedules for week: $weekStartDate');
      emit(
        state.copyWith(
          status: DoctorScheduleStatus.fetchSuccess,
          schedules: schedules,
        ),
      );
    } catch (e) {
      print('❌ Error fetching schedules: $e');
      emit(
        state.copyWith(
          status: DoctorScheduleStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> addSchedule(String token, DoctorSchedule schedule, String currentWeek) async {
    emit(state.copyWith(status: DoctorScheduleStatus.loading));
    try {
      print('=== ADDING SCHEDULE ===');
      print('Schedule details:');
      print('- Day: ${schedule.dayName}');
      print('- Week Start: ${schedule.weekStartDate}');
      print('- Is Working: ${schedule.isWorkingDay}');
      print('- Start Time: ${schedule.startTime}');
      print('- End Time: ${schedule.endTime}');
      print('- Duration: ${schedule.appointmentDuration}');
      print('- Current Week: $currentWeek');
      
      final addedSchedule = await service.addSchedule(token, schedule);
      print('✅ Successfully added schedule: ${addedSchedule.id}');
      print('Added schedule weekStart: ${addedSchedule.weekStartDate}');

      // Refresh the schedules list for the currently selected week
      print('🔄 Refreshing schedules for current week: $currentWeek');
      final updatedSchedules = await service.getSchedules(
        token,
        currentWeek,
      );
      print('📦 Refreshed schedules count: ${updatedSchedules.length}');
      
      updatedSchedules.forEach((s) {
        print('Updated schedule: ${s.dayName} - Week: ${s.weekStartDate} - Working: ${s.isWorkingDay}');
      });

      emit(
        state.copyWith(
          status: DoctorScheduleStatus.addSuccess,
          schedules: updatedSchedules,
        ),
      );
      print('=== END ADDING SCHEDULE ===');
    } catch (e) {
      print('❌ Error adding schedule: $e');
      emit(
        state.copyWith(
          status: DoctorScheduleStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> updateSchedule(String token, DoctorSchedule schedule, String currentWeek) async {
    emit(state.copyWith(status: DoctorScheduleStatus.loading));
    try {
      if (schedule.id == null) throw Exception('Schedule ID is required');

      print('✏️ Updating schedule: ${schedule.id}');
      final updatedSchedule = await service.updateSchedule(token, schedule.id!, schedule);
      print('✅ Successfully updated schedule: ${updatedSchedule.id}');

      // Refresh the schedules list for the currently selected week
      final updatedSchedules = await service.getSchedules(
        token,
        currentWeek,
      );
      print('📦 Refreshed schedules count: ${updatedSchedules.length}');

      emit(
        state.copyWith(
          status: DoctorScheduleStatus.updateSuccess,
          schedules: updatedSchedules,
        ),
      );
    } catch (e) {
      print('❌ Error updating schedule: $e');
      emit(
        state.copyWith(
          status: DoctorScheduleStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteSchedule(
    String token,
    int id,
    String weekStartDate,
  ) async {
    emit(state.copyWith(status: DoctorScheduleStatus.loading));
    try {
      print('🗑️ Deleting schedule: $id');
      await service.deleteSchedule(token, id, weekStartDate);
      print('✅ Successfully deleted schedule: $id');

      final updatedSchedules = await service.getSchedules(token, weekStartDate);
      print('📦 Refreshed schedules count: ${updatedSchedules.length}');

      emit(
        state.copyWith(
          status: DoctorScheduleStatus.deleteSuccess,
          schedules: updatedSchedules,
        ),
      );
    } catch (e) {
      print('❌ Error deleting schedule: $e');
      emit(
        state.copyWith(
          status: DoctorScheduleStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // Cache management methods
  Future<void> clearCache() async {
    await service.clearCache();
    print('🧹 Cache cleared');
  }

  Map<String, int> getCacheStatistics() {
    return service.getCacheStatistics();
  }

  Future<void> preloadCache(String token) async {
    try {
      print('🔄 Preloading cache...');
      // Preload current week and next week
      final now = DateTime.now();
      final currentWeek = _getStartOfWeek(now);
      final nextWeek = currentWeek.add(const Duration(days: 7));
      
      await service.getSchedules(token, _formatDate(currentWeek));
      await service.getSchedules(token, _formatDate(nextWeek));
      
      print('✅ Cache preloaded');
    } catch (e) {
      print('❌ Error preloading cache: $e');
    }
  }

  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
