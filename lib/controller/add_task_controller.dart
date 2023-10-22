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
    }).onError(
      (error, stackTrace) {
        AlertDialogBox.hideProgressBar(context: context);
        ToastMessage.showToastMessage("An error occured try again");
      },
    );
  }

  static updateTask(
      String taskTitle,
      String name,
      String deuDate,
      String status,
      String docId,
      BuildContext context,
      String description) async {
    AlertDialogBox.showAlertDialogWithProgressBar(
        context: context, message: "Updating task");
    await dbInstance
        .collection(auth.currentUser!.uid)
        .doc("tasks")
        .collection("assignedTasks")
        .doc(docId)
        .update(
      {
        "name": name,
        "taskTitle": taskTitle,
        "deuDate": deuDate,
        "description": description,
        "status": status,
      },
    ).then((value) {
      AlertDialogBox.hideProgressBar(context: context);
      ToastMessage.showToastMessage("Task sucessfully updated");
      Navigator.of(context).pop();
    }).onError(
      (error, stackTrace) {
        AlertDialogBox.hideProgressBar(context: context);
        ToastMessage.showToastMessage("An error occured try again");
      },
    );
  }

  static deleteTask(String docId, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("Do you want to really delete this task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                dbInstance
                    .collection(auth.currentUser!.uid)
                    .doc("tasks")
                    .collection("assignedTasks")
                    .doc(docId)
                    .delete();
                Navigator.pushReplacementNamed(context, "landinghomepage");
                ToastMessage.showToastMessage("Task Deleted");
              },
              child: const Text("Yes"),
            )
          ],
        );
      },
    );
  }
}
