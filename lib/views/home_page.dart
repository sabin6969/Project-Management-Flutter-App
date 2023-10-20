import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectmanagementapp/controller/auth_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                onTap: () {},
                title: Text(
                  "Hi, ${auth.currentUser!.email}",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "Are you ready to get back to work?",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Divider(
                thickness: 1.5,
              ),
              ListTile(
                title: Text(
                  "Top Employee",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                subtitle: Text(
                  "Hanok",
                  style: TextStyle(
                    fontSize: 38.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_outward,
                  size: 35.sp,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: Text(
                  "Completed Tasks: 122/125",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 5.h,
                ),
                child: MaterialButton(
                  elevation: 7,
                  height: size.height * 0.075,
                  minWidth: size.width,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  color: Colors.blue,
                  onPressed: () {},
                  child: Text(
                    "+ New Task ",
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "All users",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 5.sp,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.orange,
                              radius: 10.sp,
                              child: Text(
                                "0",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        MaterialButton(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              15.sp,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "adduserpage");
                          },
                          child: Text(
                            "+ Add users",
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
