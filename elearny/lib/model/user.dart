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
  Timestamp birthDate;
  String password;
  List<String>? trainigList;
  String userId;
  Timestamp createdAt;
  Timestamp updatedAt;
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
    required this.trainigList,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      bio: json['bio'],
      company: json['company'],
      role: json['role'],
      birthDate: Timestamp.fromDate(json['birthDate']),
      password: json['password'],
      trainigList: json['trainigList'].cast<String>(),
      createdAt: Timestamp.fromDate(json['createdAt']),
      updatedAt: Timestamp.fromDate(json['updatedAt']),
      isDeleted: json['isDeleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
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
      'trainigList': trainigList,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isDeleted': isDeleted,
    };
  }
}
