import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/domain/repositories/user_repository.dart';
import 'package:flame_game/domain/usecases/user/update_user_photo.dart';
import 'package:flame_game/presentation/widgets/main_background_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _glowAnimation,
            builder: (context, child) {
              return MainBackgroundComponent(
                colorFilter: ColorFilter.mode(
                  Color.fromRGBO(
                    255,
                    165,
                    0,
                    (0.1 * _glowAnimation.value).clamp(0.0, 1.0),
                  ),
                  BlendMode.lighten,
                ),
              );
            },
          ),
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
                      //info button
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/images/info.png",
                          width: 205.w,
                          height: 205.h,
                        ),
                      ),
                      //menu button
                      IconButton(
                        onPressed: () {
                          debugPrint("press");
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
                        onPressed: () {},
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
