import 'package:flame_game/presentation/widgets/main_background_component.dart';
import 'package:flame_game/presentation/widgets/purple_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HowToPlayScreen extends StatefulWidget {
  const HowToPlayScreen({super.key});

  @override
  State<HowToPlayScreen> createState() => _HowToPlayScreenState();
}

void goBack(dynamic context) {
  Navigator.pop(context);
}

class _HowToPlayScreenState extends State<HowToPlayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainBackgroundComponent(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(40.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        goBack(context);
                      },
                      icon: Image.asset(
                        "assets/images/back.png",
                        width: 205.w,
                        height: 205.h,
                      ),
                    ),
                  ],
                ),
                PurpleContainer(
                  width: 935.w,
                  height: 1360.h,
                  child: Padding(
                    padding: EdgeInsets.all(70.w),
                    child: Column(
                      children: [
                        Text(
                          "HOW TO PLAY",
                          style: TextStyle(
                            fontFamily: "RubikMonoOne",
                            fontSize: 75.sp,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "TEXT",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "RubikMonoOne",
                                fontSize: 25.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
