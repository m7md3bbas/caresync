import 'package:caresync/config/validation/auth_validation.dart';
import 'package:caresync/views/auth/widgets/custom_date_picker.dart';
import 'package:caresync/views/auth/widgets/custom_gender_drop_down.dart';
import 'package:caresync/views/auth/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

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
  late final AutovalidateMode autovalidateMode;
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
              child: Column(
                spacing: 24,
                children: [
                  const Text(
                    'Pharmacy Registration',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
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
                        isObsecure ? Icons.visibility_off : Icons.visibility,
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
                        child: DatePickerField(
                          controller: birthdayController,
                          hintText: 'Birthday',
                          width: 150,
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
