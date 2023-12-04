import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppService extends ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  bool _initialized = false;
  bool _onboarding = false;
  String onBoardKey = "GD2G82CG9G82VDFGVD22DVG";
  String onDarkMode = "GD2G82CG";

  AppService(this.sharedPreferences);

  bool get initialized => _initialized;
  bool get onboarding => _onboarding;

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  setDarkMode(bool value) {
    sharedPreferences.setBool(onDarkMode, value);
  }

  set onboarding(bool value) {
    sharedPreferences.setBool(onBoardKey, value);
    _onboarding = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    _onboarding = sharedPreferences.getBool(onBoardKey) ?? false;

    await Future.delayed(const Duration(milliseconds: 2250));
    _initialized = true;
    if (kDebugMode) {
      print("isInitiailized");
    }
    notifyListeners();
  }

  authNotifier() {
    subscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (kDebugMode) {
        print("Streaming User Auth Changes");
      }

      if (user != null) {
        if (kDebugMode) {
          print("User is already logged in");
        }
      } else {
        if (kDebugMode) {
          print("User has signed out");
        }
      }
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> subscription;

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
