import 'package:caresync/models/doctor_model.dart';
import 'package:caresync/models/patient_model.dart';
import 'package:caresync/models/pharmacist_model.dart';

enum AuthStatus {
  initial,
  loading,
  unauthenticated,
  authenticated,
  registerd,
  error,
}

class AuthState {
  final AuthStatus authStatus;
  final String? errorMessage;

  AuthState({required this.authStatus, this.errorMessage});

  AuthState copyWith({
    AuthStatus? authStatus,
    DoctorModel? doctorModel,
    PatientModel? patientModel,
    PharmacistModel? pharmacistModel,
    String? errorMessage,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'AuthState(authStatus: $authStatus, errorMessage: $errorMessage)';
}
