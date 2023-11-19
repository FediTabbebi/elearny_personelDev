import 'package:elearny/provider/userProvider/user_provider.dart';
import 'package:elearny/services/firebase/fireStore/auth/authservice.dart';
import 'package:elearny/src/widgets/one_button_dialog.dart';

import 'package:elearny/utils/helper.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginProvider with ChangeNotifier {
  bool isLoading = false;
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
        context.read<UserProvider>().updateUser(value);
        context.go("/");
        isLoading = false;
        notifyListeners();
      }).onError((error, stackTrace) {
        isLoading = false;
        notifyListeners();
        showDialogMessage(context, '$error');
      });
    }
  }

  Future<void> signOutUser(BuildContext context) async {
    // isLoading = false;
    // showProgressIndicator(context);
    await authService
        .signOut()
        .onError((error, stackTrace) => showSnackBar("$error", context));
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

  Future<void> showDialogMessage(BuildContext context, String message) async {
    await showDialog<void>(
        // barrierColor: Colors.transparent,
        // barrierDismissible: !isLoading,
        context: context,
        builder: (BuildContext context) {
          return OneButtonDialogWidget(
              title: "An Error Occured",
              contents: message,
              confirmbuttonText: "Back",
              onConfirm: () {
                context.pop();
              },
              onWillPopScopeValue: true);
        });
  }
}
