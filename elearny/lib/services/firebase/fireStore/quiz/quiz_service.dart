import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearny/model/quiz_model.dart';

class QuizService {
  final DocumentReference docReference =
      FirebaseFirestore.instance.collection('quiz').doc();

  Future<void> createQuiz(
    QuizModel data,
  ) async {
    await docReference.set({
      'quizLink': data.quizLink,
      'quizId': docReference.id,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
    });
  }

  Future<QuizModel?> getData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance.collection('quiz').doc("quiz").get();

      if (docSnapshot.exists) {
        print("getting data");
        return QuizModel.fromMap(docSnapshot.data()!);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching data: $e");
      return null;
    }
  }
}
