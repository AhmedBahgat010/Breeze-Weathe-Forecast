import 'package:breeze_weather_forecast/core/resources/palette.dart';
import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData(
    primaryColor: lightThemeDarkBackgroundColor,
    //accentColor: lightThemeDarkBackgroundColor,
    //canvasColor: lightThemeForegroundColor,
    dividerColor: lightThemeForegroundColor,
    scaffoldBackgroundColor: lightThemeLightBackgroundColor,
    appBarTheme: AppBarTheme(
        color: lightThemeDarkBackgroundColor,
        foregroundColor: lightThemeForegroundColor),
    brightness: Brightness.light,
    cardColor: lightThemeLightBackgroundColor,
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      fillColor: MaterialStateProperty.all(green),
      overlayColor: MaterialStateProperty.all(Colors.white),
    ),
    fontFamily: 'Bahij',
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: redAccent,
      foregroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: lightThemeForegroundColor),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: lightThemeDarkBackgroundColor,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected) ? green : null),
      trackColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected) ? green : null),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected) ? green : null),
    ),
  );
  static final dark = ThemeData(
    primaryColor: darkThemeDarkBackgroundColor,
    // accentColor: darkThemeDarkBackgroundColor,
    //canvasColor: darkThemeForegroundColor,
    dividerColor: darkThemeForegroundColor,
    scaffoldBackgroundColor: darkThemeLightBackgroundColor,
    appBarTheme: AppBarTheme(
        color: darkThemeDarkBackgroundColor,
        foregroundColor: darkThemeForegroundColor),
    brightness: Brightness.dark,
    cardColor: darkThemeLightBackgroundColor,
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      fillColor: MaterialStateProperty.all(green),
      overlayColor: MaterialStateProperty.all(Colors.white),
    ),
    fontFamily: 'Bahij',
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: floatingActionButtonColor,
        foregroundColor: Colors.white),
    iconTheme: IconThemeData(color: darkThemeForegroundColor),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: darkThemeDarkBackgroundColor,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected) ? green : null),
      trackColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected) ? green : null),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected) ? green : null),
    ),
  );
}
