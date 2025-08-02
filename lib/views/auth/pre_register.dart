import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/core/theme/theme_button.dart';
import 'package:caresync/views/auth/widgets/custom_role_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreRegisterScreen extends StatelessWidget {
  PreRegisterScreen({super.key});

  final List<Map<String, dynamic>> roles = [
    {
      'title': 'Doctor',
      'description':
          'Manage your patients and view their medical records efficiently.',
      'image': 'assets/images/doctorI.png',
      'onTap': (context) => GoRouter.of(context).push(RoutesApp.doctorRegister),
    },
    {
      'title': 'Patient',
      'description':
          'Access your health information and manage your prescriptions.',
      'image': 'assets/images/patient.png',
      'onTap': (context) =>
          GoRouter.of(context).push(RoutesApp.patientRegister),
    },
    {
      'title': 'Pharmacist',
      'description': 'View and manage prescriptions and medical data.',
      'image': 'assets/images/pharmacy.png',
      'onTap': (context) =>
          GoRouter.of(context).push(RoutesApp.pharmacyRegister),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CareSync',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              GoRouter.of(context).push(RoutesApp.login);
            },
            child: const Text(
              'Login now',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Welcome to CareSync!',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Select your role to get started:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: roles.length,
                itemBuilder: (context, index) {
                  return CustomRoleWidget(
                    title: roles[index]['title'],
                    description: roles[index]['description'],
                    onTap: () => roles[index]['onTap'](context),
                    image: roles[index]['image'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
