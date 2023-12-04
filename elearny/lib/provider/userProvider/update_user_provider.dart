import 'dart:io';
import 'package:elearny/model/user_model.dart';
import 'package:elearny/provider/userProvider/user_provider.dart';
import 'package:elearny/services/firebase/fireStore/auth/auth_service.dart';
import 'package:elearny/src/widgets/shared_widget/one_button_dialog_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../services/firebase/storage/upload_files.dart';

class UpdateUserProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  DateTime? birthday;

  bool isLoading = false;
  String imageURL = '';
  Uint8List? imageData;
  File? imageDataMobile;
  Storage storage = Storage();
  AuthenticationServices authService = AuthenticationServices();

  updateProfile(BuildContext context) async {
    if (kIsWeb) {
      if (formKey.currentState!.validate()) {
        if (verifyFields(context) && imageData == null) {
          showingDialog(context, "No Changes Detected",
              "Please make sure to modify at least one field before attempting to update.");
        } else {
          if (imageData != null) {
            await updateUserAndUploadImage(context, imageData!);
          } else {
            updateUserwithoutUploadingImg(context);
          }
        }
      }
    } else {
      if (formKey.currentState!.validate()) {
        if (verifyFields(context) && imageDataMobile == null) {
          showingDialog(context, "No Changes Detected",
              "Please make sure to modify at least one field before attempting to update.");
        } else {
          if (imageDataMobile != null) {
            await updateUserAndUploadImage(
                context, imageDataMobile!.readAsBytesSync());
          } else {
            updateUserwithoutUploadingImg(context);
          }
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
            profilePicture:
                context.read<UserProvider>().currentUser!.profilePicture,
            bio: bioController.text,
            company: context.read<UserProvider>().currentUser!.company,
            role: context.read<UserProvider>().currentUser!.role,
            birthDate: DateTime.parse(birthdayController.text),
            password: context.read<UserProvider>().currentUser!.password,
            trainingList:
                context.read<UserProvider>().currentUser!.trainingList,
            userId: context.read<UserProvider>().currentUser!.userId,
            createdAt: context.read<UserProvider>().currentUser!.createdAt,
            updatedAt: DateTime.now(),
            isDeleted: context.read<UserProvider>().currentUser!.isDeleted))
        .then((value) async {
      await authService.getAuthUser().then((value) async {
        clearControllers();
        context.read<UserProvider>().updateUser(value);
        settingControllers(context);
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

  Future<void> updateUserAndUploadImage(
      BuildContext context, Uint8List imageData) async {
    isLoading = true;
    notifyListeners();
    await storage
        .uploadImage(
            imageData,
            '${context.read<UserProvider>().currentUser!.phoneNumber}-${context.read<UserProvider>().currentUser!.userId}',
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
              company: context.read<UserProvider>().currentUser!.company,
              role: context.read<UserProvider>().currentUser!.role,
              birthDate: DateTime.parse(birthdayController.text),
              password: context.read<UserProvider>().currentUser!.password,
              trainingList:
                  context.read<UserProvider>().currentUser!.trainingList,
              userId: context.read<UserProvider>().currentUser!.userId,
              createdAt: context.read<UserProvider>().currentUser!.createdAt,
              updatedAt: DateTime.now(),
              isDeleted: context.read<UserProvider>().currentUser!.isDeleted))
          .then((value) async {
        await authService.getAuthUser().then((value) {
          clearControllers();
          context.read<UserProvider>().updateUser(value);
          settingControllers(context);
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
      ImagePicker imagePicker = ImagePicker();
      final file = await imagePicker.pickImage(source: ImageSource.gallery);

      // If user cancels the picker, do nothing
      if (file == null) {
        if (kDebugMode) {
          print('No image selected.');
        }
      }

      if (!kIsWeb) {
        final imageFile = file;
        if (kDebugMode) {
          print(' image selected.');
        }
        imageDataMobile = File(imageFile!.path);

        if (kDebugMode) {
          print(imageFile.path);
        }
        notifyListeners();
      } else {
        imageData = await file?.readAsBytes();

        notifyListeners();
      }
    } catch (e) {
      // If there is an error, show a snackBar with the error message
    }
  }

  void removeImg() {
    imageData = null;
    imageDataMobile = null;
    notifyListeners();
  }

  bool verifyFields(BuildContext context) {
    return firstNameController.text ==
            context.read<UserProvider>().currentUser!.firstName &&
        lastNameController.text ==
            context.read<UserProvider>().currentUser!.lastName &&
        emailController.text ==
            context.read<UserProvider>().currentUser!.email &&
        phoneNumberController.text ==
            context.read<UserProvider>().currentUser!.phoneNumber &&
        bioController.text == context.read<UserProvider>().currentUser!.bio &&
        addressController.text ==
            context.read<UserProvider>().currentUser!.address &&
        birthdayController.text ==
            "${context.read<UserProvider>().currentUser!.birthDate.toLocal()}"
                .split(' ')[0];
  }

  void settingControllers(BuildContext context) {
    firstNameController.text =
        context.read<UserProvider>().currentUser?.firstName ?? "";
    lastNameController.text =
        context.read<UserProvider>().currentUser?.lastName ?? "";
    emailController.text =
        context.read<UserProvider>().currentUser?.email ?? "";
    phoneNumberController.text =
        context.read<UserProvider>().currentUser?.phoneNumber ?? "";
    bioController.text = context.read<UserProvider>().currentUser?.bio ?? "";
    addressController.text =
        context.read<UserProvider>().currentUser?.address ?? "";
    birthday = context.read<UserProvider>().currentUser?.birthDate;
    birthdayController.text =
        "${context.read<UserProvider>().currentUser!.birthDate.toLocal()}"
            .split(' ')[0];
    imageURL = context.read<UserProvider>().currentUser?.profilePicture ?? "";
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
    imageDataMobile = null;
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
          );
        });
  }
}
