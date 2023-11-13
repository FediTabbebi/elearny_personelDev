import 'package:elearny/data/globales.dart';
import 'package:elearny/model/user.dart';
import 'package:elearny/services/firebase/fireStore/auth/authservice.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:elearny/src/widgets/one_button_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../../services/firebase/storage/upload_files.dart';

class UpdateUserProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  final TextEditingController firstNameController =
      TextEditingController(text: globalUser!.firstName);
  final TextEditingController lastNameController =
      TextEditingController(text: globalUser!.lastName);
  final TextEditingController emailController =
      TextEditingController(text: globalUser!.email);
  final TextEditingController phoneNumberController =
      TextEditingController(text: globalUser!.phoneNumber);
  final TextEditingController bioController =
      TextEditingController(text: globalUser!.bio);
  final TextEditingController addressController =
      TextEditingController(text: globalUser!.address);
  final TextEditingController birthdayController = TextEditingController(
      text: "${globalUser!.birthDate.toLocal()}".split(' ')[0]);
  DateTime? birthday;

  bool isLoading = false;
  String imageURL = '';
  Uint8List? imageData;
  Storage storage = Storage();
  AuthenticationServices authService = AuthenticationServices();

  updateProfile(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (verifyFields() && imageData == null) {
        showingDialog(context, "No Changes Detected",
            "Please make sure to modify at least one field before attempting to update.");
      } else {
        if (imageData != null) {
          await updateUserandUploadImage(
            context,
          );
        } else {
          updateUserwithoutUploadingImg(context);
        }
      }
    }
  }

  Future<void> updateUserwithoutUploadingImg(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await authService
        .updateUser(UserModel(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            address: addressController.text,
            phoneNumber: phoneNumberController.text,
            profilePicture: globalUser!.profilePicture,
            bio: bioController.text,
            company: globalUser!.company,
            role: globalUser!.role,
            birthDate: DateTime.parse(birthdayController.text),
            password: globalUser!.password,
            trainingList: globalUser!.trainingList,
            userId: globalUser!.userId,
            createdAt: globalUser!.createdAt,
            updatedAt: DateTime.now(),
            isDeleted: globalUser!.isDeleted))
        .then((value) async {
      await authService.getAuthUser().then((value) async {
        clearControllers();
        globalUser = value;
        settingControllers();
        isLoading = false;
        notifyListeners();
        showingDialog(context, 'Success', 'Your profile has been updated');
      });
    }).onError((error, stackTrace) {
      isLoading = false;
      notifyListeners();
      showingDialog(context, 'Error', 'An error has occur');
    });
  }

  Future<void> updateUserandUploadImage(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await storage
        .uploadImage(
            imageData!,
            '${globalUser!.phoneNumber}-${globalUser!.userId}',
            'Profile Images')
        .then((value) async {
      imageURL = value;
      await authService
          .updateUser(UserModel(
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              email: emailController.text,
              address: addressController.text,
              phoneNumber: phoneNumberController.text,
              profilePicture: imageURL,
              bio: bioController.text,
              company: globalUser!.company,
              role: globalUser!.role,
              birthDate: DateTime.parse(birthdayController.text),
              password: globalUser!.password,
              trainingList: globalUser!.trainingList,
              userId: globalUser!.userId,
              createdAt: globalUser!.createdAt,
              updatedAt: DateTime.now(),
              isDeleted: globalUser!.isDeleted))
          .then((value) async {
        await authService.getAuthUser().then((value) {
          clearControllers();
          globalUser = value;
          settingControllers();
          isLoading = false;
          notifyListeners();
          showingDialog(context, 'Success', 'Your profile has been updated');
        });
      }).onError((error, stackTrace) {
        isLoading = false;
        notifyListeners();
        showingDialog(context, 'Error', 'An error has occur');
      });
    });
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      birthdayController.text = "${selectedDate.toLocal()}".split(' ')[0];
      birthday = selectedDate;
      notifyListeners();
    }
  }

  void showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> pickImage() async {
    try {
      Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();

      if (bytesFromPicker != null) {
        imageData = bytesFromPicker;
        notifyListeners();
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred while picking an image: $e');
      }
    }
  }

  void removeImg() {
    imageData = null;
    notifyListeners();
  }

  bool verifyFields() {
    return firstNameController.text == globalUser!.firstName &&
        lastNameController.text == globalUser!.lastName &&
        emailController.text == globalUser!.email &&
        phoneNumberController.text == globalUser!.phoneNumber &&
        bioController.text == globalUser!.bio &&
        addressController.text == globalUser!.address &&
        birthdayController.text ==
            "${globalUser!.birthDate.toLocal()}".split(' ')[0];
  }

  void settingControllers() {
    firstNameController.text = globalUser?.firstName ?? "";
    lastNameController.text = globalUser?.lastName ?? "";
    emailController.text = globalUser?.email ?? "";
    phoneNumberController.text = globalUser?.phoneNumber ?? "";
    bioController.text = globalUser?.bio ?? "";
    addressController.text = globalUser?.address ?? "";
    birthday = globalUser?.birthDate;
    birthdayController.text =
        "${globalUser!.birthDate.toLocal()}".split(' ')[0];
    imageURL = globalUser?.profilePicture ?? "";
  }

  void clearControllers() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneNumberController.clear();

    bioController.clear();
    addressController.clear();
    birthday = null;
    birthdayController.clear();
    imageURL = "";
    imageData = null;
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
                Navigator.pop(context);
              },
              onWillPopScopeValue: false);
        });
  }
}
