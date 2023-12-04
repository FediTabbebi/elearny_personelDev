import 'package:elearny/core/models/user_model.dart';
import 'package:elearny/core/services/firestore/auth/auth_service.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;

  AuthenticationServices auth = AuthenticationServices();

  UserModel? getUserModel() {
    return currentUser;
  }

  updateUser(UserModel? newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
