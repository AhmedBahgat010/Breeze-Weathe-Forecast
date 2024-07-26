import 'dart:async';
import 'package:breeze_weather_forecast/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:breeze_weather_forecast/dependencies_injection.dart' as di;

import 'dependencies_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyB2MMU2AGYVPKhTcGTBB_1ZECUUx2TfDWE",
      appId: "1:830529096070:android:92c7d9d888517464558407",
      messagingSenderId: "830529096070",
      projectId: "bim-app-a047d",
    ),
  );

  /// Register Service locator
  await serviceLocator();

  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BMi Task'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_outlined,
                color: Colors.red,
                size: 100,
              ),
              Text(
                !kReleaseMode
                    ? 'Oops... something went wrong'
                    : errorDetails.exception.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  };

  return SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then((_) => runApp(const MyApp()));
}
