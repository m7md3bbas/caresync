import 'package:caresync/core/locale/generated/l10n.dart';
import 'package:caresync/core/validation/auth_validation.dart';
import 'package:caresync/controller/patient/patient_cubit.dart';
import 'package:caresync/controller/patient/patient_state.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/views/auth/widgets/custom_text_form_field.dart';
import 'package:caresync/views/doctor/widgets/cutom_elvated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_headline.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  final TextEditingController _controller = TextEditingController();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit, PatientState>(
      listener: (context, state) {
        if (state.status == PatientStatus.success) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message ?? "Success")));
        }
        if (state.status == PatientStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? "An error occurred")),
          );
        }
      },
      builder: (context, state) {
        final patient = state.getPatientModel;

        return Scaffold(
          appBar: AppBar(title: Text(S.of(context).getPatientDetails), centerTitle: true),
          body: Form(
            autovalidateMode: autoValidate,
            key: _globalKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        CutsomTextFormFiled(
                          validator: (value) =>
                              AuthValidation.validateNationalID(value, context),
                          textEditingController: _controller,
                          isObsecure: false,
                          textInputType: TextInputType.number,
                          labelText: S.of(context).enterPatientID
                        ),
                        const SizedBox(height: 16),
                        CutomElvatedButton(
                          onTap: () {
                            final id = _controller.text.trim();
                            if (id.isNotEmpty) {
                              if (_globalKey.currentState!.validate()) {
                                context
                                    .read<PatientCubit>()
                                    .getPatientPresceiption(
                                      nationalId: id,
                                      token:
                                          SharedPrefHelper.getString(
                                            SharedPrefKeys.token,
                                          ) ??
                                          '',
                                    );
                              } else {
                                setState(() {
                                  autoValidate = AutovalidateMode.always;
                                });
                              }
                            }
                          },
                          text: S.of(context).getPrescribedMedicines,
                        ),
                      ],
                    ),
                  ),
                  state.status != PatientStatus.success
                      ? SliverToBoxAdapter(child: Container())
                      : SliverToBoxAdapter(
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              CustomHeadline(text: S.of(context).patientDetails),
                              const SizedBox(height: 10),
                              if (state.status == PatientStatus.loading)
                                const Center(child: CircularProgressIndicator())
                              else if (patient == null)
                                Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(S.of(context).noPatientDetailsAvailable),
                                  ),
                                )
                              else
                                Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${S.of(context).fullName}: ${patient.fullName}"),
                                        Text("${S.of(context).email}: ${patient.email}"),
                                        Text("${S.of(context).phoneNumber}: ${patient.phoneNumber}"),
                                        Text("${S.of(context).address}: ${patient.address}"),
                                        Text(
                                          "${S.of(context).nationalID}: ${patient.nationalId}",
                                        ),
                                        Text("${S.of(context).birthday}: ${patient.birthday}"),
                                        Text(
                                          "${S.of(context).diabetes}: ${patient.diabetes ? S.of(context).yes : S.of(context).no}",
                                        ),
                                        Text(
                                          "${S.of(context).heartDisease}: ${patient.heartDisease ? S.of(context).yes : S.of(context).no}",
                                        ),
                                        Text(
                                          "${S.of(context).allergies}: ${patient.allergies.join(", ")}",
                                        ),
                                        Text(
                                          "${S.of(context).otherDiseases}: ${patient.otherDiseases}",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 30),
                              CustomHeadline(text: S.of(context).prescriptionMedicines),
                              const SizedBox(height: 10),
                              if (patient == null ||
                                  patient.prescriptions.isEmpty)
                                Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      S.of(context).noPrescribedMedicinesFound,
                                    ),
                                  ),
                                )
                              else
                                ListView.builder(
                                  itemCount: patient.prescriptions.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final pres = patient.prescriptions[index];
                                    return Card(
                                      elevation: 2,
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      child: ListTile(
                                        title: Text(pres.medicineName),
                                        subtitle: Text(
                                          "${pres.dosage} | ${pres.instructions}\n${S.of(context).doctor}: ${pres.doctor}",
                                        ),
                                        trailing: Text(pres.createdAt),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
