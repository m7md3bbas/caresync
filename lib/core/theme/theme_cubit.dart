// lib/core/theme/theme_cubit.dart

import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.system)) {
    _loadTheme();
  }

  void _loadTheme() {
    final String? savedTheme = SharedPrefHelper.getString(SharedPrefKeys.theme);

    switch (savedTheme) {
      case 'light':
        emit(ThemeState(themeMode: ThemeMode.light));
        break;
      case 'dark':
        emit(ThemeState(themeMode: ThemeMode.dark));
        break;
      default:
        emit(ThemeState(themeMode: ThemeMode.system));
    }
  }

  void changeTheme(ThemeMode mode) async {
    emit(ThemeState(themeMode: mode));
    switch (mode) {
      case ThemeMode.light:
        await SharedPrefHelper.setString(SharedPrefKeys.theme, 'light');
        break;
      case ThemeMode.dark:
        await SharedPrefHelper.setString(SharedPrefKeys.theme, 'dark');
        break;
      case ThemeMode.system:
        await SharedPrefHelper.setString(SharedPrefKeys.theme, 'system');
        break;
    }
  }
}
