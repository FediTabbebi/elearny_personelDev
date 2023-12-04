import 'dart:async';
import 'package:elearny/core/providers/userProvider/user_provider.dart';
import 'package:elearny/core/routes/app_routes.dart';
import 'package:elearny/core/services/firestore/auth/auth_service.dart';
import 'package:elearny/core/utils/shared_preference_utils.dart';
import 'package:elearny/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

enum AuthState {
  initialize,
  onboarded,
  authenticated,
  unAuthenticated,
}

enum UserType {
  anonymous,
  admin,
  contentCreator,
  client,
}

class AppService extends ChangeNotifier {
  static final AuthenticationServices getUser = AuthenticationServices();

  SharedPrefs prefs = locator<SharedPrefs>();

  AuthState authState = AuthState.initialize;
  bool _initialized = false;
  bool _onboarding = false;
  String onBoardKey = "GD2G82CG9G82VDFGVD22DVG";
  String onDarkMode = "GD2G82CG";

  // AppService() {
  //   authNotifier();
  // }
  bool get initialized => _initialized;
  bool get onboarding => _onboarding;

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  setDarkMode(bool value) {
    prefs.setBool(onDarkMode, value);
  }

  set onboarding(bool value) {
    prefs.setBool(onBoardKey, value);
    _onboarding = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    _onboarding = prefs.getBool(onBoardKey) ?? false;

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

  FutureOr<String?> redirectionHandler(
      BuildContext context, GoRouterState state) async {
    final User? user = await FirebaseAuth.instance.authStateChanges().first;

    final loginLocation = state.namedLocation(AppPage.login.toName);
    final homeLocation = state.namedLocation(AppPage.home.toName);
    final splashLocation = state.namedLocation(AppPage.splash.toName);
    final onboardLocation = state.namedLocation(AppPage.onBoarding.toName);
    final registerLocation = state.namedLocation(AppPage.register.toName);

    final isLogedIn = user != null;

    final isInitialized = initialized;
    final isOnboarded = onboarding;

    final isGoingToInit = state.matchedLocation == splashLocation;
    final isGoingToLogin = state.matchedLocation == loginLocation;

    final isGoingToOnboard = state.matchedLocation == onboardLocation;
    final isGoingToRegister = state.matchedLocation == registerLocation;

    if (!kIsWeb) {
      // If not Initialized and not going to Initialized redirect to Splash
      if (!isInitialized && !isGoingToInit) {
        return splashLocation;
      }
      // If not onboard and not going to onboard redirect to OnBoarding
      else if (isInitialized && !isOnboarded && !isGoingToOnboard) {
        return onboardLocation;
      }
      // If not logedin and not going to login redirect to Login
      else if (isInitialized && isOnboarded && !isLogedIn && !isGoingToLogin) {
        if (isGoingToRegister) {
          return registerLocation;
        }
        return loginLocation;
      }
      // If all the scenarios are cleared but still going to any of that screen redirect to Home
      else if ((isLogedIn && isGoingToLogin) ||
          (isInitialized && isGoingToInit) ||
          (isOnboarded && isGoingToOnboard)) {
        await getUser
            .getCurrentUser(user!.uid)
            .then((value) => context.read<UserProvider>().updateUser(value));
        return homeLocation;
      } else {
        // Else Don't do anything
        return null;
      }
    } else {
      if (isLogedIn) {
        await getUser
            .getCurrentUser(user.uid)
            .then((value) => context.read<UserProvider>().updateUser(value));

        if (isGoingToLogin) {
          return homeLocation;
        }
        return null;
      } else if (isGoingToRegister) {
        return registerLocation;
      }
      return loginLocation;
    }
  }
}
