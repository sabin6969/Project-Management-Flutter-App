import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectmanagementapp/controller/auth_controller.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final dataStream = FirebaseFirestore.instance
      .collection(auth.currentUser!.uid)
      .doc("tasks")
      .collection("assignedTasks")
      .where("status", isEqualTo: "Pending")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              Text(
                "Pending Tasks",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    14.sp,
                  ),
                ),
                color: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "addtaskpage");
                },
                child: Text(
                  "+ Add Task",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              )
            ],
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
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("An Error occured"),
                  );
                } else {
                  final requiredData = snapshot.data!.docs;
                  if (requiredData.isEmpty) {
                    return const Center(
                      child: Text("No tasks to show"),
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
                              height: size.height * 0.35,
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
                                    children: [
                                      const Icon(
                                        Icons.hourglass_bottom,
                                      ),
                                      Text(
                                        "Pending",
                                        style: TextStyle(
                                          fontSize: 16.sp,
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
