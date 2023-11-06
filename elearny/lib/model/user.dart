import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
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

  UserModel({
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

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      bio: map['bio'] ?? '',
      company: map['company'] ?? '',
      role: map['role'] ?? '',
      birthDate: (map['birthDate'] as Timestamp).toDate(),
      password: map['password'] ?? '',
      trainingList: (map['trainingList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      userId: map['userId'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      isDeleted: map['isDeleted'] ?? false,
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
