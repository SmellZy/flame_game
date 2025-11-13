import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const ProfileTextField({super.key, required this.controller, required this.hintText});

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 610.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 108, 216),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 450.w,
            height: 80.h,
            child: TextField(
              controller: widget.controller,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "RubikMonoOne",
                fontSize: 45.sp,
              ),
              decoration: InputDecoration(
                filled: false,
                hintText: widget.hintText,
                focusColor: Colors.white,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: "RubikMonoOne",
                  fontSize: 45.sp,
                ),
              ),
            ),
          ),
          Icon(Icons.edit, size: 36.w, color: Colors.white),
        ],
      ),
    );
  }
}
