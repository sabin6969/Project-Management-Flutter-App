import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectmanagementapp/utils/alert_dialog_with_progress_bar.dart';
import 'package:projectmanagementapp/utils/toast_message.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class AuthController {
  static signInUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    AlertDialogBox.showAlertDialogWithProgressBar(
        context: context, message: "Requesting");
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        AlertDialogBox.hideProgressBar(context: context);
        Navigator.popAndPushNamed(context, "landinghomepage");
        ToastMessage.showToastMessage("Login sucess");
      },
    ).onError(
      (error, stackTrace) {
        AlertDialogBox.hideProgressBar(context: context);
        if (error is FirebaseAuthException) {
          ToastMessage.showToastMessage(error.message.toString());
        } else {
          ToastMessage.showToastMessage("An unknown error occured");
        }
      },
    );
  }

  static createUserr(
      {required String email,
      required String password,
      required BuildContext context}) async {
    AlertDialogBox.showAlertDialogWithProgressBar(
        context: context, message: "Creating account");
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        AlertDialogBox.hideProgressBar(context: context);
        Navigator.pushReplacementNamed(context, "loginscreen");
        ToastMessage.showToastMessage("Acount created ! now you can login");
      },
    ).onError(
      (error, stackTrace) {
        AlertDialogBox.hideProgressBar(context: context);
        if (error is FirebaseAuthException) {
          ToastMessage.showToastMessage(error.message.toString());
        } else {
          ToastMessage.showToastMessage(
              "An unknown error occured ${error.toString()}");
        }
      },
    );
  }
}
