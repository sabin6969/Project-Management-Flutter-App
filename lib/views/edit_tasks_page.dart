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

class EditTaskPage extends StatefulWidget {
  final String name;
  final String description;
  final String title;
  final String docId;
  const EditTaskPage({
    super.key,
    required this.name,
    required this.description,
    required this.title,
    required this.docId,
  });

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final selectedDay = DateTime.now();
  List<String> status = ["Pending", "Completed"];

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    final dateSelectionProvider =
        Provider.of<DateSelectionProvider>(context, listen: false);
    final statusProvider = Provider.of<StatusDropDownProvider>(context);
    final userProvider = Provider.of<AssignToDynamicDropDownProvider>(context);
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit task for ${widget.name}",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.task,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              MaterialButton(
                elevation: 10,
                height: size.height * 0.07,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateSelectionProvider.selectedDate,
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
              SizedBox(
                height: 20.h,
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
                          hint: Text(value.assignedUser ?? "Asign user"),
                          items: dropdownItems,
                          onChanged: (selectedItem) {
                            value.selected(selectedItem!);
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
                maxLines: 4,
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
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
                height: 20.h,
              ),
              MaterialButton(
                  minWidth: size.width,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      15.sp,
                    ),
                  ),
                  height: size.height * 0.07,
                  color: Colors.blue,
                  onPressed: () async {
                    await AddTaskController.updateTask(
                      titleController.text,
                      userProvider.assignedUser!,
                      dateSelectionProvider.selectedDate,
                      statusProvider.defaultStatus,
                      widget.docId,
                      context,
                      descriptionController.text,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.update,
                        size: 23.sp,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Update Task",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20.h,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20.sp,
                  ),
                ),
                height: size.height * 0.07,
                color: Colors.blue,
                onPressed: () async {
                  AddTaskController.deleteTask(widget.docId, context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete,
                      size: 23.sp,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Delete Task",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    )
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
