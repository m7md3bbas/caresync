import 'package:caresync/core/locale/generated/l10n.dart';
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
            decoration: InputDecoration(
              hintText: S.of(context).selectGender,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            items: [
              DropdownMenuItem(value: 'Male', child: Text(S.of(context).male)),
              DropdownMenuItem(
                value: 'Female',
                child: Text(S.of(context).female),
              ),
              DropdownMenuItem(
                value: 'Other',
                child: Text(S.of(context).other),
              ),
            ],
            validator: (value) =>
                value == null ? S.of(context).fieldIsRequired : null,
          );
        },
      ),
    );
  }
}
