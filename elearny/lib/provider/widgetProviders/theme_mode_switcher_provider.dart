import 'package:flutter/cupertino.dart';

class ThemeModeSwitcherProvider with ChangeNotifier {
  bool positive = false;

  void chnageState(bool b) {
    positive = b;
    notifyListeners();
  }
}
