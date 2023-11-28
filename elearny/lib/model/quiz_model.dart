import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  String quizLink;
  String quizId;
  DateTime? createdAt;
  DateTime? updatedAt;

  QuizModel({
    required this.quizLink,
    required this.quizId,
    this.createdAt,
    this.updatedAt,
  });

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      quizLink: map['quizLink'] ?? '',
      quizId: map['quizId'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'quizLink': quizLink,
      'quizId': quizId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
