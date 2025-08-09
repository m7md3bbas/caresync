import 'package:caresync/core/locale/generated/l10n.dart';
import 'package:caresync/core/validation/auth_validation.dart';
import 'package:caresync/controller/doctor/doctor_cubit.dart';
import 'package:caresync/controller/doctor/doctor_state.dart';
import 'package:caresync/core/widget/custom_toast.dart';
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
          ToastHelper.showSuccess(S.of(context).prescriptionAddedSuccessfully);
        } else if (state.state == DoctorStatus.error) {
          ToastHelper.showError(state.message!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(S.of(context).addPrescription), centerTitle: true),
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
                                AuthValidation.validateNationalID(
                                  value,
                                  context,
                                ),
                            textEditingController: _patientIDController,
                            labelText: S.of(context).enterPatientID,
                            isObsecure: false,
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(height: 16),
                          CutsomTextFormFiled(
                            validator: (value) => value == null
                                ? S.of(context).fieldIsRequired
                                : null,
                            textEditingController: _medicineNameController,
                            labelText: S.of(context).enterMedicineName,
                            isObsecure: false,
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(height: 16),
                          CutsomTextFormFiled(
                            validator: (value) =>
                                AuthValidation.validateName(context, value),
                            textEditingController: _dosageController,
                            labelText: S.of(context).enterDosage,
                            isObsecure: false,
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            validator: (value) => value == null
                                ? S.of(context).fieldIsRequired
                                : null,
                            controller: _instructionController,
                            decoration: InputDecoration(
                              labelText: S.of(context).enterInstructions,
                              border: const OutlineInputBorder(),
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
                            text: S.of(context).addPrescription,
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
