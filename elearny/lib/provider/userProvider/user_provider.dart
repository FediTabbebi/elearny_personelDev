import 'package:elearny/model/user.dart';
import 'package:elearny/services/firebase/fireStore/auth/authservice.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;

  AuthenticationServices auth = AuthenticationServices();

  // Future<void> streamUserAuthChanges() async {
  //   Completer<void> completer = Completer<void>();

  //   FirebaseAuth.instance.authStateChanges().listen((User? user) async {
  //     if (user != null) {
  //       userId = user.uid;
  //       print("user not null ===> user Id : ");
  //       print(userId);
  //       await auth
  //           .getCurrentUser(user.uid)
  //           .then((value) => currentUser = value);
  //     } else {
  //       userId = "";
  //       print("user == null ===> user Id : ");
  //       print(userId);
  //     }
  //     isUserIdSet = true;
  //     notifyListeners();
  //     // Signal that the operation is complete
  //     completer.complete();
  //     // AppNavigation.router.refresh();
  //   });

  //   // Return the Future to wait for the completion
  //   return completer.future;
  // }

  UserModel? getUserModel() {
    // Wait until the user ID is set before returning it
    return currentUser;
  }

  updateUser(UserModel? newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
