import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/views/doctor/main_doctor_screen.dart';
import 'package:caresync/views/patient/patient_main_screen.dart';
import 'package:caresync/views/pharmacist/main_pharmcist_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final String? userType;
  initialize() async {
    userType = SharedPrefHelper.getString(SharedPrefKeys.userType);
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    if (userType == 'doctor') {
      return MainDoctorScreen();
    } else if (userType == 'patient') {
      return PatientMainScreen();
    } else if (userType == 'pharmacist') {
      return PharmacistMainScreen();
    }
    return Scaffold();
  }
}
