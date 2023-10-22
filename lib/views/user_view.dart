import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectmanagementapp/controller/auth_controller.dart';
import 'package:projectmanagementapp/views/edit_tasks_page.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _TaskPageState();
}

class _TaskPageState extends State<UserView> {
  final dataStream = FirebaseFirestore.instance
      .collection(auth.currentUser!.uid)
      .doc("tasks")
      .collection("assignedTasks")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit tasks",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
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
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("An Error occured"),
                  );
                } else {
                  final requiredData = snapshot.data!.docs;
                  if (requiredData.isEmpty) {
                    return Center(
                      child: Text(
                        "No tasks to show",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  } else {
                    return Flexible(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(
                                    13.sp,
                                  )),
                              height: size.height * 0.4,
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.task),
                                      Flexible(
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              ["taskTitle"],
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.description),
                                      Flexible(
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              ["description"],
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.date_range),
                                      Text(
                                        snapshot.data!.docs[index]["deuDate"],
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.person),
                                      Flexible(
                                        child: Text(
                                          snapshot.data!.docs[index]["name"],
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.hourglass_bottom,
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                ["status"],
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        color: Colors.black,
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditTaskPage(
                                                name: snapshot.data!.docs[index]
                                                    ["name"],
                                                description: snapshot.data!
                                                    .docs[index]["description"],
                                                title: snapshot.data!
                                                    .docs[index]["taskTitle"],
                                                docId: snapshot
                                                    .data!.docs[index].id,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "+ Edit Task",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.white),
                                        ),
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
              })
        ],
      )),
    );
  }
}
