import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearny/data/globales.dart';
import 'package:elearny/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

// abstract class AuthBase {
//   Stream<UserModel?> get onAuthStateChanged;
//   Future<UserModel?> currentUser();
//   Future<UserModel?> signInWithEmailAndPassword(String email, String password);
//   Future<UserModel?> createUserWithEmailAndPassword(
//       String email, String password);
//   Future<void> signOut();
// }

class AuthenticationServices {
  final _firebaseAuth = auth.FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // <#1>
  // Future<UserModel?> _userFromFirebase(auth.User? user) async {
  //   if (user == null) {
  //     return null;
  //   }
  //   try {
  //     DocumentSnapshot userSnapshot =
  //         await firestore.collection('users').doc(user.uid).get();
  //     if (userSnapshot.exists) {
  //       Map<String, dynamic> userData =
  //           userSnapshot.data() as Map<String, dynamic>;
  //       // globalUser= UserModel.fromMap(userData);
  //       return UserModel.fromMap(userData);
  //     } else {
  //       throw Exception('User not found');
  //     }
  //   } catch (e) {
  //     throw Exception('Error retrieving user: $e');
  //   }
  // }

  // #2
  Stream<UserModel?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().asyncMap((user) async {
      return await getCurrentUser(user!.uid);
    });
  }

  Future<UserModel?> getCurrentUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDocument.exists) {
      //  globalUser = UserModel.fromMap(userDocument.data()!);
      return UserModel.fromMap(userDocument.data()!);
    }
    return null;
  }

  Future<UserModel?> getAuthUser() async {
    auth.User? firebaseUser = auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      UserModel? user = await getCurrentUser(firebaseUser.uid)
          .then((value) => globalUser = value);
      return user;
    } else {
      return null;
    }
  }

// #3
  // Future<UserModel?> currentUser() async {
  //   try {
  //     // final user = _firebaseAuth.currentUser;
  //     return await _userFromFirebase(_firebaseAuth.currentUser);
  //   } catch (e) {
  //     throw Exception('Error getting current user: $e');
  //   }
  // }

// #4
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return await getCurrentUser(authResult.user!.uid);
  }

// #5
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

  Future<void> updateUser(UserModel user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(globalUser!.userId)
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
      'userId': globalUser!.userId,
      'createdAt': user.createdAt,
      'updatedAt': DateTime.now(),
      'isDeleted': false,
    });
  }

// #6
  Future<void> signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
    // Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   '/login',
    //   (Route<dynamic> route) => false,
    // );
  }
}
