import 'dart:convert';
import 'package:caresync/core/internet/internet_connection.dart';
import 'package:caresync/core/service/patient_service.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/models/get_patient_details.dart';

class PatientRepository {
  final PatientService patientService;
  final NetworkInfo networkInfo;

  PatientRepository(this.networkInfo, this.patientService);

  Future<GetPatientModel> getPatientByNationalId(
    String nationalId,
    String token,
  ) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      final patient = await patientService.searchPatientByNationalId(
        nationalId,
        token,
      );

      // Cache result with key per patient
      await SharedPrefHelper.setString(
        '${SharedPrefKeys.patient}_$nationalId',
        jsonEncode(patient.toJson()),
      );

      return patient;
    } else {
      // Try loading from cache
      final cached = SharedPrefHelper.getString(
        '${SharedPrefKeys.patient}_$nationalId',
      );
      if (cached != null) {
        return GetPatientModel.fromJson(jsonDecode(cached));
      } else {
        throw Exception("No internet and no cached data found for patient.");
      }
    }
  }
}
