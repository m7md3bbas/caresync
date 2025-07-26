import 'package:caresync/controller/auth/auth_state.dart';
import 'package:caresync/core/service/auth_service.dart';
import 'package:caresync/models/doctor_model.dart';
import 'package:caresync/models/login_request_model.dart';
import 'package:caresync/models/password_reset_model.dart';
import 'package:caresync/models/patient_model.dart';
import 'package:caresync/models/pharmacist_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit({required this.authService})
    : super(AuthState(authStatus: AuthStatus.initial));

  Future<void> login({
    required String nationalID,
    required String password,
  }) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      final response = await authService.login(
        LoginRequest(nationalId: nationalID, password: password),
      );

      emit(state.copyWith(authStatus: AuthStatus.authenticated));
    } catch (e) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> reigsterPatient(PatientModel patientModel) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    try {
      final response = await authService.registerPatient(patientModel);
      emit(state.copyWith(authStatus: AuthStatus.registerd));
    } catch (e) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> registerPharmacist(PharmacistModel pharmacistModel) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    try {
      final response = await authService.registerPharmacist(pharmacistModel);
      emit(state.copyWith(authStatus: AuthStatus.registerd));
    } catch (e) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> registerDoctor(DoctorModel doctorModel) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    try {
      final response = await authService.registerDoctor(doctorModel);
      emit(state.copyWith(authStatus: AuthStatus.registerd));
    } catch (e) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> logout() async =>
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated));

  Future<void> verifyOtp(VerifyOtpRequest request) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      final response = await authService.verifyOtp(request);
      emit(state.copyWith(authStatus: AuthStatus.authenticated));
    } catch (e) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> requestPasswordReset(PasswordResetRequest request) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      final response = await authService.requestPasswordReset(request);
      emit(state.copyWith(authStatus: AuthStatus.authenticated));
    } catch (e) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> setNewPassword(SetNewPasswordRequest request) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      final response = await authService.setNewPassword(request);
      emit(state.copyWith(authStatus: AuthStatus.authenticated));
    } catch (e) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
