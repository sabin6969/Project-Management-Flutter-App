import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectmanagementapp/controller/auth_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dataStream =
      FirebaseFirestore.instance.collection(auth.currentUser!.uid).snapshots();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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
                    15,
                  ),
                ),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pushNamed(context, "addtaskpage");
                },
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
                      Text(
                        "All users",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
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
            ),
            SizedBox(
              height: 20.h,
            ),
            StreamBuilder(
              stream: dataStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No user record found"),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("An error occured"),
                  );
                } else {
                  int noOfUsers = snapshot.data!.docs.length;
                  if (noOfUsers == 0) {
                    return Center(
                      child: Text(
                        "No user record found !",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: SizedBox(
                              height: size.height * 0.3,
                              width: size.width,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          height: size.height * 0.15,
                                          width: size.width * 0.3,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 0.5,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                snapshot.data!.docs[index]
                                                    ["imageURL"],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            // color: Colors.black,
                                            borderRadius: BorderRadius.circular(
                                              30.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]["name"],
                                            style: TextStyle(
                                              fontSize: 22.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]["email"],
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                ["designation"],
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.blue,
                                            ),
                                            textAlign: TextAlign.left,
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
