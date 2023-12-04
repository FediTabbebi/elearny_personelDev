import 'package:elearny/core/providers/app_service/app_service.dart';
import 'package:elearny/core/utils/shared_preference_utils.dart';
import 'package:elearny/ui/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:elearny/locator.dart';

class ThemeProvider with ChangeNotifier {
  SharedPrefs prefs = locator<SharedPrefs>();
  AppService appService = locator<AppService>();

  late bool isDarkMode;
  ThemeProvider() {
    isDarkMode = prefs.getBool(appService.onDarkMode) ?? false;
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
