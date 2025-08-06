import 'package:caresync/core/locale/generated/l10n.dart';
import 'package:caresync/core/locale/locale_button.dart';
import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/views/auth/widgets/custom_role_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreRegisterScreen extends StatelessWidget {
  PreRegisterScreen({super.key});

  final List<Map<String, dynamic>> roles = [
    {
      'title': (context) => S.of(context).doctor,
      'description': (context) => S.of(context).preregisterTitleDoctor,
      'image':
          'https://reaikvslnvtzdllrrong.supabase.co/storage/v1/object/public/images/pojectImages/doctorI.png',
      'onTap': (context) => GoRouter.of(context).push(RoutesApp.doctorRegister),
    },
    {
      'title': (context) => S.of(context).patient,
      'description': (context) => S.of(context).preregisterTitlePatient,
      'image':
          'https://reaikvslnvtzdllrrong.supabase.co/storage/v1/object/public/images/pojectImages/patient.png',
      'onTap': (context) =>
          GoRouter.of(context).push(RoutesApp.patientRegister),
    },
    {
      'title': (context) => S.of(context).pharmacist,
      'description': (context) => S.of(context).preregisterTitlePharmacist,
      'image':
          'https://reaikvslnvtzdllrrong.supabase.co/storage/v1/object/public/images/pojectImages/pharmacy.png',
      'onTap': (context) =>
          GoRouter.of(context).push(RoutesApp.pharmacyRegister),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).appName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              GoRouter.of(context).push(RoutesApp.login);
            },
            child: Text(
              S.of(context).loginNow,
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
              S.of(context).preregisterTitle,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).preregisterSubTitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30),
            LocaleButton(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: roles.length,
                itemBuilder: (context, index) {
                  return CustomRoleWidget(
                    title: roles[index]['title'](context),
                    description: roles[index]['description'](context),
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
