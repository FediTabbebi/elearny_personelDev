import 'package:elearny/services/app_service/app_service.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  late final AppService appService;
  late final SharedPreferences sharedPreferences;
  ThemeProvider({required this.appService, required this.sharedPreferences});

  bool isDarkMode = false;
  initSystemMode() {
    isDarkMode = sharedPreferences.getBool(appService.onDarkMode) ?? false;
  }

  ThemeData getThemeData() {
    return isDarkMode ? Themes.dark : Themes.light;
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    appService.setDarkMode(isDarkMode);
    notifyListeners();
  }
}
