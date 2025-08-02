import 'package:caresync/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Theme.of(context).brightness == Brightness.light
            ? Icons.light_mode_outlined
            : Icons.dark_mode_outlined,
      ),
      onPressed: () {
        final cubit = context.read<ThemeCubit>();
        final currentMode = cubit.state.themeMode;

        if (currentMode == ThemeMode.light) {
          cubit.changeTheme(ThemeMode.dark);
        } else {
          cubit.changeTheme(ThemeMode.light);
        }
      },
    );
  }
}
