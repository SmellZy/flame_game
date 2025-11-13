import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_game/game/egg_tapper.dart';
import 'package:flutter/material.dart';

class PauseComponent extends SpriteComponent
    with HasGameReference<HitTheEggGame>, TapCallbacks {
  PauseComponent({super.position, super.size}) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await game.loadSprite("pause.png");
  }

  @override
  bool onTapDown(TapDownEvent event) {
    game.paused = !game.paused;
    game.overlays.add('GamePauseOverlay');
    debugPrint("Game paused: ${game.paused}");
    return true;
  }
}
