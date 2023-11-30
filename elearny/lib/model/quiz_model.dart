import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  String quizId;
  String quizTitle;
  String quizLink;

  DateTime? createdAt;
  DateTime? updatedAt;

  QuizModel({
    required this.quizId,
    required this.quizTitle,
    required this.quizLink,
    this.createdAt,
    this.updatedAt,
  });

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      quizId: map['quizId'] ?? '',
      quizTitle: map['quizTitle'] ?? '',
      quizLink: map['quizLink'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'quizId': quizId,
      'quizTitle': quizTitle,
      'quizLink': quizLink,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
