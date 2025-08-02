import 'package:caresync/controller/doctor/doctor_cubit.dart';
import 'package:caresync/controller/patient/patient_cubit.dart';
import 'package:caresync/controller/profile/profile_cubit.dart';
import 'package:caresync/core/colors/color_manager.dart';
import 'package:caresync/core/service/doctor_service.dart';
import 'package:caresync/core/service/patient_service.dart';
import 'package:caresync/core/service/profile_service.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/views/doctor/screens/doctor_appoinment.dart';
import 'package:caresync/views/doctor/screens/doctor_information.dart';
import 'package:caresync/views/doctor/screens/patient_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'screens/add_perscription.dart';

class MainDoctorScreen extends StatefulWidget {
  const MainDoctorScreen({super.key});

  @override
  State<MainDoctorScreen> createState() => _MainDoctorScreenState();
}

class _MainDoctorScreenState extends State<MainDoctorScreen> {
  final PageController _pageController = PageController(initialPage: 3);
  int currentIndex = 3;

  late final DoctorCubit doctorCubit;
  late final PatientCubit patientCubit;
  late final ProfileCubit profileCubit;

  final List<Widget> _screens = const [
    PatientDetails(),
    AddPrescription(),
    DoctorAppointmentsPage(),
    DoctorInformation(),
  ];

  @override
  void initState() {
    super.initState();
    final token = SharedPrefHelper.getString(SharedPrefKeys.token) ?? '';
    print("profile token: $token");
    doctorCubit = DoctorCubit(DoctorService())..getDoctorAppointments(token);
    patientCubit = PatientCubit(PatientService());
    profileCubit = ProfileCubit(ProfileService())..getProfile(token);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: doctorCubit),
        BlocProvider.value(value: patientCubit),
        BlocProvider.value(value: profileCubit),
      ],
      child: Scaffold(
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          onPageChanged: (index) => setState(() {
            currentIndex = index;
          }),
          itemBuilder: (context, index) => _screens[index],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            _pageController.jumpToPage(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              label: "Patients",
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.prescription),
              label: "Prescription",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: "Appointments",
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
