import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedProgressBar extends StatefulWidget {
  const AnimatedProgressBar({super.key});

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation =
        Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          )
          ..addListener(() {
            setState(() {
              progress = _animation.value;
            });
          });
          

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 907.w,
      height: 117.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.orange.shade200, width: 2.w),
      ),
      child: Stack(
        children: [
          // Градієнтна заливка
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 907.w * progress,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 42, 0),
                  Color.fromARGB(255, 255, 230, 0),
                ],
              ),
              borderRadius: BorderRadius.circular(25.r),
            ),
          ),
          // Відсоток текстом
          Center(
            child: Text(
              "${(progress * 100).round()}%",
              style: TextStyle(
                fontFamily: "RubikMonoOne",
                fontSize: 75.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(blurRadius: 2.r, color: Colors.black38)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
