import 'package:flame_game/domain/entities/level.dart';
import 'package:flame_game/presentation/bloc/level/level_bloc.dart';
import 'package:flame_game/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildLevelTile({
  required int levelNumber,
  required int currentLevel,
  required BuildContext context,
  required UserBloc userBloc,
  required Level level,
}) {
  final bool isUnlocked = levelNumber <= currentLevel + 1;

  return GestureDetector(
    onTap: isUnlocked
        ? () {
            context.read<LevelBloc>().add(
              GetLevelByIdEvent(levelNumber: levelNumber),
            );
            debugPrint('Starting Level $levelNumber');
          }
        : null,
    child: Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Image.asset(
          isUnlocked
              ? "assets/images/level_icon.png"
              : "assets/images/locked_level_icon.png",
        ),
        Text(
          levelNumber.toString(),
          style: TextStyle(
            fontFamily: "RubikMonoOne",
            fontSize: 75.sp,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
