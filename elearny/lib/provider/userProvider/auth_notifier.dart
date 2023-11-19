import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  AuthNotifier() {
    subscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print("Streaming User Auth Changes");

      if (user != null) {
        print("User is already logged in");
      } else {
        print("User has signed out");
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
