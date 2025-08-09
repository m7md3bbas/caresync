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

  /// `Manage Availability`
  String get manageAvailability {
    return Intl.message(
      'Manage Availability',
      name: 'manageAvailability',
      desc: '',
      args: [],
    );
  }

  /// `Cache Statistics`
  String get cacheStatistics {
    return Intl.message(
      'Cache Statistics',
      name: 'cacheStatistics',
      desc: '',
      args: [],
    );
  }

  /// `Cache Box`
  String get cacheBox {
    return Intl.message('Cache Box', name: 'cacheBox', desc: '', args: []);
  }

  /// `User Data Box`
  String get userDataBox {
    return Intl.message(
      'User Data Box',
      name: 'userDataBox',
      desc: '',
      args: [],
    );
  }

  /// `API Cache Box`
  String get apiCacheBox {
    return Intl.message(
      'API Cache Box',
      name: 'apiCacheBox',
      desc: '',
      args: [],
    );
  }

  /// `Settings Box`
  String get settingsBox {
    return Intl.message(
      'Settings Box',
      name: 'settingsBox',
      desc: '',
      args: [],
    );
  }

  /// `items`
  String get items {
    return Intl.message('items', name: 'items', desc: '', args: []);
  }

  /// `This shows the number of cached items in each storage box.`
  String get cacheStatisticsDescription {
    return Intl.message(
      'This shows the number of cached items in each storage box.',
      name: 'cacheStatisticsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Clear Cache`
  String get clearCache {
    return Intl.message('Clear Cache', name: 'clearCache', desc: '', args: []);
  }

  /// `This will clear all cached data. The app will need to fetch fresh data from the server.`
  String get clearCacheDescription {
    return Intl.message(
      'This will clear all cached data. The app will need to fetch fresh data from the server.',
      name: 'clearCacheDescription',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Cache cleared successfully!`
  String get cacheClearedSuccessfully {
    return Intl.message(
      'Cache cleared successfully!',
      name: 'cacheClearedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Preload Cache`
  String get preloadCache {
    return Intl.message(
      'Preload Cache',
      name: 'preloadCache',
      desc: '',
      args: [],
    );
  }

  /// `Preloading cache...`
  String get preloadingCache {
    return Intl.message(
      'Preloading cache...',
      name: 'preloadingCache',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message('Weekly', name: 'weekly', desc: '', args: []);
  }

  /// `Select Week Date`
  String get selectWeekDate {
    return Intl.message(
      'Select Week Date',
      name: 'selectWeekDate',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message('Week', name: 'week', desc: '', args: []);
  }

  /// `No schedules found for this week.`
  String get noSchedulesFound {
    return Intl.message(
      'No schedules found for this week.',
      name: 'noSchedulesFound',
      desc: '',
      args: [],
    );
  }

  /// `Add Schedule for This Week`
  String get addScheduleForThisWeek {
    return Intl.message(
      'Add Schedule for This Week',
      name: 'addScheduleForThisWeek',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message('Day', name: 'day', desc: '', args: []);
  }

  /// `Working`
  String get working {
    return Intl.message('Working', name: 'working', desc: '', args: []);
  }

  /// `Hours`
  String get hours {
    return Intl.message('Hours', name: 'hours', desc: '', args: []);
  }

  /// `Duration`
  String get duration {
    return Intl.message('Duration', name: 'duration', desc: '', args: []);
  }

  /// `Actions`
  String get actions {
    return Intl.message('Actions', name: 'actions', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Day Off`
  String get dayOff {
    return Intl.message('Day Off', name: 'dayOff', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Offline`
  String get offlineIndicator {
    return Intl.message(
      'Offline',
      name: 'offlineIndicator',
      desc: '',
      args: [],
    );
  }

  /// `actions pending`
  String get offlineActionsPending {
    return Intl.message(
      'actions pending',
      name: 'offlineActionsPending',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Sync`
  String get sync {
    return Intl.message('Sync', name: 'sync', desc: '', args: []);
  }

  /// `Offline actions synced!`
  String get offlineActionsSynced {
    return Intl.message(
      'Offline actions synced!',
      name: 'offlineActionsSynced',
      desc: '',
      args: [],
    );
  }

  /// `Schedule added successfully!`
  String get scheduleAddedSuccessfully {
    return Intl.message(
      'Schedule added successfully!',
      name: 'scheduleAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Schedule updated successfully!`
  String get scheduleUpdatedSuccessfully {
    return Intl.message(
      'Schedule updated successfully!',
      name: 'scheduleUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Schedule deleted successfully!`
  String get scheduleDeletedSuccessfully {
    return Intl.message(
      'Schedule deleted successfully!',
      name: 'scheduleDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Add Schedule`
  String get addSchedule {
    return Intl.message(
      'Add Schedule',
      name: 'addSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Edit Schedule`
  String get editSchedule {
    return Intl.message(
      'Edit Schedule',
      name: 'editSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Schedule Type`
  String get scheduleType {
    return Intl.message(
      'Schedule Type',
      name: 'scheduleType',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weeklySchedule {
    return Intl.message('Weekly', name: 'weeklySchedule', desc: '', args: []);
  }

  /// `Recurring`
  String get recurringSchedule {
    return Intl.message(
      'Recurring',
      name: 'recurringSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Week Starting`
  String get weekStarting {
    return Intl.message(
      'Week Starting',
      name: 'weekStarting',
      desc: '',
      args: [],
    );
  }

  /// `Day of Week`
  String get dayOfWeek {
    return Intl.message('Day of Week', name: 'dayOfWeek', desc: '', args: []);
  }

  /// `Is Working Day`
  String get isWorkingDay {
    return Intl.message(
      'Is Working Day',
      name: 'isWorkingDay',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get startTime {
    return Intl.message('Start Time', name: 'startTime', desc: '', args: []);
  }

  /// `End Time`
  String get endTime {
    return Intl.message('End Time', name: 'endTime', desc: '', args: []);
  }

  /// `Appointment Duration (minutes)`
  String get appointmentDuration {
    return Intl.message(
      'Appointment Duration (minutes)',
      name: 'appointmentDuration',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Please select a day of the week`
  String get pleaseSelectDay {
    return Intl.message(
      'Please select a day of the week',
      name: 'pleaseSelectDay',
      desc: '',
      args: [],
    );
  }

  /// `End time must be after start time`
  String get endTimeMustBeAfterStartTime {
    return Intl.message(
      'End time must be after start time',
      name: 'endTimeMustBeAfterStartTime',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid duration`
  String get pleaseEnterValidDuration {
    return Intl.message(
      'Please enter a valid duration',
      name: 'pleaseEnterValidDuration',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message('Monday', name: 'monday', desc: '', args: []);
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message('Tuesday', name: 'tuesday', desc: '', args: []);
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message('Wednesday', name: 'wednesday', desc: '', args: []);
  }

  /// `Thursday`
  String get thursday {
    return Intl.message('Thursday', name: 'thursday', desc: '', args: []);
  }

  /// `Friday`
  String get friday {
    return Intl.message('Friday', name: 'friday', desc: '', args: []);
  }

  /// `Saturday`
  String get saturday {
    return Intl.message('Saturday', name: 'saturday', desc: '', args: []);
  }

  /// `Sunday`
  String get sunday {
    return Intl.message('Sunday', name: 'sunday', desc: '', args: []);
  }

  /// `Recurring`
  String get recurring {
    return Intl.message('Recurring', name: 'recurring', desc: '', args: []);
  }

  /// `Pharmacist Profile`
  String get pharmacist_profile {
    return Intl.message(
      'Pharmacist Profile',
      name: 'pharmacist_profile',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Full Name`
  String get full_name {
    return Intl.message('Full Name', name: 'full_name', desc: '', args: []);
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Reject`
  String get reject {
    return Intl.message('Reject', name: 'reject', desc: '', args: []);
  }

  /// `No appointments found.`
  String get noAppointmentsFound {
    return Intl.message(
      'No appointments found.',
      name: 'noAppointmentsFound',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Appointments`
  String get appointments {
    return Intl.message(
      'Appointments',
      name: 'appointments',
      desc: '',
      args: [],
    );
  }

  /// `Prescription added successfully`
  String get prescriptionAddedSuccessfully {
    return Intl.message(
      'Prescription added successfully',
      name: 'prescriptionAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Add Prescription`
  String get addPrescription {
    return Intl.message(
      'Add Prescription',
      name: 'addPrescription',
      desc: '',
      args: [],
    );
  }

  /// `Enter Patient ID`
  String get enterPatientID {
    return Intl.message(
      'Enter Patient ID',
      name: 'enterPatientID',
      desc: '',
      args: [],
    );
  }

  /// `Enter Medicine Name`
  String get enterMedicineName {
    return Intl.message(
      'Enter Medicine Name',
      name: 'enterMedicineName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Dosage`
  String get enterDosage {
    return Intl.message(
      'Enter Dosage',
      name: 'enterDosage',
      desc: '',
      args: [],
    );
  }

  /// `Enter Instructions`
  String get enterInstructions {
    return Intl.message(
      'Enter Instructions',
      name: 'enterInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Get Prescribed Medicines`
  String get getPrescribedMedicines {
    return Intl.message(
      'Get Prescribed Medicines',
      name: 'getPrescribedMedicines',
      desc: '',
      args: [],
    );
  }

  /// `Patient Details`
  String get patientDetails {
    return Intl.message(
      'Patient Details',
      name: 'patientDetails',
      desc: '',
      args: [],
    );
  }

  /// `No patient details available`
  String get noPatientDetailsAvailable {
    return Intl.message(
      'No patient details available',
      name: 'noPatientDetailsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Diabetes`
  String get diabetes {
    return Intl.message('Diabetes', name: 'diabetes', desc: '', args: []);
  }

  /// `Heart Disease`
  String get heartDisease {
    return Intl.message(
      'Heart Disease',
      name: 'heartDisease',
      desc: '',
      args: [],
    );
  }

  /// `Prescription Medicines`
  String get prescriptionMedicines {
    return Intl.message(
      'Prescription Medicines',
      name: 'prescriptionMedicines',
      desc: '',
      args: [],
    );
  }

  /// `No prescribed medicines found for this patient`
  String get noPrescribedMedicinesFound {
    return Intl.message(
      'No prescribed medicines found for this patient',
      name: 'noPrescribedMedicinesFound',
      desc: '',
      args: [],
    );
  }

  /// `Get Patient Details`
  String get getPatientDetails {
    return Intl.message(
      'Get Patient Details',
      name: 'getPatientDetails',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Profile`
  String get doctorProfile {
    return Intl.message(
      'Doctor Profile',
      name: 'doctorProfile',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Schedule`
  String get schedule {
    return Intl.message('Schedule', name: 'schedule', desc: '', args: []);
  }

  /// `Patients`
  String get patients {
    return Intl.message('Patients', name: 'patients', desc: '', args: []);
  }

  /// `Prescription`
  String get prescription {
    return Intl.message(
      'Prescription',
      name: 'prescription',
      desc: '',
      args: [],
    );
  }

  /// `Appointment confirmed successfully!`
  String get appointmentConfirmed {
    return Intl.message(
      'Appointment confirmed successfully!',
      name: 'appointmentConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Appointment cancelled successfully!`
  String get appointmentCancelled {
    return Intl.message(
      'Appointment cancelled successfully!',
      name: 'appointmentCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacy`
  String get pharmacy {
    return Intl.message('Pharmacy', name: 'pharmacy', desc: '', args: []);
  }

  /// `Appoinment`
  String get appoinment {
    return Intl.message('Appoinment', name: 'appoinment', desc: '', args: []);
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
