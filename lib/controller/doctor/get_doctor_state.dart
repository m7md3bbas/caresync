import 'package:caresync/models/get_doctors.dart';

enum GetDoctorsStatus { initial, loading, success, error }

class GetDoctorsState {
  final GetDoctorsStatus status;
  final List<GetDoctorModel>? doctors;
  final String? errorMessage;

  const GetDoctorsState({
    required this.status,
    this.doctors,
    this.errorMessage,
  });

  factory GetDoctorsState.initial() {
    return const GetDoctorsState(status: GetDoctorsStatus.initial, doctors: []);
  }

  GetDoctorsState copyWith({
    GetDoctorsStatus? status,
    List<GetDoctorModel>? doctors,
    String? errorMessage,
  }) {
    return GetDoctorsState(
      status: status ?? this.status,
      doctors: doctors ?? this.doctors,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
