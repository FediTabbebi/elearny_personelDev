import 'package:elearny/model/user_model.dart';
import 'package:elearny/services/firebase/fireStore/admin_edit_users/admin_edit_users.dart';
import 'package:flutter/material.dart';

class AdminEditUsersProvider with ChangeNotifier {
  AdminEditUserService adminEditUserService = AdminEditUserService();
  List<UserModel> allUsers = [];
  bool isInitialized = false;

  Future<void> getAllUsers(BuildContext context) async {
    await adminEditUserService.getUsers2().then((value) async {
      allUsers = value;
      notifyListeners();
    }).onError((error, stackTrace) {
      showSnackBar('$error', context);

      notifyListeners();
    });
    // return allUsers;
  }

  void showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
        content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void initi() {
    isInitialized = !isInitialized;
    notifyListeners();
  }
}
