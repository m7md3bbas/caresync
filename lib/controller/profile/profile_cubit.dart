import 'package:caresync/controller/profile/profile_state.dart';
import 'package:caresync/core/service/profile_service.dart';
import 'package:caresync/models/doctor_model.dart';
import 'package:caresync/models/patient_model.dart';
import 'package:caresync/models/pharmacist_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService profileService;
  ProfileCubit(this.profileService)
    : super(ProfileState(status: ProfileStatus.initial));

  Future<void> getProfile(String token) async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));

      final profile = await profileService.getProfile(token);

      if (profile is DoctorModel) {
        emit(
          state.copyWith(
            status: ProfileStatus.success,
            doctorModel: profile as DoctorModel,
          ),
        );
      } else if (profile is PatientModel) {
        emit(
          state.copyWith(
            status: ProfileStatus.success,
            patientModel: profile as PatientModel,
          ),
        );
      } else if (profile is PharmacistModel) {
        emit(
          state.copyWith(
            status: ProfileStatus.success,
            pharmacistModel: profile as PharmacistModel,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ProfileStatus.error,
            message: "Unknown user type",
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.error, message: e.toString()));
    }
  }
}
