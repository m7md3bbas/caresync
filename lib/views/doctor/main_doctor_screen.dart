import 'package:caresync/core/colors/color_manager.dart';
import 'package:caresync/views/doctor/screens/doctor_appoinment.dart';
import 'package:caresync/views/doctor/screens/doctor_information.dart';
import 'package:caresync/views/doctor/screens/patient_details.dart';
import 'package:caresync/views/doctor/screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubitt/nav_cubit.dart';
import 'screens/add_perscription.dart';

class MainDoctorScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  final List<Widget> _screens = [
    Setting(),
    PatientDetails(),
    AddPrescription(),
    DoctorAppointmentsPage(),
    DoctorInformation(),
  ];

  MainDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: PageView.builder(
            controller: _pageController,
            itemCount: _screens.length,
            onPageChanged: (index) => context.read<NavCubit>().changeTab(index),
            itemBuilder: (context, index) {
              return _screens[index];
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: ColorManager.splashBackgroundColor,
            unselectedItemColor: ColorManager.grey,
            currentIndex: currentIndex,
            onTap: (index) {
              context.read<NavCubit>().changeTab(index);
              _pageController.jumpToPage(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Setting",
              ),
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
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
