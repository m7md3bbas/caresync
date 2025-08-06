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
          appBar: AppBar(title: Text("Get patient details"), centerTitle: true),
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
                          labelText: "National ID",
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
                          text: 'Get Prescribed Medicines',
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
                              CustomHeadline(text: "Patient Details"),
                              const SizedBox(height: 10),
                              if (state.status == PatientStatus.loading)
                                const Center(child: CircularProgressIndicator())
                              else if (patient == null)
                                Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text("No patient details available"),
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
                                        Text("Full Name: ${patient.fullName}"),
                                        Text("Email: ${patient.email}"),
                                        Text("Phone: ${patient.phoneNumber}"),
                                        Text("Address: ${patient.address}"),
                                        Text(
                                          "National ID: ${patient.nationalId}",
                                        ),
                                        Text("Birthday: ${patient.birthday}"),
                                        Text(
                                          "Diabetes: ${patient.diabetes ? "Yes" : "No"}",
                                        ),
                                        Text(
                                          "Heart Disease: ${patient.heartDisease ? "Yes" : "No"}",
                                        ),
                                        Text(
                                          "Allergies: ${patient.allergies.join(", ")}",
                                        ),
                                        Text(
                                          "Other Diseases: ${patient.otherDiseases}",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 30),
                              CustomHeadline(text: "Prescription Medicines"),
                              const SizedBox(height: 10),
                              if (patient == null ||
                                  patient.prescriptions.isEmpty)
                                Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      "No prescribed medicines found for this patient",
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
                                          "${pres.dosage} | ${pres.instructions}\nDoctor: ${pres.doctor}",
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
