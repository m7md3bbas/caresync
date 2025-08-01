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
import 'screens/add_perscription.dart';

class MainDoctorScreen extends StatefulWidget {
  const MainDoctorScreen({super.key});

  @override
  State<MainDoctorScreen> createState() => _MainDoctorScreenState();
}

class _MainDoctorScreenState extends State<MainDoctorScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  final List<Widget> _screens = [
    PatientDetails(),
    AddPrescription(),
    DoctorAppointmentsPage(),
    DoctorInformation(),
  ];

  @override
  Widget build(BuildContext context) {
    final token = SharedPrefHelper.getString(SharedPrefKeys.token) ?? '';

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              DoctorCubit(DoctorService())..getDoctorAppointments(token),
        ),
        BlocProvider(create: (context) => PatientCubit(PatientService())),
        BlocProvider(
          create: (context) =>
              ProfileCubit(ProfileService())..getProfile(token),
        ),
      ],
      child: Scaffold(
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          onPageChanged: (index) => setState(() {
            currentIndex = index;
          }),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: ColorManager.splashBackgroundColor,
          unselectedItemColor: ColorManager.grey,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            _pageController.jumpToPage(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_information_outlined),
              label: "patient",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_services),
              label: "perscription",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: "appointment",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
