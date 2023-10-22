import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearny/model/user.dart' as user_model;
import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  final auth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

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
      return null;
    }
  }

  Future<user_model.User?> getUserById(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await _userCollection.doc(userId).get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        return user_model.User.fromJson(userData);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
