import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectmanagementapp/utils/toast_message.dart';
import 'package:projectmanagementapp/validations/email_validation.dart';
import 'package:projectmanagementapp/validations/password_validation.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 168.1.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 25.w,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 52.h,
            ),
            Form(
              key: _globalKey,
              child: Padding(
                padding: EdgeInsets.only(left: 25.w, right: 25.w),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                        ),
                        labelStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        labelText: "Enter your name",
                        hintText: "Smith",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        final message = EmailValidation.validateEmail(value!);
                        return message;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                        ),
                        hintText: "company@gmail.com",
                        labelText: "Enter email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        final message =
                            PasswordValidation.validatePassword(value!);
                        return message;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.visibility,
                            )),
                        labelText: "Enter your password",
                        hintText: "**********",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) {
                        final message =
                            PasswordValidation.validatePassword(value!);
                        return message;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.visibility,
                            )),
                        labelText: "Enter your confirm password",
                        hintText: "**********",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 38.w),
              child: Row(
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 25.w,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: MaterialButton(
                  onPressed: () {
                    if (_globalKey.currentState!.validate() &&
                        passwordController.text
                                .compareTo(confirmPasswordController.text) ==
                            0) {
                    } else {
                      // handel password didnot matched logic
                      ToastMessage.showToastMessage("Password didnot matched");
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.sp),
                  ),
                  color: Colors.black,
                  padding: EdgeInsets.only(
                      left: 31.sp, right: 32.sp, top: 12, bottom: 18.sp),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                      color: Colors.white,
                    ),
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
