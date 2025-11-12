import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.onPressed,
    required this.imagePath
  });

  final void onPressed;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(0),
    onPressed: () {
      onPressed;
    },
    icon: Image.asset(
      imagePath,
      width: 350.w,
      height: 182.h,
    ),
                          );
  }
}