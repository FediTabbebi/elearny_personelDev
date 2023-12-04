import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  String quizId;
  String quizTitle;
  String quizUrl;

  DateTime? createdAt;
  DateTime? updatedAt;

  QuizModel({
    required this.quizId,
    required this.quizTitle,
    required this.quizUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      quizId: map['quizId'] ?? '',
      quizTitle: map['quizTitle'] ?? '',
      quizUrl: map['quizUrl'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'quizId': quizId,
      'quizTitle': quizTitle,
      'quizUrl': quizUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
