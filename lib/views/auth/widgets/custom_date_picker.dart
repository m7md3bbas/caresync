import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final String hintText;
  final String? Function(String?)? validator;

  const DatePickerField({
    super.key,
    required this.controller,
    this.width = 360,
    this.hintText = 'mm/dd/yyyy',
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            initialDate: DateTime(2000),
            builder: (context, child) {
              return Theme(data: ThemeData.dark(), child: child!);
            },
          );
          if (picked != null) {
            controller.text = '${picked.month}/${picked.day}/${picked.year}';
          }
        },
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white38),
          filled: true,
          fillColor: const Color(0xFF0D1117),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: const Icon(Icons.calendar_today, color: Colors.white38),
        ),
        validator:
            validator ??
            (value) =>
                value == null || value.isEmpty ? 'Birthday is required' : null,
      ),
    );
  }
}
