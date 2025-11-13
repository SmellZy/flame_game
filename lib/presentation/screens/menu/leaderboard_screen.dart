import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/presentation/bloc/user/user_bloc.dart';
import 'package:flame_game/presentation/widgets/leaderboard_row.dart';
import 'package:flame_game/presentation/widgets/main_background_component.dart';
import 'package:flame_game/presentation/widgets/purple_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
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

  List<User> _createLeaderboard(User currentUser) {
    final Random random = Random();
    final List<User> mockUsers = [];
    final int mockUserCount = 9;

    for (int i = 1; i <= mockUserCount; i++) {
      mockUsers.add(
        User(
          username: 'Player_$i',
          email: 'player$i@mock.com',
          points: 100 + random.nextInt(600),
          avatarPath: 'assets/images/avatars/avatar${(i % 2) + 1}.png',
        ),
      );
    }

    List<User> leaderboard = [...mockUsers, currentUser];
    leaderboard.sort((a, b) => (b.points ?? 0).compareTo(a.points ?? 0));

    return leaderboard;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        User? user;
        if (state is UserLoaded) {
          final safePoints = state.user.points ?? 0;
          user = state.user.copyWith(points: safePoints);
        }

        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final List<User> leaderboardData = _createLeaderboard(user);

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
                    PurpleContainer(
                      height: 1400.h,
                      width: 850.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                            child: Text(
                              "Leaderboard",
                              style: TextStyle(
                                fontFamily: "RubikMonoOne",
                                fontSize: 75.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: leaderboardData.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final User leader = leaderboardData[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: LeaderboardRow(
                                    user: leader,
                                    place: index + 1,
                                    isCurrentUser:
                                        leader.username == user?.username,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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
