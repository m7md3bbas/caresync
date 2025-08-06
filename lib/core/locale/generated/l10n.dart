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

  /// `CareSync`
  String get appName {
    return Intl.message('CareSync', name: 'appName', desc: '', args: []);
  }

  /// `Your Language`
  String get languageTitle {
    return Intl.message(
      'Your Language',
      name: 'languageTitle',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Your Medical Companion – All in One Place`
  String get onboardingPageOneTitle {
    return Intl.message(
      'Your Medical Companion – All in One Place',
      name: 'onboardingPageOneTitle',
      desc: '',
      args: [],
    );
  }

  /// `Whether you're a Doctor, Patient, or Pharmacist, this app is tailored just for you. Register your role and access features designed specifically to meet your needs.`
  String get onboardingPageOneSubTitle {
    return Intl.message(
      'Whether you\'re a Doctor, Patient, or Pharmacist, this app is tailored just for you. Register your role and access features designed specifically to meet your needs.',
      name: 'onboardingPageOneSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Book Appointments & Access Medical Records`
  String get onboardingPageTwoTitle {
    return Intl.message(
      'Book Appointments & Access Medical Records',
      name: 'onboardingPageTwoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Patients can easily book appointments with doctors. Doctors can review patient history, manage visits, and write digital prescriptions in seconds.`
  String get onboardingPageTwoSubTitle {
    return Intl.message(
      'Patients can easily book appointments with doctors. Doctors can review patient history, manage visits, and write digital prescriptions in seconds.',
      name: 'onboardingPageTwoSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Prescriptions Made Simple`
  String get onboardingPageThreeTitle {
    return Intl.message(
      'Prescriptions Made Simple',
      name: 'onboardingPageThreeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Doctors can create digital prescriptions. Pharmacists can view the latest ones and prepare orders for the patients—faster, safer, and paper-free.`
  String get onboardingPageThreeSubTitle {
    return Intl.message(
      'Doctors can create digital prescriptions. Pharmacists can view the latest ones and prepare orders for the patients—faster, safer, and paper-free.',
      name: 'onboardingPageThreeSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `National ID`
  String get nationalID {
    return Intl.message('National ID', name: 'nationalID', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forget password?`
  String get forgetPasswordquestion {
    return Intl.message(
      'Forget password?',
      name: 'forgetPasswordquestion',
      desc: '',
      args: [],
    );
  }

  /// `Register Now`
  String get registerNow {
    return Intl.message(
      'Register Now',
      name: 'registerNow',
      desc: '',
      args: [],
    );
  }

  /// `Login now`
  String get loginNow {
    return Intl.message('Login now', name: 'loginNow', desc: '', args: []);
  }

  /// `Forget password`
  String get titleForgetPassword {
    return Intl.message(
      'Forget password',
      name: 'titleForgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address and we'll send you a one-time password (OTP) to reset your password.`
  String get subTitleForgetPassword {
    return Intl.message(
      'Enter your email address and we\'ll send you a one-time password (OTP) to reset your password.',
      name: 'subTitleForgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP`
  String get sendOTP {
    return Intl.message('Send OTP', name: 'sendOTP', desc: '', args: []);
  }

  /// `Verify OTP`
  String get verifyOtpTitle {
    return Intl.message(
      'Verify OTP',
      name: 'verifyOtpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the OTP sent to your email address and create a new password.`
  String get verifyOtpSubTitle {
    return Intl.message(
      'Enter the OTP sent to your email address and create a new password.',
      name: 'verifyOtpSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPasswordTitle {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password and confirm it to reset your password.`
  String get resetPasswordSubTitle {
    return Intl.message(
      'Enter your new password and confirm it to reset your password.',
      name: 'resetPasswordSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to CareSync!`
  String get preregisterTitle {
    return Intl.message(
      'Welcome to CareSync!',
      name: 'preregisterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select your role to get started:`
  String get preregisterSubTitle {
    return Intl.message(
      'Select your role to get started:',
      name: 'preregisterSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Doctor`
  String get doctor {
    return Intl.message('Doctor', name: 'doctor', desc: '', args: []);
  }

  /// `Patient`
  String get patient {
    return Intl.message('Patient', name: 'patient', desc: '', args: []);
  }

  /// `Pharmacist`
  String get pharmacist {
    return Intl.message('Pharmacist', name: 'pharmacist', desc: '', args: []);
  }

  /// `Manage your patients and view their medical records efficiently.`
  String get preregisterTitleDoctor {
    return Intl.message(
      'Manage your patients and view their medical records efficiently.',
      name: 'preregisterTitleDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Access your health information and manage your prescriptions.`
  String get preregisterTitlePatient {
    return Intl.message(
      'Access your health information and manage your prescriptions.',
      name: 'preregisterTitlePatient',
      desc: '',
      args: [],
    );
  }

  /// `View and manage prescriptions and medical data.`
  String get preregisterTitlePharmacist {
    return Intl.message(
      'View and manage prescriptions and medical data.',
      name: 'preregisterTitlePharmacist',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Registration`
  String get doctorRegisterTitle {
    return Intl.message(
      'Doctor Registration',
      name: 'doctorRegisterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Patient Registration`
  String get patientRegisterTitle {
    return Intl.message(
      'Patient Registration',
      name: 'patientRegisterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacist Registration`
  String get pharmacistRegisterTitle {
    return Intl.message(
      'Pharmacist Registration',
      name: 'pharmacistRegisterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `PhoneNumber`
  String get phoneNumber {
    return Intl.message('PhoneNumber', name: 'phoneNumber', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Birthday`
  String get birthday {
    return Intl.message('Birthday', name: 'birthday', desc: '', args: []);
  }

  /// `Select Gender`
  String get selectGender {
    return Intl.message(
      'Select Gender',
      name: 'selectGender',
      desc: '',
      args: [],
    );
  }

  /// `Hospital`
  String get hospital {
    return Intl.message('Hospital', name: 'hospital', desc: '', args: []);
  }

  /// `Clinic`
  String get clinic {
    return Intl.message('Clinic', name: 'clinic', desc: '', args: []);
  }

  /// `Specialization`
  String get specialization {
    return Intl.message(
      'Specialization',
      name: 'specialization',
      desc: '',
      args: [],
    );
  }

  /// `I have diabetes`
  String get iHaveDiabetes {
    return Intl.message(
      'I have diabetes',
      name: 'iHaveDiabetes',
      desc: '',
      args: [],
    );
  }

  /// `I have heart disease`
  String get IHaveHeartDisease {
    return Intl.message(
      'I have heart disease',
      name: 'IHaveHeartDisease',
      desc: '',
      args: [],
    );
  }

  /// `Allergies`
  String get allergies {
    return Intl.message('Allergies', name: 'allergies', desc: '', args: []);
  }

  /// `Other Diseases`
  String get otherDiseases {
    return Intl.message(
      'Other Diseases',
      name: 'otherDiseases',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacy Name`
  String get pharmacyName {
    return Intl.message(
      'Pharmacy Name',
      name: 'pharmacyName',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacy Address`
  String get pharmacyAddress {
    return Intl.message(
      'Pharmacy Address',
      name: 'pharmacyAddress',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get fieldIsRequired {
    return Intl.message(
      'This field is required',
      name: 'fieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Name must be at least 3 characters`
  String get nameLength {
    return Intl.message(
      'Name must be at least 3 characters',
      name: 'nameLength',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordLength {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordLength',
      desc: '',
      args: [],
    );
  }

  /// `Address must be at least 5 characters`
  String get addressLength {
    return Intl.message(
      'Address must be at least 5 characters',
      name: 'addressLength',
      desc: '',
      args: [],
    );
  }

  /// `National ID must be at least 14 characters`
  String get nationalIDLength {
    return Intl.message(
      'National ID must be at least 14 characters',
      name: 'nationalIDLength',
      desc: '',
      args: [],
    );
  }

  /// `Invalid National ID format`
  String get nationalIDFormat {
    return Intl.message(
      'Invalid National ID format',
      name: 'nationalIDFormat',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get invalidEmail {
    return Intl.message(
      'Invalid email address',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `OTP must be exactly 6 digits`
  String get otpLength {
    return Intl.message(
      'OTP must be exactly 6 digits',
      name: 'otpLength',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character`
  String get passwordComplexity {
    return Intl.message(
      'Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character',
      name: 'passwordComplexity',
      desc: '',
      args: [],
    );
  }

  /// `phone number must be start with 010,011,012,015`
  String get invalidEgyptianPhone {
    return Intl.message(
      'phone number must be start with 010,011,012,015',
      name: 'invalidEgyptianPhone',
      desc: '',
      args: [],
    );
  }

  /// `Allergies must be letters only, separated by commas`
  String get invalidAllergies {
    return Intl.message(
      'Allergies must be letters only, separated by commas',
      name: 'invalidAllergies',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `e.g. Penicillin, Nuts, Pollen etc.`
  String get allergiesExample {
    return Intl.message(
      'e.g. Penicillin, Nuts, Pollen etc.',
      name: 'allergiesExample',
      desc: '',
      args: [],
    );
  }

  /// `Upload ID card image (Front)`
  String get uploadFrontIdImage {
    return Intl.message(
      'Upload ID card image (Front)',
      name: 'uploadFrontIdImage',
      desc: '',
      args: [],
    );
  }

  /// `Upload ID card image (Back)`
  String get uploadBackIdImage {
    return Intl.message(
      'Upload ID card image (Back)',
      name: 'uploadBackIdImage',
      desc: '',
      args: [],
    );
  }

  /// `Your request has been submitted. You'll be notified by email once approved.`
  String get accountApprovalMessage {
    return Intl.message(
      'Your request has been submitted. You\'ll be notified by email once approved.',
      name: 'accountApprovalMessage',
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
