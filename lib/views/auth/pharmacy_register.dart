import 'package:caresync/config/validation/auth_validation.dart';
import 'package:caresync/controller/auth/auth_cubit.dart';
import 'package:caresync/controller/auth/auth_state.dart';
import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/core/theme/theme_button.dart';
import 'package:caresync/models/pharmacist_model.dart';
import 'package:caresync/views/auth/widgets/custom_gender_drop_down.dart';
import 'package:caresync/views/auth/widgets/custom_text_form_field.dart';
import 'package:caresync/views/doctor/widgets/cutom_elvated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PharmacyRegistrationScreen extends StatefulWidget {
  const PharmacyRegistrationScreen({super.key});

  @override
  State<PharmacyRegistrationScreen> createState() =>
      _PharmacyRegistrationScreenState();
}

class _PharmacyRegistrationScreenState
    extends State<PharmacyRegistrationScreen> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController nationalIDController;
  late final TextEditingController phoneController;
  late final TextEditingController birthdayController;
  late final TextEditingController addressController;
  late final TextEditingController pharmacyNameController;
  late final TextEditingController pharmacyAddressController;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late final ValueNotifier<String?> gender;

  bool isObsecure = true;

  @override
  void initState() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nationalIDController = TextEditingController();
    phoneController = TextEditingController();
    birthdayController = TextEditingController();
    addressController = TextEditingController();
    pharmacyNameController = TextEditingController();
    pharmacyAddressController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    gender = ValueNotifier<String?>(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.registerd) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful')),
          );
          GoRouter.of(context).push(RoutesApp.login);
        } else if (state.authStatus == AuthStatus.error) {
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
                key: _formKey,
                autovalidateMode: autovalidateMode,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.only(top: 24),
                  child: Column(
                    spacing: 24,
                    children: [
                      Text(
                        'Pharmacy Registration',
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
                                  AuthValidation.validateAddress(value),
                              textEditingController: addressController,
                              isObsecure: false,
                              textInputType: TextInputType.text,
                              labelText: 'Address',
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
                              labelText: 'Phone Number',
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
                            color: Colors.white38,
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

                          Expanded(
                            child: GenderDropdown(gender: gender, width: 150),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CutsomTextFormFiled(
                              validator: (value) =>
                                  AuthValidation.validateName(context, value),
                              textEditingController: pharmacyNameController,
                              isObsecure: false,
                              textInputType: TextInputType.text,
                              labelText: 'Pharmacy Name',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CutsomTextFormFiled(
                              validator: (value) =>
                                  AuthValidation.validateAddress(value),
                              textEditingController: pharmacyAddressController,
                              isObsecure: false,
                              textInputType: TextInputType.text,
                              labelText: 'Pharmacy Address',
                            ),
                          ),
                        ],
                      ),
                      state.authStatus == AuthStatus.loading
                          ? const CircularProgressIndicator()
                          : CutomElvatedButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  final model = PharmacistModel(
                                    fullName: fullNameController.text,
                                    email: emailController.text,
                                    nationalId: nationalIDController.text,
                                    phoneNumber: phoneController.text,
                                    password: passwordController.text,
                                    gender: gender.value,
                                    birthday: birthdayController.text,
                                    address: addressController.text,
                                    pharmacyName: pharmacyNameController.text,
                                    pharmacyAddress:
                                        pharmacyAddressController.text,
                                    userType: 'pharmacist',
                                  );
                                  context.read<AuthCubit>().registerPharmacist(
                                    model,
                                  );
                                } else {
                                  setState(() {
                                    autovalidateMode = AutovalidateMode.always;
                                  });
                                }
                              },
                              text: 'Register',
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
    passwordController.dispose();
    nationalIDController.dispose();
    phoneController.dispose();
    birthdayController.dispose();
    addressController.dispose();
    pharmacyNameController.dispose();
    pharmacyAddressController.dispose();
    gender.dispose();
    super.dispose();
  }
}
