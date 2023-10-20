import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectmanagementapp/controller/auth_controller.dart';
import 'package:projectmanagementapp/utils/alert_dialog_with_progress_bar.dart';
import 'package:projectmanagementapp/utils/toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  TextEditingController emailController = TextEditingController();
  XFile? imageFilePath;
  ImagePicker picker = ImagePicker();

  SharedPreferences? preferences;
  @override
  void initState() {
    super.initState();
    emailController.text = auth.currentUser!.email!;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 24.sp,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "My Profile",
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageFilePath == null
                ? CircleAvatar(
                    radius: 58.sp,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            child: CircleAvatar(
                              radius: 18.sp,
                              backgroundColor: Colors.white70,
                              child: IconButton(
                                onPressed: () async {
                                  imageFilePath = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (imageFilePath == null) {
                                    ToastMessage.showToastMessage(
                                        "Task Failed");
                                  } else {
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(
                                  CupertinoIcons.camera,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : CircleAvatar(
                    radius: 58.sp,
                    backgroundImage: FileImage(
                      File(imageFilePath!.path),
                    ),
                  ),
            SizedBox(
              height: 51.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                enabled: false,
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    CupertinoIcons.mail,
                    color: Colors.black,
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        width: 1.sp,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(
                        10.sp,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
              ),
              child: MaterialButton(
                minWidth: double.infinity,
                height: size.height * 0.065,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10.sp,
                  ),
                ),
                onPressed: () {
                  AlertDialogBox.askForLogoutDialog(context);
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
