
import 'package:breeze_weather_forecast/core/theme/export.dart';
import 'package:breeze_weather_forecast/core/translations/app_language.dart';
import 'package:breeze_weather_forecast/utils/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/themes.dart';
import 'core/translations/translations.dart';
import 'dependencies_injection.dart';
import 'features/auth/auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class MyApp extends StatelessWidget {
    final SharedPreferences prefs;

   MyApp({super.key, required this.prefs});
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
        BlocProvider(create: (_) => sl<ThemeCubit>()),
                BlocProvider(create: (_) => LanguageCubit(prefs)),

      ],

      child: ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, __) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
              return MaterialApp(
                   navigatorKey: navigatorKey,
                      // initialBinding: Binding(),
                      debugShowCheckedModeBanner: false,
                     // translations: Translation(),
                      locale: Get.deviceLocale,
                      theme: Themes.light,
                      darkTheme: Themes.dark,
                      themeMode:themeMode,
                      localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: const [
              Locale('ar'),
              Locale('en'),
              Locale('fr')
                      ],
                  home: LoginPage(),
              
                  title: Constants.get.appName,
                  // theme: ThemeData(
                  //   primaryColor: Palette.primary,
                  //   iconTheme: const IconThemeData(color: Palette.primary),
                  //   primaryIconTheme: const IconThemeData(color: Palette.primary),
                  // )
              );
            }
          );
        },
      ),
    );
  }
}
