import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/presentation/bloc/user/user_bloc.dart';
import 'package:flame_game/presentation/screens/home_screen.dart';
import 'package:flame_game/presentation/widgets/animated_loading_bar.dart';
import 'package:flame_game/presentation/widgets/main_background_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isBlocLoaded = false;
  bool isAnimationDone = false;
  final User user = User(
    username: "Player",
    avatarPath: "assets/images/avatars/avatar1.png",
    coins: 1000,
    currentEgg: "eggs/egg1.png",
    currentLevel: 0,
    points: 0,
    purshasedEggs: ["assets/images/eggs/egg1.png"],
    sound: true,
    notifications: true,
    vibration: true,
  );

  @override
  void initState() {
    context.read<UserBloc>().add(CreateUserEvent(user: user));
    context.read<UserBloc>().add(GetUserEvent());

    super.initState();
  }

  void checkAndNavigate() {
    if (isBlocLoaded && isAnimationDone) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomeScreen(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoaded) {
          debugPrint(state.user.username);
          isBlocLoaded = true;
          checkAndNavigate();
        }
      },
      child: Scaffold(
        body: Stack(
          alignment: AlignmentGeometry.bottomCenter,
          children: [
            MainBackgroundComponent(),
            Image.asset("assets/images/main_chik.png"),
            Padding(
              padding: EdgeInsetsGeometry.only(bottom: 175.h),
              child: AnimatedProgressBar(
                onComplete: () {
                  setState(() {
                    isAnimationDone = true;
                  });
                  checkAndNavigate();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
