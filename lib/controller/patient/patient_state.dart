import 'package:caresync/models/get_patient_details.dart';

enum PatientStatus { initial, loading, success, error }

class PatientState {
  final PatientStatus status;
  final GetPatientModel? getPatientModel;
  final String? message;

  PatientState({required this.status, this.getPatientModel, this.message});

  PatientState copyWith({
    PatientStatus? status,
    GetPatientModel? getPatientModel,
    String? message,
  }) {
    return PatientState(
      status: status ?? this.status,
      getPatientModel: getPatientModel ?? this.getPatientModel,
      message: message ?? this.message,
    );
  }
}
