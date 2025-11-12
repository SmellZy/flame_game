import 'package:flame_game/domain/entities/level.dart';
import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/presentation/bloc/level/level_bloc.dart';
import 'package:flame_game/presentation/bloc/user/user_bloc.dart';
import 'package:flame_game/presentation/widgets/level_tiles.dart';
import 'package:flame_game/presentation/widgets/main_background_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

void goBack(dynamic context) {
  Navigator.pop(context);
}

class _PlayScreenState extends State<PlayScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
    context.read<LevelBloc>().add(GetAllLevelsEvent());
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
          debugPrint(user.username);
          debugPrint(user.coins.toString());
        }
        final int displayCoins = user?.coins ?? 0;
        return Scaffold(
          body: MainBackgroundComponent(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsetsGeometry.all(40.w),
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
                            if (user == null) return;
                            final int newCoins = displayCoins + 1;
                            final User updatedUser = user.copyWith(
                              coins: newCoins,
                            );

                            context.read<UserBloc>().add(
                              UpdateUserEvent(user: updatedUser),
                            );
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
                    Text(
                      "CHANGE LEVEL",
                      style: TextStyle(
                        fontFamily: "RubikMonoOne",
                        fontSize: 75.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 210.h,
                    ),
                    
                    Expanded(
                      child: BlocBuilder<LevelBloc, LevelState>(
                        builder: (context, levelState) {
                          if (levelState is LevelsLoading || levelState is LevelInitial) {
                            return const Center(child: CircularProgressIndicator(color: Colors.white));
                          }
                          
                          if (levelState is LevelError) {
                            return Center(
                              child: Text(
                                "Error loading levels: ${levelState.message}",
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          
                          List<Level> levels = [];
                          if (levelState is LevelsLoaded) {
                            levels = levelState.levels;
                          } else {
                            return const Center(
                              child: Text(
                                "Waiting for level data...",
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }

                          if (levels.isEmpty) {
                            return const Center(
                              child: Text(
                                "No levels defined!",
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }

                          // Display the levels in a grid
                          return GridView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.0,
                              crossAxisSpacing: 42.w,
                              mainAxisSpacing: 87.h,
                            ),
                            itemCount: levels.length,
                            itemBuilder: (context, index) {
                              final int levelNumber = index + 1; 

                              return buildLevelTile(
                                levelNumber: levelNumber,
                                currentLevel: user?.currentLevel ?? 0,
                                context: context,
                              );
                            },
                          );
                        },
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
