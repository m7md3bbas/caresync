import 'package:caresync/models/doctor_schedule_model.dart';

enum DoctorScheduleStatus {
  initial,
  loading,
  fetchSuccess,
  addSuccess,
  updateSuccess,
  deleteSuccess,
  error,
}

class DoctorScheduleState {
  final DoctorScheduleStatus status;
  final List<DoctorSchedule>? schedules;
  final String? errorMessage;

  const DoctorScheduleState({
    required this.status,
    this.schedules,
    this.errorMessage,
  });

  DoctorScheduleState copyWith({
    DoctorScheduleStatus? status,
    List<DoctorSchedule>? schedules,
    String? errorMessage,
  }) {
    return DoctorScheduleState(
      status: status ?? this.status,
      schedules: schedules ?? this.schedules,
      errorMessage: errorMessage,
    );
  }
}
