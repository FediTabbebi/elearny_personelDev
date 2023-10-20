import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  final auth = FirebaseAuth.instance;

  Future<User?> loginUser(String email, String password) async {
    // Try to sign in the user with Firebase Auth.
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Return the current user.
      return userCredential.user!;
    } catch (e) {
      // Handle the error.
      print(e);
      return null;
    }
  }
}
