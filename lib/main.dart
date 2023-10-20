import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectmanagementapp/provider/designation_list_provider.dart';
import 'package:projectmanagementapp/provider/employee_image_provider.dart';
import 'package:projectmanagementapp/provider/show_hide_password_provider.dart';
import 'package:projectmanagementapp/views/add_user_page.dart';
import 'package:projectmanagementapp/views/get_started_page.dart';
import 'package:projectmanagementapp/views/home_page.dart';
import 'package:projectmanagementapp/views/landing_home_page.dart';
import 'package:projectmanagementapp/views/login_screen.dart';
import 'package:projectmanagementapp/views/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShowHidePasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DesignationListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EmployeeImageProvider(),
        ),
      ],
      child: ScreenUtilInit(
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
              "landinghomepage": (context) => const LandingHomePage(),
              "mainhomepage": (context) => const MyHomePage(),
              "adduserpage": (context) => const AddUserPage(),
            },
          );
        },
      ),
    );
  }
}
