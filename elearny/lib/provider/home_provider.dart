import 'package:elearny/provider/userProvider/user_provider.dart';
import 'package:elearny/services/firebase/fireStore/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  final AuthenticationServices authService = AuthenticationServices();

  bool isLoading = false;
  Future<void> gettingUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await authService
        .getAuthUser()
        .then((value) => context.read<UserProvider>().updateUser(value));

    isLoading = false;
    notifyListeners();
    // .then((value) {
    //   globalUser = value;
    //   showSnackBar('success', context);
    //   isLoading = false;
    //   notifyListeners();
    // }).onError((error, stackTrace) {
    //   showSnackBar('$error', context);
    //   isLoading = true;
    //   notifyListeners();
    // });
    // notifyListeners() ;
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

  void showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
