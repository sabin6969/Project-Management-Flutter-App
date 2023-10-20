import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectmanagementapp/provider/designation_list_provider.dart';
import 'package:projectmanagementapp/provider/employee_image_provider.dart';
import 'package:projectmanagementapp/utils/toast_message.dart';
import 'package:projectmanagementapp/validations/email_validation.dart';
import 'package:projectmanagementapp/validations/password_validation.dart';
import 'package:provider/provider.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  List<String> desgination = [
    "Junior Developer",
    "Senior Developer",
    "Intern",
    "AI Engineer",
    "Full Stack Engineeer",
    "Flutter Developer",
    "React Developer",
  ];
  String? defaultValue;
  @override
  void initState() {
    super.initState();
    defaultValue = desgination.first;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  ImagePicker imagePicker = ImagePicker();
  XFile? employeeImageFilePath;

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<EmployeeImageProvider>(context);
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
            size: 20.sp,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Add user",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    } else {
                      return null;
                    }
                  },
                  textCapitalization: TextCapitalization.words,
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                    ),
                    hintText: "Enter Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        8.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Consumer<DesignationListProvider>(
                  builder: (context, value, child) {
                    return DropdownButton(
                      value: value.defaultDesignaiton,
                      hint: Text(value.defaultDesignaiton),
                      isExpanded: true,
                      items: desgination.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (selectedValue) {
                        value.whenChanged(selectedValue);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  validator: (value) {
                    final message = EmailValidation.validateEmail(value!);
                    return message;
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_rounded),
                    hintText: "Enter email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        8.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  validator: (value) {
                    final message = PasswordValidation.validatePassword(value!);
                    return message;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    prefixIcon: const Icon(
                      Icons.lock,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        8.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                MaterialButton(
                  height: size.height * 0.07,
                  minWidth: size.width,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                    10.sp,
                  )),
                  onPressed: () async {
                    employeeImageFilePath = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 100,
                    );
                    if (employeeImageFilePath != null) {
                      ToastMessage.showToastMessage("Image Selected !!");
                      imageProvider.imageSelected(employeeImageFilePath);
                    } else {
                      ToastMessage.showToastMessage("Task Terminated !!");
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        "Select Image",
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                MaterialButton(
                  height: size.height * 0.07,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                    8.sp,
                  )),
                  color: Colors.blue,
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      if (imageProvider.imagePath == null) {
                        ToastMessage.showToastMessage(
                            "Please select image and add user");
                      } else {
                        //handle data adding to database here
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        "Add user",
                        style: TextStyle(fontSize: 15.sp, color: Colors.white),
                      ),
                    ],
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
