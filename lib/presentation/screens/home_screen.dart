import 'package:flame_game/presentation/screens/how_to_play_screen.dart';
import 'package:flame_game/presentation/screens/menu_screen.dart';
import 'package:flame_game/presentation/screens/play_screen.dart';
import 'package:flame_game/presentation/widgets/main_background_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void howToPlay() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            HowToPlayScreen(),
        transitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  }

  void menu() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => MenuScreen(),
        transitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  }

  void play() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => PlayScreen(),
        transitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MainBackgroundComponent(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(40.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          howToPlay();
                        },
                        icon: Image.asset(
                          "assets/images/info.png",
                          width: 205.w,
                          height: 205.h,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          menu();
                        },
                        icon: Image.asset(
                          "assets/images/menu.png",
                          width: 205.w,
                          height: 205.h,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: AlignmentGeometry.bottomCenter,
                    children: [
                      Image.asset(
                        "assets/images/main_chik.png",
                        width: 830.w,
                        height: 1400.h,
                      ),
                      IconButton(
                        onPressed: () {
                          play();
                        },
                        icon: Image.asset(
                          "assets/images/button.png",
                          width: 668.w,
                          height: 347.h,
                        ),
                      ),
                    ],
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
