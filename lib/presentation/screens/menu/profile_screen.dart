import 'package:flame_game/presentation/widgets/main_background_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBackgroundComponent(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(40.w),
          child: Column(
            children: [
              Row(
                
              )
            ],
          ),
          )
        ),
    );
  }
}
