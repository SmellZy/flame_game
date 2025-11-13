import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_game/game/egg_tapper.dart';
import 'package:flutter/material.dart';

class EggComponent extends SpriteComponent
    with HasGameReference<HitTheEggGame>, TapCallbacks {
  final double lifeTime;
  final int id;
  final String eggIcon;
  late final Timer _lifeTimer;

  EggComponent({
    required Vector2 position,
    required Vector2 size,
    required this.lifeTime,
    required this.id,
    required this.eggIcon,
  }) : super(position: position, size: size, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    try {
      sprite = await game.loadSprite(eggIcon);
    } catch (e) {
      debugPrint('Egg load fail');
    }

    _lifeTimer = Timer(lifeTime, onTick: _onTimerComplete, repeat: false);
    _lifeTimer.start();
  }

  void _onTimerComplete() {
    game.onRemoveEgg();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isLoaded) {
      _lifeTimer.update(dt);
    }
  }

  @override
  bool onTapDown(TapDownEvent event) {
    if (!game.isGameActive) return false;

    game.onEggHit(id);
    return true;
  }
}
