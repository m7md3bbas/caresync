import 'package:caresync/views/doctor/widgets/custom_headline.dart';
import 'package:caresync/views/doctor/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../../core/colors/color_manager.dart';

class AddPrescription extends StatefulWidget {
  const AddPrescription({super.key});

  @override
  State<AddPrescription> createState() => _AddPrescriptionState();
}

class _AddPrescriptionState extends State<AddPrescription> {
  final TextEditingController _patientIDController = TextEditingController();
  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _instructionController = TextEditingController();
  @override
  void initState() {
    _instructionController;
    _medicineNameController;
    _dosageController;
    _patientIDController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.splashBackgroundColor,
        title: Text(
          "Add Perscription",
          style: TextStyle(color: ColorManager.primaryColorLight),
        ),
        centerTitle: true,
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            children: [
              SizedBox(height: 16),
              CustomHeadline(text: "Patient ID"),
              CustomTextField(
                controller: _patientIDController,
                label: "Enter Patient ID ",
              ),
              CustomHeadline(text: "Medicine Name"),
              CustomTextField(
                controller: _patientIDController,
                label: "Enter medicine name ",
              ),
              CustomHeadline(text: "Dosage"),
              CustomTextField(
                controller: _patientIDController,
                label: "Enter dosage ",
              ),
              CustomHeadline(text: "Instructions"),
              CustomTextField(
                controller: _patientIDController,
                label: "Enter Patient ID ",
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    ColorManager.splashBackgroundColor,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Add Perscription",
                  style: TextStyle(color: ColorManager.primaryColorLight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _instructionController;
    _medicineNameController;
    _dosageController;
    _patientIDController;
    super.dispose();
  }
}
