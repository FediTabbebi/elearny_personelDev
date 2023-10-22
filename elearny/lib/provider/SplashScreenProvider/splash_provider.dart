// splash_provider.dart
import 'dart:async';
import 'package:elearny/data/globales.dart';
import 'package:elearny/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  late Timer timer;

  void navigateToSignIn(BuildContext context) {
    timer = Timer(const Duration(milliseconds: 3150), () {
      // if (Navigator.canPop(context)) {
      //   Navigator.pushReplacementNamed(context, Routes.login);
      // }
      if (deviceType == 2 || deviceType == 3) {
        Navigator.pushReplacementNamed(context, Routes.onboarding);
      } else {
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
