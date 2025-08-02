import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final String hintText;
  final String? Function(String?)? validator;

  const DatePickerField({
    super.key,
    required this.controller,
    this.width = 360,
    this.hintText = 'yyyy-mm-dd',
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
            final formatted = DateFormat('yyyy-MM-dd').format(picked);
            controller.text = formatted;
          }
        },
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.calendar_month),
          hintText: hintText,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator:
            validator ??
            (value) =>
                value == null || value.isEmpty ? 'Birthday is required' : null,
      ),
    );
  }
}
