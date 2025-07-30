import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/views/auth/Pharmacy_register.dart';
import 'package:caresync/views/auth/doctor_register.dart';
import 'package:caresync/views/auth/forget_password.dart';
import 'package:caresync/views/auth/login.dart';
import 'package:caresync/views/auth/patient_register.dart';
import 'package:caresync/views/auth/pre_register.dart';
import 'package:caresync/views/doctor/cubitt/nav_cubit.dart';
import 'package:caresync/views/doctor/main_doctor_screen.dart';
import 'package:caresync/views/doctor/screens/doctor_appoinment.dart';
import 'package:caresync/views/onboarding/onboarding.dart';
import 'package:caresync/views/startup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutesApp.initialRoute,
    routes: [
      GoRoute(
        path: RoutesApp.doctorAppointments,
        builder: (context, state) => const DoctorAppointmentsPage(),
      ),
      GoRoute(
        path: RoutesApp.preRegister,
        builder: (context, state) => PreRegisterScreen(),
      ),
      GoRoute(path: RoutesApp.login, builder: (context, state) => LoginPage()),
      GoRoute(
        path: RoutesApp.doctorRegister,
        builder: (context, state) => const DoctorRegistrationScreen(),
      ),
      GoRoute(
        path: RoutesApp.patientRegister,
        builder: (context, state) => const PatientRegistrationScreen(),
      ),
      GoRoute(
        path: RoutesApp.pharmacyRegister,
        builder: (context, state) => const PharmacyRegistrationScreen(),
      ),
      GoRoute(
        path: RoutesApp.forgetPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: RoutesApp.initialRoute,
        builder: (context, state) => const StartupPage(),
      ),
      GoRoute(
        path: RoutesApp.onBoarding,
        builder: (context, state) => OnboardingPage(),
      ),
      GoRoute(
        path: RoutesApp.mainViewDoctor,
        builder: (context, state) =>
            BlocProvider(create: (_) => NavCubit(), child: MainDoctorScreen()),
      ),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('No route defined'))),
  );
}
