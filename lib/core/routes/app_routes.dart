import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/views/auth/Pharmacy_register.dart';
import 'package:caresync/views/auth/doctor_register.dart';
import 'package:caresync/views/auth/forget_password.dart';
import 'package:caresync/views/auth/login.dart';
import 'package:caresync/views/auth/patient_register.dart';
import 'package:caresync/views/auth/pre_register.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutesApp.preRegister,
    routes: [
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
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('No route defined'))),
  );
}
