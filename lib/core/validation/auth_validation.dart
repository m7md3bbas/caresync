import 'package:caresync/core/locale/generated/l10n.dart';
import 'package:flutter/widgets.dart';

class AuthValidation {
  static String? validateName(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    } else if (value.length > 18 || value.length < 3) {
      return S.of(context).nameLength;
    } else {
      return null;
    }
  }

  static String? validateAddress(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    } else if (value.length < 5) {
      return S.of(context).addressLength;
    }
    return null;
  }

  static String? validateNationalID(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    }

    if (value.length != 14) {
      return S.of(context).nationalIDLength;
    }

    final regex = RegExp(r'^[23]\d{13}$');
    if (!regex.hasMatch(value)) {
      return S.of(context).nationalIDFormat;
    }

    return null;
  }

  static String? validateEmail(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return S.of(context).invalidEmail;
    } else {
      return null;
    }
  }

  static String? validateOTP(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return S.of(context).otpLength;
    }
    return null;
  }

  static String? validatePassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    } else if (value.length < 8 || value.length > 22) {
      return S.of(context).passwordLength;
    } else if (!RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~_^\-+=]).{8,}$',
    ).hasMatch(value)) {
      return S.of(context).passwordComplexity;
    } else {
      return null;
    }
  }

  static String? validateEgyptianPhone(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    } else if (!RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(value)) {
      return S.of(context).invalidEgyptianPhone;
    } else {
      return null;
    }
  }
}
