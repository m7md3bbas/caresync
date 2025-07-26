import 'package:caresync/config/locale/locale_state.dart';
import 'package:caresync/core/constants/languages_locale.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState(LanguagesLocale.getEnglishLan())) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final savedLocale = SharedPrefHelper.getString(SharedPrefKeys.locale);

    if (savedLocale == 'ar') {
      emit(LocaleState(LanguagesLocale.getArabicLan()));
    } else {
      emit(LocaleState(LanguagesLocale.getEnglishLan()));
    }
  }

  Future<void> changeLocale(Locale locale) async {
    emit(LocaleState(locale));
    await SharedPrefHelper.setString(
      SharedPrefKeys.locale,
      locale.languageCode,
    );
  }

  void toggleLocale() {
    final currentLang = state.locale.languageCode;
    final newLocale = currentLang == 'en'
        ? LanguagesLocale.getArabicLan()
        : LanguagesLocale.getEnglishLan();
    changeLocale(newLocale);
  }
}
