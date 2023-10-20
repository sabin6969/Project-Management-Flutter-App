import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectmanagementapp/views/login_screen.dart';

class AlertDialogBox {
  static showAlertDialogWithProgressBar(
      {required BuildContext context, required String message}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              SizedBox(
                width: 30.w,
              ),
              Text(message),
            ],
          ),
        );
      },
    );
  }

  static hideProgressBar({required BuildContext context}) {
    Navigator.of(context).pop();
  }

  static askForLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10.sp,
              ),
            ),
            title: Text(
              "Do you really want to logout?",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScren(),
                        ),
                        (route) => false);
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  )),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "No",
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              )
            ],
          );
        });
  }
}
