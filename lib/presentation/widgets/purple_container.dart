import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurpleContainer extends StatelessWidget {
  const PurpleContainer({
    super.key,
    required this.height,
    required this.width,
    required this.child
  });

  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color.fromARGB(204, 122, 2, 90),
        borderRadius: BorderRadius.circular(20.r),
        border: BoxBorder.all(width: 5.w, color: Color(0xFFFF6CD8))
      ),
      child: child,
    );
  }
}