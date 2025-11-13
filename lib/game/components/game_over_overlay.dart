import 'package:flame_game/game/egg_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameOverOverlay extends StatelessWidget {
  final HitTheEggGame game;
  final VoidCallback onNextLevel;

  TextStyle buttonTextStyle(Color color) => TextStyle(
    fontFamily: "RubikMonoOne",
    fontSize: 75.sp,
    color: color,
    decoration: TextDecoration.underline,
    decorationColor: color,
  );

  final buttonColor = Colors.white;

  const GameOverOverlay({
    super.key,
    required this.game,
    required this.onNextLevel,
  });

  @override
  Widget build(BuildContext context) {
    final bool passed = game.currentScore >= game.levelConfig.targetScore;

    void goHome() {
      game.overlays.remove('GameOverOverlay');
      game.paused = false;
      Navigator.of(context).pushReplacementNamed("/home");
    }

    void onMainButtonPressed() {
      game.overlays.remove('GameOverOverlay');
      if (passed) {
        onNextLevel();
      } else {
        game.resetGame();
        game.paused = false;
      }
    }

    return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(204, 19, 19, 19)),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 350.h, bottom: 195.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    passed ? "YOU WIN!" : "YOU LOSE!",
                    style: TextStyle(
                      fontFamily: "RubikMonoOne",
                      fontSize: 135.sp,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
              Container(
                width: 850.w,
                height: 160.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: const Color.fromARGB(255, 0, 107, 8),
                ),
                child: Center(
                  child: Text(
                    "SCORE ${game.currentScore}",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "RubikMonoOne",
                      fontSize: 75.sp,
                      overflow: TextOverflow.clip,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                width: 850.w,
                height: 160.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: const Color.fromARGB(255, 0, 107, 8),
                ),
                child: Center(
                  child: Text(
                    "GOAL ${game.levelConfig.targetScore}",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "RubikMonoOne",
                      fontSize: 75.sp,
                      overflow: TextOverflow.clip,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: goHome,
                    style: TextButton.styleFrom(
                      foregroundColor: buttonColor,
                      textStyle: buttonTextStyle(buttonColor),
                    ),
                    child: const Text("HOME"),
                  ),
                  if (!passed)
                    TextButton(
                      onPressed: () {
                        game.overlays.remove('GameOverOverlay');
                        game.resetGame();
                        game.paused = false;
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: buttonColor,
                        textStyle: buttonTextStyle(buttonColor),
                      ),
                      child: const Text("RESTART"),
                    ),
                ],
              ),
              IconButton(
                onPressed: onMainButtonPressed,
                icon: Image.asset(
                  passed
                      ? "assets/images/next.png"
                      : "assets/images/tryagain.png",
                  width: 668.w,
                  height: 347.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget builder(BuildContext context, HitTheEggGame game) {
    return GameOverOverlay(
      game: game,
      onNextLevel: () {
        Navigator.of(context).popUntil(ModalRoute.withName('/play'));
      },
    );
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
