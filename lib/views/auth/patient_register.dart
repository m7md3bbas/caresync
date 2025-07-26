import 'package:caresync/config/validation/auth_validation.dart';
import 'package:caresync/views/auth/widgets/custom_date_picker.dart';
import 'package:caresync/views/auth/widgets/custom_gender_drop_down.dart';
import 'package:caresync/views/auth/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

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
  late final AutovalidateMode autovalidateMode;
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
    autovalidateMode = AutovalidateMode.disabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Form(
            key: _formKey,
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
                child: Column(
                  children: [
                    const Text(
                      'Patient Registration',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: CutsomTextFormFiled(
                            validator: (value) =>
                                AuthValidation.validateName(context, value),
                            textEditingController: fullNameController,
                            isObsecure: false,
                            textInputType: TextInputType.text,
                            labelText: 'Full Name',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CutsomTextFormFiled(
                            validator: (value) =>
                                AuthValidation.validateEmail(context, value),
                            textEditingController: emailController,
                            isObsecure: false,
                            textInputType: TextInputType.emailAddress,
                            labelText: 'Email',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CutsomTextFormFiled(
                            validator: (value) =>
                                AuthValidation.validateNationalID(value),
                            textEditingController: nationalIDController,
                            isObsecure: false,
                            textInputType: TextInputType.number,
                            labelText: 'National ID',
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
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CutsomTextFormFiled(
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
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DatePickerField(
                            controller: birthdayController,
                            hintText: 'mm/dd/yyyy',
                            validator: (value) => null,
                            width: 200,
                          ),
                        ),
                        const SizedBox(width: 16),

                        Expanded(child: GenderDropdown(gender: gender)),
                      ],
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CutsomTextFormFiled(
                            validator: (value) => null, // Optional field
                            textEditingController: allergiesController,
                            isObsecure: false,
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
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
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
      ),
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
