import 'package:caresync/app.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  runApp(const CureSync());
}
