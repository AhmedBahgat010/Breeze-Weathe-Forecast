
import 'package:breeze_weather_forecast/utils/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dependencies_injection.dart';
import 'features/auth/auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, __) {
          return MaterialApp(
              home: LoginPage(),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              title: Constants.get.appName,
              locale: const Locale("en"),
              themeMode: ThemeMode.dark,
              // theme: ThemeData(
              //   primaryColor: Palette.primary,
              //   iconTheme: const IconThemeData(color: Palette.primary),
              //   primaryIconTheme: const IconThemeData(color: Palette.primary),
              // )
          );
        },
      ),
    );
  }
}
