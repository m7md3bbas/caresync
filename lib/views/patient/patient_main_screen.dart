import 'package:caresync/core/colors/color_manager.dart';
import 'package:caresync/views/doctor/cubitt/nav_cubit.dart';
import 'package:caresync/views/patient/screens/nearest_pharmacy.dart';
import 'package:caresync/views/patient/screens/patient_appoinment.dart';
import 'package:caresync/views/patient/screens/patient_information.dart';
import 'package:caresync/views/patient/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientMainScreen extends StatefulWidget {
  const PatientMainScreen({super.key});

  @override
  State<PatientMainScreen> createState() => _PatientMainScreenState();
}

class _PatientMainScreenState extends State<PatientMainScreen> {
  final PageController _pageController = PageController();
  final List<Widget> _screens = [
    PatientSettings(),
    NearestPharmacy(),
    AppointmentBookingScreen(),
    PatientInformation(),
  ];
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
                icon: Icon(Icons.local_pharmacy),
                label: "Pharmcy",
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
