import 'package:caresync/config/validation/auth_validation.dart';
import 'package:caresync/controller/auth/auth_cubit.dart';
import 'package:caresync/controller/auth/auth_state.dart';
import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/models/patient_model.dart';
import 'package:caresync/views/auth/widgets/custom_date_picker.dart';
import 'package:caresync/views/auth/widgets/custom_gender_drop_down.dart';
import 'package:caresync/views/auth/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("registerd")));
          GoRouter.of(context).pushReplacement(RoutesApp.login);
        } else {
          if (state.authStatus == AuthStatus.error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("User already exist")));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF1D4ED8),
          appBar: AppBar(
            backgroundColor: const Color(0xFF161B22),
            title: const Text(
              'CareSync',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.only(top: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF161B22),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: Form(
                  key: _formKey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    spacing: 24,
                    children: [
                      const Text(
                        'Patient Registration',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
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
                      CheckboxListTile(
                        title: const Text(
                          'I have diabetes',
                          style: TextStyle(color: Colors.white),
                        ),
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
                        title: const Text(
                          'I have heart disease',
                          style: TextStyle(color: Colors.white),
                        ),
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
                                  return 'Please enter at least one allergy';
                                }
                                final List<String> allergies = value.split(',');
                                for (String item in allergies) {
                                  if (!RegExp(
                                    r'^[a-zA-Z\s]+$',
                                  ).hasMatch(item.trim())) {
                                    return 'Allergies must be letters only, separated by commas';
                                  }
                                }

                                return null; // ✅ صالح
                              }, // Optional field
                              textEditingController: allergiesController,
                              isObsecure: false,
                              hintText: 'e.g. Penicillin, Nuts, Pollen',
                              textInputType: TextInputType.text,
                              labelText: 'Allergies (comma separated)',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CutsomTextFormFiled(
                              validator: (value) => null,
                              textEditingController: otherDiseasesController,
                              isObsecure: false,
                              textInputType: TextInputType.text,
                              labelText: 'Other diseases (comma separated)',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      state.authStatus == AuthStatus.loading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
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
                                      otherDiseases:
                                          otherDiseasesController.text,
                                      password: passwordController.text,
                                      phoneNumber: phoneController.text,
                                      userType: 'patient',
                                    );
                                    print(model.toJson());
                                    context.read<AuthCubit>().reigsterPatient(
                                      model,
                                    );
                                  } else {
                                    setState(() {
                                      autovalidateMode =
                                          AutovalidateMode.always;
                                    });
                                  }
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
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
