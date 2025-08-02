import 'package:bloc/bloc.dart';
import 'package:caresync/controller/patient/book_appoinment_state.dart';
import 'package:caresync/core/service/patient_service.dart';
import 'package:caresync/models/book_appoinment.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final PatientService service;

  AppointmentCubit(this.service) : super(AppointmentState());

  Future<void> bookAppointment(
    AppointmentBookingModel model,
    String token,
  ) async {
    try {
      emit(state.copyWith(status: AppointmentStatus.loading));
      await service.bookAppointment(model, token);
      emit(state.copyWith(status: AppointmentStatus.success));
    } catch (e) {
      emit(
        state.copyWith(status: AppointmentStatus.error, message: e.toString()),
      );
    }
  }
}
