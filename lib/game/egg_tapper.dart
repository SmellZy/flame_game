import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_game/domain/entities/level.dart';
import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/game/components/background.dart';
import 'package:flame_game/game/components/egg_component.dart';
import 'package:flame_game/game/components/pause_component.dart';
import 'package:flame_game/game/components/score_display_component.dart';
import 'package:flame_game/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flame/text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Додано для TextPaint

// the logic was: eggs spawn on playground, user tap on it and earn points.
// If user hit the minimum required points to pass the level, user move to next level
// Coins earn are related to points, coins = points;

class HitTheEggGame extends FlameGame with TapCallbacks {
  final Level levelConfig;
  final UserBloc userBloc;
  final User user;

  int currentScore = 0;
  int currentEggCount = 0;
  int eggIdCounter = 0;
  Timer? gameTimer;
  double timeLeft = 0.0;
  bool isGameActive = true;

  late ScoreDisplayComponent scoreDisplay;
  late Background background;

  EggComponent? currentEgg;
  final Random random = Random();

  HitTheEggGame({
    required this.user,
    required this.levelConfig,
    required this.userBloc,
  }) {
    timeLeft = levelConfig.timeLimit.toDouble();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    background = Background(size);
    add(background);

    gameTimer = Timer(
      levelConfig.timeLimit.toDouble(),
      onTick: _onGameTimeUp,
      repeat: false,
    );

    add(ScreenHitbox());
    _addHud();

    spawnNewEgg();

    gameTimer!.start();
  }

  void _addHud() {
    final style = TextStyle(
      color: Colors.white,
      fontSize: 30.sp,
      fontFamily: "RubikMonoOne",
    );
    final regular = TextPaint(style: style);

    scoreDisplay = ScoreDisplayComponent(
      textRenderer: regular,
      position: Vector2(size.x * 0.5, size.y * 0.11),
    );
    add(scoreDisplay);

    final pauseButton = PauseComponent(
      size: Vector2(200.w, 180.h),
      position: Vector2(size.x * 0.85, size.y * 0.11),
    );
    add(pauseButton);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isGameActive && !paused) {
      gameTimer!.update(dt);

      timeLeft = gameTimer!.limit - gameTimer!.current;
    }
  }

  // логіка спавну нового яйця
  void spawnNewEgg() {
    // перевірка ліміту спавну (якщо 0, ліміту немає)
    if (levelConfig.maxEggSpawnLimit > 0 &&
        currentEggCount >= levelConfig.maxEggSpawnLimit) {
      _onGameTimeUp();
      return;
    }

    // видаляємо старе яйце, якщо воно існує
    if (currentEgg != null) {
      remove(currentEgg!);
      currentEgg = null;
    }

    if (user.currentEgg == null) {
      debugPrint('user.currentEgg == null неможливо заспавнити яйце');
      return;
    }

    // визначаємо рандмну позицію (з урахуванням розміру яйця)
    final double eggSize = 100.0;
    final minX = eggSize / 2;
    final maxX = size.x - eggSize / 2;
    final minY = eggSize / 2 + size.y * 0.1;
    final maxY = size.y - eggSize / 2;

    final newPosition = Vector2(
      minX + random.nextDouble() * (maxX - minX),
      minY + random.nextDouble() * (maxY - minY),
    );

    // стврюємо нове яйце
    eggIdCounter++;
    currentEgg = EggComponent(
      eggIcon: "eggs/egg4.png",
      position: newPosition,
      size: Vector2.all(eggSize),
      lifeTime: levelConfig.eggLifetime,
      id: eggIdCounter,
    );

    add(currentEgg!);
    currentEggCount++;
  }

  // при успішному кліку на яйце
  void onEggHit(int eggId) {
    // чи юзер клікнув на поточне активне яйце
    if (currentEgg != null && currentEgg!.id == eggId) {
      currentScore += levelConfig.eggCostPoint;
      scoreDisplay.updateScore(currentScore);

      spawnNewEgg();
    }
  }

  // пропуск яйця (час lifeTime закінчився)
  void onRemoveEgg() {
    if (isGameActive) {
      spawnNewEgg();
    }
  }

  // jбробка завершення часу гри
  void _onGameTimeUp() {
    if (!isGameActive) return;

    isGameActive = false;
    gameTimer!.pause();

    if (currentEgg != null) {
      remove(currentEgg!);
      currentEgg = null;
    }

    _updateUserProgress();
    overlays.add('GameOverOverlay');
  }

  void _updateUserProgress() {
    if (userBloc.state is UserLoaded) {
      User user = (userBloc.state as UserLoaded).user;

      final int newPoints = (user.points ?? 0) + currentScore;
      final int newCoins = (user.coins ?? 0) + currentScore;
      int newCurrentLevel = user.currentLevel ?? 0;
      final bool levelCompleted = currentScore >= levelConfig.targetScore;

      if (levelCompleted && levelConfig.level == newCurrentLevel + 1) {
        newCurrentLevel = levelConfig.level;
      }

      final updatedUser = user.copyWith(
        points: newPoints,
        coins: newCoins,
        currentLevel: newCurrentLevel,
      );

      userBloc.add(UpdateUserEvent(user: updatedUser));
    }
  }
}
