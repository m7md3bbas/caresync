import 'package:caresync/controller/doctor/doctor_state.dart';
import 'package:caresync/core/service/doctor_service.dart';
import 'package:caresync/models/prescription_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorService doctorService;
  DoctorCubit(this.doctorService)
    : super(DoctorState(state: DoctorStatus.initial));

  Future<void> getDoctorAppointments(String token) async {
    emit(state.copyWith(state: DoctorStatus.loading));
    try {
      final data = await doctorService.getDoctorAppointments(token);
      emit(state.copyWith(state: DoctorStatus.success, appointments: data));
    } catch (e) {
      emit(state.copyWith(state: DoctorStatus.error, message: e.toString()));
    }
  }

  Future<void> appointmentStatusUpdate(int id, String status, {String doctorNotes = ''}) async {
    emit(state.copyWith(state: DoctorStatus.loading));
    try {
      await doctorService.updateAppointmentStatus(id, status, doctorNotes: doctorNotes);
      emit(state.copyWith(state: DoctorStatus.success));
    } catch (e) {
      emit(state.copyWith(state: DoctorStatus.error, message: e.toString()));
    }
  }


  void addPerscription(
    String patientID,
    String token,
    String medicineName,
    String dosage,
    String instruction,
  ) async {
    emit(state.copyWith(state: DoctorStatus.loading));
    try {
      await doctorService.addPrescription(
        patientID,
        PrescriptionModel(
          medicineName: medicineName,
          dosage: dosage,
          instructions: instruction,
        ),
        token,
      );
      emit(state.copyWith(state: DoctorStatus.sent));
    } catch (e) {
      emit(state.copyWith(state: DoctorStatus.error, message: e.toString()));
    }
  }
}
