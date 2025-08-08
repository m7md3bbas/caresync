import 'package:caresync/app.dart';
import 'package:caresync/core/cache/cache_manager.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize shared preferences
  await SharedPrefHelper.init();
  
  // Initialize cache manager
  await CacheManager().initialize();
  
  print('🚀 App initialized with cache support');
  print('Token: ${SharedPrefHelper.getString(SharedPrefKeys.token)}');
  
  runApp(const CureSync());
}
