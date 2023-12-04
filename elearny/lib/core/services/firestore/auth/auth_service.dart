import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearny/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthenticationServices {
  final _firebaseAuth = auth.FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // #1 login
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return await getCurrentUser(authResult.user!.uid);
  }

  // #2 register
  Future<void> registerUser(UserModel user) async {
    final auth.UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );

    final auth.User currentUser = userCredential.user!;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .set({
      'firstName': user.firstName,
      'lastName': user.lastName,
      'email': user.email,
      'address': user.address,
      'phoneNumber': user.phoneNumber,
      'profilePicture': user.profilePicture,
      'bio': user.bio,
      'company': user.company,
      'role': user.role,
      'birthDate': Timestamp.now(),
      'trainigList': user.trainingList,
      'userId': currentUser.uid,
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
      'isDeleted': false,
    });
  }

  // #3 get particular user by id
  Future<UserModel?> getCurrentUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDocument.exists) {
      return UserModel.fromMap(userDocument.data()!);
    }
    return null;
  }

  // #4 get current authenticated user (no id needed)
  Future<UserModel?> getAuthUser() async {
    auth.User? firebaseUser = auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      UserModel? user = await getCurrentUser(firebaseUser.uid);
      return user;
    } else {
      return null;
    }
  }

// #5 update user
  Future<void> updateUser(UserModel user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.userId)
        .update({
      'firstName': user.firstName,
      'lastName': user.lastName,
      'email': user.email,
      'address': user.address,
      'phoneNumber': user.phoneNumber,
      'profilePicture': user.profilePicture,
      'bio': user.bio,
      'company': user.company,
      'role': user.role,
      'birthDate': user.birthDate,
      'trainigList': user.trainingList,
      'userId': user.userId,
      'createdAt': user.createdAt,
      'updatedAt': DateTime.now(),
      'isDeleted': false,
    });
  }

// #6 signout user
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }
}
