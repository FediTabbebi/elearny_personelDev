// splash_provider.dart
import 'dart:async';
import 'package:elearny/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  late Timer timer;

  void navigateToSignIn(BuildContext context) {
    timer = Timer(const Duration(milliseconds: 3150), () {
      if (Navigator.canPop(context)) {
        Navigator.pushReplacementNamed(context, Routes.login);
      }
      Navigator.pushReplacementNamed(context, Routes.login);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
