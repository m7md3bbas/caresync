import 'dart:io';
import 'package:caresync/core/locale/generated/l10n.dart';
import 'package:caresync/core/validation/auth_validation.dart';
import 'package:caresync/controller/auth/auth_cubit.dart';
import 'package:caresync/controller/auth/auth_state.dart';
import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/core/widget/custom_toast.dart';
import 'package:caresync/models/doctor_model.dart';
import 'package:caresync/views/auth/widgets/custom_gender_drop_down.dart';
import 'package:caresync/views/auth/widgets/custom_text_form_field.dart';
import 'package:caresync/views/doctor/widgets/cutom_elvated_button.dart';
import 'package:caresync/views/auth/widgets/custom_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DoctorRegistrationScreen extends StatefulWidget {
  const DoctorRegistrationScreen({super.key});

  @override
  State<DoctorRegistrationScreen> createState() =>
      _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController nationalIDController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late final TextEditingController birthdayController;
  late final TextEditingController addressController;
  late final TextEditingController hospitalController;
  late final TextEditingController clinicController;
  late final TextEditingController specializationController;
  late final ValueNotifier<String?> gender;

  File? frontIdImage;
  File? backIdImage;

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isObsecure = true;

  @override
  void initState() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    nationalIDController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    birthdayController = TextEditingController();
    addressController = TextEditingController();
    hospitalController = TextEditingController();
    clinicController = TextEditingController();
    specializationController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    gender = ValueNotifier<String?>(null);
    super.initState();
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
    hospitalController.dispose();
    clinicController.dispose();
    specializationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.registerd) {
          ToastHelper.showSuccess(S.of(context).accountApprovalMessage);
          GoRouter.of(context).go(RoutesApp.login);
        }
        if (state.authStatus == AuthStatus.error) {
          ToastHelper.showError(state.errorMessage.toString());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(centerTitle: true, title: Text(S.of(context).appName)),
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: autovalidateMode,
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.only(top: 24),
                  child: Column(
                    spacing: 24,
                    children: [
                      Text(
                        S.of(context).doctorRegisterTitle,
                        style: Theme.of(context).textTheme.headlineLarge,
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
                          const SizedBox(width: 16),
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
                                border: const OutlineInputBorder(),
                                suffixIcon: const Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(child: GenderDropdown(gender: gender)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CutsomTextFormFiled(
                              validator: (value) =>
                                  AuthValidation.validateName(context, value),
                              textEditingController: hospitalController,
                              isObsecure: false,
                              textInputType: TextInputType.text,
                              labelText: S.of(context).hospital,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CutsomTextFormFiled(
                              validator: (value) =>
                                  AuthValidation.validateName(context, value),
                              textEditingController: clinicController,
                              isObsecure: false,
                              textInputType: TextInputType.text,
                              labelText: S.of(context).clinic,
                            ),
                          ),
                        ],
                      ),
                      CutsomTextFormFiled(
                        validator: (value) =>
                            AuthValidation.validateName(context, value),
                        textEditingController: specializationController,
                        isObsecure: false,
                        textInputType: TextInputType.text,
                        labelText: S.of(context).specialization,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: CustomImagePicker(
                              label: S.of(context).uploadFrontIdImage,
                              onImageSelected: (file) => frontIdImage = file,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomImagePicker(
                              label: S.of(context).uploadBackIdImage,
                              onImageSelected: (file) => backIdImage = file,
                            ),
                          ),
                        ],
                      ),

                      state.authStatus == AuthStatus.loading
                          ? const CircularProgressIndicator()
                          : CutomElvatedButton(
                              onTap: () {
                                if (frontIdImage == null ||
                                    backIdImage == null) {
                                  ToastHelper.showError(
                                    'Please upload ID images',
                                  );
                                  return;
                                }
                                if (_formKey.currentState!.validate()) {
                                  final model = DoctorModel(
                                    address: addressController.text,
                                    birthday: birthdayController.text,
                                    email: emailController.text,
                                    fullName: fullNameController.text,
                                    gender: gender.value,
                                    nationalId: nationalIDController.text,
                                    password: passwordController.text,
                                    phoneNumber: phoneController.text,
                                    userType: 'doctor',
                                    hospital: hospitalController.text,
                                    clinic: clinicController.text,
                                    specialization:
                                        specializationController.text,
                                    faceIdImage: frontIdImage!,
                                    backIdImage: backIdImage!,
                                  );

                                  context.read<AuthCubit>().registerDoctor(
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
}
