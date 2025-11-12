import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildLevelTile({
  required int levelNumber,
  required int currentLevel,
  required BuildContext context,
}) {
  final bool isUnlocked = levelNumber <= currentLevel + 1;

  return GestureDetector(
    onTap: isUnlocked
        ? () {
            // Navigate to the selected level game screen
            // You would typically dispatch GetLevelByIdEvent here
            // context.read<LevelBloc>().add(GetLevelByIdEvent(levelNumber: levelNumber));
            debugPrint('Starting Level $levelNumber');
          }
        : null, // onTap is null if locked
    child: Stack(
      alignment: AlignmentGeometry.center,
      children: [
        IconButton(
          onPressed: () {},
          color: isUnlocked ? null : Colors.black,
          style: ButtonStyle(
          ),
          icon: isUnlocked ? Image.asset("assets/images/level_icon.png") : Image.asset("assets/images/locked_level_icon.png"),
        ),
        Text(levelNumber.toString(),
        style: TextStyle(
          fontFamily: "RubikMonoOne",
          fontSize: 75.sp,
          color: Colors.white
        ),),
      ],
    ),
  );
}
