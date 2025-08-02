enum AppointmentStatus { initial, loading, success, error }

class AppointmentState {
  final AppointmentStatus status;
  final String? message;

  AppointmentState({this.status = AppointmentStatus.initial, this.message});

  AppointmentState copyWith({AppointmentStatus? status, String? message}) {
    return AppointmentState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
