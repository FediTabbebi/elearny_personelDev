import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearny/model/user.dart' as user_model;
import 'package:firebase_auth/firebase_auth.dart';

class RegisterService {
  final auth = FirebaseAuth.instance;

  Future<void> registerUser(user_model.User user) async {
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      final User currentUser = userCredential.user!;

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
    } catch (e) {
      throw Exception(e);
    }
  }
}
