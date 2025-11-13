import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/presentation/bloc/user/user_bloc.dart';
import 'package:flame_game/presentation/widgets/main_background_component.dart';
import 'package:flame_game/presentation/widgets/menu_button.dart';
import 'package:flame_game/presentation/widgets/purple_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

void goBack(dynamic context) {
  Navigator.pop(context);
}

class _MenuScreenState extends State<MenuScreen> {
  void clearPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        User? user;
        if (state is UserLoaded) {
          user = state.user;
          debugPrint(user.points.toString());
        }
        final int displayCoins = user?.coins ?? 0;
        return Scaffold(
          body: MainBackgroundComponent(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(40.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        GestureDetector(
                          onTap: () {
                            shomModalShop(context);
                          },
                          child: Stack(
                            alignment: AlignmentGeometry.centerRight,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 90.w),
                                child: Container(
                                  width: 205.w,
                                  height: 75.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFF8E03),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 60.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          user?.coins.toString() ??
                                              displayCoins.toString(),
                                          style: TextStyle(
                                            overflow: TextOverflow.clip,
                                            fontFamily: "RubikMonoOne",
                                            fontSize: 30.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20.w),
                                child: Image.asset(
                                  "assets/images/coin_logo.png",
                                  width: 140.w,
                                  height: 140.h,
                                ),
                              ),
                            ],
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "MENU",
                              style: TextStyle(
                                fontFamily: "RubikMonoOne",
                                fontSize: 75.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 30.h),
                            MenuButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/profile");
                              },
                              imagePath: "assets/images/profile.png",
                            ),
                            MenuButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/settings");
                              },
                              imagePath: "assets/images/settings.png",
                            ),
                            MenuButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/leaderboard");
                              },
                              imagePath: "assets/images/leaderboard.png",
                            ),
                            MenuButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/privacy");
                              },
                              imagePath: "assets/images/policy.png",
                            ),
                            MenuButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/terms");
                              },
                              imagePath: "assets/images/terms.png",
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
      },
    );
  }
}

Future shomModalShop(context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (sheetContext, sheetSetState) {
          return Container(
            height: 900.h,
            decoration: BoxDecoration(
              color: const Color.fromARGB(133, 158, 158, 158),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: Column(
                  children: [
                    Text("SHOP"),
                    GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 42.w,
                        mainAxisSpacing: 87.h,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        final eggPath =
                            "assets/images/eggs/egg${index + 1}.png";
                    
                        // final bool isSelected = eggPath == _selectedEgg;
                    
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 195, 146, 218),
                                
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: IconButton(
                            onPressed: () {
                    
                              sheetSetState(() {});
                    
                              Navigator.pop(context);
                            },
                            icon: Image.asset(eggPath, width: 80.w, height: 80.h),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
