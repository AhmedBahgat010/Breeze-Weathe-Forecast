import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final String _key = 'isLightMode';

  // Constructor to set the initial state
  ThemeCubit() : super(CacheHelper.getData(key: 'isLightMode') ?? true ? ThemeMode.light : ThemeMode.dark);

  // Method to toggle the theme
  void toggleTheme() {
    final newThemeMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newThemeMode);
    _saveThemeToCache(newThemeMode);
  }

  // Helper method to save the theme mode to SharedPreferences
  void _saveThemeToCache(ThemeMode themeMode) {
    CacheHelper.saveData(key: _key, value: themeMode == ThemeMode.light);
  }
  
}