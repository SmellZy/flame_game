import 'package:flame_game/domain/entities/level.dart';
import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/presentation/bloc/level/level_bloc.dart';
import 'package:flame_game/presentation/bloc/user/user_bloc.dart';
import 'package:flame_game/presentation/widgets/level_tiles.dart';
import 'package:flame_game/presentation/widgets/main_background_component.dart';
import 'package:flame_game/presentation/widgets/game_widget.dart'; // Потрібно для навігації
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

void goBack(dynamic context) {
  Navigator.popUntil(context, ModalRoute.withName('/home'));
}

class _PlayScreenState extends State<PlayScreen> {
  List<Level> allLevels = [];
  void _navigateToGameScreen(
    BuildContext context,
    Level level,
    UserBloc userBloc,
    User user,
    List<Level> levels,
    int currentLevelIndex,
  ) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => MyGameWidget(
          level: level,
          userBloc: userBloc,
          user: user,
          allLevels: levels,
          currentLevelIndex: currentLevelIndex,
        ),
        transitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  }

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
    final userBloc = context.read<UserBloc>();

    return BlocListener<LevelBloc, LevelState>(
      listenWhen: (previous, current) => current is LevelLoaded,
      listener: (context, state) {
        if (state is LevelLoaded) {
          final userState = userBloc.state;
          if (userState is UserLoaded) {
            final User user = userState.user;
            final int index = allLevels.indexWhere(
              (l) => l.level == state.level.level,
            );

            _navigateToGameScreen(
              context,
              state.level,
              userBloc,
              user,
              allLevels,
              index,
            );
          }
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          User? user;
          if (state is UserLoaded) {
            user = state.user;
            debugPrint(user.username);
            debugPrint(user.coins.toString());
          }
          final int displayCoins = user?.coins ?? 0;

          if (state is UserLoading || state is UserInitial) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          }

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
                              alignment: Alignment.centerRight,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 90.w),
                                  child: Container(
                                    width: 205.w,
                                    height: 75.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF8E03),
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        child: Text(
                          "CHANGE LEVEL",
                          style: TextStyle(
                            fontFamily: "RubikMonoOne",
                            fontSize: 75.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      Expanded(
                        child: BlocBuilder<LevelBloc, LevelState>(
                          buildWhen: (previous, current) =>
                              current is! LevelLoaded,
                          builder: (context, levelState) {
                            if (levelState is LevelsLoading ||
                                levelState is LevelInitial ||
                                levelState is LevelLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
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
                              allLevels = levels;
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

                            return GridView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 20.h,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1.0,
                                    crossAxisSpacing: 42.w,
                                    mainAxisSpacing: 87.h,
                                  ),
                              itemCount: levels.length,
                              itemBuilder: (context, index) {
                                final int levelNumber = index + 1;
                                final Level currentLevelObject = levels[index];

                                return buildLevelTile(
                                  level: currentLevelObject,
                                  userBloc: userBloc,
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
      ),
    );
  }
}
