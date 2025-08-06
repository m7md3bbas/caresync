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
      emit(
        state.copyWith(
          status: DoctorScheduleStatus.fetchSuccess,
          schedules: schedules,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DoctorScheduleStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> addSchedule(String token, DoctorSchedule schedule) async {
    emit(state.copyWith(status: DoctorScheduleStatus.loading));
    try {
      await service.addSchedule(token, schedule);

      final updatedSchedules = await service.getSchedules(
        token,
        schedule.weekStartDate,
      );

      emit(
        state.copyWith(
          status: DoctorScheduleStatus.addSuccess,
          schedules: updatedSchedules,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DoctorScheduleStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> updateSchedule(String token, DoctorSchedule schedule) async {
    emit(state.copyWith(status: DoctorScheduleStatus.loading));
    try {
      if (schedule.id == null) throw Exception('Schedule ID is required');

      await service.updateSchedule(token, schedule.id!, schedule);

      final updatedSchedules = await service.getSchedules(
        token,
        schedule.weekStartDate,
      );

      emit(
        state.copyWith(
          status: DoctorScheduleStatus.updateSuccess,
          schedules: updatedSchedules,
        ),
      );
    } catch (e) {
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
      await service.deleteSchedule(token, id);

      final updatedSchedules = await service.getSchedules(token, weekStartDate);

      emit(
        state.copyWith(
          status: DoctorScheduleStatus.deleteSuccess,
          schedules: updatedSchedules,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DoctorScheduleStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
