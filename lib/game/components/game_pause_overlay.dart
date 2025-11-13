import 'package:flame_game/game/egg_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GamePauseOverlay extends StatelessWidget {
  final HitTheEggGame game;

  const GamePauseOverlay({super.key, required this.game});

  TextStyle buttonTextStyle(Color color) => TextStyle(
    fontFamily: "RubikMonoOne",
    fontSize: 75.sp,
    color: color,
    decoration: TextDecoration.underline,
    decorationColor: color,
  );

  final buttonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    void goHome() {
      game.overlays.remove('GamePauseOverlay');
      game.paused = false;
      Navigator.of(context).popAndPushNamed('/home');
    }

    return Container(
      decoration: BoxDecoration(color: const Color.fromARGB(204, 19, 19, 19)),

      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 500.h, bottom: 195.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "PAUSED",
                    style: TextStyle(
                      fontFamily: "RubikMonoOne",
                      fontSize: 155.sp,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      game.overlays.remove('GamePauseOverlay');
                      goHome();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: buttonColor,
                      textStyle: buttonTextStyle(buttonColor),
                    ),
                    child: Text("HOME"),
                  ),
                  TextButton(
                    onPressed: () {
                      game.overlays.remove('GamePauseOverlay');
                      game.resetGame();
                      game.paused = false;
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: buttonColor,
                      textStyle: buttonTextStyle(buttonColor),
                    ),
                    child: Text("RESTART"),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  game.overlays.remove('GamePauseOverlay');
                  game.paused = false;
                },
                icon: Image.asset("assets/images/button.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget builder(BuildContext context, HitTheEggGame game) {
    return GamePauseOverlay(game: game);
  }
}

extension on HitTheEggGame {
  void resetGame() {
    currentScore = 0;
    currentEggCount = 0;
    eggIdCounter = 0;
    timeLeft = levelConfig.timeLimit.toDouble();
    isGameActive = true;

    gameTimer?.stop();
    gameTimer?.start();

    if (scoreDisplay.isMounted) {
      scoreDisplay.updateScore(currentScore);
    }
    if (currentEgg != null) {
      remove(currentEgg!);
      currentEgg = null;
    }
    spawnNewEgg();
  }
}
