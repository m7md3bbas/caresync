enum GetDoctorScheduleStatus { initial, loading, success, failure }

class DoctorScheduleState {
  final GetDoctorScheduleStatus status;
  final List<Map<String, dynamic>> slots;
  final String? errorMessage;

  const DoctorScheduleState({
    this.status = GetDoctorScheduleStatus.initial,
    this.slots = const [],
    this.errorMessage,
  });

  DoctorScheduleState copyWith({
    GetDoctorScheduleStatus? status,
    List<Map<String, dynamic>>? slots,
    String? errorMessage,
  }) {
    return DoctorScheduleState(
      status: status ?? this.status,
      slots: slots ?? this.slots,
      errorMessage: errorMessage,
    );
  }
}
