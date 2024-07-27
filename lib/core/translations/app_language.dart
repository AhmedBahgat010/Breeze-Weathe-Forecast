import 'package:breeze_weather_forecast/core/translations/utils/local_storage/local_storgae.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

// LanguageCubit Class for managing language state
class LanguageCubit extends Cubit<String> {
  static const String _key = 'lang';
  final SharedPreferences prefs;
  var appLocale = 'en';

  LanguageCubit(this.prefs) : super(prefs.getString(_key) ?? 'en') {
    _setLocale(state);

  }
  @override
  void onInit() async {
    LocalStorage localStorage = LocalStorage();

    appLocale = (await localStorage.languageSelected ?? Get.deviceLocale?.languageCode)
        ?? 'en';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lang", appLocale);
    print("prefs.getString(lang) : ${prefs.getString("lang")}");
    Get.updateLocale(Locale(appLocale));
  }
  // Method to change language
  void changeLanguage(String type) async {
    LocalStorage localStorage = LocalStorage();

    if (appLocale == type) {
      return;
    }
    if (type == 'ar') {
      appLocale = 'ar';
      localStorage.saveLanguageToDisk('ar');
    } else if (type == 'en') {
      appLocale = 'en';
      localStorage.saveLanguageToDisk('en');
    } else {
      appLocale = 'fr';
      localStorage.saveLanguageToDisk('fr');
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lang", appLocale);
  }

  // Method to update the app locale
  void _setLocale(String languageCode) {
    Get.updateLocale(Locale(languageCode));
  }
}