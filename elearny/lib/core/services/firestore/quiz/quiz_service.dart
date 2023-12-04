import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearny/core/models/quiz_model.dart';
import 'package:flutter/foundation.dart';

class QuizService {
  Future<void> createQuiz(
    QuizModel data,
  ) async {
    final DocumentReference docReference =
        FirebaseFirestore.instance.collection('quiz').doc(
              data.quizId == '' ? null : data.quizId,
            );
    await docReference.set({
      'quizId': data.quizId == '' ? docReference.id : data.quizId,
      'quizTitle': data.quizTitle,
      'quizUrl': data.quizUrl,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
    });
  }

  Stream<List<QuizModel>> getAllData() {
    StreamController<List<QuizModel>> controller =
        StreamController<List<QuizModel>>();

    FirebaseFirestore.instance.collection('quiz').snapshots().listen(
        (querySnapshot) {
      List<QuizModel> quizlist = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        quizlist.add(QuizModel.fromMap(data));
      }
      controller.add(quizlist);
    }, onError: (error) {
      // Handle any errors here
      if (kDebugMode) {
        print('Error getting quiz list: $error');
      }
    });

    return controller.stream;
  }

  Future<void> deleteQuizDocument(String quizId) async {
    await FirebaseFirestore.instance.collection('quiz').doc(quizId).delete();
  }
}
