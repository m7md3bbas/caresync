import 'package:caresync/core/colors/color_manager.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const CustomTextField({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(label: Text(label),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
        color: ColorManager.splashBackgroundColor
      )),focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.splashBackgroundColor)
      )),
    );
  }
}
