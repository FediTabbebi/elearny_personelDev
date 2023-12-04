import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearny/model/user_model.dart';
import 'package:flutter/foundation.dart';

class AdminEditUserService {
  Future<List<UserModel>> getUsers() async {
    List<UserModel> usersList = [];
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        usersList.add(UserModel.fromMap(data));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting users: $e');
      }
    }
    return usersList;
  }

  Stream<List<UserModel>> getUsersStream() {
    StreamController<List<UserModel>> controller =
        StreamController<List<UserModel>>();

    FirebaseFirestore.instance.collection('users').snapshots().listen(
        (querySnapshot) {
      List<UserModel> usersList = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        usersList.add(UserModel.fromMap(data));
      }
      controller.add(usersList);
    }, onError: (error) {
      // Handle any errors here
      if (kDebugMode) {
        print('Error getting users: $error');
      }
    });

    return controller.stream;
  }

  Future<List<UserModel>> getUsers2() async {
    List<UserModel> usersList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      usersList.add(UserModel.fromMap(data));
    }

    if (kDebugMode) {
      print(usersList[0].email);
    }
    return usersList;
  }
}
