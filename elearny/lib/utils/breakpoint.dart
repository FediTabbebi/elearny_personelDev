import 'package:flutter/material.dart';

class Breakpoints {
  static const double desktop = 1024.0;
  static const double tablet = 600.0;
  static const double smartphone = 0.0;

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktop;
  }

  static bool isTablet(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= tablet && screenWidth < desktop;
  }

  static bool isSmartphone(BuildContext context) {
    return MediaQuery.of(context).size.width < tablet;
  }
}
