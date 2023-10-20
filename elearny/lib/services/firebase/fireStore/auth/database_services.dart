import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../model/user.dart';

class DatabaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(User user) async {
    return await userCollection.doc(user.userId).set(user.toJson());
  }

  // You can add more database operations here
}
