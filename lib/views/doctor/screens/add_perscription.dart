import 'package:caresync/config/validation/auth_validation.dart';
import 'package:caresync/controller/doctor/doctor_cubit.dart';
import 'package:caresync/controller/doctor/doctor_state.dart';
import 'package:caresync/views/auth/widgets/custom_text_form_field.dart';
import 'package:caresync/views/doctor/widgets/cutom_elvated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';

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
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state.state == DoctorStatus.sent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Prescription added successfully")),
          );
        } else if (state.state == DoctorStatus.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text("Add Prescription"), centerTitle: true),
          body: state.state == DoctorStatus.loading
              ? Center(child: const CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Form(
                      key: _formKey,
                      autovalidateMode: autovalidateMode,
                      child: Column(
                        children: [
                          CutsomTextFormFiled(
                            validator: (value) =>
                                AuthValidation.validateNationalID(value),
                            textEditingController: _patientIDController,
                            labelText: "Enter Patient ID",
                            isObsecure: false,
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(height: 16),
                          CutsomTextFormFiled(
                            validator: (value) => value == null
                                ? 'Medicine Name is required'
                                : null,
                            textEditingController: _medicineNameController,
                            labelText: "Enter Medicine Name",
                            isObsecure: false,
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(height: 16),
                          CutsomTextFormFiled(
                            validator: (value) =>
                                AuthValidation.validateName(context, value),
                            textEditingController: _dosageController,
                            labelText: "Enter Dosage",
                            isObsecure: false,
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            validator: (value) => value == null
                                ? 'Instruction is required'
                                : null,
                            controller: _instructionController,
                            decoration: const InputDecoration(
                              labelText: "Enter Instructions",
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 5,
                          ),
                          const SizedBox(height: 24),
                          CutomElvatedButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                final token =
                                    SharedPrefHelper.getString(
                                      SharedPrefKeys.token,
                                    ) ??
                                    '';
                                context.read<DoctorCubit>().addPerscription(
                                  _patientIDController.text.trim(),
                                  token,
                                  _medicineNameController.text.trim(),
                                  _dosageController.text.trim(),
                                  _instructionController.text.trim(),
                                );

                                _patientIDController.clear();
                                _medicineNameController.clear();
                                _dosageController.clear();
                                _instructionController.clear();
                              } else {
                                setState(() {
                                  autovalidateMode = AutovalidateMode.always;
                                });
                              }
                            },
                            text: "Add Prescription",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  @override
  void dispose() {
    _patientIDController.dispose();
    _medicineNameController.dispose();
    _dosageController.dispose();
    _instructionController.dispose();
    super.dispose();
  }
}
