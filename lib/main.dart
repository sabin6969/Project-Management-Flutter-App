import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectmanagementapp/views/get_started_page.dart';
import 'package:projectmanagementapp/views/login_screen.dart';
import 'package:projectmanagementapp/views/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(360, 800),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Project Management App",
          theme: ThemeData(
            brightness: Brightness.light,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          initialRoute: "getstartedpage",
          routes: {
            "getstartedpage": (context) => const GetStartedPage(),
            "loginscreen": (context) => const LoginScren(),
            "registerpage": (context) => const RegisterPage(),
          },
        );
      },
    );
  }
}
