import 'package:flutter/material.dart';

class DropdownValue with ChangeNotifier {
  String _value = 'Admin';

  String get value => _value;

  set value(String newValue) {
    _value = newValue;
    notifyListeners();
  }
}
