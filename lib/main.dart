import 'dart:async';
import 'package:breeze_weather_forecast/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:breeze_weather_forecast/dependencies_injection.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

import 'dependencies_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final prefs = await SharedPreferences.getInstance();
      // await Firebase.initializeApp(

  // );

  /// Register Service locator
  await di.initServiceLocator();


  return SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then((_) => runApp( MyApp(prefs: prefs)));
}
