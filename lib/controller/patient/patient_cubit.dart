import 'package:caresync/controller/patient/patient_state.dart';
import 'package:caresync/core/service/patient_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientCubit extends Cubit<PatientState> {
  final PatientService patientService;

  PatientCubit(this.patientService)
    : super(PatientState(status: PatientStatus.initial));

  void getPatientPresceiption({
    required String nationalId,
    required String token,
  }) async {
    emit(state.copyWith(status: PatientStatus.loading));

    try {
      final response = await patientService.searchPatientByNationalId(
        nationalId,
        token,
      );

      emit(
        state.copyWith(
          status: PatientStatus.success,
          message: "Patient data retrieved successfully",
          getPatientModel: response,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PatientStatus.error, message: e.toString()));
    }
  }
}
