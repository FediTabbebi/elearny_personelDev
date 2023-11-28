import 'dart:io';

import 'package:elearny/model/admin_links.dart';
import 'package:elearny/services/firebase/fireStore/admin_edit_social_links/add_links.dart';
import 'package:elearny/services/firebase/storage/upload_files.dart';
import 'package:elearny/src/widgets/one_button_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_picker_web/image_picker_web.dart';

class AdminAddLinkProvider with ChangeNotifier {
  final TextEditingController facebookTextField = TextEditingController();
  final TextEditingController linkedInTextfield = TextEditingController();
  final TextEditingController whatsAppTextfield = TextEditingController();
  final TextEditingController instagramTexfield = TextEditingController();
  final TextEditingController emailTextfield = TextEditingController();
  final TextEditingController phoneNumbertextfield = TextEditingController();
  final TextEditingController youtubeTexfield = TextEditingController();
  final TextEditingController playStoreTextfield = TextEditingController();
  final TextEditingController apkTextfield = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String landingImgURL = '';
  String logoImgURL = '';
  bool isLoading = false;
  bool gettingData = false;
  Uint8List? landingImg;
  Uint8List? logoImg;
  File? landingImgMobile;
  File? logoImgMobile;
  AdminLinksModel? adminLinks;
  bool isInitialized = false;

  AdminServices adminServices = AdminServices();
  Storage storage = Storage();

  Future<void> createOrUpdateAdminLinks(
    BuildContext context,
  ) async {
    if (kIsWeb) {
      if (formKey.currentState!.validate()) {
        if ((logoImgURL.isEmpty && (logoImg == null) ||
            landingImgURL.isEmpty && (landingImg == null))) {
          showingDialog(context, "Error", "Your must pick images");
        } else {
          if (verifyChangedFields() && logoImg == null && landingImg == null) {
            showingDialog(context, "No Changes Detected",
                "Please make sure to modify at least one field before attempting to update.");
          } else {
            if (landingImg != null && logoImg == null) {
              await uploadOneImageThenSubmit(
                  context, landingImg!, 'landing image', landingImgURL, 1);
            } else if (logoImg != null && landingImg == null) {
              await uploadOneImageThenSubmit(
                  context, logoImg!, 'the team logo', logoImgURL, 2);
            } else if (logoImg == null && landingImg == null) {
              submitWithoutUpload(context);
            } else {
              uploadTwoImageThenSubmit(context);
            }
          }
        }
      }
    } else {
      if (formKey.currentState!.validate()) {
        if ((logoImgURL.isEmpty && (logoImgMobile == null) ||
            landingImgURL.isEmpty && (landingImgMobile == null))) {
          showingDialog(context, "Error", "Your must pick images");
        } else {
          if (verifyChangedFields() &&
              logoImgMobile == null &&
              landingImgMobile == null) {
            showingDialog(context, "No Changes Detected",
                "Please make sure to modify at least one field before attempting to update.");
          } else {
            if (landingImgMobile != null && logoImgMobile == null) {
              await uploadOneImageThenSubmit(
                  context,
                  landingImgMobile!.readAsBytesSync(),
                  'landing image',
                  landingImgURL,
                  1);
            } else if (logoImgMobile != null && landingImgMobile == null) {
              await uploadOneImageThenSubmit(
                  context,
                  logoImgMobile!.readAsBytesSync(),
                  'the team logo',
                  logoImgURL,
                  2);
            } else if (logoImg == null && landingImg == null) {
              submitWithoutUpload(context);
            } else {
              uploadTwoImageThenSubmit(context);
            }
          }
        }
      }
    }
  }

  Future<AdminLinksModel?> getLinks(
    BuildContext context,
  ) async {
    gettingData = true;

    notifyListeners();
    await adminServices.getData().then((value) async {
      adminLinks = value;
      settingControllers(adminLinks);
      gettingData = false;

      notifyListeners();
    }).onError((error, stackTrace) {
      gettingData = false;

      notifyListeners();
      showSnackBar('$error', context);
      gettingData = false;

      notifyListeners();
    });
    return adminLinks;
  }

  Future<void> uploadOneImageThenSubmit(BuildContext context, Uint8List image,
      String imageName, String imageURL, int whichImage) async {
    isLoading = true;
    notifyListeners();
    await storage
        .uploadImage(image, imageName, 'Admin images')
        .then((value) async {
      imageURL = value;

      await adminServices
          .createOrUpdateAdminLinks(AdminLinksModel(
              facebookLink: facebookTextField.text,
              linkedInLink: linkedInTextfield.text,
              whatsAppLink: whatsAppTextfield.text,
              instagramLink: instagramTexfield.text,
              youtubeLink: youtubeTexfield.text,
              emailLink: emailTextfield.text,
              phoneNumberLink: phoneNumbertextfield.text,
              playStoreLink: playStoreTextfield.text,
              apkLink: apkTextfield.text,
              landingImgLink:
                  whichImage == 1 ? imageURL : adminLinks!.landingImgLink,
              theTeamLogoLink:
                  whichImage == 2 ? imageURL : adminLinks!.theTeamLogoLink,
              updatedAt: DateTime.now()))
          .then((value) async {
        clearControllers();
        await getLinks(context).then((value) {
          showingDialog(context, "Success", "Your informations has been added");
          isLoading = false;
          notifyListeners();
        });
      }).onError((error, stackTrace) {
        isLoading = false;
        notifyListeners();
        showSnackBar('$error', context);
      });
    }).onError((error, stackTrace) {
      isLoading = false;
      notifyListeners();
      showSnackBar('$error', context);
    });
  }

  Future<void> uploadTwoImageThenSubmit(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await storage
        .uploadImage(landingImg!, 'landing image', 'Admin images')
        .then((value) async {
      landingImgURL = value;

      await storage
          .uploadImage(logoImg!, 'the team logo', 'Admin images')
          .then((value) async {
        logoImgURL = value;

        await adminServices
            .createOrUpdateAdminLinks(AdminLinksModel(
                facebookLink: facebookTextField.text,
                linkedInLink: linkedInTextfield.text,
                whatsAppLink: whatsAppTextfield.text,
                instagramLink: instagramTexfield.text,
                youtubeLink: youtubeTexfield.text,
                emailLink: emailTextfield.text,
                phoneNumberLink: phoneNumbertextfield.text,
                playStoreLink: playStoreTextfield.text,
                apkLink: apkTextfield.text,
                landingImgLink: landingImgURL,
                theTeamLogoLink: logoImgURL,
                updatedAt: DateTime.now()))
            .then((value) async {
          clearControllers();
          await getLinks(context).then((value) {
            showingDialog(
                context, "Success", "Your informations has been added");
            isLoading = false;
            notifyListeners();
          });
        }).onError((error, stackTrace) {
          isLoading = false;
          notifyListeners();
          showSnackBar('$error', context);
        });
      }).onError((error, stackTrace) {
        isLoading = false;
        notifyListeners();
        showSnackBar('$error', context);
      });
    }).onError((error, stackTrace) {
      isLoading = false;
      notifyListeners();
      showSnackBar('$error', context);
    });
  }

  Future<void> submitWithoutUpload(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await adminServices
        .createOrUpdateAdminLinks(AdminLinksModel(
            facebookLink: facebookTextField.text,
            linkedInLink: linkedInTextfield.text,
            whatsAppLink: whatsAppTextfield.text,
            instagramLink: instagramTexfield.text,
            youtubeLink: youtubeTexfield.text,
            emailLink: emailTextfield.text,
            phoneNumberLink: phoneNumbertextfield.text,
            playStoreLink: playStoreTextfield.text,
            apkLink: apkTextfield.text,
            landingImgLink: adminLinks!.landingImgLink,
            theTeamLogoLink: adminLinks!.theTeamLogoLink,
            updatedAt: DateTime.now()))
        .then((value) async {
      clearControllers();
      await getLinks(context).then((value) {
        showingDialog(context, "Success", "Your informations has been added");
        isLoading = false;
        notifyListeners();
      });
    }).onError((error, stackTrace) {
      isLoading = false;
      notifyListeners();
      showSnackBar('$error', context);
    });
  }

  Future<void> pickImage(int whichImg) async {
    try {
      ImagePicker imagePicker = ImagePicker();
      final file = await imagePicker.pickImage(source: ImageSource.gallery);
      // Pick an image file using file_picker package
      /*    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );*/

      // If user cancels the picker, do nothing
      if (file == null) {
        print('No image selected.');
      }

      if (!kIsWeb) {
        final imageFile = file;
        print(' image selected.');
        whichImg == 1
            ? landingImgMobile = File(imageFile!.path)
            : logoImgMobile = File(imageFile!.path);
        print(imageFile.path);
        notifyListeners();
      } else {
        Uint8List? imageFileWeb = await file?.readAsBytes();
        whichImg == 1 ? landingImg = imageFileWeb : logoImg = imageFileWeb;
        notifyListeners();
      }
    } catch (e) {
      // If there is an error, show a snackBar with the error message
    }
  }
  // Future<void> pickImage(int whichImg) async {
  //   try {
  //     Uint8List? bytesFromPicker;
  //     //= await ImagePickerWeb.getImageAsBytes();

  //     if (bytesFromPicker != null) {
  //       whichImg == 1
  //           ? landingImg = bytesFromPicker
  //           : logoImg = bytesFromPicker;
  //       notifyListeners();
  //     } else {
  //       if (kDebugMode) {
  //         print('No image selected.');
  //       }
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error occurred while picking an image: $e');
  //     }
  //   }
  // }

  bool verifyChangedFields() {
    return facebookTextField.text == adminLinks?.facebookLink &&
        linkedInTextfield.text == adminLinks?.linkedInLink &&
        whatsAppTextfield.text == adminLinks?.whatsAppLink &&
        instagramTexfield.text == adminLinks?.instagramLink &&
        emailTextfield.text == adminLinks?.emailLink &&
        phoneNumbertextfield.text == adminLinks?.phoneNumberLink &&
        youtubeTexfield.text == adminLinks?.youtubeLink &&
        playStoreTextfield.text == adminLinks?.playStoreLink &&
        apkTextfield.text == adminLinks?.apkLink;
  }

  void settingControllers(AdminLinksModel? admminLinks) {
    adminLinks = admminLinks;
    facebookTextField.text = admminLinks?.facebookLink ?? "";
    linkedInTextfield.text = admminLinks?.linkedInLink ?? "";
    whatsAppTextfield.text = admminLinks?.whatsAppLink ?? "";
    instagramTexfield.text = admminLinks?.instagramLink ?? "";
    emailTextfield.text = admminLinks?.emailLink ?? "";
    phoneNumbertextfield.text = admminLinks?.phoneNumberLink ?? "";
    youtubeTexfield.text = admminLinks?.youtubeLink ?? "";
    playStoreTextfield.text = admminLinks?.playStoreLink ?? "";
    apkTextfield.text = admminLinks?.apkLink ?? "";
    landingImgURL = admminLinks?.landingImgLink ?? "";
    logoImgURL = admminLinks?.theTeamLogoLink ?? "";
  }

  void initi() {
    isInitialized = true;
    notifyListeners();
  }

  void showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
        content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> showingDialog(
    BuildContext context,
    String title,
    String contents,
  ) async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return OneButtonDialogWidget(
              title: title,
              contents: contents,
              confirmbuttonText: 'Back',
              onConfirm: () {
                context.pop();
              },
              onWillPopScopeValue: true);
        });
  }

  void clearControllers() {
    facebookTextField.clear();
    linkedInTextfield.clear();
    whatsAppTextfield.clear();
    instagramTexfield.clear();
    emailTextfield.clear();
    phoneNumbertextfield.clear();
    youtubeTexfield.clear();
    playStoreTextfield.clear();
    apkTextfield.clear();

    landingImgURL = '';
    logoImgURL = '';

    landingImg = null;
    logoImg = null;
    landingImgMobile = null;
    logoImgMobile = null;
    adminLinks = null;
  }
}
