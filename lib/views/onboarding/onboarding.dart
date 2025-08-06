import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/views/onboarding/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Your Medical Companion – All in One Place",
      "description":
          "Whether you're a Doctor, Patient, or Pharmacist, this app is tailored just for you. Register your role and access features designed specifically to meet your needs.",
      "image":
          "https://reaikvslnvtzdllrrong.supabase.co/storage/v1/object/public/images/pojectImages/undraw_doctors_djoj.svg",
    },
    {
      "title": "Book Appointments & Access Medical Records",
      "description":
          "Patients can easily book appointments with doctors. Doctors can review patient history, manage visits, and write digital prescriptions in seconds.",
      "image":
          "https://reaikvslnvtzdllrrong.supabase.co/storage/v1/object/public/images/pojectImages/undraw_online-calendar_zaoc.svg",
    },
    {
      "title": "Prescriptions Made Simple",
      "description":
          "Doctors can create digital prescriptions. Pharmacists can view the latest ones and prepare orders for the patients—faster, safer, and paper-free.",
      "image":
          "https://reaikvslnvtzdllrrong.supabase.co/storage/v1/object/public/images/pojectImages/undraw_terms_sx63.svg",
    },
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) => OnboardingContent(
                title: onboardingData[index]["title"]!,
                description: onboardingData[index]["description"]!,
                image: onboardingData[index]["image"]!,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => buildDot(index),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                if (currentPage == onboardingData.length - 1) {
                  SharedPrefHelper.setBool(SharedPrefKeys.onboarding, true);
                  GoRouter.of(context).go(RoutesApp.login);
                } else {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: Text(
                currentPage == onboardingData.length - 1
                    ? "Get Started"
                    : "Next",
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 10,
      width: currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.blue : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
