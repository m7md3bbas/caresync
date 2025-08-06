import 'dart:io';

import 'package:caresync/core/locale/generated/l10n.dart';
import 'package:caresync/core/locale/locale_button.dart';
import 'package:caresync/core/validation/auth_validation.dart';
import 'package:caresync/controller/auth/auth_cubit.dart';
import 'package:caresync/controller/auth/auth_state.dart';
import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/core/widget/custom_toast.dart';
import 'package:caresync/models/patient_model.dart';
import 'package:caresync/views/auth/widgets/custom_gender_drop_down.dart';
import 'package:caresync/views/auth/widgets/custom_image_picker.dart';
import 'package:caresync/views/auth/widgets/custom_text_form_field.dart';
import 'package:caresync/views/doctor/widgets/cutom_elvated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PatientRegistrationScreen extends StatefulWidget {
  const PatientRegistrationScreen({super.key});

  @override
  State<PatientRegistrationScreen> createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController nationalIDController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late final TextEditingController birthdayController;
  late final TextEditingController addressController;
  late final TextEditingController allergiesController;
  late final TextEditingController otherDiseasesController;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late final ValueNotifier<String?> gender;

  bool isObsecure = true;
  bool hasDiabetes = false;
  bool hasHeartDisease = false;
  @override
  void initState() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    nationalIDController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    birthdayController = TextEditingController();
    addressController = TextEditingController();
    allergiesController = TextEditingController();
    otherDiseasesController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    gender = ValueNotifier<String?>(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.registerd) {
          Fluttertoast.showToast(msg: "user created wait for admin approval");
          GoRouter.of(context).pushReplacement(RoutesApp.login);
        } else {
          if (state.authStatus == AuthStatus.error) {
            Fluttertoast.showToast(msg: state.errorMessage.toString());
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(centerTitle: true, title: Text(S.of(context).appName)),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.only(top: 24),
                child: Form(
                  key: _formKey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    spacing: 24,
                    children: [
                      Text(
                        S.of(context).patientRegisterTitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      CutsomTextFormFiled(
                        validator: (value) =>
                            AuthValidation.validateName(context, value),
                        textEditingController: fullNameController,
                        isObsecure: false,
                        textInputType: TextInputType.text,
                        labelText: S.of(context).fullName,
                      ),
                      CutsomTextFormFiled(
                        validator: (value) =>
                            AuthValidation.validateEmail(context, value),
                        textEditingController: emailController,
                        isObsecure: false,
                        textInputType: TextInputType.emailAddress,
                        labelText: S.of(context).email,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CutsomTextFormFiled(
                              validator: (value) =>
                                  AuthValidation.validateAddress(
                                    value,
                                    context,
                                  ),
                              textEditingController: addressController,
                              isObsecure: false,
                              textInputType: TextInputType.text,
                              labelText: S.of(context).address,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CutsomTextFormFiled(
                              validator: (value) =>
                                  AuthValidation.validateEgyptianPhone(
                                    context,
                                    value,
                                  ),
                              textEditingController: phoneController,
                              isObsecure: false,
                              textInputType: TextInputType.phone,
                              labelText: S.of(context).phoneNumber,
                            ),
                          ),
                        ],
                      ),
                      CutsomTextFormFiled(
                        validator: (value) =>
                            AuthValidation.validateNationalID(value, context),
                        textEditingController: nationalIDController,
                        isObsecure: false,
                        textInputType: TextInputType.number,
                        labelText: S.of(context).nationalID,
                      ),
                      CutsomTextFormFiled(
                        validator: (value) =>
                            AuthValidation.validatePassword(context, value),
                        textEditingController: passwordController,
                        isObsecure: isObsecure,
                        textInputType: TextInputType.visiblePassword,
                        labelText: S.of(context).password,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObsecure
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isObsecure = !isObsecure;
                            });
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: birthdayController,
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  final formattedDate = DateFormat(
                                    'yyyy-M-d',
                                  ).format(pickedDate);
                                  birthdayController.text = formattedDate;
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).fieldIsRequired;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: S.of(context).birthday,
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          Expanded(child: GenderDropdown(gender: gender)),
                        ],
                      ),
                      CheckboxListTile(
                        title: Text(S.of(context).iHaveDiabetes),
                        value: hasDiabetes,
                        onChanged: (value) {
                          setState(() {
                            hasDiabetes = value ?? false;
                          });
                        },
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                      ),
                      CheckboxListTile(
                        title: Text(S.of(context).IHaveHeartDisease),
                        value: hasHeartDisease,
                        onChanged: (value) {
                          setState(() {
                            hasHeartDisease = value ?? false;
                          });
                        },
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CutsomTextFormFiled(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return S.of(context).fieldIsRequired;
                                }
                                final List<String> allergies = value.split(',');
                                for (String item in allergies) {
                                  if (!RegExp(
                                    r'^[a-zA-Z\s]+$',
                                  ).hasMatch(item.trim())) {
                                    return S.of(context).invalidAllergies;
                                  }
                                }
                                return null;
                              },
                              textEditingController: allergiesController,
                              isObsecure: false,
                              hintText: S.of(context).allergiesExample,
                              textInputType: TextInputType.text,
                              labelText: S.of(context).allergies,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CutsomTextFormFiled(
                              validator: (value) => null,
                              textEditingController: otherDiseasesController,
                              isObsecure: false,
                              textInputType: TextInputType.text,
                              labelText: S.of(context).otherDiseases,
                            ),
                          ),
                        ],
                      ),
                      state.authStatus == AuthStatus.loading
                          ? const CircularProgressIndicator()
                          : CutomElvatedButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  final model = PatientModel(
                                    address: addressController.text,
                                    allergies: allergiesController.text
                                        .split(',')
                                        .map((e) => e.trim())
                                        .where((e) => e.isNotEmpty)
                                        .toList(),
                                    birthday: birthdayController.text,
                                    diabetes: hasDiabetes,
                                    email: emailController.text,
                                    fullName: fullNameController.text,
                                    gender: gender.value,
                                    heartDisease: hasHeartDisease,
                                    nationalId: nationalIDController.text,
                                    otherDiseases: otherDiseasesController.text,
                                    password: passwordController.text,
                                    phoneNumber: phoneController.text,
                                    userType: 'patient',
                                  );
                                  context.read<AuthCubit>().reigsterPatient(
                                    model,
                                  );
                                } else {
                                  setState(() {
                                    autovalidateMode = AutovalidateMode.always;
                                  });
                                }
                              },
                              text: S.of(context).createAccount,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    nationalIDController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    birthdayController.dispose();
    addressController.dispose();
    allergiesController.dispose();
    otherDiseasesController.dispose();
    gender.dispose();
    super.dispose();
  }
}
