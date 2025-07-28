import 'package:flutter/material.dart';

class CutsomTextFormFiled extends StatelessWidget {
  const CutsomTextFormFiled({
    required this.validator,
    required this.textEditingController,
    required this.isObsecure,
    required this.textInputType,
    required this.labelText,
    this.hintText,
    super.key,
    this.suffixIcon,
  });
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final bool isObsecure;
  final TextInputType? textInputType;
  final String? labelText;
  final Widget? suffixIcon;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validator,

      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
        suffixIcon: suffixIcon,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        labelText: labelText,
      ),
      obscureText: isObsecure,
      keyboardType: textInputType,
    );
  }
}
