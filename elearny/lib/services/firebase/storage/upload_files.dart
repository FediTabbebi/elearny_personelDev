import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> uploadFile2(String upload, String firebaseStoragePath,
      String filePath, String fileName) async {
    String globalURLDownload = "";
    try {
      final file = io.File(filePath);
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("$firebaseStoragePath/$fileName");
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      globalURLDownload = await snapshot.ref.getDownloadURL();
    } catch (e) {
      // Handle specific exceptions and provide appropriate error messages

      if (kDebugMode) {
        print(e);
      }
    }
    if (kDebugMode) {
      print(globalURLDownload);
    }
    return globalURLDownload;
  }

  Future<String?> uploadFile(XFile? file, String firebaseStoragePath,
      String filePath, String fileName, String imageType) async {
    String downloadURL = "";
    if (file == null) {
      if (kDebugMode) {
        print("no file is selected");
      }

      return null;
    }

    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("$firebaseStoragePath/$fileName.$imageType");

    final metadata = firebase_storage.SettableMetadata(
      contentType: imageType,
      customMetadata: {'picked-file-path': file.path},
    );

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
      final firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() {});
      downloadURL = await taskSnapshot.ref.getDownloadURL();
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
      final firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() {});
      downloadURL = await taskSnapshot.ref.getDownloadURL();
    }

    return downloadURL;
  }

  Future<String> uploadImage(
      Uint8List imageData, String imageName, String imagePath) async {
    final metadata = firebase_storage.SettableMetadata(
      contentType: 'image/jpeg', // Change to the appropriate content type
    );

    final String fileName = imageName; // Change to the appropriate file name
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("$imagePath/$fileName");

    await ref.putData(imageData, metadata);

    // Retrieve the download URL
    final String downloadURL = await ref.getDownloadURL();
    print('File uploaded to Firestore. Download URL: $downloadURL');
    return downloadURL;
  }
}
