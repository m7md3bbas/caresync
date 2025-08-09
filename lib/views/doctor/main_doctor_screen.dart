import 'package:caresync/controller/doctor/doctor_cubit.dart';
import 'package:caresync/controller/doctor/doctor_schedule_cubit.dart';
import 'package:caresync/controller/patient/patient_cubit.dart';
import 'package:caresync/controller/profile/profile_cubit.dart';
import 'package:caresync/core/locale/generated/l10n.dart';
import 'package:caresync/core/service/doctor_schedule_service.dart';
import 'package:caresync/core/service/doctor_service.dart';
import 'package:caresync/core/service/patient_service.dart';
import 'package:caresync/core/service/profile_service.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/views/doctor/screens/doctor_appoinment.dart';
import 'package:caresync/views/doctor/screens/doctor_information.dart';
import 'package:caresync/views/doctor/screens/manage_avalibality.dart';
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
  late final DoctorScheduleCubit scheduleCubit;

  final List<Widget> _screens = const [
    PatientDetails(),
    AddPrescription(),
    DoctorAppointmentsPage(),
    DoctorScheduleManagementPage(),
    DoctorInformation(),
  ];

  @override
  void initState() {
    super.initState();
    final token = SharedPrefHelper.getString(SharedPrefKeys.token) ?? '';
    doctorCubit = DoctorCubit(DoctorService())..getDoctorAppointments(token);
    patientCubit = PatientCubit(PatientService());
    profileCubit = ProfileCubit(ProfileService())..getProfile(token);
    scheduleCubit = DoctorScheduleCubit(DoctorScheduleService());
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
        BlocProvider.value(value: scheduleCubit),
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
          items:  [
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              label: S.of(context).patients,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.prescription),
              label: S.of(context).prescription,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: S.of(context).appointments,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.calendarCheck),
              label: S.of(context).schedule,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user),
              label: S.of(context).profile,
            ),
          ],
        ),
      ),
    );
  }
}
