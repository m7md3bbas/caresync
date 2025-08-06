import 'dart:convert';
import 'package:caresync/core/internet/internet_connection.dart';
import 'package:caresync/core/service/doctor_service.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/models/appoinment_model.dart';
import 'package:caresync/models/get_doctors.dart';

class DoctorRepository {
  final DoctorService doctorService;
  final NetworkInfo networkInfo;

  DoctorRepository(this.networkInfo, this.doctorService);

  // 🔹 Fetch & cache doctor categories
  Future<List<GetDoctorModel>> fetchDoctors({
    bool forceRefresh = false,
    String? token,
  }) async {
    final isConnected = await networkInfo.isConnected;

    if ((isConnected && !forceRefresh == false) || forceRefresh) {
      final response = await doctorService.getDoctors(token!);

      await SharedPrefHelper.setString(
        SharedPrefKeys.doctorcategoryCach,
        jsonEncode(response.map((e) => e.toJson()).toList()),
      );

      return response;
    }

    final cached = SharedPrefHelper.getString(
      SharedPrefKeys.doctorcategoryCach,
    );
    if (cached != null) {
      final jsonList = jsonDecode(cached) as List;
      return jsonList.map((e) => GetDoctorModel.fromJson(e)).toList();
    } else {
      throw Exception("No internet and no cached doctor categories found.");
    }
  }

  // 🔹 Fetch & cache doctor appointments
  Future<List<Appointment>> fetchAppointments(
    String token, {
    bool forceRefresh = false,
  }) async {
    final isConnected = await networkInfo.isConnected;

    if ((isConnected && !forceRefresh == false) || forceRefresh) {
      final appointments = await doctorService.getDoctorAppointments(token);
      await SharedPrefHelper.setString(
        SharedPrefKeys.doctorappointmentCach,
        jsonEncode(appointments.map((e) => e.toJson()).toList()),
      );
      return appointments;
    }

    final cached = SharedPrefHelper.getString(
      SharedPrefKeys.doctorappointmentCach,
    );
    if (cached != null) {
      final jsonList = jsonDecode(cached) as List;
      return jsonList.map((e) => Appointment.fromJson(e)).toList();
    } else {
      throw Exception("No internet and no cached appointments found.");
    }
  }
}
