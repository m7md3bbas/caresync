import 'package:caresync/controller/doctor/doctor_state.dart';
import 'package:caresync/core/service/doctor_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorService doctorService;
  DoctorCubit(this.doctorService)
    : super(DoctorState(state: DoctorStatus.initial));

  void getDoctorAppointments(String token) async {
    emit(state.copyWith(state: DoctorStatus.loading));
    try {
      final data = await doctorService.getDoctorAppointments(token);
      emit(state.copyWith(state: DoctorStatus.success, appointments: data));
    } catch (e) {
      emit(state.copyWith(state: DoctorStatus.error, message: e.toString()));
    }
  }
}
