import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectmanagementapp/controller/auth_controller.dart';
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
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 13.sp),
                        prefixIcon: Icon(
                          Icons.person,
                          size: 15.sp,
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
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                      controller: emailController,
                      validator: (value) {
                        final message = EmailValidation.validateEmail(value!);
                        return message;
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 13.sp),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          size: 15.sp,
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
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                      controller: passwordController,
                      validator: (value) {
                        final message =
                            PasswordValidation.validatePassword(value!);
                        return message;
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 13.sp),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 15.sp,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.visibility,
                              size: 15.sp,
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
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                      controller: confirmPasswordController,
                      validator: (value) {
                        final message =
                            PasswordValidation.validatePassword(value!);
                        return message;
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 13.sp),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 15.sp,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.visibility,
                              size: 15.sp,
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
                  height: 45.sp,
                  minWidth: 123.sp,
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {
                      if (passwordController.text
                              .compareTo(confirmPasswordController.text) ==
                          0) {
                        AuthController.createUserr(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context,
                        );
                      } else {
                        ToastMessage.showToastMessage(
                            "Both password must match");
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.sp),
                  ),
                  color: Colors.black,
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
