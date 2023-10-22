import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String firstName;
  String lastName;
  String email;
  String address;
  String phoneNumber;
  String profilePicture;
  String bio;
  String company;
  String role;
  DateTime birthDate;
  String password;
  List<String>? trainingList;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  bool isDeleted;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.profilePicture,
    required this.bio,
    required this.company,
    required this.role,
    required this.birthDate,
    required this.password,
    required this.trainingList,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      bio: json['bio'] ?? '',
      company: json['company'] ?? '',
      role: json['role'] ?? '',
      birthDate: (json['birthDate'] as Timestamp).toDate(),
      password: json['password'] ?? '',
      trainingList: (json['trainingList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      userId: json['userId'] ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
      isDeleted: json['isDeleted'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'address': address,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'bio': bio,
      'company': company,
      'role': role,
      'birthDate': birthDate,
      'password': password,
      'trainingList': trainingList,
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isDeleted': isDeleted,
    };
  }
}
