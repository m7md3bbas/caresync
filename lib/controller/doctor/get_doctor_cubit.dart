import 'package:caresync/controller/doctor/get_doctor_state.dart';
import 'package:caresync/core/service/doctor_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetDoctorsCubit extends Cubit<GetDoctorsState> {
  final DoctorService doctorService;
  GetDoctorsCubit(this.doctorService)
    : super(GetDoctorsState(status: GetDoctorsStatus.initial));

  Future<void> fetchDoctors(String token) async {
    emit(state.copyWith(status: GetDoctorsStatus.loading));

    try {
      final response = await doctorService.getDoctors(token);

      emit(state.copyWith(status: GetDoctorsStatus.success, doctors: response));
    } catch (e) {
      emit(
        state.copyWith(
          status: GetDoctorsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
