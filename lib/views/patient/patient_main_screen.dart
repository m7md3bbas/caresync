import 'package:caresync/controller/doctor/get_doctor_cubit.dart';
import 'package:caresync/controller/patient/book_appoinment_cubit.dart';
import 'package:caresync/controller/patient/patient_cubit.dart';
import 'package:caresync/controller/pharmacist/get_pharmacy_cubit.dart';
import 'package:caresync/controller/profile/profile_cubit.dart';
import 'package:caresync/core/service/doctor_service.dart';
import 'package:caresync/core/service/patient_service.dart';
import 'package:caresync/core/service/pharmacist_service.dart';
import 'package:caresync/core/service/profile_service.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/views/patient/screens/nearest_pharmacy.dart';
import 'package:caresync/views/patient/screens/appointment_booking_screen.dart';
import 'package:caresync/views/patient/screens/patient_appoinment.dart'
    hide AppointmentBookingScreen;
import 'package:caresync/views/patient/screens/patient_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientMainScreen extends StatefulWidget {
  const PatientMainScreen({super.key});

  @override
  State<PatientMainScreen> createState() => _PatientMainScreenState();
}

class _PatientMainScreenState extends State<PatientMainScreen> {
  final PageController _pageController = PageController(initialPage: 2);
  int currentIndex = 2;
  final List<Widget> _screens = [
    NearestPharmacy(),
    AppointmentBookingScreen(),
    PatientInformation(),
  ];
  late final PatientCubit patientCubit;
  late final ProfileCubit profileCubit;
  late final AppointmentCubit appointmentCubit;
  late final GetDoctorsCubit doctorsCubit;
  late final GetPharmacyCubit pharmacyCubit;

  @override
  void initState() {
    super.initState();
    final token = SharedPrefHelper.getString(SharedPrefKeys.token) ?? '';
    patientCubit = PatientCubit(PatientService());
    profileCubit = ProfileCubit(ProfileService())..getProfile(token);
    appointmentCubit = AppointmentCubit(PatientService());
    doctorsCubit = GetDoctorsCubit(DoctorService())..fetchDoctors(token);
    pharmacyCubit = GetPharmacyCubit(PharmacistService())..getPharmacy();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: patientCubit),
        BlocProvider.value(value: profileCubit),
        BlocProvider.value(value: appointmentCubit),
        BlocProvider.value(value: doctorsCubit),
        BlocProvider.value(value: pharmacyCubit),
      ],
      child: Scaffold(
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
      ),
    );
  }
}
