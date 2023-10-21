import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectmanagementapp/controller/add_task_controller.dart';
import 'package:projectmanagementapp/controller/auth_controller.dart';
import 'package:projectmanagementapp/provider/assign_to_dynamic_dropdown_provider.dart';
import 'package:projectmanagementapp/provider/date_selection_provider.dart';
import 'package:projectmanagementapp/provider/status_drop_down_provider.dart';
import 'package:projectmanagementapp/utils/toast_message.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final selectedDay = DateTime.now();
  List<String> status = ["Pending", "Completed"];
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dateSelectionProvider =
        Provider.of<DateSelectionProvider>(context, listen: false);
    final userProvider = Provider.of<AssignToDynamicDropDownProvider>(context);
    final statusProvider = Provider.of<StatusDropDownProvider>(context);
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 28.sp,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Add Task",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                TextFormField(
                  controller: taskTitleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.task_sharp,
                    ),
                    hintText: "Task Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                MaterialButton(
                  elevation: 10,
                  height: size.height * 0.06,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.sp,
                    ),
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: selectedDay,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 4),
                    ).then((value) {
                      dateSelectionProvider
                          .onSelectedNextDay(value.toString().substring(0, 10));
                      ToastMessage.showToastMessage(
                          "${value.toString().substring(0, 10)} selected");
                    }).onError(
                      (error, stackTrace) {
                        ToastMessage.showToastMessage("Date is not picked");
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Select Date",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Icon(
                        Icons.date_range,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(auth.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Hang on Loading");
                    } else if (snapshot.hasError) {
                      return const Text("An error occurred");
                    } else {
                      final users = snapshot.data!.docs.toList();
                      List<DropdownMenuItem> dropdownItems = [];
                      for (var user in users) {
                        dropdownItems.add(
                          DropdownMenuItem(
                            value: user["name"],
                            child: Text(user["name"]),
                          ),
                        );
                      }
                      return Consumer<AssignToDynamicDropDownProvider>(
                        builder: (context, value, child) {
                          return DropdownButton(
                            isExpanded: true,
                            hint: const Text("Assign to"),
                            items: dropdownItems,
                            onChanged: (selectedItem) {
                              value.selected(selectedItem!);
                              ToastMessage.showToastMessage(
                                "$selectedItem is assigned for this task",
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    } else {
                      return null;
                    }
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Descibe task description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Select Status",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Consumer<StatusDropDownProvider>(
                  builder: (context, value, child) {
                    return DropdownButton(
                      hint: Text(
                        value.defaultStatus,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                      isExpanded: true,
                      items: status.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (selectedValue) {
                        value.changeStatus(selectedValue!);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                MaterialButton(
                  elevation: 7,
                  minWidth: size.width,
                  height: size.height * 0.07,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                    10.sp,
                  )),
                  color: Colors.blue,
                  onPressed: () async {
                    if (globalKey.currentState!.validate()) {
                      await AddTaskController.addTask(
                        userProvider.assignedUser!,
                        dateSelectionProvider.selectedDate,
                        descriptionController.text.trim(),
                        statusProvider.defaultStatus,
                        taskTitleController.text.trim(),
                        context,
                      );
                    }
                    taskTitleController.clear();
                    descriptionController.clear();
                  },
                  child: Text(
                    "Assign Task",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
