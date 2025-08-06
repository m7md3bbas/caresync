import 'package:caresync/core/locale/generated/l10n.dart';
import 'package:caresync/core/validation/auth_validation.dart';
import 'package:caresync/controller/auth/auth_cubit.dart';
import 'package:caresync/controller/auth/auth_state.dart';
import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/core/theme/theme_button.dart';
import 'package:caresync/core/widget/custom_toast.dart';
import 'package:caresync/models/password_reset_model.dart';
import 'package:caresync/views/auth/widgets/custom_text_form_field.dart';
import 'package:caresync/views/doctor/widgets/cutom_elvated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final TextEditingController emailController;
  late final TextEditingController otpVerify;
  late final TextEditingController setNewPassword;
  late final GlobalKey<FormState> formKey;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isObscure = true;
  @override
  void initState() {
    emailController = TextEditingController();
    otpVerify = TextEditingController();
    setNewPassword = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.otpSent) {
          ToastHelper.showSuccess('OTP sent successfully');
        }
        if (state.authStatus == AuthStatus.passwordReset) {
          ToastHelper.showSuccess('Password reset successfully');
          context.read<AuthCubit>().onAuthReset();
          GoRouter.of(context).pushReplacement(RoutesApp.login);
        }
        if (state.authStatus == AuthStatus.error) {
          GoRouter.of(context).go(RoutesApp.login);
          print(state.errorMessage);
          ToastHelper.showError(state.errorMessage.toString());
          context.read<AuthCubit>().onAuthReset();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).appName),
            actions: [ThemeButton()],
          ),
          body: Center(
            child: state.authStatus == AuthStatus.loading
                ? CircularProgressIndicator(strokeWidth: 2.5)
                : Container(
                    width: 400,
                    padding: const EdgeInsets.all(24),

                    child: Form(
                      key: formKey,
                      autovalidateMode: autovalidateMode,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 24,
                        children: [
                          Text(
                            state.authStatus == AuthStatus.initial
                                ? S.of(context).titleForgetPassword
                                : state.authStatus == AuthStatus.otpSent
                                ? S.of(context).verifyOtpTitle
                                : S.of(context).resetPasswordTitle,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            state.authStatus == AuthStatus.initial
                                ? S.of(context).subTitleForgetPassword
                                : state.authStatus == AuthStatus.otpSent
                                ? S.of(context).verifyOtpSubTitle
                                : S.of(context).resetPasswordSubTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          state.authStatus == AuthStatus.initial
                              ? CutsomTextFormFiled(
                                  isObsecure: false,
                                  textEditingController: emailController,
                                  validator: (value) =>
                                      AuthValidation.validateEmail(
                                        context,
                                        value,
                                      ),
                                  textInputType: TextInputType.emailAddress,
                                  labelText: S.of(context).email,
                                )
                              : state.authStatus == AuthStatus.otpSent
                              ? OtpTextField(
                                  numberOfFields: 6,
                                  borderColor: Colors.white,
                                  showFieldAsBox: true,
                                  onCodeChanged: (String code) =>
                                      AuthValidation.validateOTP(code, context),
                                  onSubmit: (String verificationCode) {
                                    otpVerify.text = verificationCode;
                                    context.read<AuthCubit>().verifyOtp(
                                      VerifyOtpRequest(
                                        emailController.text,
                                        verificationCode,
                                      ),
                                    );
                                  },
                                )
                              : state.authStatus == AuthStatus.otpVerified
                              ? CutsomTextFormFiled(
                                  validator: (value) =>
                                      AuthValidation.validatePassword(
                                        context,
                                        value,
                                      ),
                                  textEditingController: setNewPassword,
                                  isObsecure: isObscure,
                                  textInputType: TextInputType.visiblePassword,
                                  labelText: S.of(context).newPassword,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                  ),
                                )
                              : TextFormField(),
                          state.authStatus == AuthStatus.otpSent
                              ? SizedBox()
                              : CutomElvatedButton(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      if (state.authStatus ==
                                          AuthStatus.initial) {
                                        context
                                            .read<AuthCubit>()
                                            .requestPasswordReset(
                                              PasswordResetRequest(
                                                emailController.text,
                                              ),
                                            );
                                      } else if (state.authStatus ==
                                          AuthStatus.otpVerified) {
                                        context
                                            .read<AuthCubit>()
                                            .setNewPassword(
                                              SetNewPasswordRequest(
                                                emailController.text,
                                                otpVerify.text,
                                                setNewPassword.text,
                                              ),
                                            );
                                      }
                                    } else {
                                      setState(() {
                                        autovalidateMode =
                                            AutovalidateMode.always;
                                      });
                                    }
                                  },
                                  text: state.authStatus == AuthStatus.initial
                                      ? S.of(context).sendOTP
                                      : state.authStatus ==
                                            AuthStatus.otpVerified
                                      ? S.of(context).resetPassword
                                      : "",
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
