import 'package:elearny/data/globales.dart';
import 'package:elearny/routes/app_routes.dart';
import 'package:elearny/services/firebase/fireStore/auth/login_services.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  // final AuthService _authService;
  bool isLoading = false;
  String userId = "";
  final LoginService loginService = LoginService();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    // Add more complex email validation if necessary
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    // Add more complex password validation if needed
    return null;
  }

  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      showProgressIndicator(context);
      await loginService.loginUser(email, password).then((value) async {
        userId = value!.uid;
      }).onError((error, stackTrace) {
        isLoading = false;
        Navigator.of(context).pop();
        showSnackBar('$error', context);
      });

      if (userId.isNotEmpty) {
        isLoading = true;
        await loginService.getUserById(userId).then((value) async {
          currentUser = value;
          showSnackBar('success', context);
          Navigator.of(context).pop();
          Navigator.pushReplacementNamed(context, Routes.home);
        }).onError((error, stackTrace) {
          isLoading = false;
          Navigator.of(context).pop();
          showSnackBar('$error', context);
        });
      }
    }
  }

  void showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> showProgressIndicator(BuildContext context) async {
    await showDialog<void>(
        barrierColor: Colors.transparent,
        barrierDismissible: !isLoading,
        context: context,
        builder: (BuildContext context) {
          return const Center(
            child: SizedBox(
                height: 50, width: 50, child: CircularProgressIndicator()),
          );
        });
  }
}
