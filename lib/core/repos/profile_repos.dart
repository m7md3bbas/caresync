// import 'dart:convert';
// import 'package:caresync/core/internet/internet_connection.dart';
// import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
// import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
// import 'package:caresync/core/service/profile_service.dart';
// import 'package:caresync/models/doctor_model.dart';
// import 'package:caresync/models/patient_model.dart';
// import 'package:caresync/models/pharmacist_model.dart';

// class ProfileRepository {
//   final ProfileService profileService;
//   final NetworkInfo networkInfo;

//   ProfileRepository(this.networkInfo, this.profileService);

//   Future<UserProfile> getProfile(String token) async {
//     final connectReuslt = await networkInfo.isConnected;

//     if (connectReuslt != false) {
//       final profile = await profileService.getProfile(token);

//       await SharedPrefHelper.setString(
//         SharedPrefKeys.profileCache,
//         json.encode(_toJson(profile)),
//       );
//       return profile;
//     } else {
//       final cached = SharedPrefHelper.getString(SharedPrefKeys.profileCache);
//       if (cached != null) {
//         final data = json.decode(cached);
//         return _fromJson(data);
//       } else {
//         throw Exception("No internet and no cached profile found.");
//       }
//     }
//   }

//   Map<String, dynamic> _toJson(UserProfile profile) {
//     if (profile is DoctorProfile) {
//       return {"user_type": "doctor", "data": profile.data.toJson()};
//     } else if (profile is PatientProfile) {
//       return {"user_type": "patient", "data": profile.data.toJson()};
//     } else if (profile is PharmacistProfile) {
//       return {"user_type": "pharmacist", "data": profile.data.toJson()};
//     }
//     throw Exception("Unknown profile type");
//   }

//   UserProfile _fromJson(Map<String, dynamic> json) {
//     switch (json["user_type"]) {
//       case "doctor":
//         return DoctorProfile(DoctorModel.fromJson(json["data"]));
//       case "patient":
//         return PatientProfile(PatientModel.fromJson(json["data"]));
//       case "pharmacist":
//         return PharmacistProfile(PharmacistModel.fromJson(json["data"]));
//       default:
//         throw Exception("Unknown cached profile type");
//     }
//   }
// }
