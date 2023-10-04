import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(234, 247, 252, 0.95),
            Color.fromRGBO(242, 243, 229, 0.95),
            Color.fromRGBO(242, 243, 229, 0.95),
          ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 119.h,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 19.w, right: 22.w),
                  child: SizedBox(
                    height: 305.h,
                    width: 319.w,
                    child: Image.asset(
                      "asset/images/getstartedimage.png",
                      fit: BoxFit.contain,
                    ),
                  )),
              SizedBox(
                height: 68.h,
              ),
              Text(
                "  Management of a project will be easier if it is done well",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 31.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 46.h,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 105.w, right: 105.w, bottom: 90.h),
                child: MaterialButton(
                  minWidth: 150.w,
                  height: 54.h,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.w),
                  ),
                  color: const Color.fromRGBO(24, 24, 24, 1),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "loginscreen");
                  },
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
