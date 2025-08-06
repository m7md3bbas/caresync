import 'package:caresync/controller/auth/auth_state.dart';
import 'package:caresync/core/exception/parseerror.dart';
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
      await authService.login(
        LoginRequest(nationalId: nationalID, password: password),
      );

      emit(state.copyWith(authStatus: AuthStatus.authenticated));
    } catch (e) {
      final message = ParseError.extractErrorMessage(e);
      emit(state.copyWith(authStatus: AuthStatus.error, errorMessage: message));
    }
  }

  Future<void> reigsterPatient(PatientModel patientModel) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    try {
      await authService.registerPatient(patientModel);
      emit(state.copyWith(authStatus: AuthStatus.registerd));
    } catch (e) {
      final error = ParseError.extractErrorMessage(e.toString());
      emit(state.copyWith(authStatus: AuthStatus.error, errorMessage: error));
    }
  }

  Future<void> registerPharmacist(PharmacistModel pharmacistModel) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    try {
      await authService.registerPharmacist(pharmacistModel);
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
      await authService.registerDoctor(doctorModel);
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

  Future<void> logout() async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      authService.logout();
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
    } catch (e) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> verifyOtp(VerifyOtpRequest request) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      await authService.verifyOtp(request);
      emit(state.copyWith(authStatus: AuthStatus.otpVerified));
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
      await authService.requestPasswordReset(request);
      emit(state.copyWith(authStatus: AuthStatus.otpSent));
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
      await authService.setNewPassword(request);
      emit(state.copyWith(authStatus: AuthStatus.passwordReset));
      print('password reset');
    } catch (e) {
      emit(AuthState(authStatus: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  void onAuthReset() {
    emit(state.copyWith(authStatus: AuthStatus.initial));
  }
}
