import 'package:elearny/src/theme/themes.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkMode = false;

  ThemeData getThemeData() {
    return isDarkMode ? Themes.dark : Themes.light;
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
