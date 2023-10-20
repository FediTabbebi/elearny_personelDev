import 'package:elearny/model/user.dart';
import 'package:elearny/routes/app_routes.dart';
import 'package:elearny/services/firebase/fireStore/auth/register_service.dart';

import 'package:flutter/material.dart';

class RegisterProvider with ChangeNotifier {
  // final AuthService _authService;
  bool isLoading = false;
  final RegisterService registerService = RegisterService();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateFirstName(String value) {
    if (value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? validateLastName(String value) {
    if (value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

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

  Future<void> registerUser(User user, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      showProgressIndicator(context);
      await registerService.registerUser(user).then((value) {
        showSnackBar('success', context);
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, Routes.login);
      }).onError((error, stackTrace) {
        isLoading = false;
        Navigator.of(context).pop();
        showSnackBar('$error', context);
      });
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
