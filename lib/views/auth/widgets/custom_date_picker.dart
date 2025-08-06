import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final String hintText;
  final String? Function(String?)? validator;
  final bool futureDatesOnly;
  final Function(String)? onChanged;

  const DatePickerField({
    super.key,
    required this.controller,
    this.width = 360,
    this.hintText = 'yyyy-mm-dd',
    this.validator,
    this.futureDatesOnly = false,
    this.onChanged,
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
            firstDate: futureDatesOnly ? DateTime.now() : DateTime(1900),
            lastDate: DateTime(2100),
            initialDate: DateTime.tryParse(controller.text) ?? DateTime.now(),
            builder: (context, child) {
              return Theme(data: ThemeData.dark(), child: child!);
            },
          );
          if (picked != null) {
            final formatted = DateFormat('yyyy-MM-dd').format(picked);
            controller.text = formatted;
            onChanged?.call(formatted);
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
            (value) => (value == null || value.isEmpty)
                ? 'This field is required'
                : null,
      ),
    );
  }
}
