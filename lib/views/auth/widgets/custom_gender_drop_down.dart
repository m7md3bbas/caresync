import 'package:flutter/material.dart';

class GenderDropdown extends StatelessWidget {
  final ValueNotifier<String?> gender;
  final double? width;

  const GenderDropdown({super.key, required this.gender, this.width = 360});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ValueListenableBuilder<String?>(
        valueListenable: gender,
        builder: (_, selectedGender, __) {
          return DropdownButtonFormField<String>(
            value: selectedGender,
            onChanged: (value) => gender.value = value,
            dropdownColor: const Color(0xFF0D1117),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Select gender',
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: const Color(0xFF0D1117),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            items: const [
              DropdownMenuItem(value: 'Male', child: Text('Male')),
              DropdownMenuItem(value: 'Female', child: Text('Female')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
            validator: (value) => value == null ? 'Gender is required' : null,
          );
        },
      ),
    );
  }
}
