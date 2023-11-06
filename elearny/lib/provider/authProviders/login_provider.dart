import 'package:elearny/data/globales.dart';
import 'package:elearny/services/firebase/fireStore/auth/authservice.dart';

import 'package:elearny/utils/helper.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginProvider with ChangeNotifier {
  // final AuthService _authService;
  bool isLoading = false;
  String userId = "";
  final AuthenticationServices authService = AuthenticationServices();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValidateFields validate = ValidateFields();

  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      await authService
          .signInWithEmailAndPassword(email, password)
          .then((value) {
        showSnackBar('success', context);

        globalUser = value;
        isLoading = false;
        notifyListeners();
        context.goNamed("profile");
      }).onError((error, stackTrace) {
        isLoading = false;
        notifyListeners();
        // Navigator.of(context).pop();
        showSnackBar('$error', context);
      });
    }
  }

  Future<void> signOutUser(BuildContext context) async {
    // isLoading = false;
    // showProgressIndicator(context);
    await authService.signOut(context).then((value) {
      //  Navigator.of(context).pop();
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   Routes.home,
      //   (Route<dynamic> route) => false,
      // );
      context.pushReplacementNamed("login");
    }).onError((error, stackTrace) {
      // isLoading = false;
      // Navigator.of(context).pop();
      showSnackBar('$error', context);
    });
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
