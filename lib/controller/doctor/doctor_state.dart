import 'package:caresync/models/appoinment_model.dart';

enum DoctorStatus { initial, loading, success, error }

class DoctorState {
  final DoctorStatus state;
  final List<Appointment>? appointments;
  final String? message;
  const DoctorState({required this.state, this.message, this.appointments});

  DoctorState copyWith({
    DoctorStatus? state,
    List<Appointment>? appointments,
    String? message,
  }) {
    return DoctorState(
      state: state ?? this.state,
      appointments: appointments ?? this.appointments,
      message: message ?? this.message,
    );
  }
}
