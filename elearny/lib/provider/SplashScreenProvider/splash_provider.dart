// splash_provider.dart
import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  // late Timer timer;

  // Future<void> navigateToSignIn(BuildContext context) async {
  //   timer = Timer(const Duration(milliseconds: 3150), () async {
  //     if (deviceType == 2 || deviceType == 3) {
  //       Navigator.pushReplacementNamed(context, Routes.onboarding);
  //     } else {
  //       Navigator.pushReplacementNamed(context, Routes.login);
  //     }
  //   });
  //   //  user = context.watch<FirebaseAuthMethods>().user;

  //   // if (user != null) {
  //   //   Navigator.pushReplacementNamed(context, Routes.home);
  //   // } else {
  //   //   if (deviceType == 2 || deviceType == 3) {
  //   //     Navigator.pushReplacementNamed(context, Routes.onboarding);
  //   //   } else {
  //   //     Navigator.pushReplacementNamed(context, Routes.login);
  //   //   }
  //   // }
  // }

  // void showSnackBar(String message, BuildContext context) {
  //   final snackBar = SnackBar(content: Text(message));
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  // // Future<void> showProgressIndicator(BuildContext context) async {
  // //   await showDialog<void>(
  // //       barrierColor: Colors.transparent,
  // //       barrierDismissible: !isLoading,
  // //       context: context,
  // //       builder: (BuildContext context) {
  // //         return const Center(
  // //           child: SizedBox(
  // //               height: 50, width: 50, child: CircularProgressIndicator()),
  // //         );
  // //       });
  // // }

  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }
}
