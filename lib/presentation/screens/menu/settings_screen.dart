import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/presentation/bloc/user/user_bloc.dart';
import 'package:flame_game/presentation/widgets/main_background_component.dart';
import 'package:flame_game/presentation/widgets/purple_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User? _currentUser;
  bool soundStatus = false;
  bool notifiStatus = false;
  bool vibroStatus = false;
  
  bool _isInitialLoad = true; 

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goBack(dynamic context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        User? user;
        if (state is UserLoaded) {
          user = state.user;
          _currentUser = user;

          if (_isInitialLoad) {
            soundStatus = user.sound ?? false;
            notifiStatus = user.notifications ?? false;
            vibroStatus = user.vibration ?? false;
            _isInitialLoad = false;
          }
        }

        return Scaffold(
          body: MainBackgroundComponent(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(40.w),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(height: 200.h),
                    PurpleContainer(
                      height: 720.h,
                      width: 1045.w,
                      child: Padding(
                        padding: EdgeInsets.only(right: 100.w, left: 100.w, top: 50.h, bottom: 50.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Settings",
                              style: TextStyle(
                                fontFamily: "RubikMonoOne",
                                fontSize: 75.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 135.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "SOUND",
                                  style: TextStyle(
                                    fontFamily: "RubikMonoOne",
                                    fontSize: 45.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                FlutterSwitch(
                                  width: 120.w,
                                  height: 60.h,
                                  toggleSize: 40.h,
                                  activeColor: Color(0xFF1BC431),
                                  value: soundStatus, 
                                  onToggle: (val) {
                                    setState(() {
                                      soundStatus = val;
                                    });
                                  })
                              ],
                            ),

                            SizedBox(
                              height: 60.h,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "NOTIFICATIONS",
                                  style: TextStyle(
                                    fontFamily: "RubikMonoOne",
                                    fontSize: 45.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                FlutterSwitch(
                                  width: 120.w,
                                  height: 60.h,
                                  toggleSize: 40.h,
                                  activeColor: Color(0xFF1BC431),
                                  value: notifiStatus, 
                                  onToggle: (val) {
                                    setState(() {
                                      notifiStatus = val;
                                    });
                                  })
                              ],
                            ),

                            SizedBox(
                              height: 60.h,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "VIBRATION",
                                  style: TextStyle(
                                    fontFamily: "RubikMonoOne",
                                    fontSize: 45.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                FlutterSwitch(
                                  width: 120.w,
                                  height: 60.h,
                                  toggleSize: 40.h,
                                  activeColor: Color(0xFF1BC431),
                                  value: vibroStatus, 
                                  onToggle: (val) {
                                    setState(() {
                                      vibroStatus = val;
                                    });
                                  })
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_currentUser == null) return;
                        final updatedUser = _currentUser!.copyWith(
                          sound: soundStatus, 
                          notifications: notifiStatus,
                          vibration: vibroStatus,
                        );

                        context.read<UserBloc>().add(
                          UpdateUserEvent(user: updatedUser),
                        );
                        
                        goBack(context);
                      },
                      icon: Image.asset(
                        "assets/images/save_button.png",
                        width: 688.w,
                        height: 347.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}