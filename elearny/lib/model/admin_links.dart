import 'package:cloud_firestore/cloud_firestore.dart';

class AdminLinksModel {
  String facebookLink,
      linkedInLink,
      whatsAppLink,
      instagramLink,
      youtubeLink,
      emailLink,
      phoneNumberLink,
      playStoreLink,
      apkLink,
      landingImgLink,
      theTeamLogoLink;
  DateTime? createdAt;
  DateTime? updatedAt;

  AdminLinksModel({
    required this.facebookLink,
    required this.linkedInLink,
    required this.whatsAppLink,
    required this.instagramLink,
    required this.youtubeLink,
    required this.emailLink,
    required this.phoneNumberLink,
    required this.playStoreLink,
    required this.apkLink,
    required this.landingImgLink,
    required this.theTeamLogoLink,
    this.createdAt,
    this.updatedAt,
  });

  factory AdminLinksModel.fromMap(Map<String, dynamic> map) {
    return AdminLinksModel(
      facebookLink: map['facebookLink'] ?? '',
      linkedInLink: map['linkedInLink'] ?? '',
      whatsAppLink: map['whatsAppLink'] ?? '',
      instagramLink: map['instagramLink'] ?? '',
      youtubeLink: map['youtubeLink'] ?? '',
      emailLink: map['emailLink'] ?? '',
      phoneNumberLink: map['phoneNumberLink'] ?? '',
      playStoreLink: map['playStoreLink'] ?? '',
      apkLink: map['apkLink'] ?? '',
      landingImgLink: map['landingImgLink'] ?? '',
      theTeamLogoLink: map['theTeamLogoLink'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'facebookLink': facebookLink,
      'linkedInLink': linkedInLink,
      'whatsAppLink': whatsAppLink,
      'instagramLink': instagramLink,
      'youtubeLink': youtubeLink,
      'emailLink': emailLink,
      'phoneNumberLink': phoneNumberLink,
      'playStoreLink': playStoreLink,
      'apkLink': apkLink,
      'theTeamLogoLink': theTeamLogoLink,
      'landingImgLink': landingImgLink,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
