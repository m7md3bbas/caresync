import 'package:caresync/core/colors/color_manager.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_headline.dart';
import '../widgets/custom_text_field.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.splashBackgroundColor,
        title: Text(
          "Get patient details",
          style: TextStyle(color: ColorManager.primaryColorLight),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          spacing: 16,
          children: [
            SizedBox(height: 30),
            CustomTextField(controller: _controller, label: 'National ID'),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  ColorManager.splashBackgroundColor,
                ),
              ),
              onPressed: () {},
              child: Text(
                "Get Perscribed Medicines",
                style: TextStyle(color: ColorManager.primaryColorLight),
              ),
            ),
            CustomHeadline(text: "Pateint Details"),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Card(
                elevation: 3,
                child: Text(
                  "No patient details available ",
                  style: TextStyle(color: ColorManager.grey),
                ),
              ),
            ),
            CustomHeadline(text: "Prescritption Medicines"),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Card(
                elevation: 3,
                child: Text(
                  "No prescribed medicines found for this patient ",
                  style: TextStyle(color: ColorManager.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller;
    super.dispose();
  }
}
