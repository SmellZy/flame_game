import 'package:flame_game/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderboardRow extends StatelessWidget {
  final User user;
  final int place;
  final bool isCurrentUser;

  const LeaderboardRow({
    super.key,
    required this.user,
    required this.place,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = isCurrentUser
        ? const Color(0xFF1BC431)
        : const Color(0xFFFF6CD8);

    return Container(
      height: 100.h,
      width: 760.w,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: isCurrentUser
            ? [
                BoxShadow(
                  color: const Color.fromARGB(123, 255, 255, 255),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/images/level_icon.png",
                width: 130.w,
                height: 130.h,
              ),
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  image: DecorationImage(
                    image: AssetImage(user.avatarPath.toString()),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 40.w, right: 40.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    user.username ?? "Unknown User",
                    style: TextStyle(
                      fontFamily: "RubikMonoOne",
                      fontSize: 45.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    user.points.toString(),
                    style: TextStyle(
                      fontFamily: "RubikMonoOne",
                      fontSize: 45.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
