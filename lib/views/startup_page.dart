import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  void initState() {
    super.initState();
    checkOnboardingSeen();
  }

  Future<void> checkOnboardingSeen() async {
    final hasSeenOnboarding = await SharedPrefHelper.getBool(
      SharedPrefKeys.onboarding,
    );
    print('hasSeenOnboarding: $hasSeenOnboarding');

    if (!mounted) return;

    if (hasSeenOnboarding == true) {
      GoRouter.of(context).go(RoutesApp.login);
    } else {
      GoRouter.of(context).go(RoutesApp.initialRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
