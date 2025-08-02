import 'package:caresync/config/validation/auth_validation.dart';
import 'package:caresync/controller/auth/auth_cubit.dart';
import 'package:caresync/controller/auth/auth_state.dart';
import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/models/doctor_model.dart';
import 'package:caresync/views/auth/widgets/custom_date_picker.dart';
import 'package:caresync/views/auth/widgets/custom_gender_drop_down.dart';
import 'package:caresync/views/auth/widgets/custom_text_form_field.dart';
import 'package:caresync/views/doctor/widgets/cutom_elvated_button.dart';
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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("user Registered")));
          GoRouter.of(context).go(RoutesApp.login);
        }
        if (state.authStatus == AuthStatus.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('CareSync'), centerTitle: true),
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
                        'Doctor Registration',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      CutsomTextFormFiled(
                        validator: (value) =>
                            AuthValidation.validateName(context, value),
                        textEditingController: fullNameController,
                        isObsecure: false,
                        textInputType: TextInputType.text,
                        labelText: 'Full Name',
                      ),
                      CutsomTextFormFiled(
                        validator: (value) =>
                            AuthValidation.validateEmail(context, value),
                        textEditingController: emailController,
                        isObsecure: false,
                        textInputType: TextInputType.emailAddress,
                        labelText: 'Email',
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
                              labelText: 'Phone Number',
                            ),
                          ),

                          const SizedBox(width: 16),
                          Expanded(
                            child: CutsomTextFormFiled(
                              validator: (value) =>
                                  AuthValidation.validateAddress(value),
                              textEditingController: addressController,
                              isObsecure: false,
                              textInputType: TextInputType.text,
                              labelText: 'Address',
                            ),
                          ),
                        ],
                      ),
                      CutsomTextFormFiled(
                        validator: (value) =>
                            AuthValidation.validateNationalID(value),
                        textEditingController: nationalIDController,
                        isObsecure: false,
                        textInputType: TextInputType.number,
                        labelText: 'National ID',
                      ),
                      CutsomTextFormFiled(
                        validator: (value) =>
                            AuthValidation.validatePassword(context, value),
                        textEditingController: passwordController,
                        isObsecure: isObsecure,
                        textInputType: TextInputType.visiblePassword,
                        labelText: 'Password',
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
                                  return 'Please select your birthday';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Birthday',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
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
                              labelText: 'Hospital',
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
                              labelText: 'Clinic',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CutsomTextFormFiled(
                              validator: (value) =>
                                  AuthValidation.validateName(context, value),
                              textEditingController: specializationController,
                              isObsecure: false,
                              textInputType: TextInputType.text,
                              labelText: 'Specialization',
                            ),
                          ),
                        ],
                      ),
                      state.authStatus == AuthStatus.loading
                          ? const CircularProgressIndicator()
                          : CutomElvatedButton(
                              onTap: () {
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
                              text: 'Create Account',
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
