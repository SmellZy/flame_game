import 'package:flame/components.dart';
import 'package:flame_game/game/components/rounded_rectangle_component.dart';
import 'package:flame_game/game/egg_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreDisplayComponent extends PositionComponent
    with HasGameReference<HitTheEggGame> {
  final TextPaint textRenderer;
  late TextComponent scoreText;
  late SpriteComponent coinIcon;

  ScoreDisplayComponent({required this.textRenderer, super.position})
    : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    double containerWidth = 277.w;
    double containerHeight = 75.h;
    double iconSize = 140.h;

    final container = RoundedRectangleComponent(
      size: Vector2(containerWidth, containerHeight),
      cornerRadius: 30.r,
      color: Color(0xFFFF8E03),
    );

    container.position = Vector2(0, 0);
    add(container);

    coinIcon = SpriteComponent(
      sprite: await game.loadSprite("coin_logo.png"),
      size: Vector2.all(iconSize),
      anchor: Anchor.center,
      position: Vector2(containerWidth - 10, containerHeight / 2),
    );
    add(coinIcon);

    scoreText = TextComponent(
      text: game.currentScore.toString(),
      textRenderer: textRenderer,
      anchor: Anchor.center,
      position: Vector2(containerWidth / 2 - 20, containerHeight / 2),
    );
    add(scoreText);

    size = Vector2(containerWidth + iconSize / 2 - 10, containerHeight);
  }

  void updateScore(int score) {
    if (scoreText.isMounted) {
      scoreText.text = score.toString();
    }
  }
}
