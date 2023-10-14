import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectmanagementapp/validations/email_validation.dart';
import 'package:projectmanagementapp/validations/password_validation.dart';

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
                      controller: emailController,
                      validator: (value) {
                        final message = EmailValidation.validateEmail(value!);
                        return message;
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          size: 20.h,
                        ),
                        hintText: "company@gmail.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        final message =
                            PasswordValidation.validatePassword(value!);
                        return message;
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.visibility,
                            )),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 15.sp,
                        ),
                        labelText: "Password",
                        hintText: "***********",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            13.sp,
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
                    if (globalKey.currentState!.validate()) {}
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
