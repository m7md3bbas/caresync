import 'package:caresync/config/validation/auth_validation.dart';
import 'package:caresync/controller/auth/auth_cubit.dart';
import 'package:caresync/controller/auth/auth_state.dart';
import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/views/auth/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController nationalIDController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;
  late AutovalidateMode autovalidateMode;
  bool isObsecure = true;

  void tokenExist() {
    final token = SharedPrefHelper.getString(SharedPrefKeys.token);
    if (token != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          GoRouter.of(context).go(RoutesApp.home);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nationalIDController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    autovalidateMode = AutovalidateMode.disabled;
    tokenExist();
  }

  @override
  void dispose() {
    nationalIDController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.authenticated) {
          GoRouter.of(context).go(RoutesApp.home);
        } else if (state.authStatus == AuthStatus.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF1D4ED8),
          appBar: AppBar(
            backgroundColor: const Color(0xFF0D1117),
            title: const Text(
              'CareSync',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  GoRouter.of(context).go(RoutesApp.preRegister);
                },
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          body: Center(
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1117),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CutsomTextFormFiled(
                      isObsecure: false,
                      labelText: "National ID",
                      textEditingController: nationalIDController,
                      textInputType: TextInputType.number,
                      validator: (value) =>
                          AuthValidation.validateNationalID(value),
                      suffixIcon: null,
                    ),
                    const SizedBox(height: 16),
                    CutsomTextFormFiled(
                      isObsecure: isObsecure,
                      labelText: "Password",
                      textEditingController: passwordController,
                      textInputType: TextInputType.visiblePassword,
                      validator: (value) => null,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObsecure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).push(RoutesApp.forgetPassword);
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        const Spacer(),
                        state.authStatus == AuthStatus.loading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().login(
                                      nationalID: nationalIDController.text,
                                      password: passwordController.text,
                                    );
                                  } else {
                                    autovalidateMode = AutovalidateMode.always;
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text('Login'),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
