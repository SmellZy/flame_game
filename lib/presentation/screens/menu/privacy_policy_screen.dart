import 'package:flame_game/presentation/widgets/main_background_component.dart';
import 'package:flame_game/presentation/widgets/purple_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

void goBack(dynamic context) {
  Navigator.pop(context);
}

class _PrivacyScreenState extends State<PrivacyScreen> {
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
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  "PRIVACY \nPOLICY",
                                  style: TextStyle(
                                    fontFamily: "RubikMonoOne",
                                    fontSize: 75.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
