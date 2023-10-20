import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectmanagementapp/controller/auth_controller.dart';
import 'package:projectmanagementapp/provider/show_hide_password_provider.dart';
import 'package:projectmanagementapp/validations/email_validation.dart';
import 'package:projectmanagementapp/validations/password_validation.dart';
import 'package:provider/provider.dart';

class LoginScren extends StatefulWidget {
  const LoginScren({super.key});

  @override
  State<LoginScren> createState() => _LoginScrenState();
}

class _LoginScrenState extends State<LoginScren> {
  GlobalKey<FormState> globalKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("Build method called");
    final loginProvider =
        Provider.of<ShowHidePasswordProvider>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 214.2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 41.w, right: 38.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 58.66.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
              ),
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
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
                        labelText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          size: 15.sp,
                        ),
                        hintText: "company@gmail.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    TextFormField(
                      obscureText: loginProvider.isHiddenForLogin,
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
                        suffixIcon: Consumer<ShowHidePasswordProvider>(
                          builder: (context, value, child) {
                            return IconButton(
                              onPressed: () {
                                value.changeStatusForLogin();
                              },
                              icon: value.isHiddenForLogin
                                  ? const Icon(Icons.visibility)
                                  : const Icon(
                                      Icons.visibility_off,
                                    ),
                            );
                          },
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 15.sp,
                        ),
                        labelText: "Password",
                        hintText: "***********",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "New here?",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "registerpage");
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                  ],
                ),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30.sp,
                    ),
                  ),
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      AuthController.signInUser(
                          email: emailController.text.trim(),
                          password: passwordController.text,
                          context: context);
                    }
                  },
                  color: Colors.black,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
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
