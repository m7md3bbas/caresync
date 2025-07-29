import 'package:caresync/core/colors/color_manager.dart';
import 'package:flutter/material.dart';

class CustomHeadline extends StatelessWidget {
  final String text;
  const CustomHeadline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: ColorManager.splashBackgroundColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}
