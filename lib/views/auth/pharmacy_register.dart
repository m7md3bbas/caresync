import 'dart:io';
import 'package:caresync/core/locale/generated/l10n.dart';
import 'package:caresync/core/validation/auth_validation.dart';
import 'package:caresync/controller/auth/auth_cubit.dart';
import 'package:caresync/controller/auth/auth_state.dart';
import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/core/widget/custom_toast.dart';
import 'package:caresync/models/pharmacist_model.dart';
import 'package:caresync/views/auth/widgets/custom_gender_drop_down.dart';
import 'package:caresync/views/auth/widgets/custom_text_form_field.dart';
import 'package:caresync/views/auth/widgets/custom_image_picker.dart';
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
  late final ValueNotifier<String?> gender;

  File? frontIdImage;
  File? backIdImage;

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.registerd) {
          GoRouter.of(context).push(RoutesApp.login);
        } else if (state.authStatus == AuthStatus.error) {
          print(state.errorMessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(centerTitle: true, title: Text(S.of(context).appName)),
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
                        S.of(context).pharmacistRegisterTitle,
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
                              textEditingController: pharmacyNameController,
                              isObsecure: false,
                              textInputType: TextInputType.text,
                              labelText: S.of(context).pharmacyName,
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
                              textEditingController: pharmacyAddressController,
                              isObsecure: false,
                              textInputType: TextInputType.text,
                              labelText: S.of(context).pharmacyAddress,
                            ),
                          ),
                        ],
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
                      const SizedBox(height: 16),

                      state.authStatus == AuthStatus.loading
                          ? const CircularProgressIndicator()
                          : CutomElvatedButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (frontIdImage == null ||
                                      backIdImage == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'برجاء تحميل صورتي البطاقة (الوجه والظهر)',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

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
                                    faceIdImage: frontIdImage!,
                                    backIdImage: backIdImage!,
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
