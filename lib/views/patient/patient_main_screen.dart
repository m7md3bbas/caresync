import 'package:caresync/core/colors/color_manager.dart';
import 'package:caresync/views/patient/screens/nearest_pharmacy.dart';
import 'package:caresync/views/patient/screens/patient_appoinment.dart';
import 'package:caresync/views/patient/screens/patient_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientMainScreen extends StatefulWidget {
  const PatientMainScreen({super.key});

  @override
  State<PatientMainScreen> createState() => _PatientMainScreenState();
}

class _PatientMainScreenState extends State<PatientMainScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  final List<Widget> _screens = [
    NearestPharmacy(),
    AppointmentBookingScreen(),
    PatientInformation(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _screens.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
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
            icon: Icon(Icons.local_pharmacy),
            label: "Pharmcy",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: "appointment",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
