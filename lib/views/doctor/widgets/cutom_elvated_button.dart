import 'package:flutter/material.dart';

class CutomElvatedButton extends StatelessWidget {
  const CutomElvatedButton({
    super.key,
    required this.onTap,
    required this.text,
  });
  final VoidCallback onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap, child: Text(text));
  }
}
