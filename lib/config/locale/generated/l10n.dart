// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello`
  String get hello {
    return Intl.message('Hello', name: 'hello', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Security`
  String get Security {
    return Intl.message('Security', name: 'Security', desc: '', args: []);
  }

  /// `Devices`
  String get devices {
    return Intl.message('Devices', name: 'devices', desc: '', args: []);
  }

  /// `First Name`
  String get firstName {
    return Intl.message('First Name', name: 'firstName', desc: '', args: []);
  }

  /// `Last Name`
  String get lastName {
    return Intl.message('Last Name', name: 'lastName', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `This field is required`
  String get requiredField {
    return Intl.message(
      'This field is required',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `The name should be between 3 to 12 characters`
  String get nameLength {
    return Intl.message(
      'The name should be between 3 to 12 characters',
      name: 'nameLength',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get invalidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must be between 8 to 16 characters`
  String get passwordLength {
    return Intl.message(
      'Password must be between 8 to 16 characters',
      name: 'passwordLength',
      desc: '',
      args: [],
    );
  }

  /// `Password must include uppercase, lowercase, digit, and special symbol`
  String get passwordComplexity {
    return Intl.message(
      'Password must include uppercase, lowercase, digit, and special symbol',
      name: 'passwordComplexity',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid Egyptian phone number`
  String get invalidEgyptianPhone {
    return Intl.message(
      'Enter a valid Egyptian phone number',
      name: 'invalidEgyptianPhone',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the terms and conditions`
  String get terms {
    return Intl.message(
      'I agree to the terms and conditions',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number or email`
  String get loginWithEmailOrPhone {
    return Intl.message(
      'Mobile number or email',
      name: 'loginWithEmailOrPhone',
      desc: '',
      args: [],
    );
  }

  /// `Forget password?`
  String get forgetPassword {
    return Intl.message(
      'Forget password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login with Facebook`
  String get loginfacebook {
    return Intl.message(
      'Login with Facebook',
      name: 'loginfacebook',
      desc: '',
      args: [],
    );
  }

  /// `Login with Gmail`
  String get logingmail {
    return Intl.message(
      'Login with Gmail',
      name: 'logingmail',
      desc: '',
      args: [],
    );
  }

  /// `Register with Facebook`
  String get registerfacebook {
    return Intl.message(
      'Register with Facebook',
      name: 'registerfacebook',
      desc: '',
      args: [],
    );
  }

  /// `Register with Gmail`
  String get registergmail {
    return Intl.message(
      'Register with Gmail',
      name: 'registergmail',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
