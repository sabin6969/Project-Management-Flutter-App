import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectmanagementapp/views/about_page.dart';
import 'package:projectmanagementapp/views/home_page.dart';
import 'package:projectmanagementapp/views/notification_page.dart';
import 'package:projectmanagementapp/views/task_page.dart';

class LandingHomePage extends StatefulWidget {
  const LandingHomePage({super.key});

  @override
  State<LandingHomePage> createState() => _LandingHomePageState();
}

class _LandingHomePageState extends State<LandingHomePage> {
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: pageController,
        physics: const ScrollPhysics(
          parent: NeverScrollableScrollPhysics(),
        ),
        children: const [
          MyHomePage(),
          TaskPage(),
          NotificationPage(),
          AboutPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24.sp,
        currentIndex: currentIndex,
        onTap: (value) {
          pageController.jumpToPage(value);
          currentIndex = value;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.home,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.check_box_outlined,
              ),
              label: ""),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_none_outlined,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
            ),
            label: "",
          )
        ],
      ),
    );
  }
}
