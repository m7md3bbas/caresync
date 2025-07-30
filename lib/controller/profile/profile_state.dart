import 'package:caresync/models/doctor_model.dart';
import 'package:caresync/models/patient_model.dart';
import 'package:caresync/models/pharmacist_model.dart';

enum ProfileStatus { initial, loading, success, error }

class ProfileState {
  final ProfileStatus status;
  final DoctorModel? doctorModel;
  final PatientModel? patientModel;
  final PharmacistModel? pharmacistModel;
  final String? message;

  ProfileState({
    this.status = ProfileStatus.initial,
    this.doctorModel,
    this.patientModel,
    this.pharmacistModel,
    this.message,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    DoctorModel? doctorModel,
    PatientModel? patientModel,
    PharmacistModel? pharmacistModel,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      doctorModel: doctorModel ?? this.doctorModel,
      patientModel: patientModel ?? this.patientModel,
      pharmacistModel: pharmacistModel ?? this.pharmacistModel,
      message: message ?? this.message,
    );
  }
}
