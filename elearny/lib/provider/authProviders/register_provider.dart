import 'package:elearny/model/user.dart';
import 'package:elearny/routes/app_routes.dart';
import 'package:elearny/services/firebase/fireStore/auth/authservice.dart';
import 'package:elearny/utils/helper.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterProvider with ChangeNotifier {
  // final AuthService _authService;
  bool isLoading = false;
  final AuthenticationServices authService = AuthenticationServices();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> registerUser(UserModel user, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      await authService.registerUser(user).then((value) {
        showSnackBar('success', context);

        isLoading = false;
        notifyListeners();

        context.pushNamed(AppPage.login.toName);
      }).onError((error, stackTrace) {
        isLoading = false;
        notifyListeners();
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
