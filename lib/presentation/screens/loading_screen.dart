import 'package:flame_game/presentation/screens/home_screen.dart';
import 'package:flame_game/presentation/widgets/animated_loading_bar.dart';
import 'package:flame_game/presentation/widgets/main_background_component.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 4), () => onLoadingComplete());
    super.initState();
  }

  void onLoadingComplete() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentGeometry.bottomCenter,
        children: [
          MainBackgroundComponent(),
          Image.asset("assets/images/main_chik.png"),
          Padding(
            padding: EdgeInsetsGeometry.only(bottom: 175.h),
            child: AnimatedProgressBar(),
          ),
        ],
      ),
    );
  }
}
