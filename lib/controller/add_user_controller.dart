import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectmanagementapp/controller/auth_controller.dart';
import 'package:projectmanagementapp/utils/toast_message.dart';
import 'package:projectmanagementapp/utils/alert_dialog_with_progress_bar.dart';

FirebaseFirestore dbInstance = FirebaseFirestore.instance;
final storageInstance = FirebaseStorage.instance;

class AddUserController {
  static String? imageURL;

  static addUser(String name, String password, String designation, String email,
      XFile imageFile, BuildContext context) async {
    AlertDialogBox.showAlertDialogWithProgressBar(
        context: context, message: "Loading");
    final stroageRefrence = storageInstance.ref().child("images/$name/image");
    final uploadTask = stroageRefrence.putFile(File(imageFile.path));
    await Future.value(uploadTask);
    imageURL = await stroageRefrence.getDownloadURL();
    dbInstance.collection(auth.currentUser!.uid).doc("$name'sdetails").set({
      "name": name,
      "email": email,
      "designation": designation,
      "imageURL": imageURL,
    }).then((value) {
      AlertDialogBox.hideProgressBar(context: context);
      ToastMessage.showToastMessage("Employee details added!");
    }).onError((error, stackTrace) {
      AlertDialogBox.hideProgressBar(context: context);
      ToastMessage.showToastMessage(
          "An error occured while adding user try again!!");
    });
  }
}
