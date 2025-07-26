import 'package:caresync/config/locale/generated/l10n.dart';
import 'package:flutter/widgets.dart';

class AuthValidation {
  static String? validateName(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).requiredField;
    } else if (value.length > 12 || value.length < 3) {
      return S.of(context).nameLength;
    } else {
      return null;
    }
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    } else if (value.length < 5) {
      return 'Address must be at least 5 characters';
    }
    return null;
  }

  static String? validateNationalID(String? value) {
    if (value == null || value.isEmpty) {
      return 'National ID is required';
    }

    if (value.length != 14) {
      return 'National ID must be exactly 14 digits';
    }

    final regex = RegExp(r'^[23]\d{13}$');
    if (!regex.hasMatch(value)) {
      return 'Invalid National ID format';
    }

    return null;
  }

  static String? validateEmail(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).requiredField;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return S.of(context).invalidEmail;
    } else {
      return null;
    }
  }

  static String? validatePassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).requiredField;
    } else if (value.length < 8 || value.length > 16) {
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
      return S.of(context).requiredField;
    } else if (!RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(value)) {
      return S.of(context).invalidEgyptianPhone;
    } else {
      return null;
    }
  }
}
