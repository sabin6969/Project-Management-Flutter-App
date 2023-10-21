import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectmanagementapp/controller/auth_controller.dart';
import 'package:projectmanagementapp/utils/alert_dialog_with_progress_bar.dart';
import 'package:projectmanagementapp/utils/toast_message.dart';

FirebaseFirestore dbInstance = FirebaseFirestore.instance;

class AddTaskController {
  static addTask(String name, String date, String description, String status,
      String taskTitle, BuildContext context) async {
    AlertDialogBox.showAlertDialogWithProgressBar(
        context: context, message: "Assigning task to $name");
    await dbInstance
        .collection(auth.currentUser!.uid)
        .doc("tasks")
        .collection("assignedTasks")
        .doc()
        .set(
      {
        "name": name,
        "taskTitle": taskTitle,
        "deuDate": date,
        "description": description,
        "status": status,
      },
    ).then((value) {
      AlertDialogBox.hideProgressBar(context: context);
      ToastMessage.showToastMessage("Task sucessfully assigned to $name");
    }).onError((error, stackTrace) {
      AlertDialogBox.hideProgressBar(context: context);
      ToastMessage.showToastMessage("An error occured try again");
    });
  }
}
