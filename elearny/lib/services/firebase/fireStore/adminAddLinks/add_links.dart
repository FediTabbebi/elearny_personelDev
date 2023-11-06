import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearny/model/admin_links.dart';

class AdminServices {
  final DocumentReference docReference =
      FirebaseFirestore.instance.collection('SocialLinks').doc('SocialLinks');

  Future<void> createOrUpdateAdminLinks(
    AdminLinksModel data,
  ) async {
    final docSnapshot = await docReference.get();
    if (docSnapshot.exists) {
      await docReference.update({
        'facebookLink': data.facebookLink,
        'linkedInLink': data.linkedInLink,
        'whatsAppLink': data.whatsAppLink,
        'instagramLink': data.instagramLink,
        'youtubeLink': data.youtubeLink,
        'emailLink': data.emailLink,
        'phoneNumberLink': data.phoneNumberLink,
        'playStoreLink': data.playStoreLink,
        'apkLink': data.apkLink,
        'theTeamLogoLink': data.theTeamLogoLink,
        'landingImgLink': data.landingImgLink,
        'updatedAt': data.updatedAt,
      });
    } else {
      await docReference.set({
        'facebookLink': data.facebookLink,
        'linkedInLink': data.linkedInLink,
        'whatsAppLink': data.whatsAppLink,
        'instagramLink': data.instagramLink,
        'youtubeLink': data.youtubeLink,
        'emailLink': data.emailLink,
        'phoneNumberLink': data.phoneNumberLink,
        'playStoreLink': data.playStoreLink,
        'apkLink': data.apkLink,
        'theTeamLogoLink': data.theTeamLogoLink,
        'landingImgLink': data.landingImgLink,
        'createdAt': DateTime.now(),
        'updatedAt': data.updatedAt,
      });
    }
  }

  Future<AdminLinksModel?> getData() async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await FirebaseFirestore
        .instance
        .collection('SocialLinks')
        .doc("SocialLinks")
        .get();

    if (docSnapshot.exists) {
      return AdminLinksModel.fromMap(docSnapshot.data()!);
    } else {
      return null;
    }
  }
}
